pageextension 52188460 ChartOfAccounts extends "Chart of Accounts"
{


    trigger OnOpenPage();
    begin
        Rec.SetRange(Blocked, false);
    end;



}
