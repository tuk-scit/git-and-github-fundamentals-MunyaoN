
Table 52188667 "Monthly Advice Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Advice Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));

            trigger OnValidate()
            begin
                if Customer.Get("Employer Code") then begin
                    "Employer Name" := Customer.Name;
                    if Customer."Advice Method" = Customer."Advice Method"::" " then
                        Error('Advice Type Not Specified for this Employer');
                end else
                    "Employer Name" := '';
            end;
        }
        field(14; "Employer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Total Count"; Integer)
        {
            Editable = false;
            CalcFormula = count("Monthly Checkoff Lines" where("Checkoff Header" = field("No.")));
            FieldClass = FlowField;
        }
        field(16; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(21; "CHK Buffer Amount"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Monthly Checkoff Buffer".Amount where("Checkoff No" = field("No.")));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
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
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Advice Nos");
            NoSeriesMgt.InitSeries(NoSetup."Advice Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Customer: Record Customer;
        UserSetup: Record "User Setup";
}

