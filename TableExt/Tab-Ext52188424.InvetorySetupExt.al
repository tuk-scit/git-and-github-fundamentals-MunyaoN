tableextension 50100 "Invetory Setup Ext" extends "Inventory Setup"
{
    fields
    {
        field(52188423; "Item Jnl Template"; Code[20])
        {
            Caption = 'Item Jnl Template';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template".Name where(Type = const(Item));
        }
        field(52188424; "Item Jnl Batch"; Code[20])
        {
            Caption = 'Item Jnl Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Item Jnl Template"));
        }
    }
}
