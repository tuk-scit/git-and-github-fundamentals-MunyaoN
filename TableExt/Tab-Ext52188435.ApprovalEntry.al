TableExtension 52188435 ApprovalEntry extends "Approval Entry"
{
    fields
    {

        field(50000; "Tracker ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval Tracker";
        }
        field(50001; "Document Rec ID to Approve"; RecordID)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Document Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Name; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }
}

