
Page 52188429 "Common Activities"
{
    PageType = CardPart;
    SourceTable = "Sacco Cues";

    layout
    {
        area(content)
        {
            cuegroup(Leave)
            {
                field(LeaveApplication; "Leave - Application")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }
                field(LeavePending; "Leave - Pending")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }
                field(LeaveApproved; "Leave - Approved")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }
                field(LeaveRejected; "Leave - Rejected")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                    LookupPageID = "HR Leave Applications List";
                }

                actions
                {
                    action("Staff Claims List")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    action("Staff Imprest Requisition")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    action("Staff Imprest Surrender")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    action("Travel Advance Requisition")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    action("Travel Advance Surrender")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                }
            }
            cuegroup(Approvals)
            {
                field(ApprovalEntry; "Approval Entry")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Requests to Approve";
                    LookupPageID = "Requests to Approve";
                }

                actions
                {
                    action("Requests to Approve")
                    {
                        ApplicationArea = Basic;
                        RunObject = Page "Requests to Approve";
                    }
                    action("Approval Request Entries")
                    {
                        ApplicationArea = Basic;
                        RunObject = Page "Approval Request Entries";
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;
}

