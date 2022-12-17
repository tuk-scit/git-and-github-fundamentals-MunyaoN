
Page 52188590 "Account Signatories App."
{
    CardPageID = "Account Signatory App. Card";
    PageType = List;
    SourceTable = "Account Signatories.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Position; Position)
                {
                    ApplicationArea = Basic;
                }
                field(DateOfBirth; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(StaffPayroll; "Staff/Payroll")
                {
                    ApplicationArea = Basic;
                }
                field(PhoneNo; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(Signatory; Signatory)
                {
                    ApplicationArea = Basic;
                }
                field(MustSign; "Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field(MustbePresent; "Must be Present")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Signature)
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

