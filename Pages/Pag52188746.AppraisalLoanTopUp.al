page 52188751 "Appraisal Loan Top Up"
{

    PageType = List;
    SourceTable = "Appraisal Top Up";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanTopUp; "Loan Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanType; "Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field(PrincipleTopUp; "Principle Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(InterestTopUp; "Interest Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyTopUp; "Penalty Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(Commision; Commision)
                {
                    ApplicationArea = Basic;
                }
                field(TotalTopUp; "Total Top Up")
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


