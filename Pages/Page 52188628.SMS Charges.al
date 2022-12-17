
Page 52188628 "SMS Charges"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "SMS Charges";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Source;Source)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAmount;"Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeGLAccount;"Charge G/L Account")
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

