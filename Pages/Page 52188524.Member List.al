
Page 52188524 "Member List"
{
    ApplicationArea = Basic;
    CardPageID = "Member Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = where(Type = const(Member));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; "No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(RegistrationDate; "Registration Date")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(OldMemberNo; "Old Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Category"; "Member Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IDNo; "ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("From Another Sacco"; "From Another Sacco")
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
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
                field(CapturedBy; "Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(TestNo; "Test No")
                {
                    ApplicationArea = Basic;
                }
                field(RelationshipOfficer; "Relationship Officer")
                {
                    ApplicationArea = Basic;
                }
                field(RelationshipOfficerName; "Relationship Officer Name")
                {
                    ApplicationArea = Basic;
                }
                field(MemberStatus; "Member Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

