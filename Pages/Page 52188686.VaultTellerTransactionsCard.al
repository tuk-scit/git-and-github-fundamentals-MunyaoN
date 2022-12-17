#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 52188686 "Treasury/Teller Trans. Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Treasury/Teller Transactions";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionType; "Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = TransType;
                }
                field(From; "From Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'From';
                    Editable = FrAccount;
                }
                field(FromTill; "From Till")
                {
                    ApplicationArea = Basic;
                }
                field(FromBalance; "From Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(FromBank; "From Bank")
                {
                    ApplicationArea = Basic;
                }
                field("To"; "To Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'To';
                    Editable = ToAccount;
                }
                field(ToTill; "To Till")
                {
                    ApplicationArea = Basic;
                }
                field(ToBank; "To Bank")
                {
                    ApplicationArea = Basic;
                }
                field(ToBalance; "To Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = TreasuryEditable;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = Amnt;
                }
                field(CurrencyCode; "Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = Currr;
                    Visible = false;
                }
                field(ChequeDocumentNo; "External Document No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/Document No.';
                    Editable = ExternDoc;
                }
                field(Issued; Issued)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateIssued; "Date Issued")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(TimeIssued; "Time Issued")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IssuedBy; "Issued By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Received; Received)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateReceived; "Date Received")
                {
                    ApplicationArea = Basic;
                }
                field(TimeReceived; "Time Received")
                {
                    ApplicationArea = Basic;
                }
                field(ReceivedBy; "Received By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalCashonTreasuryTellerCoinage; "Total Cash on Treasury Coinage")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Cash on Treasury/Teller Coinage';
                }
                field(CapturedBy; "Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                    Editable = Typee;
                }
                field(ExcessShortageAmount; "Excess/Shortage Amount")
                {
                    ApplicationArea = Basic;
                    Editable = Excess;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control34; Coinage)
            {
                SubPageLink = No = field(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Issue/Return")
            {
                ApplicationArea = Basic;
                Caption = 'Issue/Return';
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    /*
                    IF "Transaction Type"="Transaction Type"::"Inter Teller Transfers" THEN BEGIN
                      IF Status<>Status::Approved THEN
                        ERROR('Transaction must be approved');
                    END;
                    */

                    if "External Document No." = '' then
                        Error(Error002);

                    SaccoActivities.PostTreasuryTellerIssue(Rec);

                end;
            }
            separator(Action31)
            {
            }
            action(Receive)
            {
                ApplicationArea = Basic;
                Caption = 'Receive';
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    //IF Status<>Status::Approved THEN
                    //  ERROR('Transaction must be approved');

                    SaccoActivities.PostTreasuryTellerReceive(Rec);
                end;
            }
            action("Coinage Report")
            {
                ApplicationArea = Basic;
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TreasuryTellerTransactions.Reset;
                    TreasuryTellerTransactions.SetRange(Code, Code);
                    if TreasuryTellerTransactions.FindFirst then
                        Report.Run(50075, true, false, TreasuryTellerTransactions);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        SetControlAppearance;
    end;

    trigger OnInit()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        if Posted = true then
            CurrPage.Editable := false;
    end;

    var
        TransType: Boolean;
        FrAccount: Boolean;
        ToAccount: Boolean;
        Amnt: Boolean;
        Currr: Boolean;
        ExternDoc: Boolean;
        Excess: Boolean;
        Cnage: Boolean;
        Typee: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        BUser: Record "Banking User Setup";
        TreasuryEditable: Boolean;
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        Error001: label 'Kindly ensure Amount is Equal to Coinage Amount';
        Error002: label 'Document No./Cheque No. Must have a value';
        TreasuryTellerTransactions: Record "Treasury/Teller Transactions";

    local procedure UpdateControls()
    begin
        if (Issued = Issued::Yes) or (Received = Received::Yes) then begin
            TransType := false;
            FrAccount := false;
            ToAccount := false;
            Amnt := false;
            Excess := false;
            Currr := false;
            Cnage := false;
            ExternDoc := false;
            Typee := false;
        end else begin
            TransType := true;
            FrAccount := true;
            ToAccount := true;
            Amnt := true;
            Excess := true;
            Currr := true;
            Cnage := true;
            ExternDoc := true;
            Typee := true;

        end;

        TreasuryEditable := true;
        BUser.Reset;
        BUser.SetRange("User Name", UserId);
        BUser.SetRange(Type, BUser.Type::Cashier);
        if BUser.FindFirst then
            TreasuryEditable := false;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
    end;
}

