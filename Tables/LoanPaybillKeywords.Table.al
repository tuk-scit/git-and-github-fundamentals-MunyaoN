Table 52188677 "Loan Paybill Keywords"
{

    fields
    {
        field(1; Keyword; Text[50])
        {
            NotBlank = true;
        }
        field(2; "Product Code"; Code[20])
        {
            TableRelation = "Product Setup"."Product ID";
        }
        field(3; "Destination Type"; Option)
        {
            OptionMembers = "None";
        }
    }

    keys
    {
        key(Key1; Keyword)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

