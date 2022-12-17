
Page 52188597 Charges
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Charges.";
    UsageCategory = Lists;

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
                field(ChargeMethod; "Charge Method")
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
                field(ChargesGLAccount; "Charges G_L Account")
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
                    Editable = true;
                }
                field(Prorate; Prorate)
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

