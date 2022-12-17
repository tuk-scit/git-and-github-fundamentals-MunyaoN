
PageExtension 52188433 pageextension52188433 extends "G/L Account List" 
{
    layout
    {
        addafter("Default Deferral Template Code")
        {
            field("Can Pay Staff";"Can Pay Staff")
            {
                ApplicationArea = Basic;
            }
            field("Can Pay Board";"Can Pay Board")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

