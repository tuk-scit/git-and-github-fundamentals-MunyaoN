
Page 52188471 "HR Leave Calendar"
{
    PageType = Card;
    SourceTable = "HR Leave Calendar.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(CalendarCode;"Calendar Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(StartDate;"Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate;"End Date")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentLeaveCalendar;"Current Leave Calendar")
                {
                    ApplicationArea = Basic;
                }
                field(DateCreated;"Date Created")
                {
                    ApplicationArea = Basic;
                }
                field(LastModifiedBy;"Last Modified By")
                {
                    ApplicationArea = Basic;
                }
                field(DateModified;"Date Modified")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control3;"HR Leave Calendar Lines")
            {
                SubPageLink = Code=field("Calendar Code");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateCalendar)
            {
                ApplicationArea = Basic;
                Caption = 'Create Calendar';
                Image = CalculateCalendar;
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    Text8000: Text;
                    TEXT0025: label 'Saturday';
                    TEXT0026: label 'Sunday';
                begin
                    TestField("Calendar Code");
                    TestField("Start Date");
                    TestField("End Date");
                    
                    if Confirm('Generate Calendar [%1]',false,"Calendar Code") = true then
                    begin
                        Date.Reset;
                        Date.SetRange(Date."Period Type",Date."period type"::Date);
                        Date.SetRange(Date."Period Start","Start Date","End Date");
                        if Date.Find('-') then
                        begin
                            HRCalendarList.Reset;
                            HRCalendarList.DeleteAll;
                    
                            repeat
                                HRCalendarList.Init;
                    
                                HRCalendarList.Code:="Calendar Code";
                                HRCalendarList.Date:=Date."Period Start";;      // e.g 01-01-15
                                HRCalendarList.Day:=Date."Period Name";         // e.g Thursday
                                HRCalendarList."Non Working":=fn_DetermineNonWorking(Date."Period Start");
                                /*
                                //Saturday
                                IF  (Date."Period Name" = TEXT0025) AND NOT (HRCalendarList."Non Working") THEN
                                BEGIN
                                    HRCalendarList."Non Working":=TRUE;
                                    HRCalendarList.Reason:=TEXT0025;
                                END;
                                */
                                //Sunday
                                if  (Date."Period Name" = TEXT0026) and not (HRCalendarList."Non Working") then
                                begin
                                    HRCalendarList."Non Working":=true;
                                    HRCalendarList.Reason:=TEXT0026;
                                end;
                    
                                HRCalendarList.Insert;
                             until Date.Next = 0;
                             Message('Process complete');
                        end else
                        begin
                            Error('Invalid Date format');
                        end;
                    end else
                    begin
                        //Creation aborted
                        exit;
                    end;

                end;
            }
        }
    }

    var
        Day: Date;
        Date: Record Date;
        HRCalendarList: Record "HR Leave Calendar Lines.";

    local procedure fn_DetermineNonWorking(currDate: Date) isNonWorking: Boolean
    var
        HRNonWorkingDays: Record "HR Non Working Days & Dates.";
    begin
        isNonWorking:=false;
        HRCalendarList.Reason:='';

        HRNonWorkingDays.Reset;
        if HRNonWorkingDays.Get(currDate) then
        begin
            isNonWorking:=true;
            HRCalendarList.Reason:=HRNonWorkingDays.Reason;
        end;
    end;
}

