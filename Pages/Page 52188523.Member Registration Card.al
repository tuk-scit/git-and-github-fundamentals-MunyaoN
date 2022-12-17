
Page 52188523 "Member Registration Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Registration";
    SourceTableView = where(Type = const(Member));
    PromotedActionCategories = 'New,Process,Report,Picture & Signature,Approval Requests,Processes';


    layout
    {
        area(content)
        {

            group(General)
            {
                Caption = 'General';

                Editable = ApplicationDetailsEdit;
                field(No; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field(FirstName; "First Name")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(MiddleName; "Middle Name")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(Surname; Surname)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(SalutationCode; "Salutation Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the salutation code that will be used when you interact with the contact. The salutation code is only used in Word documents. To see a list of the salutation codes already defined, click the field.';
                }
                field("From Another Sacco"; "From Another Sacco")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; "Application Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application Date';
                    Editable = false;
                }
                field(OldMemberNo; "Old Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IDNo; "ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Passport; Passport)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = false;
                }
                field(DateofBirth; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        MemberAge := 0;
                        if "Date of Birth" <> 0D then
                            MemberAge := Date2DMY(Today, 3) - Date2DMY("Date of Birth", 3);
                    end;
                }
                field(Age; MemberAge)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                }
                field(KRAPIN; "KRA PIN")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(MaritalStatus; "Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("Self Employed"; "Self Employed")
                {
                    ApplicationArea = Basic;
                    trigger Onvalidate()
                    begin
                        UpdateFields();
                    end;
                }
                field(EmployerCode; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = SelfEmpBool;

                    trigger OnValidate()
                    begin
                        /*
                        //VALIDATE("Self Employed");
                        Customer.GET("Employer Code");
                        IF ((Customer."Self Employed"=TRUE) OR (Status<>Status::Open))THEN
                          Empstatus:=FALSE ELSE Empstatus:=TRUE;
                          "Payroll/Staff No.":='';
                        "Terms of Employment":="Terms of Employment"::" ";
                        "Appointment Date":=0D;
                        */

                    end;
                }
                field(EmployerName; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employment Section"; "Employment Section")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = SelfEmpBool;
                }
                field(TermsofEmployment; "Terms of Employment")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = SelfEmpBool;
                }
                field(PayrollStaffNo; "Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                    Editable = SelfEmpBool;

                    trigger OnValidate()
                    begin
                        if "Payroll/Staff No." <> '' then
                            TESTFIELD("Employer Code");
                    end;
                }
                field(MemberCategory; "Member Category")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(CapturedBy; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Industry Type"; "Industry Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';

                Editable = ApplicationDetailsEdit;
                group(Address)
                {
                    Caption = 'Address';
                    field(PostCode; "Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("P.O. Box"; Address)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P.O. Box';
                        ToolTip = 'Specifies the contact''s address.';
                    }
                    field("Physical Address"; "Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Physical Address';
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City; City)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the city where the contact is located.';
                    }
                    field(CountryRegionCode; "Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the country/region of the address.';
                    }
                    field("Phone Code"; "Phone Code")
                    {
                        ApplicationArea = Basic, Suite;

                    }
                    field(County; County)
                    {
                        ApplicationArea = Basic, Suite;

                    }
                }
                group(ContactDetails)
                {
                    Caption = 'Contact';
                    field(MobilePhoneNo; "Mobile Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Style = Strong;
                        StyleExpr = true;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the contact''s mobile telephone number.';
                    }
                    field(AlternativePhoneNo; "Alternative Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s phone number.';
                    }
                    field(EMail; "E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        ExtendedDatatype = EMail;
                        Importance = Promoted;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the email address of the contact.';
                    }
                }
            }
            group("Micro Credit")
            {

                Editable = ApplicationDetailsEdit;
                field(GroupNo; "Group No.")
                {
                    ApplicationArea = Basic;
                    //LookupPageId = "Group List";
                }
            }
            group("Other Information")
            {

                Editable = ApplicationDetailsEdit;
                field(GlobalDimension2Code; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field(RelationshipOfficer; "Relationship Officer")
                {
                    ApplicationArea = Basic;
                }
                field(RelationshipOfficerName; "Relationship Officer Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchManager; "Branch Manager")
                {
                    ApplicationArea = Basic;
                }
                field(BranchManagerName; "Branch Manager Name")
                {
                    ApplicationArea = Basic;
                }
                field(RecruitedbyType; "Recruited by Type")
                {
                    ApplicationArea = Basic;
                    trigger Onvalidate()
                    begin
                        if "Recruited by Type" = "Recruited by Type"::"Walk In" then
                            WalkinBool := false
                        else
                            WalkinBool := true;
                    end;
                }
                field(RecruitedBy; "Recruited By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recruited By';
                    Editable = WalkinBool;
                    trigger OnDrillDown()
                    var
                        Member: Record Customer;
                    begin
                        if "Recruited by Type" in ["Recruited by Type"::"Board Member", "Recruited by Type"::Member] then begin
                            Member.Reset();
                            Member.SetRange("Member Category", Member."Member Category"::Member);
                            if "Recruited by Type" = "Recruited by Type"::"Board Member" then
                                Member.SetRange("Member Category", Member."Member Category"::"Board Members");
                            if Member.FindFirst() then
                                Page.Run(Page::"Member List", Member);
                        end;
                    end;
                }
                field(RecruitedByName; "Recruited By Name")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {

                Editable = ApplicationDetailsEdit;
                field(BankCode; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankName; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchCode; "Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(BranchName; "Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(BankAccountNo; "Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Swift Code"; "Swift Code")
                {
                    ApplicationArea = Basic;
                }
                field("Previous Sacco No."; "Previous Sacco No.")
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
            group(All)
            {
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Image = NewLotProperties;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Next of Kin App.";
                    RunPageLink = "No." = field("No.");
                }
                action("Nominee")
                {
                    ApplicationArea = Basic;
                    Image = NewLotProperties;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Nominee Application";
                    RunPageLink = "No." = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Image = NewSparkle;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Account Signatories App.";
                    RunPageLink = Code = field("No.");
                }
                action("Create Member")
                {
                    ApplicationArea = Basic;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Text002: label 'Are you sure you want to convert this application to membership?';
                    begin

                        TestField(Status, Status::Approved);

                        if Confirm('Are you sure you want to Create this Member?') then begin
                            MemberActivities.CreateMember(Rec);
                        end;
                    end;
                }
                action("Picture & Signature")
                {
                    ApplicationArea = Basic;
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Picture & Signature App.";
                    RunPageLink = "No." = field("No.");
                }
                action("Default Accounts")
                {
                    ApplicationArea = Basic;
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Default Savings Products";
                    RunPageLink = Code = field("No.");
                }
                action("Reset Default Products")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Reset Default Products?') then begin
                            DefaultAccounts;
                            Message('Done');
                        end;
                    end;
                }
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
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Approval Document Type";
                    begin

                        CheckControls;


                        VarVariant := Rec;
                        //CalwideApprovals.CreateTracker(VarVariant, "No.", 0, Documenttype::"Member Application", '', "Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::"Member Application";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", "No.");
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

                        if not Confirm('Are you sure you want to re-open document?') then exit;
                        Status := Status::Open;
                        Modify;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        UpdateFields;

        if "Account Category" = "account category"::Individual then
            JointBool := true
        else
            JointBool := false;
    end;

    trigger OnModifyRecord(): Boolean
    begin

        if "Account Category" = "account category"::Individual then
            JointBool := true
        else
            JointBool := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::Member;
        "Account Category" := "Account Category"::Individual;
    end;

    trigger OnOpenPage()
    begin
        UpdateFields;

        if "Account Category" = "account category"::Individual then
            JointBool := true
        else
            JointBool := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin

        UpdateFields;
    end;

    local procedure UpdateFields()
    begin
        if Status = Status::Open then begin
            ApplicationDetailsEdit := true;
        end
        else begin
            ApplicationDetailsEdit := false;
        end;

        if "Recruited by Type" = "Recruited by Type"::"Walk In" then
            WalkinBool := false
        else
            WalkinBool := true;

        MemberAge := 0;
        if "Date of Birth" <> 0D then
            MemberAge := Date2DMY(Today, 3) - Date2DMY("Date of Birth", 3);


        if "Self Employed" then
            SelfEmpBool := false
        else
            SelfEmpBool := true;
    end;

    var
        VarVariant: Variant;
        ApplicationDetailsEdit: Boolean;
        UserSetup: Record "User Setup";
        //CalwideApprovals: Codeunit "Calwide Approvals";
        GenSetup: Record "Sacco Setup";
        ApprovalTracker: Record "Approval Tracker";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application";
        MemberActivities: Codeunit "Member Activities";
        NextofKin: Record "Next of Kin.";
        Nominee: Record Nominee;
        DefaultSavingsProducts: Record "Default Savings Products.";
        JointBool: Boolean;
        SelfEmpBool: Boolean;

    local procedure UpdateName()
    begin
        Name := '';

        if ("First Name" <> '') then
            Name += "First Name";

        if ("Middle Name" <> '') then
            Name += ' ' + "Middle Name";

        if (Surname <> '') then
            Name += ' ' + Surname;
    end;


    procedure CheckControls()
    var
        Allocation: Decimal;
    begin
        TestField(Status, Status::Open);
        //TESTFIELD("First Name");
        //TESTFIELD(Surname);

        if "Account Category" = "Account Category"::Individual then begin

            TESTFIELD("First Name");
            TESTFIELD(Surname);
            TestField("ID No.");
            TestField("Date of Birth");
            TestField("KRA PIN");
            TestField("E-Mail");

            if not "Self Employed" then begin


                TestField("Employer Code");
                TestField("Payroll/Staff No.");
                TestField("Employment Section");
            end;

            if Gender = Gender::"  " then
                Error('Gender MUST have a value');

        end;

        //TestField("Post Code");
        //TestField(Address);
        TestField("Mobile Phone No.");
        //TESTFIELD("E-Mail");
        TestField("Captured By");
        TestField("Application Date");

        UserSetup.Get(UserId);

        if "Global Dimension 2 Code" <> UserSetup."Global Dimension 2 Code" then begin
            UserSetup.TestField("Global Dimension 2 Code");
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Modify;
        end;

        GenSetup.Get;

        CalcFields(Picture, Signature);
        if GenSetup."Member Picture Mandatory" = GenSetup."member picture mandatory"::"Picture & Signature" then begin
            if (not Picture.Hasvalue) or (not Signature.Hasvalue) then
                Error('This Application Does Not Contain a Picture or Signature.');
        end;
        if GenSetup."Member Picture Mandatory" = GenSetup."member picture mandatory"::Picture then begin
            if (not Picture.Hasvalue) then
                Error('This Application Does Not Contain a Picture');
        end;
        if GenSetup."Member Picture Mandatory" = GenSetup."member picture mandatory"::Signature then begin
            if (not Signature.Hasvalue) then
                Error('This Application Does Not Contain a Signature.');
        end;


        NextofKin.Reset;
        NextofKin.SetRange("No.", "No.");
        NextofKin.SetFilter(Name, '<>%1', '');
        if not NextofKin.FindFirst then begin
            if GenSetup."Next of Kin Mandatory" = GenSetup."next of kin mandatory"::Yes then
                Error('Next Of Kin not Captured');
        end;

        Nominee.Reset;
        Nominee.SetRange("No.", "No.");
        Nominee.SetFilter(Name, '<>%1', '');
        if not Nominee.FindFirst then begin
            if GenSetup."Nominee Mandatory" = GenSetup."Nominee mandatory"::Yes then
                Error('Nominee not Captured');
        end;


        if GenSetup."Kin % Allocation Mandatory" = GenSetup."kin % allocation mandatory"::Yes then begin
            Allocation := 0;
            Nominee.Reset;
            Nominee.SetRange("No.", "No.");
            Nominee.SetFilter(Name, '<>%1', '');
            if Nominee.FindFirst then begin
                Nominee.CalcSums("%Allocation");
                Allocation := Nominee."%Allocation";
            end;


            if Allocation <> 100 then
                Error('Next of Kin Allocation Must Sum Up to 100');
        end;

        if "Group No." <> '' then begin
            DefaultSavingsProducts.Reset;
            DefaultSavingsProducts.SetRange(Code, "No.");
            DefaultSavingsProducts.SetRange("Product Category", DefaultSavingsProducts."product category"::"Micro Member Deposit");
            if not DefaultSavingsProducts.FindFirst then
                Error('Kindly Add Micro Member Deposits Product if creating a Micro Member');
        end;
    end;

    var
        MemberAge: Integer;
        WalkinBool: Boolean;
}

