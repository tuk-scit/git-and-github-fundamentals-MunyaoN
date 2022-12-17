
Page 52188668 "Stopped Interest List"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = Loans;
    SourceTableView = where("Stop Interest Due"=const(true));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MemberNo;"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo;"Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType;"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount;"Approved Amount")
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
                field(OutstandingPrincipal;"Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(TotalOutstandingBalance;"Total Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field(BookingBranch;"Booking Branch")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDue;"Interest Due")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate;"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementDate;"Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(IntStopDate;"Int Stop Date")
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

