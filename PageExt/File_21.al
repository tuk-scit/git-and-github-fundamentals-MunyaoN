
PageExtension 52188432 pageextension52188432 extends "G/L Account Card" 
{
    layout
    {
        addafter("Direct Posting")
        {
            field("Cashier G/L";"Cashier G/L")
            {
                ApplicationArea = Basic;
            }
            field("Can Pay Board";"Can Pay Board")
            {
                ApplicationArea = Basic;
            }
            field("Can Pay Staff";"Can Pay Staff")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

