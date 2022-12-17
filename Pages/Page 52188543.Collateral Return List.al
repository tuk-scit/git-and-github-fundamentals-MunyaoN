
Page 52188543 "Collateral Return List"
{
    ApplicationArea = Basic;
    CardPageID = "Collateral Return Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Collateral Collection";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; "Account No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                }
                field(AccountName; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Collateral; Collateral)
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

