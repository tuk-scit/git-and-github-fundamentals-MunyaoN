
Page 52188425 "Loan Activities"
{
    PageType = CardPart;
    SourceTable = "Sacco Cues";

    layout
    {
        area(content)
        {
            cuegroup(Loans)
            {
                Caption = 'Loans';
                field(LoansApplication; "Loans - Application")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Style = Subordinate;
                    StyleExpr = true;
                }
                field(LoansPending; "Loans - Pending")
                {
                    ApplicationArea = Basic;
                    Style = Ambiguous;
                    StyleExpr = true;
                }
                field(LoansApproved; "Loans - Approved")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(LoansRejected; "Loans - Rejected")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }

                actions
                {

                    action("Loan Application List")
                    {
                        ApplicationArea = Basic;
                        RunObject = Page "Loan Application List";
                    }
                    action("Loan Posted List")
                    {
                        ApplicationArea = Basic;
                        RunObject = Page "Loan Posted List";
                    }
                    action("Members List")
                    {
                        ApplicationArea = Basic;
                        RunObject = Page "Member List";
                    }
                    action("Group List")
                    {
                        ApplicationArea = Basic;
                        //RunObject = Page "Group List";
                    }
                    action("Member Accounts List")
                    {
                        ApplicationArea = Basic;
                        //RunObject = Page "Member Accounts  List";
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;

        SetFilter("User Filter", UserId);
    end;
}

