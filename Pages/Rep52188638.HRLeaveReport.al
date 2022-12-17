report 52188638 "HR Leave Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HRLeaveT.rdl';
    ApplicationArea = All;
    Caption = 'HR Leave Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(HRLeaveApplication; "HR Leave Application.")
        {
            column(Address; Address)
            {
            }
            column(AllocatedDays; "Allocated Days")
            {
            }
            column(AlternativeCellPhoneNo; "Alternative CellPhone No.")
            {
            }
            column(ApplicantComments; "Applicant Comments")
            {
            }
            column(ApplicantStaffNo; "Applicant Staff No.")
            {
            }
            column(ApplicantSupervisor; "Applicant Supervisor")
            {
            }
            column(ApplicantUserID; "Applicant User ID")
            {
            }
            column(ApplicationCode; "Application Code")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(Approveddays; "Approved days")
            {
            }
            column(ApproverComments; "Approver Comments")
            {
            }
            column(Attachments; Attachments)
            {
            }
            column(CellPhoneNumber; "Cell Phone Number")
            {
            }
            column(CurrentBalance; "Current Balance")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(DateofExam; "Date of Exam")
            {
            }
            column(DaysApplied; "Days Applied")
            {
            }
            column(DaysReimbursed; "Days Reimbursed")
            {
            }
            column(DaysTaken; "Days Taken")
            {
            }
            column(Description; Description)
            {
            }
            column(Designation; Designation)
            {
            }
            column(DetailsofExamination; "Details of Examination")
            {
            }
            column(EmailAddress; "E-mail Address")
            {
            }
            column(EarnedDays; "Earned Days")
            {
            }
            column(Emergency; Emergency)
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(EntryNo; "Entry No")
            {
            }
            column(Gender; Gender)
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension1Name; "Global Dimension 1 Name")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(GlobalDimension2Name; "Global Dimension 2 Name")
            {
            }
            column(JobTittle; "Job Tittle")
            {
            }
            column(LeaveAllowanceAmount; "Leave Allowance Amount")
            {
            }
            column(LeaveAllowanceEntittlement; "Leave Allowance Entittlement")
            {
            }
            column(LeaveBalance; "Leave Balance")
            {
            }
            column(LeaveCode; "Leave Code")
            {
            }
            column(LeaveType; "Leave Type")
            {
            }
            column(Names; Names)
            {
            }
            column(Noseries; "No series")
            {
            }
            column(NumberofPreviousAttempts; "Number of Previous Attempts")
            {
            }
            column(Picture; Picture)
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(ReImbursedDays; "Re-Imbursed Days")
            {
            }
            column(Reimbursed; Reimbursed)
            {
            }
            column(Reliever; Reliever)
            {
            }
            column(RelieverName; "Reliever Name")
            {
            }
            column(RequestLeaveAllowance; "Request Leave Allowance")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(ReturnDate; "Return Date")
            {
            }
            column(Selected; Selected)
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(Status; Status)
            {
            }
            column(SupervisorEmail; "Supervisor Email")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TimePosted; "Time Posted")
            {
            }
            column(TotalLeaveDays; "Total Leave Days")
            {
            }
            column(TotalTaken; "Total Taken")
            {
            }

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
