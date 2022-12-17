
Page 52188447 "Payroll Periods."
{
    ApplicationArea = Basic;
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Periods";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control11)
            {
                field(PeriodMonth; "Period Month")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodYear; "Period Year")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodName; "Period Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateOpened; "Date Opened")
                {
                    ApplicationArea = Basic;
                }
                field(OpenedBy; "Opened By")
                {
                    ApplicationArea = Basic;
                }
                field(DateClosed; "Date Closed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ClosedBy; "Closed By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ClosePeriod)
            {
                ApplicationArea = Basic;
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin


                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'Do still want to close [' + strPeriodName + ']?';

                    Answer := Dialog.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(PayrollProcessing);
                        PayrollProcessing.ClosePayrollPeriod(dtOpenPeriod);
                        Message('Process Complete');
                    end
                    else begin
                        Message('You have selected NOT to Close the period');
                    end
                end;
            }

            action(NewPeriod)
            {
                ApplicationArea = Basic;
                Caption = 'New Period';
                Image = NewProperties;
                Promoted = true;
                PromotedCategory = Process;
                Visible = NewPeriodVisible;

                trigger OnAction()

                begin
                    if Confirm('Are you sure you want to open a new period?') then begin
                        Page.Run(52188561);
                    end;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        RestrictAccess
    end;

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN
            NewPeriodVisible := true
        else
            NewPeriodVisible := false;
    end;

    trigger OnAfterGetRecord()
    begin
        RESET;
        IF NOT GET THEN
            NewPeriodVisible := true
        else
            NewPeriodVisible := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RESET;
        IF NOT GET THEN
            NewPeriodVisible := true
        else
            NewPeriodVisible := false;
    end;

    var
        PayrollPeriods: Record "Payroll Periods";
        strPeriodName: Text[30];
        Question: Text[250];
        Answer: Boolean;
        PayrollProcessing: Codeunit "Payroll Processing";
        dtOpenPeriod: Date;
        NewPeriodVisible: Boolean;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange(Payroll, true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Payroll"');
    end;


    procedure fnGetOpenPeriod()
    begin

        PayrollPeriods.Reset;
        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
        if PayrollPeriods.Find('-') then begin
            strPeriodName := PayrollPeriods."Period Name";
            dtOpenPeriod := PayrollPeriods."Date Opened";
        end;
    end;

}

