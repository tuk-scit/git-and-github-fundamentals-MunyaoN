
Page 52188484 "Teller Transactions - Posted"
{
    ApplicationArea = Basic;
    //CardPageID = "Teller Transaction Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Teller Transaction";
    SourceTableView = where(Posted=const(true));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionNo;"Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo;"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName;"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Cashier;Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate;"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Clear Lien")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Clear this Lien?') then begin
                        TestField(Type,Type::Lien);
                        "Cheque Status" := "cheque status"::Honoured;
                        Modify;
                    end;
                end;
            }
        }
    }
}

