
Table 52188463 "Loan Changes"
{
    DrillDownPageID = "Loan Changes List";
    LookupPageID = "Loan Changes List";

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(5900; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50001; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Members));

            trigger OnValidate()
            begin

                if Members.Get("Member No.") then begin
                    "Member Name" := Members.Name;
                end;


                Validate("Loan No.", '');
                Validate("Type of Change", "type of change"::" ");
                InitFields;
            end;
        }
        field(50002; "Member Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan No." where("Member No." = field("Member No."),
                                                    "Outstanding Principal" = filter(> 0));

            trigger OnValidate()
            var
                SActivities: Codeunit "Sacco Activities";
                ExpectedAmt: Decimal;
                AmtPaid: Decimal;
                DefAmount: Decimal;
                DaysInArrear: Integer;
                ArrearsDate: Date;

            begin

                InitFields;



                // Check schedule details
                LoanSched.Reset;
                LoanSched.SetRange(LoanSched."Loan No.", "Loan No.");
                LoanSched.SetRange(LoanSched."Repayment Date", Today, 99991230D);
                if LoanSched.Find('-') then begin
                    RemInstallments := LoanSched.Count;
                    "Remaining Installments" := RemInstallments;
                end;
                RemInstallments := 0;
                if Loans.Get("Loan No.") then begin

                    Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest", "Outstanding Appraisal", "Outstanding Penalty");

                    "Outstanding Principal" := Loans."Outstanding Principal";
                    "Outstanding Interest" := Loans."Outstanding Interest";
                    "Outstanding Appraisal" := Loans."Outstanding Appraisal";
                    "Outstanding Penalty" := Loans."Outstanding Penalty";
                    "Total Outstanding" := "Outstanding Principal" + "Outstanding Interest" + "Outstanding Penalty" + "Outstanding Appraisal";
                    "New Loan Amount" := "Total Outstanding";
                    "Old Repayment" := Loans.Repayment;
                    "Account No." := Loans."Member No.";
                    "Repay Mode" := Loans."Repay Mode";
                    "Original Installments" := Loans.Installments;
                    "Interest Rate" := Loans."Annual Interest %";
                    "Principal Grace Period" := Loans."Principal Grace Period";
                    "Loan Product Type" := Loans."Loan Product Type";
                    "Loan Product Type Name" := Loans."Loan Product Type Name";
                    "Loan Suspended" := Loans."Loan Suspended";
                    "Loan Suspension End Date" := Loans."Loan Suspension Start Date";
                    "Loan Suspension End Date" := Loans."Loan Suspension End Date";
                    "Debt Coll. Date" := Loans."Debt Coll. Date";


                    DefAmount := 0;
                    SActivities.GetDefaultedAmount("Loan No.", Today, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true);

                    "Debt Coll. Def Amount" := DefAmount + Loans."Outstanding Interest";

                    "Debt Collector" := Loans."Debt Collector";
                    "Debt Collector Name" := Loans."Debt Collector Name";
                    "Debt Collector Type" := Loans."Debt Collector Type";


                    if ProductSetup.Get(Loans."Loan Product Type") then
                        "Maximun Installments" := ProductSetup."Default Installments";



                    // Check schedule details
                    LoanSched.Reset;
                    LoanSched.SetRange(LoanSched."Loan No.", "Loan No.");
                    LoanSched.SetRange(LoanSched."Repayment Date", Today, 99991230D);
                    if LoanSched.Find('-') then begin
                        RemInstallments := LoanSched.Count;
                        "Remaining Installments" := RemInstallments;
                    end;
                end;
            end;
        }
        field(50004; "Outstanding Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Remaining Installments"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "New Installments"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                PastInstallments := 0;

                if "Original Installments" = "Maximun Installments" then begin
                    IF "New Installments" > "Remaining Installments" THEN
                        ERROR('New Installments cannot Exceed Remaining Installments');
                end
                else begin
                    PastInstallments := "Original Installments" - "Remaining Installments";
                    if "New Installments" > "Maximun Installments" then
                        Error('New Installments cannot Exceed Maximum Installments');
                end;


                GetRepayment;
            end;
        }
        field(50009; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(50010; "Old Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "New Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                LoanAmount: Decimal;
                InterestRate: Decimal;
                LBalance: Decimal;
                RunDate: Date;
                InstalNo: Integer;
                TotalMRepay: Decimal;
                LInterest: Decimal;
                LPrincipal: Decimal;
                RepayPeriod: Integer;
                v: Integer;
            begin
                "Adjusted Repayment" := "New Repayment";


                TestField("Rescheduling Date");
                GetInstallments;





                Loans.Get("Loan No.");
                Loans.CalcFields("Outstanding Principal");
                LBalance := Loans."Outstanding Principal";

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                    Loans.TestField(Loans."Annual Interest %");

                    TotalMRepay := "New Repayment";
                    LInterest := ROUND(LBalance / 1200 * InterestRate, 0.0001, '>');
                    LPrincipal := TotalMRepay - LInterest;


                end;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                    Loans.TestField(Loans."Annual Interest %");
                    TestField("New Installments");
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 1200) * LoanAmount;

                    //Update Reschedule
                    Loans.Repayment := LPrincipal;

                end;
            end;
        }
        field(50012; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50013; "Original Installments"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50014; "Maximun Installments"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50015; "Rescheduling Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50018; "Requested Repaymet"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "New Recovery Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "New Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Rescheduling Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ","Create New Loan","Update Existing Loan";
        }
        field(50024; "Top Up Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "New Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "Outstanding Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; "Outstanding Appraisal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "Total Outstanding"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50029; "Adjusted Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Adjusted Repayment" < "New Repayment" then
                    Error('Adjusted Repayment cannot be less than new repayment');
            end;
        }
        field(50030; "Type of Change"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan Rescheduling,Interest Rate,Recovery Mode,Stop Interest,Loan Suspension,Update Product Type,Debt Collector';
            OptionMembers = " ","Loan Rescheduling","Interest Rate","Repay Mode","Stop Interest","Loan Suspension","Update Product Type","Debt Collector";


            trigger OnValidate()
            begin
                Validate("Loan No.");
            end;
        }
        field(50031; "Repay Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Principal Grace Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "New Principal Grace Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Charge Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Reschedule,Restructure;

            trigger OnValidate()
            var
                ChargeCode: Code[20];
                Value: Decimal;
                ChargeAmt: Decimal;
                ChargeDuty: Decimal;
                ChargeAcctType: Enum "Gen. Journal Account Type";
                ChargeAcct: Code[20];
                d: Integer;
            begin
                SaccoSetup.Get();
                Charges := 0;
                "New Interest Due" := 0;

                "Rescheduling Type" := "rescheduling type"::" ";
                Loans.Get("Loan No.");
                if "Charge Type" = "charge type"::Reschedule then begin
                    "Rescheduling Type" := "rescheduling type"::"Update Existing Loan";
                    ChargeCode := SaccoSetup."Loan Rescheduling Fee";
                    Value := "Total Outstanding";
                    ChargeAmt := 0;
                    ChargeDuty := 0;
                    Counter := 1;
                    Lines := 1;
                    Loans.Reset;
                    Loans.SetRange("Loan No.", "Loan No.");
                    if Loans.FindFirst then begin
                        Loans.CalcFields("Last Int. Due Date", "Outstanding Principal");
                        if Loans."Last Int. Due Date" < CalcDate('-CM', Today) then begin
                            d := Today - Loans."Last Int. Due Date";
                            "New Interest Due" := ROUND(Loans."Annual Interest %" / 1200 * Loans."Outstanding Principal" * d / 30);
                        end;
                    end;
                    while Counter <= Lines do begin
                        MemberActivities.GetGeneralChargeAmountWithCounter(ChargeCode, Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, Counter, Lines, Desc);
                        //MESSAGE(Desc+': %1',ChargeAmt);
                        Charges += ChargeAmt + ChargeDuty;
                    end;
                end;

                if "Charge Type" = "charge type"::Restructure then begin

                    "Rescheduling Type" := "rescheduling type"::"Create New Loan";
                    ChargeCode := SaccoSetup."Loan Restructure Fee";
                    Value := "Total Outstanding";
                    ChargeAmt := 0;
                    ChargeDuty := 0;
                    Counter := 1;
                    Lines := 1;
                    while Counter <= Lines do begin
                        MemberActivities.GetGeneralChargeAmountWithCounter(ChargeCode, Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, Counter, Lines, Desc);
                        //MESSAGE(Desc+': %1',ChargeAmt);
                        Charges += ChargeAmt + ChargeDuty;
                    end;
                end;

                Loans.CalcFields("Total Outstanding Balance");
                "New Loan Amount" := Loans."Total Outstanding Balance" + Charges + "New Interest Due";
            end;
        }
        field(50035; Charges; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50036; "New Interest Due"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Loan Suspended"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Loan Suspension Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Loan Suspension End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = const(Credit));
            Editable = false;
            trigger OnValidate()
            var
                ProdSetup: Record "Product Setup";
            begin
                ProdSetup.Get("Loan Product Type");
                "Loan Product Type Name" := ProdSetup.Description;
            end;
        }
        field(50042; "Loan Product Type Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50043; "New Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup";
            Editable = false;
            trigger OnValidate()
            var
                ProdSetup: Record "Product Setup";
            begin
                ProdSetup.Get("Loan Product Type");
                "Loan Product Type Name" := ProdSetup.Description;
            end;
        }
        field(50044; "New Loan Product Type Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }



        field(182; "Debt Collector Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Walk In",Marketer,Staff,"Board Member",Member,Website;
            ValuesAllowed = Marketer, Staff;
        }

        field(183; "Debt Collector Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(184; "Debt Collector"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Debt Collector Type" = const(Marketer)) "Salesperson/Purchaser"
            else
            if ("Debt Collector Type" = const(Staff)) Employee
            else
            if ("Debt Collector Type" = const("Board Member")) Customer where("Member Category" = const("Board Members"))
            else
            if ("Debt Collector Type" = const(Member)) Customer where("Member Category" = const(Member));

            trigger OnValidate()
            var
                SalespersonPurchaser: Record "Salesperson/Purchaser";
                HREmployees: Record Employee;

            begin
                "Debt Collector Name" := '';

                if "Debt Collector Type" = "Debt Collector Type"::Marketer then begin
                    SalespersonPurchaser.Reset;
                    SalespersonPurchaser.SetRange(Code, "Debt Collector");
                    if SalespersonPurchaser.Find('-') then begin
                        "Debt Collector Name" := SalespersonPurchaser.Name;
                    end;
                end
                else
                    if "Debt Collector Type" = "Debt Collector Type"::"Board Member" then begin
                        Members.Reset;
                        Members.SetRange("No.", "Debt Collector");
                        if Members.Find('-') then begin
                            "Debt Collector Name" := Members.Name;
                        end;
                    end
                    else
                        if "Debt Collector Type" = "Debt Collector Type"::Staff then begin
                            HREmployees.Reset;
                            HREmployees.SetRange("No.", "Debt Collector");
                            if HREmployees.Find('-') then begin
                                "Debt Collector Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                            end;
                        end
                        else
                            if "Debt Collector Type" = "Debt Collector Type"::Member then begin
                                Members.Reset;
                                Members.SetRange("No.", "Debt Collector");
                                if Members.Find('-') then begin
                                    "Debt Collector Name" := Members.Name;
                                end;
                            end;
            end;
        }
        field(186; "Debt Coll. Def Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(187; "Debt Coll. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "No.", Description, "Date Filter")
        {
        }
    }

    trigger OnInsert()
    begin


        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Loan Rescheduling Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Loan Rescheduling Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;


        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Members: Record Customer;
        MemberAccounts: Record Vendor;
        MemberActivities: Codeunit "Member Activities";
        Loans: Record Loans;
        UserSetup: Record "User Setup";
        RemInstallments: Integer;
        ProductSetup: Record "Product Setup";
        LoanSched: Record "Loan Repayment Schedule";
        PastInstallments: Integer;
        SaccoSetup: Record "Sacco Setup";
        ChargeCode: Code[20];
        Value: Decimal;
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Savings,Credit;
        ChargeAcct: Code[20];
        Counter: Integer;
        Lines: Integer;
        Desc: Text;

    local procedure GetInstallments()
    var
        LoanAmount: Decimal;
        InterestRate: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
    begin
        Loans.Reset;
        Loans.SetRange("Loan No.", "Loan No.");
        if Loans.Find('-') then begin

            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
            LoanAmount := Loans."Outstanding Principal";
            InterestRate := Loans."Annual Interest %";
            LBalance := Loans."Outstanding Principal";//LoansR."Approved Amount";
            RunDate := "Rescheduling Date";
            InstalNo := 0;

            repeat
                InstalNo := InstalNo + 1;
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                    if InterestRate = 0 then
                        Loans."Interest Calculation Method" := Loans."interest calculation method"::"Reducing Balance"

                end;
                //kma
                if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                    Loans.TestField(Loans."Annual Interest %");
                    TotalMRepay := "New Repayment";
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                    LPrincipal := TotalMRepay - LInterest;
                end;

                if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                    TotalMRepay := "New Repayment";
                    LInterest := (InterestRate / 12 / 100) * LoanAmount;
                    LPrincipal := TotalMRepay - LInterest;

                end;

                if (Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Balance") or (Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat") then begin
                    TotalMRepay := "New Repayment";
                    LInterest := (InterestRate / 12 / 100) * LoanAmount;
                    LPrincipal := TotalMRepay - LInterest;

                end;

                LBalance -= LPrincipal;


                //Repayment Frequency
                if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
                                RunDate := CalcDate('1Q', RunDate)
                            else
                                if Loans."Repayment Frequency" = Loans."repayment frequency"::"Bi-Annual" then
                                    RunDate := CalcDate('6M', RunDate)
                                else
                                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Yearly then
                                        RunDate := CalcDate('1Y', RunDate)
                                    else
                                        if Loans."Repayment Frequency" = Loans."repayment frequency"::Bonus then begin
                                            RunDate := CalcDate('1Y', RunDate);
                                        end;

            until LBalance < 1;

            "New Installments" := InstalNo;
            GetRepayment;
            Modify;

        end;
    end;

    local procedure GetRepayment()
    var
        LoanAmount: Decimal;
        InterestRate: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayPeriod: Integer;
    begin

        Loans.Get("Loan No.");


        LoanAmount := "Outstanding Principal";
        InterestRate := Loans."Annual Interest %";
        RepayPeriod := "New Installments";
        LBalance := "Outstanding Principal";
        RunDate := "Rescheduling Date";


        InstalNo := InstalNo + 1;
        if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
            if Loans."Annual Interest %" = 0 then
                Loans."Interest Calculation Method" := Loans."interest calculation method"::"Reducing Balance"

        end;
        //kma
        if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin

            TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
            LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
            LPrincipal := TotalMRepay - LInterest;
        end;

        if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
            LPrincipal := LoanAmount / RepayPeriod;
            LInterest := (InterestRate / 12 / 100) * LoanAmount;
            TotalMRepay := LPrincipal + LInterest
        end;

        if (Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Balance") or (Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat") then begin
            LPrincipal := LoanAmount / RepayPeriod;
            LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1.0, '>');
            TotalMRepay := LPrincipal + LInterest;

        end;

        "New Repayment" := TotalMRepay;
    end;

    local procedure InitFields()
    begin

        "Outstanding Principal" := 0;
        "Outstanding Interest" := 0;
        "Outstanding Appraisal" := 0;
        "Outstanding Penalty" := 0;
        "Total Outstanding" := 0;
        "New Loan Amount" := 0;
        "Old Repayment" := 0;
        "Account No." := '';
        "Repay Mode" := "Repay Mode"::" ";
        "Original Installments" := 0;
        "Interest Rate" := 0;
        "Maximun Installments" := 0;
        "New Recovery Mode" := "new recovery mode"::" ";
        "New Installments" := 0;
        "Adjusted Repayment" := 0;
        "New Repayment" := 0;
    end;
}

