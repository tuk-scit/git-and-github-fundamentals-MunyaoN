
Page 52188633 "Transaction Charges Card"
{
    PageType = Card;
    SourceTable = "Transaction Charges";

    layout
    {
        area(content)
        {
            group(General)
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
                field(Category;Category)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control9;"Transaction Charges Lines")
            {
                SubPageLink = "Transaction Type"=field(Code);
            }
        }
    }

    actions
    {
    }
}

