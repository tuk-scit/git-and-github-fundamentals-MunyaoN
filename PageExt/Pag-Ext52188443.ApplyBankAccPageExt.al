pageextension 52188443 "Apply Bank Acc Page Ext" extends "Apply Bank Acc. Ledger entries"
{
    layout
    {
        modify("Posting Date")
        {
            StyleExpr = CustomStyleExpression;
        }
        modify(Description)
        {
            StyleExpr = CustomStyleExpression;
        }
        modify("Remaining Amount")
        {
            StyleExpr = CustomStyleExpression;
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        SetCustomStyleExpression
    end;

    trigger OnAfterGetRecord()
    begin
        SetCustomStyleExpression
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        SetCustomStyleExpression
    end;

    local procedure SetCustomStyleExpression()
    begin
        CustomStyleExpression := Rec.SetStyleText();
    end;

    var
        CustomStyleExpression: Text[20];
}
