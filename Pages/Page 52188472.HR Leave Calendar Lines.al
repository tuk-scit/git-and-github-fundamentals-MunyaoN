
Page 52188472 "HR Leave Calendar Lines"
{
    PageType = CardPart;
    SourceTable = "HR Leave Calendar Lines.";

    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                Editable = true;
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field(Day;Day)
                {
                    ApplicationArea = Basic;
                }
                field(NonWorking;"Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(Reason;Reason)
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

