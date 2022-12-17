
Page 52188444 "Payroll Code."
{
    PageType = Card;
    SourceTable = "Payroll Codes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(TransactionCode;"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionName;"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(BalanceType;"Balance Type")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType;"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Frequency;Frequency)
                {
                    ApplicationArea = Basic;
                }
                field(Taxable;Taxable)
                {
                    ApplicationArea = Basic;
                }
                field(CalculationType;"Calculation Type")
                {
                    ApplicationArea = Basic;
                }
                field(StandardAmount;"Standard Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Formula;Formula)
                {
                    ApplicationArea = Basic;
                }
                field(SpecialTransactions;"Special Transactions")
                {
                    ApplicationArea = Basic;
                }
                field(DeductPremium;"Deduct Premium")
                {
                    ApplicationArea = Basic;
                }
                field(SpecialIdentifier;"Special Identifier")
                {
                    ApplicationArea = Basic;
                }
                field(GLAccount;"GL Account")
                {
                    ApplicationArea = Basic;
                }
                field(Suspended;Suspended)
                {
                    ApplicationArea = Basic;
                }
                field(SortOrder;"Sort Order")
                {
                    ApplicationArea = Basic;
                }
                group("Employer Details")
                {
                    field(IncludeEmployerDeduction;"Include Employer Deduction")
                    {
                        ApplicationArea = Basic;
                    }
                    field(EmployerCalculationType;"Employer Calculation Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field(EmployerStandardAmount;"Employer Standard Amount")
                    {
                        ApplicationArea = Basic;
                    }
                    field(IsFormulaforemployer;"Is Formula for employer")
                    {
                        ApplicationArea = Basic;
                    }
                    field(EmployerGLAccount;"Employer GL Account")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Sacco Deductions")
                {
                    field(Subledger;Subledger)
                    {
                        ApplicationArea = Basic;
                    }
                    field(SubLedgerAccount;"Sub-Ledger Account")
                    {
                        ApplicationArea = Basic;
                    }
                    field(SubLedgerProductType;"Sub-Ledger Product Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field(LoanInterestMethod;"Loan Interest Method")
                    {
                        ApplicationArea = Basic;
                    }
                    field(PostLoanInterestDue;"Post Loan Interest Due")
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
    }

    actions
    {
    }
}

