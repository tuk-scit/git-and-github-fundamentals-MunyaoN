
Table 52188497 "Defaulter Recovery Lines"
{

    fields
    {
        field(1; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Guarantor Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Guarantor Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Withdrawable Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Non-Withdrable Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Loan Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Amount to Recover"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //IF "Amount to Recover" <> "Loan Allocation" THEN
                // ERROR('This Amount MUST be equal to the Loan Allocation');
            end;
        }
        field(9; "Amount Recovered"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Guarantor Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Committed Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Committed Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Loan Balance After Offset"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Header No.", "Loan No.", "Guarantor Savings Account", "Guarantor Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

