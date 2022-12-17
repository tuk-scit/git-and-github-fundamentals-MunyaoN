
Page 52188658 "Cheque Types"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Cheque Types";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(ClearingDays;"Clearing Days")
                {
                    ApplicationArea = Basic;
                }
                field(Control9;"Clearing  Days")
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

