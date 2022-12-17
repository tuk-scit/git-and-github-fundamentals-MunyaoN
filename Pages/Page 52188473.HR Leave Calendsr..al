
Page 52188473 "HR Leave Calendsr."
{
    ApplicationArea = Basic;
    CardPageID = "HR Leave Calendar";
    Editable = false;
    PageType = List;
    SourceTable = "HR Leave Calendar.";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
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
        }
    }

    actions
    {
    }
}

