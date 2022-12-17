
Page 52188656 "Monthly Contributions"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; "Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ProductName; "Product Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ProductCategory; "Product Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MonthlyContribution; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyContributionDate; "Monthly Contribution Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ContributionUpdatedBy; "Contribution Updated By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

