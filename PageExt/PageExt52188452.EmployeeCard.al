
PageExtension 52188452 pageextension52188452 extends "Employee Card"
{
    layout
    {
        modify("Salespers./Purch. Code")
        {
            ApplicationArea = BasicHR;
        }
        modify("E-Mail")
        {
            Caption = 'Personal Email';
        }
        modify("Bank Account No.")
        {
            ApplicationArea = BasicHR;

        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify(ShowMap)
        {
            Visible = false;
        }
        modify("Grounds for Term. Code")
        {
            Visible = false;
        }
        modify("Emplymt. Contract Code")
        {
            Visible = false;
        }
        modify("Statistics Group Code")
        {
            Visible = false;
        }
        modify("Resource No.")
        {
            Visible = false;
        }

        modify("Social Security No.")
        {
            Visible = false;
        }
        modify("Union Code")
        {
            Visible = false;
        }
        modify("Union Membership No.")
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }

        modify(Iban)
        {
            Visible = false;
        }
        modify("SWIFT Code")
        {
            Visible = false;
        }
        addafter("Last Name")
        {
            field("Member No"; "Member No")
            {
                ApplicationArea = BasicHR;
                LookupPageID = "Member Listing";
            }
        }
        addafter("Privacy Blocked")
        {
            field("User ID"; "User ID")
            {
                ApplicationArea = BasicHR;
            }
            field("Last Employer Name"; "Last Employer Name")
            {
                ApplicationArea = BasicHR;
            }
            field("Last Employer Phone"; "Last Employer Phone")
            {
                ApplicationArea = BasicHR;
            }
            field("Last Employer Email"; "Last Employer Email")
            {
                ApplicationArea = BasicHR;
            }
            field("Last Employer Address"; "Last Employer Address")
            {
                ApplicationArea = BasicHR;
            }
            field("Interests & Hobbies"; "Interests & Hobbies")
            {
                ApplicationArea = BasicHR;
            }
            field("Marital Status"; "Marital Status")
            {
                ApplicationArea = BasicHR;
            }
            field(District; District)
            {
                ApplicationArea = BasicHR;
            }
            field(Location; Location)
            {
                ApplicationArea = BasicHR;
            }
            field("Employee Type"; "Employee Type")
            {
                ApplicationArea = BasicHR;
            }
            field("Supervisor Code"; "Supervisor Code")
            {
                ApplicationArea = BasicHR;
            }
            field("Location County"; rec."Location County")
            {
                ApplicationArea = BasicHR;
            }
            field("Sub-Location"; "Sub-Location")
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter("Birth Date")
        {
            field("Personal ID No."; "Personal ID No.")
            {
                ApplicationArea = BasicHR;
            }
            field(PIN; PIN)
            {
                ApplicationArea = BasicHR;
            }
            field("NSSF No."; "NSSF No.")
            {
                ApplicationArea = BasicHR;
            }
            field("NHIF No."; "NHIF No.")
            {
                ApplicationArea = BasicHR;
            }
            field("HELB No."; "HELB No.")
            {
                ApplicationArea = BasicHR;
            }
            field("Passport No."; "Passport No.")
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter("Employee Posting Group")
        {
            field("Bank Code"; "Bank Code")
            {
                ApplicationArea = BasicHR;
            }
            field("Bank Name"; "Bank Name")
            {
                ApplicationArea = BasicHR;
            }
        }
        addafter(Payments)
        {
            group(Contract)
            {
                field("Years of Service"; Rec."Years of Service")
                {
                    ApplicationArea = BasicHR;
                }
                field("Probation Period"; Rec."Probation Period")
                {
                    ApplicationArea = BasicHR;
                }
                field("Probation Start Date"; Rec."Probation Start Date")
                {
                    ApplicationArea = BasicHR;
                }
                field("Probation End Date"; Rec."Probation End Date")
                {
                    ApplicationArea = BasicHR;
                }
                field("Salary Increment Month"; Rec."Salary Increment Month")
                {
                    ApplicationArea = BasicHR;
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    ApplicationArea = BasicHR;
                }
            }
        }
        addafter(Control3)
        {
            part("Leave Statistics"; "HR Leave Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
        moveafter("Job Title"; "Salespers./Purch. Code")
        moveafter("Employee Posting Group"; "Bank Account No.")
    }
    actions
    {
        modify("E&mployee")
        {

            Caption = 'Attachments';
            ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

        }


        modify("Co&nfidential Info. Overview")
        {
            Caption = 'Co&mments';
            ToolTip = 'View or add comments for the record.';
            ApplicationArea = Comments;


        }
        modify("Ledger E&ntries")
        {
            Caption = 'Co&nfidential Info. Overview';
            ToolTip = 'View confidential information that is registered for the employee.';
            ApplicationArea = BasicHR, Suite;

        }


        //Unsupported feature: Code Insertion on "Attachments(Action 19)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //var
        //DocumentAttachmentDetails: Page "Document Attachment Details";
        //RecRef: RecordRef;
        //begin
        /*
        RecRef.GETTABLE(Rec);
        DocumentAttachmentDetails.OpenForRecRef(RecRef);
        DocumentAttachmentDetails.RUNMODAL;
        */
        //end;
        modify("Co&mments")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (RunObject) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (RunPageLink) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (Image) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AlternativeAddresses(Action 75)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "AlternativeAddresses(Action 75)".


        //Unsupported feature: Property Deletion (RunObject) on "AlternativeAddresses(Action 75)".


        //Unsupported feature: Property Deletion (RunPageLink) on "AlternativeAddresses(Action 75)".

        modify("&Relatives")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (RunObject) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (RunPageLink) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (Promoted) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (Image) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (ShortCutKey) on ""Ledger E&ntries"(Action 27)".


        //Unsupported feature: Property Deletion (RunPageView) on ""Ledger E&ntries"(Action 27)".


        //Unsupported feature: Property Deletion (RunPageLink) on ""Ledger E&ntries"(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on ""Ledger E&ntries"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""Ledger E&ntries"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Ledger E&ntries"(Action 27)".

        modify(Attachments)
        {
            Visible = false;
        }

        moveafter("E&mployee"; "Co&nfidential Info. Overview")
        moveafter("Co&mments"; "Misc. Articles &Overview")
        moveafter(Dimensions; Action61)
        moveafter("Co&nfidential Info. Overview"; Action23)
    }
}

