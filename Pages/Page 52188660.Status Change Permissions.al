
Page 52188660 "Status Change Permissions"
{
    PageType = Card;
    SourceTable = "User Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(UserID;"User ID")
                {
                    ApplicationArea = Basic;
                }
                field(UsePOSPrinter;"Use POS Printer")
                {
                    ApplicationArea = Basic;
                }
                field(Payroll;Payroll)
                {
                    ApplicationArea = Basic;
                }
                field(AllowBanktoBankTrans;"Allow Bank to Bank Trans")
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

