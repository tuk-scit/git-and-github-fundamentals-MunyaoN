
Page 52188451 "Payroll Salary Line."
{
    PageType = ListPart;
    SourceTable = "Staff Payroll Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(BasicPay;"Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentMode;"Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field(ProcessNITA;"Process NITA")
                {
                    ApplicationArea = Basic;
                }
                field(PINNo;"PIN No.")
                {
                    ApplicationArea = Basic;
                }
                field(PaysNSSF;"Pays NSSF")
                {
                    ApplicationArea = Basic;
                }
                field(PaysNHIF;"Pays NHIF")
                {
                    ApplicationArea = Basic;
                }
                field(PaysPAYE;"Pays PAYE")
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

