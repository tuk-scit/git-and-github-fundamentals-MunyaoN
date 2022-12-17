
Page 52188453 "Payroll Period transactions."
{
    PageType = List;
    SourceTable = "Payroll Period Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EmployeeCode;"Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionCode;"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field(Grouping;Grouping)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionName;"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Balance)
                {
                    ApplicationArea = Basic;
                }
                field(GroupOrder;"Group Order")
                {
                    ApplicationArea = Basic;
                }
                field(SubGroupOrder;"Sub Group Order")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodMonth;"Period Month")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodYear;"Period Year")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodFilter;"Period Filter")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollPeriod;"Payroll Period")
                {
                    ApplicationArea = Basic;
                }
                field(EntryType;"Entry Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType;"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo;"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(PostAs;"Post As")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollCode;"Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentMode;"Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field(BankCode;"Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BranchCode;"Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(ACNumber;"A/C Number")
                {
                    ApplicationArea = Basic;
                }
                field(BankName;"Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchName;"Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code;"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code;"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollCodeType;"Payroll Code Type")
                {
                    ApplicationArea = Basic;
                }
                field(SpecialTransactions;"Special Transactions")
                {
                    ApplicationArea = Basic;
                }
                field(SpecialIdentifier;"Special Identifier")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID",UserId);
        SaccoPermissions.SetRange(Payroll,true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Payroll"');
    end;
}

