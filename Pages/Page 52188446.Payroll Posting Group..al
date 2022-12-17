
Page 52188446 "Payroll Posting Group."
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Payroll Posting Group";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(SalaryAccount;"Salary Account")
                {
                    ApplicationArea = Basic;
                }
                field(IncomeTaxAccount;"Income Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field(NITAExpenseAccount;"NITA Expense Account")
                {
                    ApplicationArea = Basic;
                }
                field(NITAPayableAccount;"NITA Payable Account")
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

