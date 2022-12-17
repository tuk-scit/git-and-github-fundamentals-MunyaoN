
Page 52188654 "Account Signatory Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Account Signatories.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(MemberNo;"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(IDNo;"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateOfBirth;"Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(StaffPayroll;"Staff/Payroll")
                {
                    ApplicationArea = Basic;
                }
                field(PhoneNo;"Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(Signatory;Signatory)
                {
                    ApplicationArea = Basic;
                }
                field(MustSign;"Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field(MustbePresent;"Must be Present")
                {
                    ApplicationArea = Basic;
                }
                group(Control14)
                {
                    field(Picture;Picture)
                    {
                        ApplicationArea = Basic;
                    }
                    field(Signature;Signature)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
    }

    actions
    {
    }
}

