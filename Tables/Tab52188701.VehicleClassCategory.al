table 52188701 "Vehicle Class Category"
{
    Caption = 'Vehicle Class Category';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Vehicle Category"; Code[3])
        {
            Caption = 'Vehicle Category';
            DataClassification = ToBeClassified;
        }
        field(2; "Vehicle Category Description"; Text[50])
        {
            Caption = 'Vehicle Category Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Vehicle Category")
        {
            Clustered = true;
        }
    }
}
