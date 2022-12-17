page 52188732 "Member Statistics"
{
    Caption = 'Member Statistics';
    PageType = Card;
    SourceTable = Customer;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {

            part(Accounts; "Member Accounts Listpart")
            {
                SubPageLink = "Member No." = field("No.");
            }
            part(Loans; "Member Loans Listpart")
            {
                SubPageLink = "Member No." = field("No.");
            }

        }
    }
}
