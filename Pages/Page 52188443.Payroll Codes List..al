
Page 52188443 "Payroll Codes List."
{
    ApplicationArea = Basic;
    CardPageID = "Payroll Code.";
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Codes";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionCode;"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionName;"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(SortOrder;"Sort Order")
                {
                    ApplicationArea = Basic;
                }
                field(BalanceType;"Balance Type")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType;"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Frequency;Frequency)
                {
                    ApplicationArea = Basic;
                }
                field(Taxable;Taxable)
                {
                    ApplicationArea = Basic;
                }
                field(CalculationType;"Calculation Type")
                {
                    ApplicationArea = Basic;
                }
                field(Formula;Formula)
                {
                    ApplicationArea = Basic;
                }
                field(SpecialTransactions;"Special Transactions")
                {
                    ApplicationArea = Basic;
                }
                field(DeductPremium;"Deduct Premium")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerDeduction;"Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field(SpecialIdentifier;"Special Identifier")
                {
                    ApplicationArea = Basic;
                }
                field(IncludeEmployerDeduction;"Include Employer Deduction")
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

    var
        SaccoPermissions: Record "User Setup";


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

