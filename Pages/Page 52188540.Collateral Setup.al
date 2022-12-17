
Page 52188540 "Collateral Setup"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Loan Collateral Setup";
    UsageCategory = Lists;

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
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(CollateralMultiplier;"Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked;Blocked)
                {
                    ApplicationArea = Basic;
                }
                field(RevaluationFrequency;"Revaluation Frequency")
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

