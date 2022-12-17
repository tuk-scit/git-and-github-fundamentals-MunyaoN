Page 52188548 "Defaulter Loan Recovery Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Defaulter Loan Recovery";

    layout
    {
        area(content)
        {
            group(General)
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
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Type"; "Recovery Type")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Option"; "Recovery Option")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Recover"; "Amount to Recover")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account"; "Source Account")
                {
                    ApplicationArea = Basic;
                    //LookupPageId = "Member Accounts  List";
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; "Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(EnteredBy; "Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(Recovered; Recovered)
                {
                    ApplicationArea = Basic;
                }
                field("Total Available"; "Total Available")
                {
                    ApplicationArea = Basic;
                }
                field("Self Guaranteed"; "Self Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Principal"; "Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Balance"; "Dividend Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Total Deduction"; "Total Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Fee"; "Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Balance"; "Deposit Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Net Refund"; "Net Refund")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control16; "Loans Offset List")
            {
                SubPageLink = "Header No." = field("No."), "Member No" = field("Member No.");
            }
            part(Control15; "Defaulter Recovery Lines")
            {
                SubPageLink = "Header No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {

            action(ValidateAmounts)
            {
                ApplicationArea = Basic;
                Caption = 'Validate Amounts';
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    AppraisalLine: Record "Offset Appraisal";
                    myInt: Integer;
                    j: Integer;
                    PSetup: Record "Product Setup";
                    MemberAccounts: Record Vendor;
                    AvailDep: Decimal;
                    Offset: Record "Loans Offet List";
                    LoanRecLines: Record "Loans Offet List";
                    RunBal: Decimal;
                    DedAmt: Decimal;
                    PrAmt: Decimal;
                    IntAmt: Decimal;
                    TotalGuaranteed: Decimal;
                    SActivities: Codeunit "Sacco Activities";
                    Header: Record "Defaulter Loan Recovery";
                begin

                    AppraisalLine.Reset();
                    AppraisalLine.SetRange("Offset No.", "No.");
                    if AppraisalLine.FindFirst() then begin
                        AppraisalLine.DeleteAll();
                    end;

                    SaccoActivities.CalculateLoanOffset(rec, false);
                    Commit();
                    Message('Updated');


                end;
            }
            action(OffsetReport)
            {
                ApplicationArea = Basic;
                Caption = 'Offset Report';
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    AppraisalLine: Record "Offset Appraisal";
                    myInt: Integer;
                    j: Integer;
                    PSetup: Record "Product Setup";
                    MemberAccounts: Record Vendor;
                    AvailDep: Decimal;
                    Offset: Record "Loans Offet List";
                    LoanRecLines: Record "Loans Offet List";
                    RunBal: Decimal;
                    DedAmt: Decimal;
                    PrAmt: Decimal;
                    IntAmt: Decimal;
                    TotalGuaranteed: Decimal;
                    SActivities: Codeunit "Sacco Activities";
                    Header: Record "Defaulter Loan Recovery";
                    LoanOffsetCalculator: Report "Loan Offset Calculator";
                begin
                    //TestField(Stage, Stage::Booking);                   

                    Header.Reset();
                    Header.SetRange("No.", "No.");
                    if Header.FindFirst() then
                        report.run(52188622, true, false, Header);

                end;
            }


            action(Post)
            {
                ApplicationArea = Basic;
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    AppraisalLine: Record "Offset Appraisal";
                    myInt: Integer;
                    j: Integer;
                    PSetup: Record "Product Setup";
                    MemberAccounts: Record Vendor;
                    AvailDep: Decimal;
                    Offset: Record "Loans Offet List";
                    LoanRecLines: Record "Loans Offet List";
                    RunBal: Decimal;
                    DedAmt: Decimal;
                    PrAmt: Decimal;
                    IntAmt: Decimal;
                    TotalGuaranteed: Decimal;
                    SActivities: Codeunit "Sacco Activities";
                begin

                    if Confirm('Are you sure you want to Post this Offset?') then
                        SaccoActivities.CalculateLoanOffset(rec, true);

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
                        //CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        CheckControls;

                        VarVariant := Rec;
                        //CalwideApprovals.CreateTracker(VarVariant, "No.", 0, Documenttype::"Def. Recovery", "Global Dimension 1 Code", "Global Dimension 2 Code", 0);
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
                        DocumentType: Enum "Approval Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Def. Recovery";

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
        SingleAccountBool: Boolean;
        SingleLoanBool: Boolean;
        MultiAccountBool: Boolean;
        LoanSecurity: Record "Loan Security";
        SaccoActivities: Codeunit "Sacco Activities";
        LLedger: Record "Cust. Ledger Entry";
        RecoveryLines: Record "Defaulter Recovery Lines";
        SLedger: Record "Detailed Vendor Ledg. Entry";
        Loans: Record Loans;

    local procedure UpdateControls()
    begin


        if Status = Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;
    end;

    local procedure CheckControls()
    begin

        TestField(Stage, Stage::Verification);
    end;

    var
        SActivities: Codeunit "Sacco Activities";
        Legacy: Codeunit Legacy;
        MActivities: Codeunit "Member Activities";
        JTemplate: Code[20];
        JBatch: Code[20];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        Security: Record "Loan Security";

}

