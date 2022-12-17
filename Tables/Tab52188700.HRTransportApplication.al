table 52188700 "HR Transport Application"
{
    Caption = 'HR Transport Application';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                HRSetup: Record "HR Setup.";
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if Code <> xRec.Code then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Transport Application Nos");
                    "No series" := '';
                end;
            end;
        }
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Vehicle; Code[10])
        {
            Caption = 'Vehicle';
            DataClassification = ToBeClassified;
        }
        field(5; "Purpose "; Text[100])
        {
            Caption = 'Purpose ';
            DataClassification = ToBeClassified;
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(7; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(8; "No series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        HREmp: Record Employee;
        HRSetup: Record "HR Setup.";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin

        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        HREmp.SetRange(HREmp."Employee Type", HREmp."employee type"::Permanent);
        if HREmp.Find('-') then begin
            if HREmp.Status <> HREmp.Status::Active then begin

                Error('You cannot apply Leave while inactive');
            end;
            if HREmp."Employee Type" <> HREmp."employee type"::Permanent then begin
                Error('Applicable to Permanent staff only');
            end;
        end
        else
            Error('User ID not linked to employee card or Staff is not Permanent');

        "Employee No" := HREmp."No.";
        "Employee Name" := HREmp.FullName();

        //No. Series
        if code = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Transport Application Nos");
            NoSeriesMgt.InitSeries(HRSetup."Transport Application Nos", xRec."No series", 0D, Code, "No series");
        end;

    end;
}
