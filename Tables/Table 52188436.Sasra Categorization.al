
Table 52188436 "Sasra Categorization"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Outstanding Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Outstanding Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Outstanding Appraisal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Total Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Principal Expected"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Principal Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Principal Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Days in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Loan Category"; Option)
        {
            OptionCaption = 'Performing,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Performing,Watch,Substandard,Doubtful,Loss;
        }
        field(16; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Sasra Up to Date","Sacco Up to Date","Sasra Filtered","Sacco Filtered";
        }
        field(17; "Total Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "As At"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "User Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "IFRS Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Stage 1","Stage 2","Stage 3";
        }
        field(21; "ECL"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "User Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

