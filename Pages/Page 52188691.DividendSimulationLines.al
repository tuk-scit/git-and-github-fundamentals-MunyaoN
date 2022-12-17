Page 52188691 "Dividend Simulation Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Dividend Simulation Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(GLAccount; "G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; "Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; "Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; "End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field(WeightedAmount; "Weighted Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Rate; Rate)
                {
                    ApplicationArea = Basic;
                }
                field(PayOut; "Pay Out")
                {
                    ApplicationArea = Basic;
                }
                field(WTax; "W/Tax")
                {
                    ApplicationArea = Basic;
                }
                field(NetPay; "Net Pay")
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

