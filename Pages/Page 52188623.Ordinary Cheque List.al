
Page 52188623 "Ordinary Cheque List"
{
    PageType = List;
    SourceTable = "Ordinary Cheque Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(OrdinaryChequeNo;"Ordinary Cheque No.")
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

