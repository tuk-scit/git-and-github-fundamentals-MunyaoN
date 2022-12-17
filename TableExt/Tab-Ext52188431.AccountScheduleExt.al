tableextension 52188431 "Account Schedule Ext" extends "Acc. Schedule Name"
{
    fields
    {
        field(52188423; "User Group Code"; Code[20])
        {
            Caption = 'User Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "User Group Member"."User Group Code";
        }
    }
}
