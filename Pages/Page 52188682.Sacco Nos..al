
Page 52188682 "Sacco Nos."
{
    ApplicationArea = Basic, Suite;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Customer Groups,Payments';
    SourceTable = "Sales & Receivables Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Sacco Nos")
            {
                field(TrackerNos; "Tracker Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberApplicationNos; "Member Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountApplicationNos; "Account Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNos; "Member Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(ReceiptsNos; "Receipts Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNos; "Loan Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanRecoveryNos; "Loan Recovery Nos")
                {
                    ApplicationArea = Basic;
                }
                field(LoanReschedulingNos; "Loan Rescheduling Nos")
                {
                    ApplicationArea = Basic;
                }
                field(FixedDepositNos; "Fixed Deposit Nos")
                {
                    ApplicationArea = Basic;
                }
                field(SecuritySubstitutionNos; "Security Substitution Nos")
                {
                    ApplicationArea = Basic;
                }
                field(MemberExitNoticeNos; "Member Exit Notice Nos")
                {
                    ApplicationArea = Basic;
                }
                field(MemberExitNos; "Member Exit Nos")
                {
                    ApplicationArea = Basic;
                }
                field(MemberChangesNos; "Member Changes Nos")
                {
                    ApplicationArea = Basic;
                }
                field(TreasuryTellerNos; "Treasury/Teller Nos")
                {
                    ApplicationArea = Basic;
                }
                field(TellerTransactionNos; "Teller Transaction Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(BankersChequeApplicationNos; "Bankers Cheque Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field(STONos; "STO Nos")
                {
                    ApplicationArea = Basic;
                }
                field(StandingOrderRegNos; "Standing Order Reg. Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(CheqBookNos; "Cheq. Book Nos")
                {
                    ApplicationArea = Basic;
                }
                field(AccountTransferNos; "Account Transfer Nos")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryNos; "Salary Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentVoucherNos; "Payment Voucher Nos")
                {
                    ApplicationArea = Basic;
                }
                field(PettyCashNos; "Petty Cash Nos")
                {
                    ApplicationArea = Basic;
                }
                field(BoardPVsNos; "Board PVs Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(BenevolentClaimNos; "Benevolent Claim Nos")
                {
                    ApplicationArea = Basic;
                }
                field(LoanSecurityNos; "Loan Security Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanSecurityCollectionNos; "Loan Security Collection Nos.")
                {
                    ApplicationArea = Basic;
                }
                field(CheckoffNo; "Checkoff No.")
                {
                    ApplicationArea = Basic;
                }
                field(MicroFinanceTransactions; "Micro Finance Transactions")
                {
                    ApplicationArea = Basic;
                }
                field(OverdraftNos; "Overdraft Nos")
                {
                    ApplicationArea = Basic;
                }
                field(ImprestReqNo; "Imprest Req No")
                {
                    ApplicationArea = Basic;
                }
                field(ImprestSurrenderNo; "Imprest Surrender No")
                {
                    ApplicationArea = Basic;
                }
                field("Portal Loan Nos"; "Portal Loan Nos")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        v: Record "RFQ Header";
    begin

        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;
}

