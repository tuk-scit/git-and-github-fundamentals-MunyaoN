
Page 52188426 "Member Activites"
{
    PageType = CardPart;
    SourceTable = "Sacco Cues";

    layout
    {
        area(content)
        {
            cuegroup(Members)
            {
                Caption = 'Members';
                field(MembersActive; "Members - Active")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                    Image = People;
                    LookupPageId = "Member List";
                    DrillDownPageId = "Member List";
                }
                field(MembersDormant; "Members - Dormant")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                    LookupPageId = "Member List";
                    DrillDownPageId = "Member List";
                }
                field(MembersClosed; "Members - Closed")
                {
                    ApplicationArea = Basic;
                    Style = Subordinate;
                    StyleExpr = true;
                    LookupPageId = "Member List";
                    DrillDownPageId = "Member List";
                }
                field(MembersDeceased; "Members - Deceased")
                {
                    ApplicationArea = Basic;
                    Style = Ambiguous;
                    StyleExpr = true;
                    LookupPageId = "Member List";
                    DrillDownPageId = "Member List";
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;
}

