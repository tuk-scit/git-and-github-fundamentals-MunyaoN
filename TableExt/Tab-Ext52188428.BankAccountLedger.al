tableextension 52188428 "Bank Account Ledger" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(52188423; "Statement Difference"; Decimal)
        {
            Caption = 'Statement Difference';
            DataClassification = ToBeClassified;
        }
        field(52188424; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(52188525; "Match Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Date & Document No & Amount","Document No & Amount";
        }
    }



    procedure SetStyleText() StyleText: Text[20]
    begin
        StyleText := '';
        case "Match Option" of
            "Match Option"::"Document No & Amount":
                StyleText := 'StandardAccent';
            "Match Option"::"Date & Document No & Amount":
                StyleText := 'Favorable';
        end;
    end;
}
