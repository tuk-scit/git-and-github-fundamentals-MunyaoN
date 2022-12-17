
Page 52188600 "Staggered Lines"
{
    PageType = ListPart;
    SourceTable = "Staggered Lines.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LineNo;"Line No.")
                {
                    ApplicationArea = Basic;
                }
                field(LowerLimit;"Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field(UpperLimit;"Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAmount;"Charge Amount")
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

