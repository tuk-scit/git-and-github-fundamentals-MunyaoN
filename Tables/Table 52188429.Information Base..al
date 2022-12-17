
Table 52188429 "Information Base."
{

    fields
    {
        field(1; "Member No."; Code[20])
        {
        }
        field(2; Info; Text[250])
        {

            trigger OnValidate()
            begin

                Date := Today;
                "Captured By" := UserId;
            end;
        }
        field(3; Date; Date)
        {
            Editable = false;
        }
        field(4; "Captured By"; Code[20])
        {
            Editable = false;
        }
        field(5; "Account No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Member No.", Info)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        if "Captured By" <> UserId then
            Error('This can only be deleted by %1', "Captured By");
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        if "Captured By" <> UserId then
            Error('This can only be deleted by %1', "Captured By");
    end;
}

