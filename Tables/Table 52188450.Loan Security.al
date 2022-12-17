
Table 52188450 "Loan Security"
{
    DrillDownPageID = "Loan Security";
    LookupPageID = "Loan Security";

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }

        field(50002; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Guarantor Type" = const(Guarantor)) Vendor."No." where("Product Category" = filter("Deposit Contribution" | "Micro Member Deposit" | "Micro Group Deposit"),
                                                                                                  Status = filter(Active | Dormant))
            else
            if ("Guarantor Type" = const(Collateral)) Customer."No."
            else
            if ("Guarantor Type" = const(Lien)) Vendor."No." where("Product Category" = filter("Fixed Deposit"),
                                                                                                                                                                        Status = filter(Active | Dormant));

            trigger OnLookup()
            begin

            end;

            trigger OnValidate()
            begin

                "SMS Sent" := false;

                GenSetUp.Get;

                "Self Guarantee" := false;
                SelfGuaranteedA := 0;
                Date := Today;


                Staff_Board := false;

                //Set Member Guaranteed
                if LoansR.Get("Loan No.") then begin
                    "Member Guaranteed" := LoansR."Member No.";
                    "Loanee Name" := LoansR."Member Name";
                    if Members.Get(LoansR."Member No.") then
                        if (Members."Member Category" = Members."member category"::"Board Members") or
                          (Members."Member Category" = Members."member category"::"Staff Members") then
                            Staff_Board := true;
                end;

                if "Guarantor Type" = "guarantor type"::Guarantor then begin

                    //Evaluate guarantor basic info
                    if Savings.Get("Account No.") then begin
                        if Members."No." = Savings."Member No." then
                            "Self Guarantee" := true;

                        LoansR.Reset;
                        LoansR.SetRange("Member No.", Savings."Member No.");
                        LoansR.SetFilter("Outstanding Principal", '>0');
                        LoansR.SetFilter("Loans Category-SASRA", '<>%1&<>%2', LoansR."loans category-sasra"::Perfoming, LoansR."loans category-sasra"::Watch);
                        if LoansR.FindFirst then
                            Message('Member has defaulted loan %1', LoansR."Loan Product Type");

                        if Savings.Status <> Savings.Status::Active then
                            Error('Member No. %1 is not an Active Member', Savings."No.");

                        Members.Get(Savings."Member No.");

                        if Employer.Get(Members."Employer Code") then begin

                            if Employer."Cannot Guarantee" then
                                Error('Members under %1 are not allowed to Guarantee', Employer.Name);
                        end;

                        Savings.CalcFields(Savings."Balance (LCY)");
                        Name := Savings.Name;
                        "Staff/Payroll No." := Savings."Payroll/Staff No.";
                        "Guarantor Deposits" := Savings."Balance (LCY)";
                        if GenSetUp."Guarantors Multiplier" > 0 then
                            "Guarantor Deposits" := Savings."Balance (LCY)" * GenSetUp."Guarantors Multiplier";
                        "ID No." := Savings."ID No.";
                        "Member No" := Savings."Member No.";


                        //"Available Guarantorship"=CalculateAvailableShares(Savings,"Guarantor Deposits","Application Amount Guaranteed","Total Guarantor Commitment","Available Guarantorship");


                        CalculateAvailableShares(Savings, "Guarantor Deposits", "Application Amount Guaranteed", "Total Guarantor Commitment", "Available Guarantorship");
                        "Available Guarantorship" := "Guarantor Deposits";

                        if "Available Guarantorship" < 0 then
                            "Available Guarantorship" := 0;

                    end;

                end
                else
                    if "Guarantor Type" = "guarantor type"::Collateral then begin
                        if Members.Get("Account No.") then begin

                            Name := Members.Name;
                            "Staff/Payroll No." := Members."Payroll/Staff No.";
                            "ID No." := Members."ID No.";
                            "Member No" := "Account No.";

                        end;
                    end
                    else begin
                        if Savings.Get("Account No.") then begin
                            if Savings.Status <> Savings.Status::Active then
                                Error('Member No. %1 is not an Active Member', Savings."No.");

                            Name := Savings.Name;
                            "Staff/Payroll No." := Savings."Payroll/Staff No.";
                            "Guarantor Deposits" := MemberActivities.GetAccountBalance(Savings."No.");
                            "ID No." := Savings."ID No.";
                            "Member No" := Savings."Member No.";
                            "Application Amount Guaranteed" := MemberActivities.GetMemberCommittedLien("Account No.", false);
                            "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetMemberCommittedLien("Account No.", true);
                            "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment";

                            if "Available Guarantorship" < 0 then
                                "Available Guarantorship" := 0;

                            //"Amount Guaranteed":=Savings."Lien Placed";

                        end;
                    end;



                if LoanApp.Get("Loan No.") then begin

                    if not GenSetUp."Staff Can Guarantee Loan" then
                        if LoanApp."Member No." <> "Member No" then begin
                            if not Staff_Board then begin
                                if Members.Get("Member No") then
                                    if (Members."Member Category" = Members."member category"::"Board Members") or
                                      (Members."Member Category" = Members."member category"::"Staff Members") then
                                        Error('Staff/Board cannot Guarantee a Loan');
                            end;
                        end;

                    LoanSec.Reset;
                    LoanSec.SetRange("Loan No.", LoanApp."Loan No.");
                    LoanSec.SetFilter("Account No.", '<>%1', "Account No.");
                    LoanSec.SetFilter("Amount Guaranteed", '>%1', 0);
                    if not LoanSec.FindFirst then begin
                        if LoanApp."Member No." = "Member No" then begin
                            if Savings.Get("Account No.") then begin
                                "Available Guarantorship" := 0;
                                Savings.CalcFields("Balance (LCY)");
                                if Savings."Product Category" = Savings."product category"::"Deposit Contribution" then begin
                                    "Available Guarantorship" := Savings."Balance (LCY)";

                                    CalcFields("Security Amount");
                                    if "Security Amount" = 0 then
                                        if GenSetUp."Self Guarantee %" > 0 then
                                            "Available Guarantorship" := Savings."Balance (LCY)" * GenSetUp."Self Guarantee %" * 0.01;
                                end;

                            end;
                        end;

                    end;


                    Loans.Reset;
                    Loans.SetRange("Member No.", LoanApp."Member No.");
                    Loans.SetFilter("Outstanding Principal", '>0');
                    if Loans.Find('-') then begin
                        repeat
                            //MESSAGE('0');
                            Loans.CalcFields("Outstanding Principal");
                            LoanTopUp.Reset;
                            LoanTopUp.SetRange("Loan No.", "Loan No.");
                            LoanTopUp.SetRange("Member No.", LoanApp."Member No.");
                            LoanTopUp.SetRange("Loan Top Up", Loans."Loan No.");
                            if LoanTopUp.FindFirst then begin
                                //MESSAGE('1');;
                                //MESSAGE('y%1',Loans."Outstanding Balance");
                                if Loans."Member No." = "Member No" then begin
                                    "Available Guarantorship" += LoanTopUp."Principle Top Up";
                                end
                                else begin
                                    //  MESSAGE('t1');
                                    LoanSec.Reset;
                                    LoanSec.SetRange("Loan No.", LoanTopUp."Loan Top Up");
                                    LoanSec.SetFilter("Account No.", '%1', "Account No.");
                                    if LoanSec.FindFirst then begin
                                        "Available Guarantorship" += LoanSec."Current Committed";

                                    end;
                                end;
                            end;
                        until Loans.Next = 0;
                    end;


                end;
            end;
        }
        field(50003; Name; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Guarantor Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Guarantor Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loan Security" where("Account No." = field("Account No."),
                                                       Substituted = const(false),
                                                       "Outstanding Principal" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; Substituted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "SMS Sent" := false;
                if "Amount Guaranteed" > "Available Guarantorship" then
                    Error('You cannot guarantee more than the available guarantorship of %1', "Available Guarantorship");

                "Current Committed" := "Amount Guaranteed";
            end;
        }
        field(50012; "Staff/Payroll No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Self Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "ID No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Outstanding Principal"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Loan No." = field("Loan No."),
                                                                "Transaction Type" = filter("Loan Disbursement" | "Principal Repayment"),
                                                                "User ID" = filter(<> ''),
                                                                Amount = filter(<> 0),
                                                                "Amount (LCY)" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(50017; "Member Guaranteed"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Total Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Available Guarantorship"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Loan Type"; Code[20])
        {
            CalcFormula = lookup(Loans."Loan Product Type" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(50025; "Loanee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "Guarantor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Guarantor,Collateral,Lien';
            OptionMembers = Guarantor,Collateral,Lien;
        }
        field(50027; "Collateral Reg. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Guarantor Type" = const(Collateral)) "Loan Collateral Register" where(Status = const(Approved),
                                                                                                      "Inward/Outward" = const("In-Store"),
                                                                                                      "Account No." = field("Member No"));

            trigger OnValidate()
            begin


                if SecReg.Get("Collateral Reg. No.") then begin
                    TestField("Guarantor Type", "guarantor type"::Collateral);
                    SaccoSetup.Get;
                    if SaccoSetup."Collateral % of Limit To Use" <= 0 then
                        SaccoSetup."Collateral % of Limit To Use" := 100;

                    if SaccoSetup."Collateral % of Limit To Use" > 100 then
                        SaccoSetup."Collateral % of Limit To Use" := 100;

                    "Guarantor Deposits" := ROUND(SecReg."Charged Value" * SaccoSetup."Collateral % of Limit To Use" / 100);
                    "Collateral Value" := SecReg."Collateral Value";
                    "Application Amount Guaranteed" := MemberActivities.GetCommittedCollateral("Collateral Reg. No.", false);
                    "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetCommittedCollateral("Collateral Reg. No.", true);
                    "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment";


                    if "Available Guarantorship" < 0 then
                        "Available Guarantorship" := 0;

                    if SecReg."Insurance Expiry Date" <> 0D then
                        if SecReg."Insurance Expiry Date" <= Today then
                            Error('Collateral Insurance Date has passed');

                    if SecReg."Valuation Type" = SecReg."valuation type"::" " then begin
                        //IF SecReg."Next Valuation Date" <= TODAY THEN
                        // ERROR('Next Valuation Date has passed. Kindly Revaluate');

                        /*
                        Loans.GET("Loan No");
                
                        IF Loans."Expected Date of Completion" = 0D THEN BEGIN
                            MemberActivities.GenerateRepaymentSchedule(Loans);
                            RSchedule.RESET;
                            RSchedule.SETRANGE("Loan No.",Loans."Loan No.");
                            IF RSchedule.FINDLAST THEN BEGIN
                                Loans."Expected Date of Completion":=RSchedule."Repayment Date";
                                Loans.MODIFY;
                            END;
                        END;
                
                        IF SecReg."Next Valuation Date" < Loans."Expected Date of Completion" THEN
                          MESSAGE('Note that the Expected Date of Loan Completion exceeds the Next Valuation Date');
                        */

                    end;

                end;

                /*
                LoanSec.RESET;
                LoanSec.SETFILTER("Outstanding Balance",'>0');
                LoanSec.SETRANGE("Collateral Reg. No.","Collateral Reg. No.");
                IF LoanSec.FIND('-') THEN BEGIN
                  LoanSec.CALCFIELDS("Outstanding Balance");
                  ERROR(Text004,LoanSec."Loan No",LoanSec."Outstanding Balance");
                END;
                */

            end;
        }
        field(50028; "Collateral Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "SMS Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Current Committed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Application Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Total Guarantor Commitment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Total Loan Guarantorship"; Decimal)
        {
            CalcFormula = sum("Loan Security"."Total Committed" where("Loan No." = field("Loan No."),
                                                                       Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(50041; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Defaulter Release"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Defaulter Recovered"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50044; Released; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Security Amount"; Decimal)
        {
            CalcFormula = sum("Loan Security"."Amount Guaranteed" where("Loan No." = field("Loan No."),
                                                                         "Guarantor Type" = const(Collateral)));
            FieldClass = FlowField;
        }
        field(50046; "Security Details"; Text[200])
        {
            CalcFormula = lookup("Loan Collateral Register"."Collateral Details" where("No." = field("Collateral Reg. No.")));
            FieldClass = FlowField;
        }
        field(50047; "Total Committed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Sub. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Def. Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Account No.", "Collateral Reg. No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ShipmentTermsTranslation: Record "Shipment Method Translation";
    begin
    end;

    var
        GenSetUp: Record "Sacco Setup";
        SelfGuaranteedA: Decimal;
        Staff_Board: Boolean;
        LoansR: Record Loans;
        Members: Record Customer;
        Savings: Record Vendor;
        Employer: Record Customer;
        MemberActivities: Codeunit "Member Activities";
        LoanApp: Record Loans;
        LoanSec: Record "Loan Security";
        Loans: Record Loans;
        LoanTopUp: Record "Loan Top Up";
        SecReg: Record "Loan Collateral Register";
        SaccoSetup: Record "Sacco Setup";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: Decimal;


    procedure CalculateAvailableShares(Savings: Record Vendor; var DepAmt: Decimal; var GuaranteedInApplication: Decimal; var Committed: Decimal; var Available: Decimal)
    var
        LRec: Record Loans;
        LoanTopUp: Record "Loan Top Up";
        LoanG: Record "Loan Security";
        ProductSetup: Record "Product Setup";
        SProduct: Record "Product Setup";
    begin


        GenSetUp.Get;

        Savings.CalcFields(Savings."Balance (LCY)");
        DepAmt := Savings."Balance (LCY)";



        if GenSetUp."Guarantors Multiplier" > 0 then
            DepAmt := Savings."Balance (LCY)" * GenSetUp."Guarantors Multiplier";
        //MESSAGE('%1',"Self Guarantee");

        if "Self Guarantee" then begin
            GenSetUp.TestField("Self Guarantee %");
            CalcFields("Security Amount");
            if "Security Amount" > 0 then
                DepAmt := Savings."Balance (LCY)"
            else
                DepAmt := Savings."Balance (LCY)" * GenSetUp."Self Guarantee %" / 100;
            //MESSAGE('Balanace %1 | Guarantee %2',Savings."Balance (LCY)",GenSetUp."Self Guarantee %");

        end;

        SProduct.Get(Savings."Product Type");

        GuaranteedInApplication := MemberActivities.GetMemberCommittedDeposits(Savings."No.", FALSE);
        Committed := GuaranteedInApplication + MemberActivities.GetMemberCommittedDeposits(Savings."No.", true);
        //MESSAGE('GuaranteedIn %1 |CommittedDeposits %2 ',GuaranteedInApplication,MemberActivities.GetMemberCommittedDeposits('0004056',TRUE));


        //IF Savings."Member No."= '0008199' THEN
        //MESSAGE('cDepAmt %1\Committed %2',DepAmt,Committed);

        LRec.Reset;
        LRec.SetRange("Member No.", Savings."Member No.");
        LRec.SetFilter("Outstanding Principal", '>0');
        if LRec.FindFirst then begin
            repeat
                LoanG.Reset;
                LoanG.SetRange("Loan No.", LRec."Loan No.");
                LoanG.SetRange("Self Guarantee", true);
                if not LoanG.FindFirst then begin
                    LRec.CalcFields("Outstanding Principal");

                    ProductSetup.Get(LRec."Loan Product Type");
                    if LRec."Mobile Loan" then begin

                        if ProductSetup."Deposit Multiplier" > 0 then
                            Committed += ROUND(LRec."Approved Amount" / ProductSetup."Deposit Multiplier");
                    end
                    else begin
                        if SProduct."Product ID" = ProductSetup."Appraisal Product" then
                            if LRec."Approved Amount" > 0 then
                                Committed += ROUND(LRec."Loanee Guaranteed" / LRec."Approved Amount" * LRec."Outstanding Principal");
                    end;
                end;
            until LRec.Next = 0;
        end;


        //IF Savings."Member No."= '0008199' THEN
        //MESSAGE('cDepAmt %1\Committed %2',DepAmt,Committed);


        //MESSAGE('DepAmt %1\Committed %2',DepAmt,Committed);
        Available := DepAmt - Committed;
        //MESSAGE('available %1',Available);
    end;
}

