
Page 52188587 "Product Setup Card"
{
    PageType = Card;
    SourceTable = "Product Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ProductID; "Product ID")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        "USSD Product Name" := Description;
                    end;
                }
                field(USSDProductName; "USSD Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNoPrefix; "Account No. Prefix")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNoSuffix; "Account No. Suffix")
                {
                    ApplicationArea = Basic;
                }
                field(ProductClass; "Product Class")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateControls;
                    end;
                }
                field(SearchCode; "Search Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(MinCustomerAge; "Min. Customer Age")
                {
                    ApplicationArea = Basic;
                }
                field(MaxCustomerAge; "Max.Customer Age")
                {
                    ApplicationArea = Basic;
                }
                field(InterestRateMin; "Interest Rate (Min.)")
                {
                    ApplicationArea = Basic;
                }
                field(InterestRateMax; "Interest Rate (Max.)")
                {
                    ApplicationArea = Basic;
                }
                field(ProductPostingGroup; "Product Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(DontShowonStatement; "Dont Show on Statement")
                {
                    ApplicationArea = Basic;
                }
                field(MbankingKeyWord; "Mbanking Key Word")
                {
                    ApplicationArea = Basic;
                }
                field(DepositMultiplier; "Deposit Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Special Multiplier"; "Special Multiplier")
                {
                    ApplicationArea = Basic;
                }
                /* 
                field(NoGuarantee; "No Guarantee")
                {
                    ApplicationArea = Basic;
                }
 */
            }
            group("Savings Setup")
            {
                Visible = SavingsBool;
                field(ProductCategory; "Product Category")
                {
                    ApplicationArea = Basic;
                }
                field(SavingsType; "Savings Type")
                {
                    ApplicationArea = Basic;
                }
                field(MandatoryContribution; "Mandatory Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(CanOffsetLoan; "Can Offset Loan")
                {
                    ApplicationArea = Basic;
                }

                field(AutoOpenMemberAccount; "Auto Open Member Account")
                {
                    ApplicationArea = Basic;
                }
                field(AutoOpenGroupAccount; "Auto Open Group Account")
                {
                    ApplicationArea = Basic;
                }

                field(AllowMultipleAccounts; "Allow Multiple Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Frequency"; "Withdrawal Frequency")
                {
                    ApplicationArea = Basic;
                }

                field(DividendCalcMethod; "Dividend Calc. Method")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Capitalization %"; "Dividend Capitalization %")
                {
                    ApplicationArea = Basic;
                }
                field(DormancyPeriod; "Dormancy Period")
                {
                    ApplicationArea = Basic;
                }
                field("Dormancy Period Notification"; "Dormancy Period Notification")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumContribution; "Minimum Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(EarnsInterest; "Earns Interest")
                {
                    ApplicationArea = Basic;
                }
                field(InterestExpenseAccount; "Interest Expense Account")
                {
                    ApplicationArea = Basic;
                }
                field(InterestPayableAccount; "Interest Payable Account")
                {
                    ApplicationArea = Basic;
                }
                field(InterestCalcMinBalance; "Interest Calc Min Balance")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawalInterval; "Withdrawal Interval")
                {
                    ApplicationArea = Basic;
                }
                field(StatementCharge; "Statement Charge")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumNoofWithdrawal; "Maximum No. of Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumAccountBalance; "Minimum Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field(MaxTellerWiithdrawable; "Max Teller Wiithdrawable")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingTaxAccount; "Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field(WithHoldingTax; "WithHolding Tax")
                {
                    ApplicationArea = Basic;
                }
                field(AllowOverdraft; "Allow Overdraft")
                {
                    ApplicationArea = Basic;
                }
                field(OverDraftInterest; "Over Draft Interest %")
                {
                    ApplicationArea = Basic;
                }
                field(OverDraftInterestAccount; "Over Draft Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field(AllowMultipleOverDraft; "Allow Multiple Over Draft")
                {
                    ApplicationArea = Basic;
                }
                field(MobileTransaction; "Mobile Transaction")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyMaintenanceFee; "Monthly Maintenance Fee")
                {
                    ApplicationArea = Basic;
                }
                field(MaintenanceFeeGL; "Maintenance Fee [G/L]")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Credit Setup")
            {
                Visible = CreditBool;
                field(GracePeriodPrincipal; "Grace Period - Principal")
                {
                    ApplicationArea = Basic;
                }
                field(GracePeriodInterest; "Grace Period - Interest")
                {
                    ApplicationArea = Basic;
                }
                field(LoanAccountGL; "Loan Account [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInterestIncomeGL; "Loan Interest Income [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInterestReceivableGL; "Loan Interest Receivable [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(GuarantorshipType; "Guarantorship Type")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumGuarantors; "Maximum Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumGuarantors; "Minimum Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field(LoanApplicationPeriod; "Loan Application Period")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumLoanAmount; "Minimum Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumLoanAmount; "Maximum Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field(InterestCalculationMethod; "Interest Calculation Method")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultInstallments; "Default Installments")
                {
                    ApplicationArea = Basic;
                }
                field(ExternalEFTCharges; "External EFT Charges")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyPercentage; "Penalty Percentage")
                {
                    ApplicationArea = Basic;
                }
                field(LoanPenaltyIncomeGL; "Loan Penalty Income [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(LoanPenaltyReceivableGL; "Loan Penalty Receivable [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(InterestAccountingMethod; "Interest Accounting Method")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyAccountingMethod; "Penalty Accounting Method")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalProduct; "Appraisal Product")
                {
                    ApplicationArea = Basic;
                }
                field(AllowMultipleRunningLoans; "Allow Multiple Running Loans")
                {
                    ApplicationArea = Basic;
                }
                field(LoanSource; "Loan Source")
                {
                    ApplicationArea = Basic;
                }
                field(RecoveryPriority; "Recovery Priority")
                {
                    ApplicationArea = Basic;
                }
                field(RepayMode; "Repay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(SuspendInterestAccountGL; "Suspend Interest Account [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(RepaymentFrequency; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field(NatureofLoanType; "Nature of Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field(InterestRecoveredUpfront; "Interest Recovered Upfront")
                {
                    ApplicationArea = Basic;
                }
                field(EmailLoanSchedule; "Email Loan Schedule")
                {
                    ApplicationArea = Basic;
                }
                field(RequiresBatching; "Requires Batching")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal % on Amount"; "Appraisal % on Amount")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementProduct; "Disbursement Product")
                {
                    ApplicationArea = Basic;
                }
                field(IncomeType; "Income Type")
                {
                    ApplicationArea = Basic;
                }
                field(CutoffDay; "Cutoff Day")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDueonDisbursement; "Interest Due on Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDueCutoffDay; "Interest Due Cutoff Day")
                {
                    ApplicationArea = Basic;
                }
                field(BonusAppraisalStartDate; "Bonus Appraisal Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(CRBProductCode; "CRB Product Code")
                {
                    ApplicationArea = Basic;
                }
                field(PreEarnedReceivableGL; "Pre-Earned Receivable [G/L]")
                {
                    ApplicationArea = Basic;
                }
                field(PreEarnedInterest; "Pre-Earned Interest")
                {
                    ApplicationArea = Basic;
                }
                field(RecoverRegistrationFee; "Recover Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field(AvailableonMobile; "Available on Mobile")
                {
                    ApplicationArea = Basic;
                }
                field(AvailableonPortal; "Available on Portal")
                {
                    ApplicationArea = Basic;
                }
                field(SkipIntDueOnTopUp; "Skip Int Due On Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(ScheduleofPropertyMandatory; "Schedule of Property Mandatory")
                {
                    ApplicationArea = Basic;
                }
                field(AutoSendSMSAlerts; "Auto Send SMS Alerts")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Deposits"; "Appraise Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Salary"; "Appraise Salary")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Security"; "Appraise Security")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Product Charges")
            {
                ApplicationArea = Basic;
                RunObject = Page "Loan Product Charges";
                RunPageLink = "Product Code" = field("Product ID");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        CreditBool: Boolean;
        SavingsBool: Boolean;

    local procedure UpdateControls()
    begin

        CreditBool := false;
        SavingsBool := false;

        if "Product Class" = "product class"::Credit then
            CreditBool := true;
        if "Product Class" = "product class"::Savings then
            SavingsBool := true;
    end;
}

