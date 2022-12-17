
Page 52188552 "CRB Update File"
{
    PageType = List;
    SourceTable = "CRB Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Surname;Surname)
                {
                    ApplicationArea = Basic;
                }
                field("Other Names";"Name 2"+' '+"Name 3"+' '+"Name 4")
                {
                    ApplicationArea = Basic;
                }
                field(PrimaryIdentification1;"Primary Identification 1")
                {
                    ApplicationArea = Basic;
                }
                field(SecondaryIdentification1;"Secondary Identification 1")
                {
                    ApplicationArea = Basic;
                }
                field("Service No.";"Service No.")
                {
                    ApplicationArea = Basic;
                }
                field("Alien No.";"Alien No.")
                {
                    ApplicationArea = Basic;
                }
                field(PINNo;"PIN No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth;"Update Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                }
                field(CurrencyofFacilty;"Currency of Facilty")
                {
                    ApplicationArea = Basic;
                }
                field(OriginalAmount;"Update Original Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Original Amount';
                }
                field(AmountPaid;"Update Amount Paid")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Paid';
                }
                field(CurrentBalance;"Update Current Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Balance';
                }
                field(AccountNo;"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateofLastPayment;"Update Date of Last Payment")
                {
                    ApplicationArea = Basic;
                    Caption = ' Date of Last Payment';
                }
                field(AccountStatus;"Account Status")
                {
                    ApplicationArea = Basic;
                }
                field(NoofDaysinArrears;"No. of Days in Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(NoofInstallmentsinArrears;"No. of Installments in Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(OverdueBalance;"Update Overdue Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Overdue Balance';
                }
                field(AccountType;"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(ScheduledPayment;"Update Scheduled Payment")
                {
                    ApplicationArea = Basic;
                    Caption = ' Scheduled Payment';
                }
            }
        }
    }

    actions
    {
    }

    var
        "Service No.": Text;
        "Alien No.": Text;
        OtherNames: Text;
}

