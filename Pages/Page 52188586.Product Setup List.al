
Page 52188586 "Product Setup List"
{
    ApplicationArea = Basic;
    CardPageID = "Product Setup Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Product Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ProductID;"Product ID")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(ProductClass;"Product Class")
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory;"Product Category")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code;"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(MbankingKeyWord;"Mbanking Key Word")
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

