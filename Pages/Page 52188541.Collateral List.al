
Page 52188541 "Collateral List"
{
    ApplicationArea = Basic;
    CardPageID = "Collateral Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Loan Collateral Register";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;"No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo;"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName;"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Collateral;Collateral)
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

