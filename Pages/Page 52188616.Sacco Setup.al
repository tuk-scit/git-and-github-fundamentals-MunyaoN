
Page 52188616 "Sacco Setup"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Sacco Setup";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(MembershipAge; "Membership Age")
                {
                    ApplicationArea = Basic;
                }
                field(MemberPictureMandatory; "Member Picture Mandatory")
                {
                    ApplicationArea = Basic;
                }
                field(GuarantorsMultiplier; "Guarantors Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field(StaffCanGuaranteeLoan; "Staff Can Guarantee Loan")
                {
                    ApplicationArea = Basic;
                }
                field(SelfGuarantee; "Self Guarantee %")
                {
                    ApplicationArea = Basic;
                }
                field(ExciseDuty; "Excise Duty (%)")
                {
                    ApplicationArea = Basic;
                }
                field(ExciseDutyGL; "Excise Duty GL")
                {
                    ApplicationArea = Basic;
                }
                field(DormancyPeriod; "Dormancy Period")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Contacts"; "Sacco Contacts")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No,"; "Bank Account No,")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Name"; "Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Comm. Expense"; "Registration Comm. Expense")
                {
                    ApplicationArea = Basic;
                }
                field("File Keeping Period"; "File Keeping Period")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Credit Management")
            {
                field(LoanInterestAutomation; "Loan Interest Automation")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInterestDate; "Loan Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field(SpecificLoanInterestDay; "Specific Loan Interest Day")
                {
                    ApplicationArea = Basic;
                }
                field(CalcLoanInterestOn; "Calc. Loan Interest On")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralofLimitToUse; "Collateral % of Limit To Use")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumValuationPeriod; "Maximum Valuation Period")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyDaysFromExpPayDay; "Penalty Days From Exp. Pay Day")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumAmttoPenalize; "Minimum Amt to Penalize")
                {
                    ApplicationArea = Basic;
                }
                field(LoanReschedulingFee; "Loan Rescheduling Fee")
                {
                    ApplicationArea = Basic;
                }
                field(LoanRestructureFee; "Loan Restructure Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Control"; "Checkoff Control")
                {
                    ApplicationArea = Basic;
                }
                field("Duplum Interest Period"; "Duplum Interest Period")
                {
                    ApplicationArea = Basic;
                }

                field("Email File Path"; "Email File Path")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Savings Management")
            {
                field(TellerCanSelfTransact; "Teller Can Self-Transact")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeRejectPeriod; "Cheque Reject Period")
                {
                    ApplicationArea = Basic;
                }
                field(ExternalSTOAccountNo; "External STO Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(IncomeControlAccount; "Income Control Account")
                {
                    ApplicationArea = Basic;
                }
                field(ByPassChequeClearingDays; "By Pass Cheque Clearing Days")
                {
                    ApplicationArea = Basic;
                }
                field(FDInterestAccrual; "FD Interest Accrual")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum ATM Limit"; "Maximum ATM Limit")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card No Characters"; "ATM Card No Characters")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Dividends)
            {
                field(DividendYearDate; "Dividend Year Date")
                {
                    ApplicationArea = Basic;
                }
                field(DividendProcessingAccount; "Dividend Processing Account")
                {
                    ApplicationArea = Basic;
                }
                field(DividendCharge; "Dividend Charge")
                {
                    ApplicationArea = Basic;
                }
                field(DividendProcessingCharge; "Dividend Processing Charge")
                {
                    ApplicationArea = Basic;
                }
                field(DividendActivityCode; "Dividend Activity Code")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Member Exit")
            {
                field(MemberExitNoticePeriod; "Member Exit Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field(MemberExitCharge; "Member Exit Charge")
                {
                    ApplicationArea = Basic;
                }
                field(ActivateEarlyExitCharge; "Activate Early Exit Charge")
                {
                    ApplicationArea = Basic;
                }
                field(EarlyMemberExitCharge; "Early Member Exit Charge")
                {
                    ApplicationArea = Basic;
                }
                field(MemberExitTransferAccount; "Member Exit Transfer Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Notifications)
            {
                field(SendReceiptEmail; "Send Receipt Email")
                {
                    ApplicationArea = Basic;
                }
                field(SendReceiptSMS; "Send Receipt SMS")
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

