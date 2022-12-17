
Page 52188596 "Loan Product Charges"
{
    PageType = List;
    SourceTable = "Loan Product Charges.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChargeCode; "Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeAmount; "Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Percentage; Percentage)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeType; "Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field(ChargingOption; "Charging Option")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Minimum; Minimum)
                {
                    ApplicationArea = Basic;
                }
                field(Maximum; Maximum)
                {
                    ApplicationArea = Basic;
                }
                field(EffectExciseDuty; "Effect Excise Duty")
                {
                    ApplicationArea = Basic;
                }
                field(Prorate; Prorate)
                {
                    ApplicationArea = Basic;
                }
                field(ChargeMethod; "Charge Method")
                {
                    ApplicationArea = Basic;
                }
                field(StaggeredChargeCode; "Staggered Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Type"; "Posting Type")
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

