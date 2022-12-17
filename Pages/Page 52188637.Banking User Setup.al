
Page 52188637 "Banking User Setup"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Banking User Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserName; "User Name")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field(CashierJournalTemplate; "Cashier Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field(CashierJournalBatch; "Cashier Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultBank; "Default  Bank")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultChequeBank; "Default  Cheque Bank")
                {
                    ApplicationArea = Basic;
                }
                field(MaxDepositLimit; "Max. Deposit Limit")
                {
                    ApplicationArea = Basic;
                }
                field(MaxWithdrawalLimit; "Max. Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field(MaxCashierWithholding; "Max. Cashier Withholding")
                {
                    ApplicationArea = Basic;
                }
                field(MinBalance; "Min. Balance")
                {
                    ApplicationArea = Basic;
                }
                field(BankersChequeAccount; "Bankers Cheque Account")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeClearanceAccount; "Cheque Clearance Account")
                {
                    ApplicationArea = Basic;
                }
                field(ExcessAccount; "Excess Account")
                {
                    ApplicationArea = Basic;
                }
                field(ShortageAccount; "Shortage Account")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(MPesaBankAccount; "MPesa Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(MPesaCustomerAccount; "MPesa Customer Account")
                {
                    ApplicationArea = Basic;
                }
                field(ShopCustomerAccount; "Shop Customer Account")
                {
                    ApplicationArea = Basic;
                }
                field(MPESATransactionLimit; "MPESA Transaction Limit")
                {
                    ApplicationArea = Basic;
                }
                field(MaxMPESAWithholding; "Max. MPESA Withholding")
                {
                    ApplicationArea = Basic;
                }
                field(CustServiceChequeAccount; "Cust. Service Cheque Account")
                {
                    ApplicationArea = Basic;
                }
                field(EquityBankAccount; "Equity Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(EquityCustomerAccount; "Equity Customer Account")
                {
                    ApplicationArea = Basic;
                }
                field(MPESADisbursementAc; "MPESA Disbursement A/c")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeDisbursementAc; "Cheque Disbursement A/c")
                {
                    ApplicationArea = Basic;
                }
                field(SupervisorMobileNo; "Supervisor Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(SupervisorEMail; "Supervisor E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(SuperAgentCustomerAccount; "Super Agent Customer Account")
                {
                    ApplicationArea = Basic;
                }
                field(SuperAgentTransactionLimit; "Super Agent Transaction Limit")
                {
                    ApplicationArea = Basic;
                }
                field(SuperTreasuryUser; "Super Treasury User")
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

