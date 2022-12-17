
Page 52188624 "InterBank Transfers List"
{
    CardPageID = "Bank & Cash Transfer Request";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Inter-Bank Transfers";
    SourceTableView = where(Posted=const(false));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field(SourceTransferType;"Source Transfer Type")
                {
                    ApplicationArea = Basic;
                }
                field(PayingBankAccountName;"Paying  Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivingTransferType;"Receiving Transfer Type")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivingBankAccountName;"Receiving Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(CurrencyCodeDestination;"Currency Code Destination")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(CancelledBy;"Cancelled By")
                {
                    ApplicationArea = Basic;
                }
                field(TimeCancelled;"Time Cancelled")
                {
                    ApplicationArea = Basic;
                }
                field(DateCancelled;"Date Cancelled")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    trigger OnOpenPage()
    begin
        
        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Reciept Responsibility Center",UserMgt.GetPurchasesFilter());
        //  setrange("global Dimension 2 Code",UserMgt.GetSetDimensions(userid,2));
          FILTERGROUP(0);
        END;
        */

    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
    end;
}

