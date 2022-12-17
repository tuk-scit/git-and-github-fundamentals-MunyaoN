
Page 52188631 "Transaction Charges List"
{
    ApplicationArea = Basic;
    CardPageID = "Transaction Charges Card";
    Editable = false;
    PageType = List;
    SourceTable = "Transaction Charges";
    UsageCategory = Tasks;

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
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field(ProductType;"Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(DefaultMode;"Default Mode")
                {
                    ApplicationArea = Basic;
                }
                field(ProductName;"Product Name")
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

