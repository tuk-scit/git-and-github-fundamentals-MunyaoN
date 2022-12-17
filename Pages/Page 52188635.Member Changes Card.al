
Page 52188635 "Member Changes Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Changes";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group("Member Change")
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; "Account Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        /*
                        IF "Account Type" = "Account Type"::Savings THEN BEGIN
                          SingleMemberVisibl:=FALSE;
                          GroupMemberVisibl:=FALSE;
                          IsFixedDepositVisibl:=FALSE;
                          IsJuniorVisibl:=FALSE;
                          EmployerVisibl:=FALSE;
                          BankDetailVisibl:=FALSE;
                        END ELSE BEGIN
                          SingleMemberVisibl:=FALSE;
                          GroupMemberVisibl:=FALSE;
                          IsFixedDepositVisibl:=FALSE;
                          IsJuniorVisibl:=FALSE;
                          EmployerVisibl:=FALSE;
                          BankDetailVisibl:=FALSE;
                          END;
                        */
                        StatusControl;

                    end;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field("Full Name"; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChangeType; "Change Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateActions;
                    end;
                }
                field(ApprovalStatus; "Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ReasonForChange; "Reason For Change")
                {
                    ApplicationArea = Basic;
                }
            }
            group(General)
            {
                Visible = secGeneral;
                field(FirstName; "First Name")
                {
                    ApplicationArea = Basic;
                    Editable = FirstNameEditabl;
                }
                field(NewFirstName; "New First Name")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Surname; Surname)
                {
                    ApplicationArea = Basic;
                    Editable = LastNameEditabl;
                }
                field(NewSurname; "New Surname")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(OtherNames; "Middle Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Other Names';
                    Editable = SecondNameEditabl;
                }
                field(NewMiddleName; "New Middle Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Other Names';
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(NewName; "New Name")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Member Category"; "Member Category")
                {
                    ApplicationArea = Basic;

                }
                field("New Member Category"; "New Member Category")
                {
                    ApplicationArea = Basic;

                }
                field(SalutationCode; "Salutation Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewSalutationCode; "New Salutation Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(PhysicallyChallenged; "Physically Challenged")
                {
                    ApplicationArea = Basic;
                }
                field(NewPhysicallyChallenged; "New Physically Challenged")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(KRAPIN; "KRA PIN")
                {
                    ApplicationArea = Basic;
                }
                field(NewKRAPIN; "New KRA PIN")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Status; "Status")
                {
                    ApplicationArea = Basic;
                }
                field(NewStatus; "New Status")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(OldMemberNo; "Old Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(NewOldMemberNo; "New Old Member No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(IDNo; "ID No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if "Account Category" = "account category"::Individual then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", "New ID No.");
                            Cust.SetRange(Cust."Account Category", Cust."account category"::Individual);
                            if Cust.FindFirst then begin
                                if Cust."No." <> "Member No." then
                                    Error(MemberExistError, Cust."No.", Cust.Name);
                            end;
                        end else
                            if "Account Category" = "account category"::Joint then begin
                                Cust.Reset;
                                Cust.SetRange(Cust."ID No.", "New ID No.");
                                Cust.SetRange(Cust."Account Category", Cust."account category"::Joint);
                                if Cust.FindFirst then begin
                                    if Cust."No." <> "Member No." then
                                        Error(MemberExistError, Cust."No.", Cust.Name);
                                end;
                            end;
                    end;
                }
                field(NewIDNo; "New ID No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        if "Account Category" = "account category"::Individual then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", "New ID No.");
                            Cust.SetRange(Cust."Account Category", Cust."account category"::Individual);
                            if Cust.FindFirst then begin
                                if Cust."No." <> "Member No." then
                                    Error(MemberExistError, Cust."No.", Cust.Name);
                            end;
                        end else
                            if "Account Category" = "account category"::Joint then begin
                                Cust.Reset;
                                Cust.SetRange(Cust."ID No.", "New ID No.");
                                Cust.SetRange(Cust."Account Category", Cust."account category"::Joint);
                                if Cust.FindFirst then begin
                                    if Cust."No." <> "Member No." then
                                        Error(MemberExistError, Cust."No.", Cust.Name);
                                end;
                            end;
                    end;
                }
                field(DateofBirth; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = DOBEditabl;
                }
                field(NewDateofBirth; "New Date of Birth")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(MaritalStatus; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalStatusEditabl;
                }
                field(NewMaritalStatus; "New Marital Status")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Editable = GenderEditabl;
                }
                field(NewGender; "New Gender")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(GroupNo; "Group No.")
                {
                    ApplicationArea = Basic;
                }
                field(NewGroupNo; "New Group No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
            group("Employment Details")
            {
                Visible = SecEmployment;
                field(EmployerCode; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerName; "Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field(NewEmployerCode; "New Employer Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(NewEmployerName; "New Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(TermsofEmployment; "Terms of Employment")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(NewTermsofEmployment; "New Terms of Employment")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(PayrollStaffNo; "Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        //TESTFIELD("Employer Code");
                    end;
                }
                field(NewPayrollStaffNo; "New Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        //TESTFIELD("Employer Code");
                    end;
                }
            }
            group(Communication)
            {
                Visible = secCommunication;
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                }
                field(NewAddress; "New Address")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Address2; "Address 2")
                {
                    ApplicationArea = Basic;
                }
                field(NewAddress2; "New Address 2")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(PostCode; "Post Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewPostCode; "New Post Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = Basic;
                }
                field(NewNationality; "New Nationality")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                }
                field(NewCity; "New City")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(CountryRegionCode; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewCountryRegionCode; "New Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(OfficeTelephoneNo; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Office Telephone No:';
                }
                field(NewPhoneNo; "New Phone No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(MobilePhoneNo; "Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(NewMobilePhoneNo; "New Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(EMail; "E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(NewEMail; "New E-Mail")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
            group("Other Information")
            {
                Visible = secOther;
                field(AccountCategory; "Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(NewAccountCategory; "New Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewGlobalDimension2Code; "New Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(RecruitedbyType; "Recruited by Type")
                {
                    ApplicationArea = Basic;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recruited By';
                }
                field(RecruitedByName; "Recruited By Name")
                {
                    ApplicationArea = Basic;
                }
                field(NewRecruitedbyType; "New Recruited by Type")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(NewRecruitedBy; "New Recruited By")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(NewRecruitedByName; "New Recruited By Name")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(SpecialAccount; "Special Account")
                {
                    ApplicationArea = Basic;
                }
                field(NewSpecialAccount; "New Special Account")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(CannotGuarantee; "Cannot Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field(NewCannotGuarantee; "New Cannot Guarantee")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(RelationshipManager; "Relationship Manager")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(NewRelationshipManager; "New Relationship Manager")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = false;
                }
            }
            group("Group Details")
            {
                Visible = GroupDetailVisibl;
                field(GroupCategory; "Group Category")
                {
                    ApplicationArea = Basic;
                }
                group("Non-Incorporated")
                {
                    Visible = NonIncorporatedEdit;
                    field(GroupType; "Group Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewGroupType; "New Group Type")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Other Type Of Group"; "Other Type Of Business")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Other Type Of Group"; "New Other Type Of Business")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Date of Group Reg."; "Date of Bus. Reg.")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Date of Group Reg."; "New Date of Bus. Reg.")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Group Physical Location"; "Business/Group Location")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Group Physical Location"; "New Business/Group Location")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Group Plot/Bldg/Street/Road"; "Plot/Bldg/Street/Road")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Group Plot/Bldg/Street/Road"; "New Plot/Bldg/Street/Road")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                }
                group(Incorporated)
                {
                    Visible = IncorporatedEdit;
                    field(TypeofBusiness; "Type of Business")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewTypeofBusiness; "New Type of Business")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field(OtherTypeOfBusiness; "Other Type Of Business")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewOtherTypeOfBusiness; "New Other Type Of Business")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field(BusinessRegNo; "Business Reg. No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewBusinessRegNo; "New Business Reg. No.")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field(IncorporationNo; "Incorporation No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewIncorporationNo; "New Incorporation No.")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field(DateofBusReg; "Date of Bus. Reg.")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewDateofBusReg; "New Date of Bus. Reg.")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Business Physical Location"; "Business/Group Location")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Business Physical Location"; "New Business/Group Location")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Business Plot/Bldg/Street/Road"; "Plot/Bldg/Street/Road")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Bus. Plot/Bldg/Street/Road"; "New Plot/Bldg/Street/Road")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                }
            }
            group("Bank Details")
            {
                Visible = secBank;
                field(BankCode; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewBankCode; "New Bank Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(BankName; "Bank Name")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field(NewBankName; "New Bank Name")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(BranchCode; "Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewBranchCode; "New Branch Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(BranchName; "Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(NewBranchName; "New Branch Name")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(BankAccountNo; "Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(NewBankAccountNo; "New Bank Account No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }



                field("Swift Code"; "Swift Code")
                {
                    ApplicationArea = Basic;
                }
                field("New Swift Code"; "New Swift Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
            group("Picture & Signature")
            {
                Visible = secPic_Sig;
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control132; "Next of Kin Changes")
            {
                SubPageLink = "No." = field(Code);
                Visible = secNOK;
            }
            part(Control134; "Account Signatories Changes")
            {
                SubPageLink = Code = field(Code);
                Visible = secAuthorizedPersons;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Changes")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TestField("Approval Status", "approval status"::Approved);
                    TestField(Posted, false);

                    UpdateMember("Member No.");
                    Message('Updated');
                end;
            }
            action("Show Details")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    UpdateActions;
                end;
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
                        VarVariant: Variant;
                        ////CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        UserSetup.Get(UserId);

                        VarVariant := Rec;
                        ////CalwideApprovals.CreateTracker(VarVariant, Code, 0, Documenttype::"Member Changes", UserSetup."Global Dimension 1 Code", UserSetup."Global Dimension 2 Code", 0);
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
                        TestField("Approval Status", "approval status"::Pending);

                        VarVariant := Rec;
                        //CalwideApprovals.CancelTracker(VarVariant, Code);
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
                        DocumentType := Documenttype::"Member Changes";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Code);
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(RecRef.RecordId);
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

                        if "Approval Status" = "approval status"::Pending then begin
                            VarVariant := Rec;
                            //CalwideApprovals.CancelTracker(VarVariant, Code);
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            "Approval Status" := "approval status"::Open;
                            Modify;
                        end;
                    end;
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Image = NewSparkle;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Account Signatories App.";
                    RunPageLink = Code = field("No. Series");
                }
            }
        }
    }

    trigger OnOpenPage()
    begin


        UpdateActions;

    end;

    var
        IncorporatedEdit: Boolean;
        NonIncorporatedEdit: Boolean;
        Customer: Record Customer;
        SingleMemberVisibl: Boolean;
        FirstNameEditabl: Boolean;
        SecondNameEditabl: Boolean;
        LastNameEditabl: Boolean;
        NameEditabl: Boolean;
        IDNoEditabl: Boolean;
        PassportNoEditabl: Boolean;
        StaffNoEditabl: Boolean;
        DOBEditabl: Boolean;
        MaritalStatusEditabl: Boolean;
        GenderEditabl: Boolean;
        GroupAccountNoEditabl: Boolean;
        GroupMemberVisibl: Boolean;
        BusinessMemberVisibl: Boolean;
        IsFixedDepositVisibl: Boolean;
        IsJuniorVisibl: Boolean;
        CommVisbl: Boolean;
        OtherVisibl: Boolean;
        EmployerVisibl: Boolean;
        BankDetailVisibl: Boolean;
        GroupDetailVisibl: Boolean;
        "-": Integer;
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        GroupAcc: Boolean;
        SingleAcc: Boolean;
        CameraAvailable: Boolean;
        Cust: Record Customer;
        Savings: Record Vendor;
        secGeneral: Boolean;
        secEmployment: Boolean;
        secCommunication: Boolean;
        secBank: Boolean;
        secOther: Boolean;
        secNOK: Boolean;
        secAuthorizedPersons: Boolean;
        secPic_Sig: Boolean;
        Empstatus: Boolean;
        secSignatories: Boolean;
        MemberExistError: label 'ID Already Exist. Member No. %1 - %2';
        UserSetup: Record "User Setup";


    procedure StatusControl()
    begin
        /*
        IF ("Account Type" IN ["Account Type"::" ","Account Type"::Savings]) THEN BEGIN
         CASE "Product Category" OF
          "Product Category"::"Fixed Deposit" : BEGIN
           IsFixedDepositVisibl:=TRUE;
           IsJuniorVisibl:=FALSE;
           EmployerVisibl:=FALSE;
           BankDetailVisibl:=FALSE;
           SingleMemberVisibl:=FALSE;
           GroupMemberVisibl:=FALSE;
           BusinessMemberVisibl:=FALSE;
           CommVisbl:=FALSE;
          END;
          "Product Category"::"Junior Savings" : BEGIN
           IsFixedDepositVisibl:=FALSE;
           IsJuniorVisibl:=TRUE;
           EmployerVisibl:=FALSE;
           BankDetailVisibl:=FALSE;
           SingleMemberVisibl:=FALSE;
           GroupMemberVisibl:=FALSE;
           BusinessMemberVisibl:=FALSE;
           CommVisbl:=FALSE;
          END;
          "Product Category"::" ", "Product Category" ::"Share Capital", "Product Category" ::"Deposit Contribution",
          "Product Category" ::"Registration Fee" : BEGIN
           IsFixedDepositVisibl:=FALSE;
           IsJuniorVisibl:=FALSE;
           EmployerVisibl:=FALSE;
           BankDetailVisibl:=FALSE;
           SingleMemberVisibl:=FALSE;
           GroupMemberVisibl:=FALSE;
           BusinessMemberVisibl:=FALSE;
           CommVisbl:=FALSE;
          END;
        END;
        
          END ELSE BEGIN
          CASE "Single Party/Multiple/Business" OF
           "Single Party/Multiple/Business"::Single: BEGIN
            SingleMemberVisibl:=TRUE;
            NameEditabl:=FALSE; FirstNameEditabl:=TRUE; SecondNameEditabl:=TRUE; LastNameEditabl:=TRUE; StaffNoEditabl:=TRUE;
            IDNoEditabl:=TRUE; PassportNoEditabl:=TRUE; DOBEditabl:=TRUE; MaritalStatusEditabl:=TRUE; GenderEditabl:=TRUE;
            GroupAccountNoEditabl:=TRUE;
            GroupMemberVisibl:=FALSE;
            BusinessMemberVisibl:=FALSE;
            CommVisbl:=TRUE;
            EmployerVisibl:=TRUE;
            BankDetailVisibl:=TRUE;
          END;
           "Single Party/Multiple/Business"::Multiple: BEGIN
            SingleMemberVisibl:=FALSE;
            NameEditabl:=TRUE; FirstNameEditabl:=FALSE; SecondNameEditabl:=FALSE; LastNameEditabl:=FALSE; StaffNoEditabl:=FALSE;
            IDNoEditabl:=FALSE; PassportNoEditabl:=FALSE; DOBEditabl:=FALSE; MaritalStatusEditabl:=FALSE; GenderEditabl:=FALSE;
            GroupAccountNoEditabl:=FALSE;
            GroupMemberVisibl:=TRUE;
            BusinessMemberVisibl:=FALSE;
            CommVisbl:=TRUE;
            EmployerVisibl:=TRUE;
            BankDetailVisibl:=TRUE;
          END;
          "Single Party/Multiple/Business"::Business: BEGIN
           SingleMemberVisibl:=FALSE;
           NameEditabl:=TRUE; FirstNameEditabl:=FALSE; SecondNameEditabl:=FALSE; LastNameEditabl:=FALSE; StaffNoEditabl:=FALSE;
           IDNoEditabl:=FALSE; PassportNoEditabl:=FALSE; DOBEditabl:=FALSE; MaritalStatusEditabl:=FALSE; GenderEditabl:=FALSE;
           GroupAccountNoEditabl:=FALSE;
           GroupMemberVisibl:=FALSE;
           BusinessMemberVisibl:=TRUE;
           CommVisbl:=TRUE;
           EmployerVisibl:=TRUE;
           BankDetailVisibl:=TRUE;
          END;
        END;
            END;
        */

        /*
        CASE Status OF
         Status::Open :
           BEGIN
             CurrPage.EDITABLE:=TRUE;
             END;
        
         Status::Pending, Status::Rejected, Status::Processed :
           BEGIN
             CurrPage.EDITABLE:=FALSE;
             END;
        END;
        */
        /*
        CASE "Single Party/Multiple/Business" OF
        "Single Party/Multiple/Business"::Single: BEGIN
          SingleMemberVisibl:=TRUE;
           NameEditabl:=FALSE; FirstNameEditabl:=TRUE; SecondNameEditabl:=TRUE; LastNameEditabl:=TRUE; StaffNoEditabl:=TRUE;
           IDNoEditabl:=TRUE; PassportNoEditabl:=TRUE; DOBEditabl:=TRUE; MaritalStatusEditabl:=TRUE; GenderEditabl:=TRUE;
           GroupAccountNoEditabl:=TRUE;
          GroupMemberVisibl:=FALSE;
          BusinessMemberVisibl:=FALSE;
          END;
        "Single Party/Multiple/Business"::Multiple: BEGIN
          SingleMemberVisibl:=FALSE;
           NameEditabl:=TRUE; FirstNameEditabl:=FALSE; SecondNameEditabl:=FALSE; LastNameEditabl:=FALSE; StaffNoEditabl:=FALSE;
           IDNoEditabl:=FALSE; PassportNoEditabl:=FALSE; DOBEditabl:=FALSE; MaritalStatusEditabl:=FALSE; GenderEditabl:=FALSE;
           GroupAccountNoEditabl:=FALSE;
          GroupMemberVisibl:=TRUE;
          BusinessMemberVisibl:=FALSE;
          END;
        "Single Party/Multiple/Business"::Business: BEGIN
          SingleMemberVisibl:=FALSE;
           NameEditabl:=TRUE; FirstNameEditabl:=FALSE; SecondNameEditabl:=FALSE; LastNameEditabl:=FALSE; StaffNoEditabl:=FALSE;
           IDNoEditabl:=FALSE; PassportNoEditabl:=FALSE; DOBEditabl:=FALSE; MaritalStatusEditabl:=FALSE; GenderEditabl:=FALSE;
           GroupAccountNoEditabl:=FALSE;
          GroupMemberVisibl:=FALSE;
          BusinessMemberVisibl:=TRUE;
          END;
        END;
        
        
        CASE "Product Category" OF
        "Product Category"::"Fixed Deposit" : BEGIN
          IsFixedDepositVisibl:=TRUE;
          IsJuniorVisibl:=FALSE;
          EmployerVisibl:=FALSE;
          BankDetailVisibl:=FALSE;
          END;
        "Product Category"::"Junior Savings" : BEGIN
          IsFixedDepositVisibl:=FALSE;
          IsJuniorVisibl:=TRUE;
          EmployerVisibl:=FALSE;
          BankDetailVisibl:=FALSE;
          END;
        "Product Category"::" ", "Product Category" ::"Share Capital", "Product Category" ::"Deposit Contribution",
        "Product Category" ::"Registration Fee" : BEGIN
          IsFixedDepositVisibl:=FALSE;
          IsJuniorVisibl:=FALSE;
          EmployerVisibl:=TRUE;
          BankDetailVisibl:=TRUE;
          END;
        END;
        
        
        
        //IF ("Account Type" IN ["Account Type"::" ","Account Type"::Savings]) THEN BEGIN
        
        
        
        CASE Status OF
         Status::Open :
           BEGIN
             CurrPage.EDITABLE:=TRUE;
             END;
        
         Status::Pending, Status::Rejected, Status::Processed :
           BEGIN
             CurrPage.EDITABLE:=FALSE;
             END;
        END;
        */


        NonIncorporatedEdit := false;
        IncorporatedEdit := false;

        if "Group Category" = "group category"::"Non-Incorporated" then begin
            NonIncorporatedEdit := true;
        end;
        if "Group Category" = "group category"::Incorporated then begin
            IncorporatedEdit := true;
        end;

    end;

    local procedure UpdateActions()
    begin


        secGeneral := false;
        secEmployment := false;
        secCommunication := false;
        secBank := false;
        secOther := false;
        secNOK := false;
        secAuthorizedPersons := false;
        secPic_Sig := false;
        secSignatories := false;
        GroupDetailVisibl := false;


        if "Change Type" = "change type"::"Authorized Persons" then
            secAuthorizedPersons := true;

        if "Change Type" = "change type"::"Bank Details" then
            secBank := true;

        if "Change Type" = "change type"::Communication then
            secCommunication := true;

        if "Change Type" = "change type"::"Employment Details" then
            secEmployment := true;

        if "Change Type" = "change type"::General then begin
            secGeneral := true;
            "New Member Category" := "Member Category";
        end;

        if "Change Type" = "change type"::"Next of Kin" then
            secNOK := true;

        if "Change Type" = "change type"::"Other Information" then
            secOther := true;

        if "Change Type" = "change type"::"Pic & Signature" then
            secPic_Sig := true;


        if "Change Type" = "change type"::"Group Details" then
            GroupDetailVisibl := true;




        NonIncorporatedEdit := false;
        IncorporatedEdit := false;

        if "Group Category" = "group category"::"Non-Incorporated" then begin
            NonIncorporatedEdit := true;
        end;
        if "Group Category" = "group category"::Incorporated then begin
            IncorporatedEdit := true;
        end;

        /*
        IF "Group Account" THEN BEGIN
            GroupAcc:=TRUE;
            SingleAcc:=FALSE;
        END
        ELSE BEGIN
            GroupAcc:=FALSE;
            SingleAcc:=TRUE;
        END;
        */

    end;
}

