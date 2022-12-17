
Page 52188651 "Bank Branches"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Bank Branches";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(BankCode;"Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankName;"Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchCode;"Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(BranchName;"Branch Name")
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

