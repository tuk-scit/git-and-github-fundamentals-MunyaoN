
Table 52188471 "Standing Order Header"
{
   // DrillDownPageID = "Standing Orders List";
    //LookupPageID = "Standing Orders List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(50002; "Application Date"; Date)
        {
            Editable = false;
        }
        field(50003; "No. Series"; Code[10])
        {
            Editable = false;
        }
        field(50004; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected,Stopped';
            OptionMembers = Open,Pending,Approved,Rejected,Stopped;
        }
        field(50005; "Transaction Branch"; Code[10])
        {
        }
        field(50006; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(50007; "Source Account Type"; Enum "Gen. Journal Account Type")
        {
        }
        field(50008; "Source Account No."; Code[20])
        {
            TableRelation = if ("Source Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Source Account Type" = const(Customer)) Customer
            else
            if ("Source Account Type" = const(Vendor)) Vendor
            else
            if ("Source Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Source Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Source Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Source Account Type" = const(Savings)) Vendor where("Product Category" = filter("Ordinary Savings" | Business))
            else
            if ("Source Account Type" = const(Credit)) Customer;

            trigger OnValidate()
            begin

                if MemberAccounts.Get("Source Account No.") then begin

                    "Member No." := MemberAccounts."Member No.";
                    Members.Get("Member No.");
                    "Payroll/Staff No." := Members."Payroll/Staff No.";
                    "Source Account Name" := Members.Name;
                    "ID Number" := Members."ID No.";
                end;
            end;
        }
        field(50009; "Source Account Name"; Text[80])
        {
            Editable = false;
        }
        field(50010; "Member No."; Code[10])
        {
            Editable = false;
        }
        field(50011; "ID Number"; Code[20])
        {
            Editable = false;
        }
        field(50012; "Payroll/Staff No."; Code[20])
        {
            Editable = false;
        }
        field(50013; Description; Text[100])
        {
            Description = 'LookUp to Standing Orders Description Table';
        }
        field(50014; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                Validate("Income Type");
            end;
        }
        field(50015; "Allocated Amount"; Decimal)
        {
            CalcFormula = sum("Standing Order Lines".Amount where("Document No." = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016; Balance; Decimal)
        {
            Editable = false;
        }
        field(50020; "Standing Order Type"; Option)
        {
            OptionCaption = 'Internal,External,Pensioner';
            OptionMembers = Internal,External,Pensioner;

            trigger OnValidate()
            begin

                if "Standing Order Type" = "standing order type"::Pensioner then
                    Priority := 1
                else
                    if "Standing Order Type" = "standing order type"::Internal then
                        Priority := 2
                    else
                        if "Standing Order Type" = "standing order type"::External then
                            Priority := 3;
            end;
        }
        field(50021; "Allow Partial Deduction"; Boolean)
        {

            trigger OnValidate()
            begin

                STOLines.Reset;
                STOLines.SetRange("Document No.", Code);
                STOLines.SetRange(STOLines."Destination Account Type", STOLines."destination account type"::External);
                if STOLines.Find('-') then begin
                    if STOLines."Destination Account Type" = STOLines."destination account type"::External then
                        Error('An external standing order cannot be partially deducted');
                end;
            end;
        }
        field(50022; "None Salary"; Boolean)
        {
            Enabled = false;
        }
        field(50023; "Income Type"; Enum "Repay Mode Enum")//TODO CHANGE THE ENUMS TO SUITE
        {

            trigger OnValidate()
            begin

                if ("Income Type" = "income type"::Business) then
                    TestField("STO Type", "sto type"::Amount);

                if "STO Type" = "sto type"::Percentage then
                    if Amount > 100 then
                        Error('Percentage Value cannot be more than 100');
            end;
        }
        field(50025; Priority; Decimal)
        {
        }
        field(50026; "Effective/Start Date"; Date)
        {

            trigger OnValidate()
            begin

                //if "Effective/Start Date" < CalcDate('-CM', Today) then
                //  Error('Date must be Current Month or in future');

                "Next Run Date" := "Effective/Start Date";
            end;
        }
        field(50027; "Frequency (Months)"; DateFormula)
        {

            trigger OnValidate()
            begin
                /*EVALUATE(DurationInteger,FORMAT("Duration (Months)"));
                EVALUATE(FrequencyInteger,FORMAT("Frequency (Months)"));
                IF DurationInteger < FrequencyInteger THEN
                  ERROR(DurationError);*/

                /*
                EVALUATE(FrequencyText,FORMAT("Frequency (Months)"));
                FrequencyText:=DELCHR(FORMAT(FrequencyText),'=','-|+|');
                EVALUATE("Frequency (Months)",FrequencyText);
                */

                "Next Run Date" := CalcDate("Frequency (Months)", "Effective/Start Date");

            end;
        }
        field(50028; "Duration (Months)"; DateFormula)
        {

            trigger OnValidate()
            begin

                TestField("Effective/Start Date");
                TestField("Frequency (Months)");
                TestField("Duration (Months)");

                "End Date" := CalcDate("Duration (Months)", "Effective/Start Date");
            end;
        }
        field(50029; "End Date"; Date)
        {
            Editable = true;
        }
        field(50030; Effected; Boolean)
        {
            Editable = false;
        }
        field(50031; Unsuccessfull; Boolean)
        {
            Editable = false;
        }
        field(50032; "Next Run Date"; Date)
        {
        }
        field(50033; "Auto Process"; Boolean)
        {
        }
        field(50034; "Date Reset"; Date)
        {
            Editable = false;
        }
        field(50035; Invalid; Boolean)
        {
        }
        field(50036; Unrecovered; Boolean)
        {
        }
        field(50037; "Created By"; Code[60])
        {
        }
        field(50038; "Bank Code"; Code[10])
        {

            trigger OnValidate()
            begin
                /*
                //*
                BankCodes.RESET;
                BankCodes.SETRANGE(BankCodes."Bank Code","Bank Code");
                IF BankCodes.FIND('-') THEN
                  "Bank Name":=BankCodes."Bank Name";
                
                //*
                IF "Bank Code" = '' THEN BEGIN
                  "Branch Code":=''; "Bank Name":=''; "Bank Account No.":=''; END;
                  */

            end;
        }
        field(50039; "Branch Code"; Code[10])
        {
        }
        field(50040; "Bank Name"; Text[100])
        {
            Editable = false;
        }
        field(50041; "Bank Account No."; Code[15])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                IF STRLEN("Bank Account No.") <>13 THEN BEGIN
                 ERROR('Invalid Bank account No. Please enter the correct Bank Account No.');
                END;
                */

            end;
        }
        field(50042; "Transfered to EFT"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Help Identify eft that has External transfer during eft processing';
        }
        field(50043; "Transaction Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Target Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "STO Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Amount,Percentage';
            OptionMembers = Amount,Percentage;

            trigger OnValidate()
            begin
                Validate("Income Type");
            end;
        }
        field(50046; "Grower No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50048; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }

        key(Key2; "Source Account No.", Priority)
        {
        }


    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if Code = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("STO Nos");
            NoSeriesMgt.InitSeries(SalesSetup."STO Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;


        UserSetup.Get(UserId);
        "Application Date" := Today;
        "Created By" := UserId;
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");

        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        if UserSetup."Max. Open Documents" > 0 then begin
            StndingOrders.Reset;
            StndingOrders.SetRange(Status, StndingOrders.Status::Open);
            StndingOrders.SetRange("Created By", UserId);
            if StndingOrders.FindFirst then
                if StndingOrders.Count > UserSetup."Max. Open Documents" then
                    Error('You can only work on %1 Open Standing Orders', UserSetup."Max. Open Documents");
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        StndingOrders: Record "Standing Order Header";
        MemberAccounts: Record Vendor;
        Members: Record Customer;
        STOLines: Record "Standing Order Lines";
        DurationText: Text;



}

