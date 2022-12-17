
Page 52188535 "Checkoff Import"
{
    PageType = ListPart;
    SourceTable = "Monthly Checkoff Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Payroll; Payroll)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Savings Amount"; "Savings Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Amount"; "Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field(SearchCode; "Search Code")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNotFound; "Member Not Found")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNotFound; "Loan Not Found")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Processed)
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Balance)
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

