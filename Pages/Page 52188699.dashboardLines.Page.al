Page 52188699 "dashboard Lines"
{
    PageType = ListPart;
    SourceTable = "Dashboard Lines";
    SourceTableView = sorting(Type)
                      order(ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                    StyleExpr = MemberStatusStyle;
                }
                field(Value; Value)
                {
                    ApplicationArea = Basic;
                    StyleExpr = MemberStatusStyle;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        MemberStatusStyle := '';
        if Type = Type::"Loans Category" then
            MemberStatusStyle := 'StrongAccent';
        if Type = Type::"Treasury Balances" then
            MemberStatusStyle := 'Attention';//'StrongAccent'

        if CopyStr(Description, 1, 1) = '-' then
            MemberStatusStyle := 'Strong';

        /*
      END ELSE IF Status =Status::Blocked THEN BEGIN
      MemberStatusStyle := 'Attention';
      END ELSE IF Status = Status::Deceased THEN BEGIN
      MemberStatusStyle := 'Strong';
        */

    end;

    var
        MemberStatusStyle: Text;
}

