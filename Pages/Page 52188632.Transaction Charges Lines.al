
Page 52188632 "Transaction Charges Lines"
{
    PageType = ListPart;
    SourceTable = "Transaction Charges Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeType;"Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAmount;"Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field(PercentageofAmount;"Percentage of Amount")
                {
                    ApplicationArea = Basic;
                }
                field(StaggeredChargeCode;"Staggered Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(MinimumAmount;"Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field(MaximumAmount;"Maximum Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAccountType;"Charge Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAccount;"Charge Account")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeExciseDuty;"Charge Excise Duty")
                {
                    ApplicationArea = Basic;
                }
                field(SharingAccountType;"Sharing Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(SharingAccountNo;"Sharing Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(SharingValue;"Sharing Value")
                {
                    ApplicationArea = Basic;
                }
                field(SharingUsePercentage;"Sharing Use Percentage")
                {
                    ApplicationArea = Basic;
                }
                field(SharingExciseDuty;"Sharing Excise Duty")
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

