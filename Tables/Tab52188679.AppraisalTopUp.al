table 52188679 "Appraisal Top Up"
{
    Caption = 'Appraisal Top Up';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = SystemMetadata;
        }
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Account Use","Top Up";
        }
        field(50002; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Loan Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Principle Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                Commision := GetCommission;
                if Loans.Get("Loan No.") then begin
                    "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + Commision;
                end;
            end;
        }
        field(50005; "Interest Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Loans.Get("Loan No.") then begin
                    "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + Commision;
                end;
            end;
        }
        field(50006; "Total Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Commision; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Loan Top Up"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."),
                                         "Total Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            var
                LRec: Record Loans;
            begin

                if LRec.Get("Loan Top Up") then begin

                    ProductSetup.Get(LRec."Loan Product Type");

                    LRec.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Appraisal", "Outstanding Penalty", "Interest Due Date");
                    if LRec."Outstanding Interest" < 0 then
                        LRec."Outstanding Interest" := 0;
                    if LRec."Outstanding Penalty" < 0 then
                        LRec."Outstanding Penalty" := 0;
                    if LRec."Outstanding Appraisal" < 0 then
                        LRec."Outstanding Appraisal" := 0;

                    "Loan Type" := LRec."Loan Product Type";
                    "Principle Top Up" := LRec."Outstanding Principal";
                    "Interest Top Up" := LRec."Outstanding Interest";
                    "Penalty Top Up" := LRec."Outstanding Penalty";
                    "Appraisal Top Up" := LRec."Outstanding Appraisal";

                    "Uncharged Interest" := 0;// ROUND(LRec."Outstanding Principal" * LRec."Annual Interest %" / 1200);


                    //MESSAGE('"Uncharged Interest" Full Month: %1',"Uncharged Interest");
                    /*
                    LastPayDate :=  SaccoActivities.GetLoanRePaymentDate(LRec,CALCDATE('-1M',TODAY));
                    IF SaccoActivities.GetLoanRePaymentDate(LRec,TODAY) < TODAY THEN
                         LastPayDate := SaccoActivities.GetLoanRePaymentDate(LRec,TODAY);
                    */
                    LastPayDate := LRec."Interest Due Date";
                    if LastPayDate = 0D then
                        LastPayDate := LRec."Disbursement Date";
                    //Message('Last Pay Date: %1', LastPayDate);

                    days := Today - LastPayDate;
                    if days < 0 then
                        days := 0;

                    //Message('days: %1', days);

                    "Uncharged Interest" := 0;// ROUND("Uncharged Interest" * days / 30);

                    if LRec."Interest Calculation Method" = LRec."interest calculation method"::"Straight Line" then begin
                        //"Uncharged Interest"  := ROUND(LRec."Approved Amount"*LRec."Annual Interest %"/1200);
                    end;


                    if ProductSetup."Skip Int Due On Top Up" then
                        "Uncharged Interest" := 0;


                    Validate("Principle Top Up");

                    Commision := GetCommission;
                    "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + Commision + "Uncharged Interest";
                end;

            end;
        }
        field(50009; "Penalty Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + Commision;
            end;
        }
        field(50010; "Appraisal Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + Commision;
            end;
        }
        field(50011; "Commission GL"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Uncharged Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Member No.", "Loan Top Up")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record "Member Salary Appraisal";
        ProductSetup: Record "Product Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        LastPayDate: Date;
        days: Integer;

    local procedure GetCommission(): Decimal
    var
        PCharges: Record "Loan Product Charges.";
        Amt: Decimal;
        MainProduct: Record "Product Setup";
        Loans: Record Loans;
        MainLoan: Record "Member Salary Appraisal";
        Loantypes: Record "Product Setup";
    begin



        Amt := 0;


        Loans.Get("Loan Top Up");
        ProductSetup.Get(Loans."Loan Product Type");
        MainLoan.Get("Loan No.");
        MainProduct.Get(MainLoan."Loan Product Type");


        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", ProductSetup."Product ID");
        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
        if PCharges.Find('-') then begin
            repeat
                PCharges.TestField(PCharges."Account No.");
                "Commission GL" := PCharges."Account No.";
                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
                    Amt := (Loans."Requested Amount" * (PCharges.Percentage / 100));
                end else
                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
                        Amt := (("Principle Top Up" + "Interest Top Up" + "Penalty Top Up" + "Appraisal Top Up" + "Uncharged Interest") * (PCharges.Percentage / 100))
                    end else
                        Amt := PCharges."Charge Amount";

                if PCharges.Minimum > 0 then
                    if Amt < PCharges.Minimum then
                        Amt := PCharges.Minimum;

                if PCharges.Maximum > 0 then
                    if Amt > PCharges.Maximum then
                        Amt := PCharges.Maximum;
                Message('Comm: %1', Amt);
            until PCharges.Next = 0;
        end;

        Amt := ROUND(Amt, 0.5, '=');

        exit(Amt);
    end;

    local procedure ChargeInterest(LoanRec: Record Loans; Amt: Decimal)
    var
        BUser: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        Loantypes: Record "Product Setup";
        SaccoTrans: Codeunit "Sacco Activities";
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
    begin

        BUser.Get(UserId);
        BUser.TestField("General Journal Template");
        BUser.TestField("General Journal Batch");
        JTemplate := BUser."General Journal Template";
        JBatch := BUser."General Journal Batch";

        if ProductSetup.Get(Loans."Loan Product Type") then begin
            SaccoTrans.JournalInit(JTemplate, JBatch);

            SaccoTrans.JournalInsert(JTemplate, JBatch, LoanRec."Loan No.", Today, Accttype::Customer, LoanRec."Member No.", 'Top Up Interest Due',
                    Accttype::"G/L Account", ProductSetup."Loan Interest Income [G/L]", Amt, "Loan No.", LoanRec."Loan No.", Transtype::"Interest Due",
                    LoanRec."Global Dimension 1 Code", LoanRec."Booking Branch", true);
            SaccoTrans.JournalPost(JTemplate, JBatch);
        end;
    end;
}


