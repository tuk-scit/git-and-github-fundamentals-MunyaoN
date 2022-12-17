
Page 52188546 "Loan Changes Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loan Changes";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(MemberName; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(TypeofChange; "Type of Change")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateControls;
                    end;
                }
                field(LoanNo; "Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; "Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPenalty; "Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingAppraisal; "Outstanding Appraisal")
                {
                    ApplicationArea = Basic;
                }
                field(TotalOutstanding; "Total Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Processed)
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }

            }
            group(Rescheduling)
            {
                Caption = 'Rescheduling';
                Visible = ReschdulingBool;
                field(ReschedulingType; "Rescheduling Type")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeType; "Charge Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Rescheduling Date"; "Rescheduling Date")
                {
                    ApplicationArea = Basic;
                }
                field(NewInterestDue; "New Interest Due")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Charges; Charges)
                {
                    ApplicationArea = Basic;
                }
                field(OriginalInstallments; "Original Installments")
                {
                    ApplicationArea = Basic;
                }
                field(MaximunInstallments; "Maximun Installments")
                {
                    ApplicationArea = Basic;
                }
                field(RemainingInstallments; "Remaining Installments")
                {
                    ApplicationArea = Basic;
                }
                field(NewInstallments; "New Installments")
                {
                    ApplicationArea = Basic;
                }
                field(OldRepayment; "Old Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(NewRepayment; "New Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(AdjustedRepayment; "Adjusted Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(NewLoanAmount; "New Loan Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            group(RecoveryMode)
            {
                Caption = 'Recovery Mode';
                Visible = RecoveryBool;
                field(Control39; "Repay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NewRecoveryMode; "New Recovery Mode")
                {
                    ApplicationArea = Basic;
                }
            }
            group(DebtCollection)
            {
                Caption = 'Debt Collector';
                Visible = DebtBool;
                field("Debt Coll. Def Amount"; "Debt Coll. Def Amount")
                {
                    Caption = 'Amount Defaulted';
                    ApplicationArea = Basic;
                }
                field("Debt Collector Type"; "Debt Collector Type")
                {
                    ApplicationArea = Basic;
                }
                field("Debt Collector"; "Debt Collector")
                {
                    ApplicationArea = Basic;
                }
                field("Debt Collector Name"; "Debt Collector Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(InterestChanges)
            {
                Caption = 'Interest Changes';
                Visible = InterestBool;
                field(InterestRate; "Interest Rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NewInterestRate; "New Interest Rate")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Loansuspension)
            {
                Caption = 'Loan Suspension';
                Visible = LoanSuspensionBool;
                field("Loan Suspended"; "Loan Suspended")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Suspension Start Date"; "Loan Suspension Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Suspension End Date"; "Loan Suspension End Date")
                {
                    ApplicationArea = Basic;
                }
            }

            group(ProductType)
            {
                Caption = 'Update Product Type';
                Visible = LoanProductVisible;

                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type Name"; "Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("New Loan Product Type"; "New Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("New Loan Product Type Name"; "New Loan Product Type Name")
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
            action("Post Change")
            {
                ApplicationArea = Basic;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TestField(Status, Status::Approved);
                    TestField(Processed, false);

                    SaccoActivities.LoanChangesFn(Rec);
                    Message('Process Completed');
                end;
            }
        }
        area(processing)
        {
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
                        VarVariant: Variant;
                        ////CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        CheckControls;
                        //Rec
                        VarVariant := Rec;
                        //CalwideApprovals.CreateTracker(VarVariant, "No.", 0, Documenttype::"Loan Changes", "Global Dimension 1 Code", "Global Dimension 2 Code", 0);
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
                        //CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        TestField(Status, Status::Pending);

                        VarVariant := Rec;
                        //CalwideApprovals.CancelTracker(VarVariant, "No.");
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
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Loan Changes";

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", "No.");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        //CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Status = Status::Pending then begin
                            VarVariant := Rec;
                            //CalwideApprovals.CancelTracker(VarVariant, "No.");
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Status := Status::Open;
                            Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        RecoveryBool: Boolean;
        InterestBool: Boolean;
        ReschdulingBool: Boolean;
        DebtBool: Boolean;
        SaccoActivities: Codeunit "Sacco Activities";
        Loans: Record Loans;
        LoanSuspensionBool: Boolean;
        LoanProductVisible: Boolean;

    local procedure UpdateControls()
    begin

        InterestBool := false;
        ReschdulingBool := false;
        RecoveryBool := false;
        LoanSuspensionBool := false;
        LoanProductVisible := false;
        DebtBool := false;


        if "Type of Change" = "type of change"::"Debt Collector" then
            DebtBool := true;
        if "Type of Change" = "type of change"::"Interest Rate" then
            InterestBool := true;

        if "Type of Change" = "type of change"::"Loan Rescheduling" then
            ReschdulingBool := true;

        if "Type of Change" = "type of change"::"Repay Mode" then
            RecoveryBool := true;

        LoanSuspensionBool := "Type of Change" = "Type of Change"::"Loan Suspension";
        LoanProductVisible := "Type of Change" = "Type of Change"::"Update Product Type";
        // LoanProductVisible := "Type of of Change"="Type of of Change"


        if Status = Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;
    end;

    local procedure CheckControls()
    begin
        TestField(Processed, false);
        TestField(Status, Status::Open);

        if "Type of Change" = "type of change"::"Interest Rate" then begin
            TestField("New Interest Rate");
        end;
        if "Type of Change" = "type of change"::"Loan Suspension" then begin
            TestField("Loan Suspension Start Date");
            TestField("Loan Suspension End Date");
        end;

        if "Type of Change" = "type of change"::"Repay Mode" then begin
            if "New Recovery Mode" = "new recovery mode"::" " then
                Error('New Recovery Mode not captured');
        end;

        if "Type of Change" = "type of change"::"Loan Rescheduling" then begin
            if "Rescheduling Type" = "rescheduling type"::" " then
                Error('Enter Rescheduling Type');

            TestField("New Installments");
            TestField("New Repayment");
            TestField("Adjusted Repayment");
            TestField("Rescheduling Date");
        end;
    end;
}

