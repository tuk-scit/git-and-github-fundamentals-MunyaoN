
Page 52188517 "Cheque Receipt Lines"
{
    PageType = ListPart;
    SourceTable = "Cheque Issue Lines_";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChequeSerialNo;"Cheque Serial No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountNo;"Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountName;"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AvailableBalance;"Available Balance")
                {
                    ApplicationArea = Basic;
                }
                field(UnpayCode;"Un pay Code")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Cheque Setup";
                }
                field(Interpretation;Interpretation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UnpayDate;"Unpay Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UnPayChargeAmount;"Un Pay Charge Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CoopAccountNo;"Coop Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateRefferenceNo;"Date _Refference No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionCode;"Transaction Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(BranchCode;"Branch Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

