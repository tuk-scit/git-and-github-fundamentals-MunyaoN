
Page 52188595 "Loans List"
{
    CardPageID = "Loan Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Loans;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo;"Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate;"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType;"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo;"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(RequestedAmount;"Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount;"Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName;"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementDate;"Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal;"Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest;"Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPenalty;"Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingAppraisal;"Outstanding Appraisal")
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

