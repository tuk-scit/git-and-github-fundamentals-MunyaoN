
Page 52188525 "Member Card"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Customer;
    SourceTableView = where(Type = const(Member));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(Surname; Surname)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(SalutationCode; "Salutation Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the salutation code that will be used when you interact with the contact. The salutation code is only used in Word documents. To see a list of the salutation codes already defined, click the field.';
                }
                field(OldMemberNo; "Old Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("From Another Sacco"; "From Another Sacco")
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; "ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(FileLocation; FileLocation)
                {
                    ApplicationArea = Basic;
                }
                field(FileLocationUser; FileLocationUser)
                {
                }
                field(Passport; Passport)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(DateofBirth; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(KRAPIN; "KRA PIN")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(MaritalStatus; "Marital Status")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(EmployerCode; "Employer Code")
                {
                    ApplicationArea = Basic;

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
                field(TermsofEmployment; "Terms of Employment")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Employment Section"; "Employment Section")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
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
                field(MemberStatus; "Member Status")
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
                }
                group(ContactDetails)
                {
                    Caption = 'Contact';
                    field(PhoneNo; "Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s phone number.';
                    }
                    field(MobilePhoneNo; "Mobile Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s mobile telephone number.';
                    }
                    field(EMail; "E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        ExtendedDatatype = EMail;
                        Importance = Promoted;
                        ToolTip = 'Specifies the email address of the contact.';
                    }
                }
            }

            group("Other Information")
            {

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
                }
                field(RecruitedBy; "Recruited By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recruited By';
                }

                field(RecruitedByName; "Recruited By Name")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
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
            }

            part("Member Change Log"; "Member Change Log")
            {
                SubPageLink = "Member No." = field("No.");
            }
        }
        area(factboxes)
        {
            part(Control59; "Info Base")
            {
                SubPageLink = "Member No." = field("No.");
            }
            part(Control58; "Member Details FactBox")
            {
                SubPageLink = "Member No." = field("No.");
            }
            part(Control56; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
            part(Control57; "Loans Statistics FactBox")
            {
                SubPageLink = "Member No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Member Accounts")
            {
                ApplicationArea = Basic;
                Image = Account;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //RunObject = Page "Member Accounts  List";
                //RunPageLink = "Member No." = field("No.");
            }
            action("Member Loans")
            {
                ApplicationArea = Basic;
                Promoted = true;
                Image = EntryStatistics;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loans Statistics";
                RunPageLink = "Member No." = field("No.");
            }
            action("Next of Kin")
            {
                ApplicationArea = Basic;
                Image = NewLotProperties;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Next of Kin";
                RunPageLink = "No." = field("No.");
            }
            action("Nominee")
            {
                ApplicationArea = Basic;
                Image = NewLotProperties;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Nominee;
                RunPageLink = "No." = field("No.");
            }
            action("Account Signatories")
            {
                ApplicationArea = Basic;
                Image = NewSparkle;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Account Signatories";
                RunPageLink = Code = field("No.");
            }
            action("Info Base")
            {
                ApplicationArea = Basic;
                Image = Info;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Information Base";
                RunPageLink = "Member No." = field("No.");
            }

            action("Dividend Instruction")
            {
                ApplicationArea = Basic;
                Image = Info;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Dividend Instruction";
                RunPageLink = "Member No." = field("No.");
            }

            action("Portal Uploads")
            {
                ApplicationArea = Basic;
                Image = Info;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ////RunObject = Page "Portal Uploads";
                ////RunPageLink = "Member No." = field("No.");

            }
            action("Monthly Contibutions")
            {
                ApplicationArea = Basic;
                Image = NewToDo;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "Monthly Contributions";
                RunPageLink = "Member No." = field("No.");
            }
            action("Exempt SMS")
            {
                ApplicationArea = Basic;
                Image = Absence;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                //RunObject = Page "Members SMS List";
                //RunPageLink = "Member No" = field("No.");

                trigger OnAction()
                begin
                    "Account Type" := "Account Type"::Members;
                    Modify();

                end;
            }

        }
        area(reporting)
        {
            action("Print Membership Card")
            {
                ApplicationArea = Basic;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", "No.");
                    if Members.FindFirst then
                        Report.Run(52188526, true, false, Members);
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
                begin
                    Members.Reset;
                    Members.SetRange("No.", "No.");
                    if Members.FindFirst then
                        Report.Run(Report::"Detailed Member Statement", true, false, Members);
                end;
            }

            action("E-mail Member Statement")
            {
                ApplicationArea = Basic;
                Image = Email;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", "No.");
                    //if Members.FindFirst then
                        //Report.Run(Report::"E-Mail Member Statement", true, false, Members);
                
                end;
            }
            action("Loan Guarantors")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", "No.");
                    if Members.Find('-') then
                        Report.Run(52188469, true, false, Members);
                end;
            }
            action("Loans Guaranteed")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", "No.");
                    if Members.Find('-') then
                        Report.Run(52188470, true, false, Members);
                end;
            }
            action("Unblock Accounts")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to unblock all accounts') then begin
                        MemberAccounts.Reset;
                        MemberAccounts.SetRange("Member No.", "No.");
                        if MemberAccounts.FindFirst then begin
                            MemberAccounts.ModifyAll(Blocked, MemberAccounts.Blocked::" ");
                            MemberAccounts.ModifyAll(Status, MemberAccounts.Status::Active);
                            "Member Status" := "Member Status"::Active;
                            Modify;
                            Message('Updated');
                        end;
                    end;
                end;
            }
            action("Create Portal Users")
            {
                ApplicationArea = Basic;
                trigger OnAction()
                var
                    //CalwidePortal: Codeunit "Calwide Portal";
                begin
                    if Confirm('Are you sure you want to create this portal user') then begin
                        //CalwidePortal.CreatePortalUser("No.");
                    end;

                end;
            }
            action("Picture & Signature")
            {
                ApplicationArea = Basic;
                Image = Picture;
                Promoted = true;

                trigger OnAction()
                var
                    ImageData: Record "Member Images";
                begin
                    ImageData.Reset;
                    ImageData.SetRange(ImageData."Member No.", "No.");
                    if ImageData.Find('-') then begin
                        Page.Run(52188589, ImageData);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        Logs: Record "File Movement Log";
    begin
        if UserSetup.Get(UserId) then begin
            if ("Member Category" = "Member Category"::"Staff Members") or ("Member Category" = "Member Category"::"Board Members") then begin
                if Rec."Payroll/Staff No." <> UserSetup."Staff No" then begin
                    if UserSetup."View Staff Accounts" = false then
                        Error('You Are Not SetUp to View Other Staff''s Accounts');
                end;
            end;
        end else
            Error('You Are Not SetUp As a User under User Setup');

        if UserSetup.Get(UserId) then begin
            if Rec."Member Category" = Rec."member category"::"Board Members" then begin
                if UserSetup."View Board Accounts" = false then
                    Error('You Are Not SetUp to View Board Members Accounts');
            end;
        end else
            Error('You Are Not SetUp to View Board Members Accounts');


        Logs.Reset();
        Logs.SetFilter("Member No.", "No.");
        if Logs.findlast() then begin
            FileLocation := Logs."Current Location";
            FileLocationUser := Logs."Current User";

        end;



    end;

    var
        Members: Record Customer;
        MemberAccounts: Record Vendor;
        UserSetup: Record "User Setup";
        FileLocation: Code[50];
        FileLocationUser: Code[50];

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


}

