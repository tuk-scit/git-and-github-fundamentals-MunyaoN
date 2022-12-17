tableextension 52188430 "Fixed Assets" extends "Fixed Asset"
{
    fields
    {
        field(52188423; Custodian; Text[200])
        {
            Caption = 'Custodian';
            DataClassification = ToBeClassified;
        }
        field(52188424; "Year of Purchase"; Integer)
        {
            Caption = 'Year of Purchase';
            DataClassification = ToBeClassified;
        }
        field(52188425; "Depart. / Section"; Code[200])
        {
            DataClassification = ToBeClassified;
        }

    }
}
