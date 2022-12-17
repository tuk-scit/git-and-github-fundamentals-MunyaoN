Page 52188461 "HR Leave Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Leave Application.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ApplicationNo; "Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    Editable = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(ApplicationDate; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(No; "Applicant Staff No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    Importance = Promoted;
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                    Importance = Promoted;
                }
                field(JobTitle; "Job Tittle")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Enabled = false;
                    Importance = Promoted;
                }
                field(Designation; Designation)
                {
                    ApplicationArea = Basic;
                }
                field(ApplicantSupervisor; "Applicant Supervisor")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SupervisorEmail; "Supervisor Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                label("**")
                {
                    ApplicationArea = Basic;
                    Caption = '*';
                }
                field(LeaveType; "Leave Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(DaysApplied; "Days Applied")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        //Commented to favour CAPITAl sacco
                        //IF "Days Applied" > dLeft THEN ERROR('Days applied exceeds Leave balance');
                    end;
                }
                field(StartDate; "Start Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        //IF "Start Date"<>0D THEN
                        //BEGIN
                        //check for overlap


                        //END;
                    end;
                }
                field(EndDate; "End Date")
                {
                    ApplicationArea = Basic;
                }
                field(ReturnDate; "Return Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Leave Purpose"; Description)
                {
                    ApplicationArea = Basic;
                }
                label("***")
                {
                    ApplicationArea = Basic;
                    Caption = '*';
                }
                field(AllocatedDays; "Allocated Days")
                {
                    ApplicationArea = Basic;
                }
                field(EarnedDays; "Earned Days")
                {
                    ApplicationArea = Basic;
                }
                field(ReImbursedDays; "Re-Imbursed Days")
                {
                    ApplicationArea = Basic;
                }
                field(TotalLeaveDays; "Total Leave Days")
                {
                    ApplicationArea = Basic;
                }
                field(DaysTaken; "Days Taken")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveBalance; "Leave Balance")
                {
                    ApplicationArea = Basic;
                }
                label("****")
                {
                    ApplicationArea = Basic;
                    Caption = '*';
                }
                field(Reliever; Reliever)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reliever Code';
                    ShowMandatory = false;
                }
                field(RelieverName; "Reliever Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                label("*****")
                {
                    ApplicationArea = Basic;
                    Caption = '*';
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(PostedBy; "Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DatePosted; "Date Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimePosted; "Time Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
            group(MoreLeaveDetails)
            {
                Caption = 'More Leave Details';
                field(CellPhoneNumber; "Cell Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field(AlternativeCellPhoneNo; "Alternative CellPhone No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmailAddress; "E-mail Address")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                }
                field(DetailsofExamination; "Details of Examination")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(DateofExam; "Date of Exam")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(NumberofPreviousAttempts; "Number of Previous Attempts")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        UserSetup.Get(UserId);

                        HRSetup.Get;
                        HRSetup.TestField("Leave Administrator");

                        if "Applicant Supervisor" <> UserSetup."User ID" then
                            if UserSetup."User ID" <> HRSetup."Leave Administrator" then
                                Error('You do not have permission to Approve this Leave');


                        if Confirm('Are you sure you want to Approve this Leave') then begin
                            Validate(Status, Status::Approved);
                            Modify;
                        end;
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Confirm('Are you sure you want to Reject this Leave') then begin
                            Validate(Status, Status::Rejected);
                            Modify;
                        end;
                    end;
                }
            }
            group(Reliver)
            {
                Caption = 'Reliver';
                action("Print Application Form")
                {
                    ApplicationArea = Basic;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code", "Application Code");
                        if HRLeaveApp.FindFirst then
                            Report.Run(2000015, true, false, HRLeaveApp);
                    end;
                }
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Approval Document Type";
                        //CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        //TESTFIELD(e)
                        //TESTFIELD("Cell Phone Number");
                        //TESTFIELD(Address);
                        TestField("Start Date");
                        TestField("Job Tittle");
                        //TESTFIELD("Interest Due Date");}

                        TESTFIELDS;
                        //CheckControls;

                        VarVariant := Rec;
                        //CalwideApprovals.CreateTracker(VarVariant, "Application Code", 0, Documenttype::Leave, "Global Dimension 1 Code", "Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ////CalwideApprovals: Codeunit "Calwide Approvals";
                        DocumentType: Enum "Approval Document Type";
                    begin
                        TestField(Status, Status::"Pending Approval");

                        VarVariant := Rec;
                        //CalwideApprovals.CancelTracker(VarVariant, "Application Code");
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff,"Bankers Cheque",Salary,Overdraft,Imprest,"Imprest Surrender",Teller,"Mbanking Application",Leave;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::Leave;


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", "Application Code");
                        ApprovalTracker.SetRange("Document Type", DocType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if (Status <> Status::New) and (Status <> Status::"Pending Approval") then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;
                            Status := Status::New;
                            Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Get Employee Details
        FillVariables;


        //Get leave statistics

        //Approvals
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        /*
          HRLeaveApp.RESET;
          HRLeaveApp.SETRANGE(HRLeaveApp.Status,HRLeaveApp.Status::New);
          HRLeaveApp.SETRANGE(HRLeaveApp."Applicant User ID",USERID);
          IF HRLeaveApp.FIND('-') THEN
          BEGIN
              IF HRLeaveApp.COUNT > 0 THEN
              BEGIN
                  ERROR('There are still some untilized Leave Application Documents [ %1 ]. Please utilise them first'
                        ,HRLeaveApp."Application Code");
              END;
          END;
          */

    end;

    trigger OnOpenPage()
    begin
        if Status = Status::Approved then
            CurrPage.Editable := false
    end;

    var
        VarVariant: Variant;
        HREmp: Record Employee;
        EmpJobDesc: Text[50];
        SupervisorName: Text[60];
        ////SMTP: Codeunit UnknownCodeunit400;
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup.";
        EmpDimension_1: Text[60];
        EmpDimension_2: Text[60];
        HRLeaveApp: Record "HR Leave Application.";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries.";
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types.";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        LeaveGjline: Record "HR Leave Journal Line.";
        "LineNo.": Integer;
        sDate: Record Date;
        Customized: Record "HR Leave Calendar Lines.";
        HRJournalBatch: Record "HR Leave Journal Batch.";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HRLeaveCal: Record "HR Leave Calendar.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        EarnedToDate: Decimal;
        m: Integer;
        HRDepartments: Record "HR Departments";


    procedure FillVariables()
    begin
        //Only modify document if status is not NEW
        if Status <> Status::New then begin
            //Fill Employee Details

        end;
    end;


    procedure TESTFIELDS()
    begin
        TestField("Leave Type");
        TestField("Days Applied");
        TestField("Start Date");
        TestField(Reliever);
        TestField("Applicant Supervisor");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        //HasIncomingDocument := "Incoming Document Entry No." <> 0;
        //SetExtDocNoMandatoryCondition;
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
    end;
}

