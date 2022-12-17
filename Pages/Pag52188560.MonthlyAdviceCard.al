page 52188560 "Monthly Advice Card"
{
    Caption = 'Monthly Advice Card';
    PageType = Card;
    SourceTable = "Monthly Advice Header";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Code field.';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Name field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entered By field.';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Entered field.';
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Entered field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }

            part(Control6; "Monthly Advice Buffer")
            {
                SubPageLink = "Advice Header No." = field("No.");
            }
        }
    }


    actions
    {
        area(processing)
        {
            action("Generate Advice")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MonthlyAdvice.Reset;
                    MonthlyAdvice.SetRange("No.", "No.");
                    if MonthlyAdvice.FindFirst then
                        Report.Run(Report::"Generate Monthly Advice_", true, false, MonthlyAdvice);

                end;
            }
            action("Advice Report")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MonthlyAdviceLine.Reset;
                    MonthlyAdviceLine.SetRange("Advice Header No.", "No.");
                    if MonthlyAdviceLine.FindFirst then
                        Report.Run(Report::"Checkoff Advice Report", true, false, MonthlyAdviceLine);

                end;
            }
        }


    }

    var
        MonthlyAdvice: Record "Monthly Advice Header";
        MonthlyAdviceLine: Record "Monthly Advice";

}
