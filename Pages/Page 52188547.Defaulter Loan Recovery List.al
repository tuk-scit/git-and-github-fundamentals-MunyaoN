
Page 52188547 "Defaulter Loan Recovery List"
{
    ApplicationArea = Basic;
    CardPageID = "Defaulter Loan Recovery Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Defaulter Loan Recovery";
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
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo;"Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered;"Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(EnteredBy;"Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
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
                field(MemberDeposits;"Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries;"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Recovered;Recovered)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate;"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(RecoveryType;"Recovery Type")
                {
                    ApplicationArea = Basic;
                }
                field(RecoverySource;"Recovery Source")
                {
                    ApplicationArea = Basic;
                }
                field(MemberSavings;"Member Savings")
                {
                    ApplicationArea = Basic;
                }
                field(SourceAccount;"Source Account")
                {
                    ApplicationArea = Basic;
                }
                field(AmounttoRecover;"Amount to Recover")
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

