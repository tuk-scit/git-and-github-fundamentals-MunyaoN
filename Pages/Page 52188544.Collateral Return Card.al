
Page 52188544 "Collateral Return Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Collateral Collection";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Editable;
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralNo; "Collateral No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Collateral ")
            {
                Editable = false;
                field(CollateralType; "Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field(Collateral; Collateral)
                {
                    ApplicationArea = Basic;
                }
                field(CollateralName; "Collateral Name")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralMultiplier; "Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralValue; "Collateral Value")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralLimit; "Collateral Limit")
                {
                    ApplicationArea = Basic;
                }
                field(ChargedValue; "Charged Value")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralDetails; "Collateral Details")
                {
                    ApplicationArea = Basic;
                }
                field(ValuationType; "Valuation Type")
                {
                    ApplicationArea = Basic;
                }
                field(RegisteredOwner; "Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field(InwardOutward; "Inward/Outward")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LastValuationDate; "Last Valuation Date")
                {
                    ApplicationArea = Basic;
                }
                field(ForcedSaleValue; "Forced Sale Value")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralPerfected; "Collateral Perfected")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(NextValuationDate; "Next Valuation Date")
                {
                    ApplicationArea = Basic;
                }
                field(InsuranceExpiryDate; "Insurance Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field(ReOpenedBy; "Re-Opened By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateReOpened; "Date Re-Opened")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LegallyCleared; "Legally Cleared")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Collection)
            {
                Editable = Editable;
                field(CollectionStatus; "Collection Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CollectorIDNo; "Collector ID No")
                {
                    ApplicationArea = Basic;
                }
                field(CollectorName; "Collector Name")
                {
                    ApplicationArea = Basic;
                }
                field(CollectorPhoneNo; "Collector Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateCollected; "Date Collected")
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
                        DocumentType: Enum "Approval Document Type";
                        VarVariant: Variant;
                        //CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        CheckControls;


                        VarVariant := Rec;
                        //CalwideApprovals.CreateTracker(VarVariant, "No.", 0, Documenttype::"Collateral Register", "Global Dimension 1 Code", "Global Dimension 2 Code", 0);
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
                        approvalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Collateral Register";


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
        Editable: Boolean;
        LoanSecurity: Record "Loan Security";

    local procedure UpdateControls()
    begin

        if Status = Status::Open then
            Editable := true
        else
            Editable := false;
    end;


    procedure CheckControls()
    begin

        TestField(Status, Status::Approved);
        TestField(Status, Status::Open);


        TestField("Collector ID No");
        TestField("Collector Name");
        TestField("Collector Phone No.");

        LoanSecurity.Reset;
        LoanSecurity.SetRange("Collateral Reg. No.", "No.");
        LoanSecurity.SetFilter("Outstanding Principal", '>0');
        if LoanSecurity.FindFirst then
            Error('This Collateral is still linked to an Active Loan: %1 - %2: %3', LoanSecurity."Loan No.", LoanSecurity."Member No", LoanSecurity."Loanee Name");
    end;
}

