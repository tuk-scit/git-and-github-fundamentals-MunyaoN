
Table 52188490 "Member Images"
{
    Caption = 'Activity';
    LookupPageID = "Activity List";

    fields
    {
        field(1; "Member No."; Code[20])
        {
            Caption = 'Registration No:';
            NotBlank = true;
        }

        field(50001; Picture; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50002; Signature; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'Signature';
            SubType = Bitmap;
        }


        /*

        field(140; Picture; Media)
        {
            Caption = 'Picture';
            ExtendedDatatype = Person;
        }
        field(141; Signature; Media)
        {
            Caption = 'Signature';
            ExtendedDatatype = Person;
        }
        */
    }

    keys
    {
        key(Key1; "Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ActivityStep: Record "Activity Step";
    begin
    end;

    procedure IncludesMeeting(ActivityCode: Code[10]): Boolean
    var
        ActivityStep: Record "Activity Step";
    begin
    end;
}

