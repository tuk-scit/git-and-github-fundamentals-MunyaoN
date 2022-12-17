page 52188780 "Business Monthly Income"
{
    Caption = 'Business Monthly Income';
    PageType = ListPart;
    SourceTable = "Business Monthly Income";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period field.';
                }
                field("Gross Monthly Income"; Rec."Gross Monthly Income")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gross Monthly Income field.';
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Monthly Repayment field.';
                }
                field("Deficit/Surplus"; Rec."Deficit/Surplus")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deficit/Surplus field.';
                }
            }
        }
    }
}
