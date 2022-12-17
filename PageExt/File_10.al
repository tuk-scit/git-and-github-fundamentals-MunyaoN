
PageExtension 52188440 pageextension52188440 extends "Cash Receipt Journal" 
{
    layout
    {
        addafter("Credit Amount")
        {
            field("Transaction Type";"Transaction Type")
            {
                ApplicationArea = Basic;
            }
            field("Loan No.";"Loan No.")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

