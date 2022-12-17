
Page 52188615 "Defaulter Recovery Lines"
{
    PageType = ListPart;
    SourceTable = "Defaulter Recovery Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; "Loan No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GuarantorMemberNo; "Guarantor Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GuarantorSavingsAccount; "Guarantor Savings Account")
                {
                    ApplicationArea = Basic;
                }
                field(GuarantorName; "Guarantor Name")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawableSavings; "Withdrawable Savings")
                {
                    ApplicationArea = Basic;
                }

                field("Loan Balance After Offset"; "Loan Balance After Offset")
                {
                    ApplicationArea = Basic;
                }
                field("Committed Loan Balance"; "Committed Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field(NonWithdrableSavings; "Non-Withdrable Savings")
                {
                    ApplicationArea = Basic;
                }
                field(AmountGuaranteed; "Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field(LoanAllocation; "Loan Allocation")
                {
                    ApplicationArea = Basic;
                }
                field(AmounttoRecover; "Amount to Recover")
                {
                    ApplicationArea = Basic;
                }
                field(AmountRecovered; "Amount Recovered")
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

