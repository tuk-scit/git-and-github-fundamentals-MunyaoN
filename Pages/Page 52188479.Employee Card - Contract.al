
Page 52188479 "Employee Card - Contract"
{
    Caption = 'Employee Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Employee,Navigate';
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No;"No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        AssistEdit;
                    end;
                }
                field(FirstName;"First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field(MiddleName;"Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field(LastName;"Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(MemberNo;"Member No")
                {
                    ApplicationArea = Basic;
                }
                field(JobTitle;"Job Title")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field(Initials;Initials)
                {
                    ApplicationArea = Basic,Suite;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field(Gender;Gender)
                {
                    ApplicationArea = Basic,Suite;
                    ToolTip = 'Specifies the employee''s gender.';
                }
                field("Phone No.2";"Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field(CompanyEMail;"Company E-Mail")
                {
                    ApplicationArea = BasicHR;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
                field(LastDateModified;"Last Date Modified")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies when this record was last modified.';
                }
                field(PrivacyBlocked;"Privacy Blocked")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
                field(UserID;"User ID")
                {
                    ApplicationArea = Basic;
                }
                field(LastEmployerName;"Last Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field(LastEmployerPhone;"Last Employer Phone")
                {
                    ApplicationArea = Basic;
                }
                field(LastEmployerEmail;"Last Employer Email")
                {
                    ApplicationArea = Basic;
                }
                field(LastEmployerAddress;"Last Employer Address")
                {
                    ApplicationArea = Basic;
                }
                field(InterestsHobbies;"Interests & Hobbies")
                {
                    ApplicationArea = Basic;
                }
                field(MaritalStatus;"Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field(District;District)
                {
                    ApplicationArea = Basic;
                }
                field(Location;Location)
                {
                    ApplicationArea = Basic;
                }
                field(SubLocation;"Sub-Location")
                {
                    ApplicationArea = Basic;
                }
            }
            group(AddressContact)
            {
                Caption = 'Address & Contact';
                group(Control48)
                {
                    field(Address;Address)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the employee''s address.';
                    }
                    field(Address2;"Address 2")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City;City)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the city of the address.';
                    }
                    group(Control44)
                    {
                        Visible = IsCountyVisible;
                        field(County;County)
                        {
                            ApplicationArea = BasicHR;
                            ToolTip = 'Specifies the county of the employee.';
                        }
                    }
                    field(PostCode;"Post Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field(CountryRegionCode;"Country/Region Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the country/region of the address.';

                        trigger OnValidate()
                        begin
                            IsCountyVisible := FormatAddress.UseCounty("Country/Region Code");
                        end;
                    }
                }
                group(Control39)
                {
                    field(PrivatePhoneNo;"Mobile Phone No.")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private telephone number.';
                    }
                    field(Pager;Pager)
                    {
                        ApplicationArea = Basic,Suite;
                        ToolTip = 'Specifies the employee''s pager number.';
                    }
                    field(Extension;Extension)
                    {
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone extension.';
                    }
                    field(DirectPhoneNo;"Phone No.")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Direct Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone number.';
                    }
                    field(PrivateEmail;"E-Mail")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Email';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private email address.';
                    }
                    field(AltAddressCode;"Alt. Address Code")
                    {
                        ApplicationArea = Basic,Suite;
                        ToolTip = 'Specifies a code for an alternate address.';
                    }
                    field(AltAddressStartDate;"Alt. Address Start Date")
                    {
                        ApplicationArea = Basic,Suite;
                        ToolTip = 'Specifies the starting date when the alternate address is valid.';
                    }
                    field(AltAddressEndDate;"Alt. Address End Date")
                    {
                        ApplicationArea = Basic,Suite;
                        ToolTip = 'Specifies the last day when the alternate address is valid.';
                    }
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field(EmploymentDate;"Employment Date")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field(Status;Status)
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employment status of the employee.';
                }
                field(InactiveDate;"Inactive Date")
                {
                    ApplicationArea = Basic,Suite;
                    ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
                }
                field(CauseofInactivityCode;"Cause of Inactivity Code")
                {
                    ApplicationArea = Basic,Suite;
                    ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
                }
                field(TerminationDate;"Termination Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field(BirthDate;"Birth Date")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field(PersonalIDNo;"Personal ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(PIN;PIN)
                {
                    ApplicationArea = Basic;
                }
                field(NSSFNo;"NSSF No.")
                {
                    ApplicationArea = Basic;
                }
                field(NHIFNo;"NHIF No.")
                {
                    ApplicationArea = Basic;
                }
                field(HELBNo;"HELB No.")
                {
                    ApplicationArea = Basic;
                }
                field(PassportNo;"Passport No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field(EmployeePostingGroup;"Employee Posting Group")
                {
                    ApplicationArea = BasicHR;
                    LookupPageID = "Employee Posting Groups";
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                }
                field(BankCode;"Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankName;"Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(BankBranchNo;"Bank Branch No.")
                {
                    ApplicationArea = Basic;
                }
                field(BranchName;"Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(BankAccountNo;"Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control5;"Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No."=field("No.");
            }
            part("Leave Statistics";"HR Leave Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No."=field("No.");
            }
            part("Attached Documents";"Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID"=const(5200),
                              "No."=field("No.");
            }
            systempart(Control2;Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1;Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Employee)
            {
                Caption = 'E&mployee';
                Image = Employee;
                action(Comments)
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name"=const(Employee),
                                  "No."=field("No.");
                    ToolTip = 'View or add comments for the record.';
                    Visible = false;
                }
                action(Dimensions)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID"=const(5200),
                                  "No."=field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                    Visible = false;
                }
                action(Picture)
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No."=field("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                }
                action(AlternativeAddresses)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = '&Alternate Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No."=field("No.");
                    ToolTip = 'Open the list of addresses that are registered for the employee.';
                    Visible = false;
                }
                action(Relatives)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No."=field("No.");
                    ToolTip = 'Open the list of relatives that are registered for the employee.';
                }
                action(MiscArticleInformation)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No."=field("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action(ConfidentialInformation)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = '&Confidential Information';
                    Image = Lock;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No."=field("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action(Qualifications)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No."=field("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action(Absences)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'A&bsences';
                    Image = Absence;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No."=field("No.");
                    ToolTip = 'View absence information for the employee.';
                    Visible = false;
                }
                separator(Action75)
                {
                }
                action(AbsencesbyCategories)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No."=field("No."),
                                  "Employee No. Filter"=field("No.");
                    ToolTip = 'View categorized absence information for the employee.';
                    Visible = false;
                }
                action(MiscArticlesOverview)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                    Visible = false;
                }
                action(ConfidentialInfoOverview)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                    Visible = false;
                }
                separator(Action59)
                {
                }
                action(LedgerEntries)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No."=field("No.");
                    RunPageView = sorting("Employee No.")
                                  order(descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                    Visible = false;
                }
                action(Attachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
                action(PayEmployee)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Pay Employee';
                    Image = SuggestVendorPayments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No."=field("No."),
                                  "Remaining Amount"=filter(<0),
                                  "Applies-to ID"=filter('');
                    ToolTip = 'View employee ledger entries for the record with remaining amount that have not been paid yet.';
                    Visible = false;
                }
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Image = CostAccountingDimensions;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Next of Kin HR";
                    RunPageLink = "No."=field("No.");
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        "Employee Type" := "employee type"::Contract;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        "Employee Type" := "employee type"::Contract;
    end;

    trigger OnOpenPage()
    begin
        SetNoFieldVisible;
        IsCountyVisible := FormatAddress.UseCounty("Country/Region Code");
    end;

    var
        ShowMapLbl: label 'Show on Map';
        FormatAddress: Codeunit "Format Address";
        NoFieldVisible: Boolean;
        IsCountyVisible: Boolean;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible;
    end;
}

