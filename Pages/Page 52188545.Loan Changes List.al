
Page 52188545 "Loan Changes List"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Changes Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Loan Changes";
    UsageCategory = Lists;

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
                field(MemberNo;"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName;"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo;"Loan No.")
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
                field(TotalOutstanding;"Total Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field(TypeofChange;"Type of Change")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Processed;Processed)
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(ReschedulingDate;"Rescheduling Date")
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

