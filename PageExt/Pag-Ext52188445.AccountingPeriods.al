pageextension 52188445 AccountingPeriods extends "Accounting Periods"
{

    layout
    {
        addafter("Date Locked")
        {
            field("Close Posting Period"; "Close Posting Period")
            {
                ApplicationArea = Basic;
            }
            field("Posting Period Closed By"; "Posting Period Closed By")
            {
                ApplicationArea = Basic;
            }
            field("Posting Period Date Closed"; "Posting Period Date Closed")
            {
                ApplicationArea = Basic;
            }
            field("Posting Period Opened By"; "Posting Period Opened By")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        addafter("C&lose Year")
        {
            action("Close User Posting Period")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                begin
                    if Confirm('Are you sure you want to Close Posting Period?') then begin

                        "Close Posting Period" := true;
                        "Posting Period Closed By" := UserId;
                        "Posting Period Date Closed" := Today;
                        Modify();
                        Message('Posting Date Closed');
                    end;
                end;
            }
            action("Open User Posting Period")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    TempAccountingPeriods: Record "Accounting Period" temporary;
                begin
                    if Confirm('Are you sure you want to Open Posting Period?') then begin


                        /*
                         CurrPage.PAGE.GetSelectedRecords(TempAccountingPeriods);

                        CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);

                        StatementBalance := 0;
                        CashBookBalance := 0;
                        if TempBankAccReconciliationLine.FindSet() then begin
                            repeat
                                StatementBalance += TempBankAccReconciliationLine."Statement Amount";
                            until TempBankAccReconciliationLine.Next() = 0;
                        end;
                        */


                        "Close Posting Period" := false;
                        "Posting Period Opened By" := UserId;
                        Modify();
                        Message('Posting Date Opened');
                    end;
                end;
            }
        }
    }
}
