
Table 52188462 "Loan Collateral Register"
{
    LookupPageID = "Collateral List";

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Security Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; "Account No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Members));

            trigger OnValidate()
            begin
                if CusMembr.Get("Account No.") then
                    "Account Name" := CusMembr.Name;
            end;
        }
        field(9; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Collateral Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Title Deed,Pension,Shares,Marketable Securities,Inventory,Motor Vehicle';
            OptionMembers = " ","Title Deed",Pension,Shares,"Marketable Securities",Inventory,"Motor Vehicle";
        }
        field(11; Collateral; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Collateral Setup".Code where(Type = field("Collateral Type"));

            trigger OnValidate()
            begin
                if SecurityRegSetUp.Get(Collateral) then begin
                    if SecurityRegSetUp.Blocked then
                        Error(Text001);

                    "Collateral Name" := SecurityRegSetUp.Description;
                    "Collateral Multiplier" := SecurityRegSetUp."Collateral Multiplier";
                    "Collateral Limit" := "Collateral Value" * ("Collateral Multiplier" / 100);
                    "Charged Value" := "Collateral Limit";
                end;
            end;
        }
        field(12; "Collateral Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Collateral Multiplier"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Collateral Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Collateral Limit" := "Collateral Value" * ("Collateral Multiplier" / 100)
            end;
        }
        field(17; "Collateral Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Max. amount Collateral can cover against loan';
            Editable = false;
        }
        field(29; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected,Returned';
            OptionMembers = Open,Pending,Approved,Rejected,Returned;

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    "Inward/Outward" := "inward/outward"::"In-Store";
                end;
            end;
        }
        field(30; "Inward/Outward"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,In-Store,Returned';
            OptionMembers = " ","In-Store",Returned;
        }
        field(31; "Last Valuation Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GenSetup.Get;
                if "Last Valuation Date" <> 0D then begin
                    if "Last Valuation Date" > Today then
                        Error(Text004);
                    GenSetup.TestField("Maximum Valuation Period");
                    if CalcDate(GenSetup."Maximum Valuation Period", "Last Valuation Date") < Today then
                        Error(Text003, GenSetup."Maximum Valuation Period");
                    SecurityRegSetUp.Reset;
                    SecurityRegSetUp.SetRange(SecurityRegSetUp.Type, "Collateral Type");
                    if SecurityRegSetUp.Find('-') then begin
                        if Format(SecurityRegSetUp."Revaluation Frequency") <> '' then
                            "Next Valuation Date" := CalcDate(SecurityRegSetUp."Revaluation Frequency", "Last Valuation Date");
                    end;
                end;
            end;
        }
        field(32; "Forced Sale Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Text001: label 'Forced sale value cannot be more than collateral limit';
            begin
                if "Forced Sale Value" > "Collateral Limit" then
                    Error(Text005, "Collateral Limit");
            end;
        }
        field(33; "Collateral Perfected"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Next Valuation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Collateral Details"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Registered Owner"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Re-Opened By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(39; "Date Re-Opened"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Insurance Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Valuation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Appreciating,Depreciating';
            OptionMembers = " ",Appreciating,Depreciating;
        }
        field(42; "Legally Cleared"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(44; "Charged Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if "Charged Value" > "Collateral Limit" then
                    Error('"Charged Value" cannot be greater than "Collateral Limit"');
            end;
        }
        field(45; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(46; "Collection Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(47; "Collector ID No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Collector Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Collector Phone No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Date Collected"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Mark For Collection"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Power of Attorney"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(53; "Vehicle Class"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vehicle Class Category";
        }
        field(54; "Vehicle Reg. No."; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(55; "Plot Location"; Code[15])
        {
            DataClassification = ToBeClassified;

        }
        field(56; "Plot No."; Code[15])
        {
            DataClassification = ToBeClassified;

        }
        field(57; "Collateral Description"; Code[15])
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



    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan Security Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Loan Security Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        if (Status = Status::Approved) or (Status = Status::Pending) then
            Error(Text002, Status);
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CusMembr: Record Customer;
        SecurityRegSetUp: Record "Loan Collateral Setup";
        GenSetup: Record "Sacco Setup";
        Text001: label 'This collateral is blocked thus not avaialable for use.';
        Text002: label 'This application is %1 thus cannot modify.';
        Text003: label 'The last valuation day is more than %1 hence is invalid';
        Text004: label 'Last valuation date cannot be greater than today';
        Text005: label 'The forced sale value cannot be greater than collateral maximum limit of %1';
}

