
PageExtension 52188451 GeneralLedgerSetup extends "General Ledger Setup"
{

    layout
    {
        Addlast(Content)
        {
            group("Custom Setups")
            {
                field("SMS Sender ID"; "SMS Sender ID")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Sender Name"; "SMS Sender Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }

    }
}

