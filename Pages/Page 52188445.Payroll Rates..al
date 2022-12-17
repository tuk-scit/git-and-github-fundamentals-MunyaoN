
Page 52188445 "Payroll Rates."
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "Payroll Rates";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(TaxRelief)
            {
                Caption = 'Tax Relief';
                field(Control33;"Tax Relief")
                {
                    ApplicationArea = Basic;
                }
                field(InsuranceRelief;"Insurance Relief")
                {
                    ApplicationArea = Basic;
                }
                field(MaxRelief;"Max Relief")
                {
                    ApplicationArea = Basic;
                }
                field(DisbledTaxLimit;"Disbled Tax Limit")
                {
                    ApplicationArea = Basic;
                }
            }
            group(NHIF)
            {
                Caption = 'NHIF';
                field(NHIFBasedon;"NHIF Based on")
                {
                    ApplicationArea = Basic;
                }
            }
            group(NITA)
            {
                Caption = 'NITA';
                field(NITAAmount;"NITA Amount")
                {
                    ApplicationArea = Basic;
                }
                field(NITANumber;"NITA Number")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Pension)
            {
                Caption = 'Pension';
                field(MaxPensionContribution;"Max Pension Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(TaxOnExcessPension;"Tax On Excess Pension")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Mortgage)
            {
                Caption = 'Mortgage';
                field(MortgageReliefLessfromTaxablePay;"Mortgage Relief")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mortgage Relief (Less from Taxable Pay)';
                }
                field(MortgageReliefPercentage;"Mortgage Relief Percentage")
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

