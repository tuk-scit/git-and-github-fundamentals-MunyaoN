tableextension 52188432 AccountingPeriod extends "Accounting Period"
{
    fields
    {
        field(52188423; "Close Posting Period"; Boolean)
        {
            Caption = 'Close Posting Period';
            DataClassification = ToBeClassified;
        }
        field(52188424; "Posting Period Closed By"; Code[50])
        {
            Caption = 'Posting Period Closed By';
            DataClassification = ToBeClassified;
        }
        field(52188425; "Posting Period Date Closed"; Date)
        {
            Caption = 'Posting Period Date Closed';
            DataClassification = ToBeClassified;
        }
        field(52188426; "Posting Period Opened By"; Code[50])
        {
            Caption = 'Posting Period Opened By';
            DataClassification = ToBeClassified;
        }
    }
}
