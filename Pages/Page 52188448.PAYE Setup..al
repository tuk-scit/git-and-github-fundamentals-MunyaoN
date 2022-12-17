
Page 52188448 "PAYE Setup."
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = PAYE;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control7)
            {
                field(TierCode;"Tier Code")
                {
                    ApplicationArea = Basic;
                }
                field(PAYETier;"PAYE Tier")
                {
                    ApplicationArea = Basic;
                }
                field(Rate;Rate)
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

