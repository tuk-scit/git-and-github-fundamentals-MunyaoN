
Page 52188469 "HR Leave Applications History"
{
    //CardPageID = 39003948;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Leave Application.";
    SourceTableView = where(Status = const(Approved));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field(ApplicationNo; "Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Name';
                    Editable = false;
                    Enabled = false;
                }
                field(ApplicantStaffNo; "Applicant Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveType; "Leave Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DaysApplied; "Days Applied")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; "Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(ReturnDate; "Return Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Leave Factbox")
            {
                SubPageLink = "No." = field("Applicant Staff No.");
            }
            systempart(Control1102755004; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //HREmp.RESET;
        //HREmp.SETRANGE(HREmp."User ID",USERID);
        //IF HREmp.GET THEN
        //SETRANGE("User ID",HREmp."User ID")
        //ELSE
        //user id may not be the creator of the doc
        //SETRANGE("User ID",USERID);
    end;

    var
        Text19010232: label 'Leave Statistics';
        Text1: label 'Reliver Details';
}

