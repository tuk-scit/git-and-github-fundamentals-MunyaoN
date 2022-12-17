Page 52188698 "Dashboard."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = DashBoard;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                }
                field(TotalIncome; "Total Income")
                {
                    ApplicationArea = Basic;
                }
                field(TotalExpense; "Total Expense")
                {
                    ApplicationArea = Basic;
                }
                field(LoanPortfolio; "Loan Portfolio")
                {
                    ApplicationArea = Basic;
                }
                field(ActiveAccounts; "Active Accounts")
                {
                    ApplicationArea = Basic;
                }
                field(DormantAccounts; "Dormant Accounts")
                {
                    ApplicationArea = Basic;
                }
                field(Assets; Assets)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control12; "dashboard Lines")
            {
                SubPageLink = Date = field(Date);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(GetDashboard)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Report.Run(52188607, true, false);
                    CurrPage.Close;
                end;
            }
        }
    }
}

