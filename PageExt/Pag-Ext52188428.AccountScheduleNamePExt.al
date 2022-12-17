pageextension 52188428 "Account Schedule Name PExt" extends "Account Schedule Names"
{
    layout
    {

        addafter("Analysis View Name")
        {
            field("User Group Code"; Rec."User Group Code")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
        }
    }

    trigger OnOpenPage()
    var
        AccSchedName: Record "Acc. Schedule Name";
        UserGrMember: Record "User Group Member";
    begin
        AccSchedName.Reset();
        AccSchedName.SetFilter("User Group Code", '<>%1', '');
        if AccSchedName.FindSet() then
            repeat

                UserGrMember.Reset();
                UserGrMember.SetRange("User Security ID", UserSecurityId());
                UserGrMember.SetRange("User Group Code", AccSchedName."User Group Code");
                if UserGrMember.FindFirst() then
                    Rec.SetFilter("User Group Code", UserGrMember."User Group Code");

            until AccSchedName.Next() = 0;

    end;

}
