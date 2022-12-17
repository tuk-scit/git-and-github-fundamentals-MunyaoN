
Page 52188667 "Penalty Due List"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Loans Penalty Buffer";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MemberNo;"Member No")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo;"Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(GLAccount;"GL Account")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest;"Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingBalance;"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType;"Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyDate;"Penalty Date")
                {
                    ApplicationArea = Basic;
                }
                field(LoanIssueDate;"Loan Issue Date")
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

