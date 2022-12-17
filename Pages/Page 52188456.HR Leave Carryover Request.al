
Page 52188456 "HR Leave Carryover Request"
{
    PageType = Card;
    SourceTable = "HR Leave Carry Allocation.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ApplicationCode;"Application Code")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate;"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(ApplicantComments;"Applicant Comments")
                {
                    ApplicationArea = Basic;
                }
                field(Names;Names)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(JobTittle;"Job Tittle")
                {
                    ApplicationArea = Basic;
                }
                field(UserID;"User ID")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo;"Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter;"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Approveddays;"Approved days")
                {
                    ApplicationArea = Basic;
                }
                field(Attachments;Attachments)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition",Job;
                    ApprovalEntries: Page "Approval Entries";
                begin
                    
                    /*
                    DocumentType:=DocumentType::Job;
                    ApprovalEntries.Setfilters(DATABASE::Table39005606,DocumentType,"Application Code");
                    ApprovalEntries.RUN;
                    */

                end;
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    /*
                    
                    IF CONFIRM('Send this Carry over request for Approval?',TRUE)=FALSE THEN EXIT;
                    //AppMgmt.SendLeaveCarryoverApprovalReq(Rec);*/

                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    /*
                    IF CONFIRM('Cancel Approval Request?',TRUE)=FALSE THEN EXIT;
                    //AppMgmt.CancelLeaveCarryoverAreasRequest(Rec,TRUE,TRUE);
                    */

                end;
            }
        }
    }
}

