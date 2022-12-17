
Page 52188527 "Default Member Accounts"
{
    PageType = List;
    SourceTable = "Default Savings Products.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Product; Product)
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; "Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyContribution; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Repay Mode"; "Repay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory; "Product Category")
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

