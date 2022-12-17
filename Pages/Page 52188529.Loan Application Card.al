
Page 52188529 "Loan Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Loans;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(LoanNo; "Loan No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                    ShowMandatory = true;

                    LookupPageID = "Member Listing";

                    trigger OnValidate()
                    begin
                        /*
                        //Check share capital requirement
                        SavAcc.RESET;
                        SavAcc.SETRANGE(SavAcc."Member No.","Member No.");
                        SavAcc.SETRANGE(SavAcc."Product Category",SavAcc."Product Category"::"Share Capital");
                        IF SavAcc.FIND('-') THEN BEGIN
                          SavAcc.CALCFIELDS(SavAcc."Balance (LCY)");
                          //Check Minimum savings per product
                          IF SavAcc."Balance (LCY)"<GenSetup."Minimum Share Capital" THEN
                             ERROR(Text019,SavAcc."Balance (LCY)",GenSetup."Minimum Share Capital");
                        END ELSE
                             ERROR(Text019,SavAcc."Balance (LCY)",GenSetup."Minimum Share Capital");
                             */

                    end;
                }
                field(MemberName; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group  Code"; "Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(StaffNo; "Staff No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MinuteNos; "Minute Nos.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(GlobalDimension1Code; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if "Global Dimension 1 Code" = 'MICRO' then infoVisible := true else infoVisible := false;
                    end;
                }
                field(BookingBranch; "Booking Branch")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ApplicationDate; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field(LoanProductType; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                    ShowMandatory = true;
                }

                field("Salary Appraisal No."; "Salary Appraisal No.")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                    ShowMandatory = true;
                }

                field(TopUpType; "Top Up Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if "Top Up Type" = "top up type"::"Add to Existing Loan" then
                            AddToExisting := true
                        else
                            AddToExisting := false;
                    end;
                }
                field(TopUpLoanNo; "Top Up Loan No.")
                {
                    ApplicationArea = Basic;
                    Editable = AddToExisting;
                    Visible = false;
                }
                field(LoanProductTypeName; "Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field(InterestCalculationMethod; "Interest Calculation Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                }
                field(AnnualInterest; "Annual Interest %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RegistrationFee; "Registration Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Use Special Multiplier"; "Use Special Multiplier")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }
                field(AmountApplied; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = ApplicationDetailsEdit;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field(SystemRecommendedAmount; "Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'System Recommended Amount';
                    Editable = false;
                }
                field(ApprovedAmount; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApplicationDetailsEdit;
                }
                field(AmountToDisburse; "Amount To Disburse")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Business Income Amount"; "Business Income Amount")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    ToolTip = 'The average income earned by a member with a business in the last six months';
                }
                field("Main Sector Code"; "Main Sector Code")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }
                field("Main Sector Description"; "Main Sector Description")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }
                field("Sub-Sector Level 1 Code"; "Sub-Sector Level 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }
                field("Sub-Sector Level 1 Description"; "Sub-Sector Level 1 Description")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }

                field("Sub-Sector Level 2 Code"; "Sub-Sector Level 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }
                field("Sub-Sector Level 2 Description"; "Sub-Sector Level 2 Description")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }
                field(RecoveryMode; "Repay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(DepositBoostingOption; "Deposit Boosting Option")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Deposit Boosting"; "Deposit Boosting")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field(ShareFinancing; "Share Capital Boosting")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Financing';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if xRec."Share Capital Boosting" <> 0 then
                            if "Share Capital Boosting" <= 0 then
                                Error('Share Financing Cannot be equal to Zero');
                    end;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanPrincipleRepayment; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanInterestRepayment; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AppraisalFee; "Appraisal Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(DiscountedAmount; "Discounted Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Self Guarantee"; "Self Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field(TypeofDisbursement; "Type of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CapturedBy; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RepaymentFrequency; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementDate; "Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(RepaymentStartDate; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(ScheduleStartDate; "Schedule Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(CompletionDate; "Completion Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved By"; "Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RecommendedbyType; "Recommended by Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(RecommendedBy; "Recommended By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(RecommendedByName; "Recommended By Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(TotalGuaranteed; "Total Guaranteed")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Disbursement)
            {
                field(ModeofDisbursement; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementAccountNo; "Disbursement Account No")
                {
                    ApplicationArea = Basic;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Customer;
                        Accounts: Record Vendor;
                        Customer: Record Customer;
                        Vendor: Record Vendor;
                        GLAcc: Record "G/L Account";
                        Bank: Record "Bank Account";
                    begin
                        if "Mode of Disbursement" = "Mode of Disbursement"::"Transfer to Fosa" then begin
                            "Disbursement Account No" := '';

                            Accounts.Reset();
                            Accounts.SetRange("Member No.", "Member No.");
                            Accounts.SetFilter("Product Category", '%1|%2|%3|%4|',
                            Accounts."Product Category"::"Ordinary Savings",
                            Accounts."Product Category"::Business,
                            Accounts."Product Category"::"Holiday Savings",
                            Accounts."Product Category"::"School Fee");
                            //if Page.RunModal(Page::"Member Accounts  List", Accounts) = Action::LookupOK then
                                "Disbursement Account No" := Accounts."No.";
                        end
                        else begin
                            "Disbursement Account No" := '';
                            Bank.Reset();
                            if Page.RunModal(Page::"Bank Account List", Bank) = Action::LookupOK then
                                "Disbursement Account No" := Bank."No.";
                        end;

                        Validate("Disbursement Account No");
                    end;

                }
                field(ChequeNo; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(BatchNo; "Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = ApprovedEdit;
                }
            }
            part(Control46; "Loan Charges")
            {
                Editable = false;
                SubPageLink = "Loan No." = field("Loan No.");
            }
        }
        area(factboxes)
        {
            part(Control63; "Info Base")
            {
                SubPageLink = "Member No." = field("Member No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Loan Security")
            {
                ApplicationArea = Basic;
                Image = SelectChart;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Loan Security";
                RunPageLink = "Loan No." = field("Loan No.");
            }
            action("Schedule of Properties")
            {
                ApplicationArea = Basic;
                Image = VATEntries;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Schedule of Properties";
                RunPageLink = "Loan No." = field("Loan No.");
            }
            action("Loan Top Up")
            {
                ApplicationArea = Basic;
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Loan Top Up";
                RunPageLink = "Loan No." = field("Loan No."),
                              "Member No." = field("Member No.");
            }
            action("Loan Witness")
            {
                ApplicationArea = Basic;
                Image = SetPriorities;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Loan Witness";
                RunPageLink = "Loan No." = field("Loan No.");
            }
            action("Salary Details")
            {
                ApplicationArea = Basic;
                Image = Calculate;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Salary Details";
                RunPageLink = "Loan No" = field("Loan No.");
            }
            action("Other Clearances")
            {
                ApplicationArea = Basic;
                Image = ClearFilter;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Other Commitments Clearance";
                RunPageLink = "Loan Application No." = field("Loan No.");
            }
            action("Loan Charges")
            {
                ApplicationArea = Basic;
                Image = Costs;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Loan Charges";
                RunPageLink = "Loan No." = field("Loan No."),
                              "Loan Product Type" = field("Loan Product Type");
            }
            action("Post Loan")
            {
                ApplicationArea = Basic;
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;


                trigger OnAction()
                var
                    NetAmt: Decimal;
                begin
                    TestField(Posted, false);
                    TestField(Status, Status::Approved);
                    // if "Mode of Disbursement" = "Mode of Disbursement"::"Transfer to Fosa" then
                    //  TestField("Disbursement Account No");

                    if Confirm('Are you sure you want to post this loan?') then begin
                        SaccoActivities.PostLoan("Loan No.", "Loan No.", "Disbursement Account No", false, NetAmt, "Disbursement Date");
                    end;
                end;
            }
        }
        area(reporting)
        {
            action("Loan Appraisal Report")
            {
                ApplicationArea = Basic;
                Image = AnalysisView;

                trigger OnAction()
                Var
                    AppraisalNew: Record "Member Salary Appraisal";
                begin

                    Commit;
                    //MemberActivities.SetLoanAppraisal("Loan No.");
                    Commit;

                    AppraisalNew.Reset;
                    AppraisalNew.SetRange("Appraisal No.", "Salary Appraisal No.");
                    if AppraisalNew.FindFirst then
                        Report.Run(Report::"Loan Salary Appraisal", true, false, AppraisalNew);
                end;
            }
            action("Loan Payment Voucher")
            {
                ApplicationArea = Basic;
                Image = AnalysisView;

                trigger OnAction()
                begin

                    Commit;
                    MemberActivities.SetLoanAppraisal("Loan No.");
                    Commit;

                    Appraisal.Reset;
                    Appraisal.SetRange("Loan No.", "Loan No.");
                    if Appraisal.FindFirst then
                        Report.Run(52188514, true, false, Appraisal);
                end;
            }
            action("Loan Schedule Report")
            {
                ApplicationArea = Basic;
                Image = Link;

                trigger OnAction()
                begin

                    SaccoActivities.GenerateRepaymentSchedule(Rec);
                    Commit;

                    LoanRec.Reset;
                    LoanRec.SetRange("Loan No.", "Loan No.");
                    if LoanRec.FindFirst then
                        Report.Run(52188436, true, false, LoanRec);
                end;
            }

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
                    Members.SetRange("No.", "Member No.");
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
                    Members.SetRange("No.", "Member No.");
                    if Members.FindFirst then
                        Report.Run(52188443, true, false, Members);
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
                    Visible = SendBool;

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

                        CheckControls;

                        SendNotifications;

                        VarVariant := Rec;
                        //CalwideApprovals.CreateTracker(VarVariant, "Loan No.", "Requested Amount", Documenttype::"Loan Application", "Global Dimension 1 Code", "Booking Branch", Source);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Visible = CancelBool;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        //CalwideApprovals: Codeunit "Calwide Approvals";
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Member Application","Loan Application";
                    begin
                        TestField(Status, Status::Pending);

                        VarVariant := Rec;
                        //CalwideApprovals.CancelTracker(VarVariant, "Loan No.");
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
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application";
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::"Loan Application";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", "Loan No.");
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

                        if (Status <> Status::Open) and (Status <> Status::Pending) then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;
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
        UpdateFields;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateFields;
    end;

    trigger OnOpenPage()
    begin
        UpdateFields;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        Found: Boolean;
        SourceType: Option "New Member","New Account","Loan Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit","Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued",Bonus,Dividend,Bulk,"Standing Order","Loan Bill Due","POS Deposit","Mini Bonus","Leave Application","Loan Witness";
        TotalOffset: Decimal;
        Vend: Record Vendor;
        GLAcc: Record "G/L Account";
        CompInfo: Record "Company Information";
        EndDateSalo: Date;
        TotalLoans: Decimal;
        "******************************************************Controls": Integer;
        ApplicationDetailsEdit: Boolean;
        DisbursementEdit: Boolean;
        ApprovedEdit: Boolean;
        Temp: Record "User Setup";
        MicroDef: Text;
        initDF: DateFormula;
        AddToExisting: Boolean;
        infoVisible: Boolean;
        MemberActivities: Codeunit "Member Activities";
        LoanSecurity: Record "Loan Security";
        LoanRec: Record Loans;
        Appraisal: Record "Loan Appraisal";
        SendBool: Boolean;
        CancelBool: Boolean;
        SaccoActivities: Codeunit "Sacco Activities";
        ProductSetup: Record "Product Setup";

    local procedure UpdateFields()
    begin
        if Status = Status::Open then begin
            ApplicationDetailsEdit := true;
            SendBool := true;
            CancelBool := false;

        end
        else begin
            ApplicationDetailsEdit := true;
            SendBool := false;
            CancelBool := false;
        end;

        if Status = Status::Pending then begin
            CancelBool := true;
        end;
        if Status = Status::Approved then
            ApprovedEdit := true
        else
            ApprovedEdit := false;
    end;

    local procedure SendNotifications()
    var
        MemberActivities: Codeunit "Member Activities";
        Msg: Text;
        Member: Record Customer;
        SMSSource: Enum "SMS Source Enum";
        ProductSetup: Record "Product Setup";
        SenderAddress: Text;
        SenderName: Text;
        CompanyInfo: Record "Company Information";
        SaccoSetup: Record "Sacco Setup";

    begin


        Member.Get("Member No.");
        ProductSetup.Get("Loan Product Type");
        //TestField("Disbursement Account No");
        CompanyInfo.get;
        CompInfo.get;

        IF NOT "SMS Sent" THEN BEGIN
            Msg := 'Dear ' + Member.Name + ', We have received your ' + ProductSetup.Description + ' of KES ' + FORMAT("Requested Amount") + '. If Approved it will be disbursed into your Account.';
            MemberActivities.SendSms(SMSSource::"Loan Application", Member."Mobile Phone No.", Msg, "Loan No.", "Disbursement Account No", FALSE, FALSE);
        END;


        /*

                if SMTPSetup.Get then begin

                    CompanyInfo.Get;
                    SenderName := CompanyInfo.Name;
                    SenderAddress := SMTPSetup."User ID";
                    if SenderName = '' then
                        SenderName := COMPANYNAME;

                            if SaccoActivities.ValidEmailAddress(SenderAddress) then begin
                                 SMTP.CreateMessage(SenderName, SenderAddress, Member."E-Mail", 'LOAN APPLICATION: ' + UpperCase(SenderName), '', true);


                                 //SMTP.AppendBody('<img src="data:image/png;base64,'+MemberActivities.Base64Header+'" alt="Red dot" />');
                                 //SMTP.AppendBody('<br><br>');
                                 SMTP.AppendBody('Dear ' + Member.Name);
                                 SMTP.AppendBody('<br><br>');
                                 SMTP.AppendBody('We have received your ' + ProductSetup.Description + ' of KES ' + Format("Requested Amount") + '. If Approved it will be disbursed into your Account.');
                                 SMTP.AppendBody('<br><br>');
                                 LoanSecurity.Reset;
                                 LoanSecurity.SetRange("Loan No.", "Loan No.");
                                 LoanSecurity.SetRange("SMS Sent", false);
                                 LoanSecurity.SetFilter("Account No.", '<>%1', '');
                                 if LoanSecurity.FindFirst then begin
                                     SMTP.AppendBody('<b>LOAN SECURITY</b>');
                                     SMTP.AppendBody('<table>');
                                     SMTP.AppendBody('<tr>');
                                     SMTP.AppendBody('<th>Security Type</th>');
                                     SMTP.AppendBody('<th>Account No.</th>');
                                     SMTP.AppendBody('<th>Collateral No.</th>');
                                     SMTP.AppendBody('<th>Name</th>');
                                     SMTP.AppendBody('<th>Amount Guaranteed</th>');
                                     SMTP.AppendBody('</tr>');

                                     repeat

                                         SMTP.AppendBody('<tr>');
                                         SMTP.AppendBody('<td>' + Format(LoanSecurity."Guarantor Type") + '</td>');
                                         SMTP.AppendBody('<td>' + LoanSecurity."Account No." + '</td>');
                                         SMTP.AppendBody('<td>' + LoanSecurity."Collateral Reg. No." + '</td>');
                                         SMTP.AppendBody('<td>' + LoanSecurity.Name + '</td>');
                                         SMTP.AppendBody('<td>' + Format(LoanSecurity."Amount Guaranteed") + '</td>');
                                         SMTP.AppendBody('</tr>');

                                     until LoanSecurity.Next = 0;
                                     SMTP.AppendBody('</table>');

                                 end;

                                 SMTP.AppendBody('<br><br>');
                                 SMTP.AppendBody('Kind Regards,');
                                 SMTP.AppendBody('<br>');
                                 SMTP.AppendBody('<hr>');


                                 if SMTP.TrySend then; 


                             end;
                end;*/



        SaccoSetup.get;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Loan No.", "Loan No.");
        LoanSecurity.SetFilter("Account No.", '<>%1', '');
        if LoanSecurity.FindFirst then begin
            repeat
                if Member.Get(LoanSecurity."Member No") then begin

                    Msg := 'Dear ' + Member.Name + ', You have guaranteed ' + "Member Name" + ' ' + ProductSetup.Description + ' of KES ' + Format("Requested Amount") +
                            ' an Amount of KES ' + Format(LoanSecurity."Amount Guaranteed") + '. Call ' + SaccoSetup."Sacco Contacts" + ' if in dispute.';

                    //TestField("Disbursement Account No");
                    if LoanSecurity."Member No" <> "Member No." then
                        MemberActivities.SendSms(Smssource::"Loan Guarantors", Member."Mobile Phone No.", Msg, "Loan No.", "Disbursement Account No", false, false);

                    /* 

                                        if SMTPSetup.Get then begin

                                            CompanyInfo.Get;
                                            SenderName := CompanyInfo.Name;
                                            SenderAddress := SMTPSetup."User ID";
                                            if SenderName = '' then
                                                SenderName := COMPANYNAME;

                                            if SaccoActivities.ValidEmailAddress(SenderAddress) then begin
                                                SMTP.CreateMessage(SenderName, SenderAddress, Member."E-Mail", 'LOAN GUARANTORSHIP: ' + UpperCase(SenderName), '', true);

                                                //SMTP.AppendBody('<img src="data:image/png;base64,'+MemberActivities.Base64Header+'" alt="Red dot" />');
                                                //SMTP.AppendBody('<br><br>');
                                                SMTP.AppendBody('Dear ' + Member."First Name");
                                                SMTP.AppendBody('<br><br>');
                                                SMTP.AppendBody('You have guaranteed ' + "Member Name" + ' ' + ProductSetup.Description + ' of KES ' + Format("Requested Amount") +
                                                    ' an Amount of KES ' + Format(LoanSecurity."Amount Guaranteed") + '. If in dispute kindly contact the SACCCO');
                                                SMTP.AppendBody('<br><br>');

                                                SMTP.AppendBody('<br><br>');
                                                SMTP.AppendBody('Kind Regards,');
                                                SMTP.AppendBody('<br>');
                                                SMTP.AppendBody(SenderName);

                                                SMTP.AppendBody('<hr>');
                                                if SMTP.TrySend then;
                                            end;
                                        end; */

                end;
            until LoanSecurity.Next = 0;
        end;

    end;

    local procedure CheckControls()
    var
        ScheduleofProperties: Record "Schedule of Properties";
    begin

        TestField("Main Sector Code");
        TestField("Sub-Sector Level 1 Code");
        TestField("Sub-Sector Level 2 Code");

        ProductSetup.Reset;
        ProductSetup.SetRange("Product ID", "Loan Product Type");
        ProductSetup.SetRange("Schedule of Property Mandatory", true);
        //ProductSetup.SETRANGE("No Guarantee",FALSE);
        if ProductSetup.FindFirst then begin
            ScheduleofProperties.Reset;
            ScheduleofProperties.SetRange("Loan No.", "Loan No.");
            ScheduleofProperties.SetFilter("Estimated Value", '>0');
            if not ScheduleofProperties.FindFirst then
                Error('Capture Schedule of Properties');

        end;


        CalcFields("Total Guaranteed");

        if ("Loanee Guaranteed" + "Total Guaranteed" < "Requested Amount") and ("Loan Product Type" <> '153') then
            Error('Loan Not Fully Guaranteed');

        if "Salary Appraisal No." = '' then
            Error('Loan Not Appraised');
    end;
}

