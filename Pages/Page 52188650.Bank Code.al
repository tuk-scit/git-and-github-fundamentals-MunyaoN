
Page 52188650 "Bank Code"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Bank Codes";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(BankCode;"Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankName;"Bank Name")
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

