tableextension 52188429 "BAnk Reconcilliation Line" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(52188423; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(52188424; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
            DataClassification = ToBeClassified;
        }
        field(52188425; "Ext. Document No."; Code[20])
        {
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
