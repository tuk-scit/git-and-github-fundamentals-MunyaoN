page 52188561 "Payroll Periods Card"
{
    Caption = 'Payroll Periods Card';
    PageType = Card;
    SourceTable = "Payroll Periods";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Year field.';
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Name field.';
                }

                field("Date Opened"; "Date Opened")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Name field.';
                }
            }
        }
    }
}
