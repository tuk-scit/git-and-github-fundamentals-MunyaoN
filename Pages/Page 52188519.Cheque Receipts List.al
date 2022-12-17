
Page 52188519 "Cheque Receipts List"
{
    //CardPageID = "Cheque Receipts Header";
    Editable = false;
    PageType = List;
    SourceTable = "Cheque Receipts_";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;"No.")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate;"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionTime;"Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy;"Created By")
                {
                    ApplicationArea = Basic;
                }
                field(ClearingBank;"Clearing Bank")
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy;"Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

