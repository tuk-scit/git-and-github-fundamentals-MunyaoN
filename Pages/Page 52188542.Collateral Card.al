
Page 52188542 "Collateral Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loan Collateral Register";

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

                    LookupPageID = "Member Listing";
                }
                field(AccountName; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralType; "Collateral Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateActions;
                    end;
                }
                field(Collateral; Collateral)
                {
                    ApplicationArea = Basic;
                }
                field(CollateralName; "Collateral Name")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        UpdateDescription;
                    end;
                }
                /*field(VehicleClass; "Vehicle Class")
                {
                    ApplicationArea = Basic;
                }
                field("Vehicle Reg. No.";"Vehicle Reg. No.")
                {
                    ApplicationArea = Basic;
                }
                field("Plot Location";"Plot Location")
                {
                    ApplicationArea = Basic;
                }
                field("Plot No.";"Plot No.")
                {
                    ApplicationArea = Basic;
                }*/

                field(CollateralDescription; "Collateral Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
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

            group("Vehicle Details")
            {
                Visible = secVehicle;
                field("Vehicle Class"; "Vehicle Class")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Vehicle Reg. No."; "Vehicle Reg. No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
            }
            group("Land Details")
            {
                Visible = secLand;
                field("Plot Location"; "Plot Location")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Plot No."; "Plot No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {


            action("Revised Member Statement")
            {
                ApplicationArea = Basic;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Members: Record Customer;
                begin
                    Members.Reset;
                    Members.SetRange("No.", "Account No.");
                    if Members.FindFirst then
                        Report.Run(52188613, true, false, Members);
                end;
            }
            action("Member Statement")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Members: Record Customer;
                begin
                    Members.Reset;
                    Members.SetRange("No.", "Account No.");
                    if Members.FindFirst then
                        Report.Run(52188443, true, false, Members);
                end;
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    //Caption = 'Send A&pproval Request';
                    Caption = 'Approve Document';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        DocumentType: Enum "Approval Document Type";
                        VarVariant: Variant;
                        //////CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        CheckControls;

                        if Confirm('Are you sure you want to Approve this Document?') then begin
                            Status := Status::Approved;
                            "Inward/Outward" := "Inward/Outward"::"In-Store";
                            Modify();
                            Message('Approved');

                        end;
                        //VarVariant := Rec;
                        ////////CalwideApprovals.CreateTracker(VarVariant, "No.", 0, Documenttype::"Collateral Register", "Global Dimension 1 Code", "Global Dimension 2 Code", 0);
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
                        //////CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        TestField(Status, Status::Pending);

                        VarVariant := Rec;
                        //////CalwideApprovals.CancelTracker(VarVariant, "No.");
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
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register";
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
                        //////CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Status = Status::Pending then begin
                            VarVariant := Rec;
                            //////CalwideApprovals.CancelTracker(VarVariant, "No.");
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
        secLand: Boolean;
        secVehicle: Boolean;

    local procedure UpdateControls()
    begin

        if Status = Status::Open then
            Editable := true
        else
            Editable := false;
    end;




    local procedure UpdateActions()
    begin


        secVehicle := false;
        secLand := false;


        if "Collateral Type" = "Collateral Type"::"Motor Vehicle" then
            secVehicle := true;

        if "Collateral Type" = "Collateral Type"::"Title Deed" then
            secLand := true;
    end;




    local procedure UpdateDescription()
    begin
        "Collateral Description" := '';

        if ("Vehicle Class" <> '') then
            "Collateral Description" += "Vehicle Class";

        if ("Vehicle Reg. No." <> '') then
            "Collateral Description" += ' ' + "Vehicle Reg. No.";

        if ("Plot Location" <> '') then
            "Collateral Description" += ' ' + "Plot Location";

        if ("Plot No." <> '') then
            "Collateral Description" += ' ' + "Plot No.";
    end;


    procedure CheckControls()
    begin

        TestField(Status, Status::Open);
        if not "Legally Cleared" then
            if not Confirm('Kindly NOTE that "Legally Cleared" needs to be Confirmed. Do you want to proceed?') then
                Error('Aborted');

        if "Valuation Type" = "valuation type"::" " then
            Error('Valuation Type MUST have a value');

        TestField("Last Valuation Date");
        TestField("Account No.");
        TestField(Collateral);
        TestField("Collateral Limit");
        TestField("Collateral Multiplier");
        //TESTFIELD("Collateral Perfected");
        TestField("Collateral Type");
        TestField("Collateral Value");
        TestField("Forced Sale Value");
        TestField("Registered Owner");
    end;
}

