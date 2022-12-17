
Page 52188653 "Account Signatories"
{
    CardPageID = "Account Signatory Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; "ID No.")
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

