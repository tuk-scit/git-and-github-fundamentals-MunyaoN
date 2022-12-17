
Page 52188602 "Loan Posted Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field(FormSerialNo; "Form Serial No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
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
                }
                field(ApplicationDate; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;

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
                field(PurposeofLoan; "Purpose of Loan")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }
                field(RecoveryMode; "Repay Mode")
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
                field("Interest to Date"; IntToDate)
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPenalty; "Outstanding Penalty")
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
                    Caption = 'Deposit Boosting';
                    Editable = false;
                    Visible = false;
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
                field(LoanRejectionReason; "Loan Rejection Reason")
                {
                    ApplicationArea = Basic;
                    Editable = DisbursementEdit;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
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
                field("<rescheduled date>"; LoanApp."Date Rescheduled")
                {
                    ApplicationArea = Basic;
                    Caption = '<rescheduled date>';
                }
                field(TotalGuaranteed; "Total Guaranteed")
                {
                    ApplicationArea = Basic;
                }

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
            group(Disbursement)
            {
                field(ModeofDisbursement; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementAccountNo; "Disbursement Account No")
                {
                    ApplicationArea = Basic;
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
        }
        area(factboxes)
        {
            part(Control8; "Loans Statistics FactBox")
            {
                SubPageLink = "Loan No." = field("Loan No.");
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
                RunObject = Page "Loan Security";
                RunPageLink = "Loan No." = field("Loan No.");
            }
            action("Salary Details")
            {
                ApplicationArea = Basic;
                RunObject = Page "Salary Details";
                RunPageLink = "Loan No" = field("Loan No.");
            }
            action("Member Card")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Member Card";
                RunPageLink = "No." = field("Member No.");
            }
        }
        area(reporting)
        {
            action("Loan Appraisal Report")
            {
                ApplicationArea = Basic;
                Image = AnalysisView;

                trigger OnAction()
                begin

                    Appraisal.Reset;
                    Appraisal.SetRange("Loan No.", "Loan No.");
                    if Appraisal.FindFirst then
                        Report.Run(50000, true, false, Appraisal);
                end;
            }
            action("Loan Schedule Report")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    LoanRec.Reset;
                    LoanRec.SetRange("Loan No.", "Loan No.");
                    if LoanRec.FindFirst then
                        Report.Run(52188436, true, false, LoanRec);
                end;
            }
            group("Defaulter Notices")
            {
                Image = ResourcePlanning;
            }
            action("Defaulter 1st Notice")
            {
                ApplicationArea = Basic;
                Caption = 'Defaulter 1st Notice';
                Image = DefaultFault;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", "Loan No.");
                    if LoanApp.Find('-') then begin
                        Report.Run(52188491, true, false, LoanApp)
                    end;
                    //def:=TODAY;
                    //MODIFY;
                end;
            }
            action("Defaulter 2nd Notice")
            {
                ApplicationArea = Basic;
                Caption = 'Defaulter 2nd Notice';
                Image = FaultDefault;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", "Loan No.");
                    if LoanApp.Find('-') then begin
                        Report.Run(52188492, true, false, LoanApp)
                    end;
                    //"BDE Type":=TODAY;
                    //MODIFY;
                end;
            }
            action("Defaulter Final Notice")
            {
                ApplicationArea = Basic;
                Caption = 'Defaulter Final Notice';
                Image = LimitedCredit;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", "Loan No.");
                    if LoanApp.Find('-') then begin
                        Report.Run(52188493, true, false, LoanApp)
                    end;
                    //"Loan Group":=TODAY;
                    //MODIFY;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        IntToDate := SaccoActivities.GetInterestDue(Rec, Today);
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
        LoanSecurity: Record "Shipment Method";
        LoanRec: Record Loans;
        Appraisal: Record "Loan Appraisal";
        SendBool: Boolean;
        CancelBool: Boolean;
        SaccoActivities: Codeunit "Sacco Activities";
        IntToDate: Decimal;
        LoanApp: Record Loans;
}

