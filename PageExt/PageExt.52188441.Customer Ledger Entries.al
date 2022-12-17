
PageExtension 52188441 CustLedger extends "Customer Ledger Entries"
{

    layout
    {
        addafter(Description)
        {
            field("Transaction Type"; "Transaction Type")
            {
                ApplicationArea = Basic;
            }
            field("Loan No."; "Loan No.")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

