table 52188666 "Member Class"
{
    Caption = 'Member Class';
    DataClassification = ToBeClassified;
    DrillDownPageID = "Member Class";
    LookupPageID = "Member Class";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Minimum Registration Fee"; Decimal)
        {
            Caption = 'Minimum Registration Fee';
            DataClassification = ToBeClassified;
        }
        field(4; "Minimum Share Capital"; Decimal)
        {
            Caption = 'Minimum Share Capital';
            DataClassification = ToBeClassified;
        }
        field(5; "Minimum Share Deposits"; Decimal)
        {
            Caption = 'Minimum Share Deposits';
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
}
