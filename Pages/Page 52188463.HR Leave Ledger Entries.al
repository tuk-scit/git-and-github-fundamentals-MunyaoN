
Page 52188463 "HR Leave Ledger Entries"
{
    Caption = 'Leave Ledger Entries';
    DataCaptionFields = "Leave Calendar Code";
    Editable = false;
    PageType = List;
    SourceTable = "HR Leave Ledger Entries.";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(PostingDate;"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveCalendarCode;"Leave Calendar Code")
                {
                    ApplicationArea = Basic;
                }
                field(StaffNo;"Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(StaffName;"Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveType;"Leave Type")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveEntryType;"Leave Entry Type")
                {
                    ApplicationArea = Basic;
                }
                field(Noofdays;"No. of days")
                {
                    ApplicationArea = Basic;
                }
                field(LeavePostingDescription;"Leave Posting Description")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Entry)
            {
                Caption = 'Ent&ry';
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    RunObject = Page "Default Dimension Where-Used";
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
        area(processing)
        {
            action(Navigate)
            {
                ApplicationArea = Basic;
                Caption = '&Navigate';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc("Posting Date","Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    var
        Navigate: Page Navigate;
        Comp: Record "Company Information";
}

