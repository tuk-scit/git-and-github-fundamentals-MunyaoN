
Page 52188537 "Monthly Advice Buffer"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Monthly Advice";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AdviceDate; "Advice Date")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollNo; "Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(AccountNo; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; "Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; "Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(LoanBalance; "Loan Balance")
                {
                    ApplicationArea = Basic;
                }

                field("Amount Off"; "Amount Off")
                {
                    ApplicationArea = Basic;
                }

                field("Amount On"; "Amount On")
                {
                    ApplicationArea = Basic;
                }
                field("Advice Type"; "Advice Type")
                {
                    ApplicationArea = Basic;
                }

                field(LoanNo; "Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerCode; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Balance"; "Schedule Balance")
                {
                    ApplicationArea = Basic;
                }
                field(Interest; Interest)
                {
                    ApplicationArea = Basic;
                }
                field(Principal; Principal)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }



}

