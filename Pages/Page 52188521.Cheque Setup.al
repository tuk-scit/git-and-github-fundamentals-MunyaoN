
Page 52188521 "Cheque Setup"
{
    PageType = List;
    SourceTable = "Cheque Set Up_";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChequeCode;"Cheque Code")
                {
                    ApplicationArea = Basic;
                }
                field(NumberOfLeaf;"Number Of Leaf")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
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

