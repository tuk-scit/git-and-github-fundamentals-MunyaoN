table 52188708 "Business Monthly Income"
{
    Caption = 'Business Monthly Income';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Appraisal No."; Code[20])
        {
            Caption = 'Appraisal No.';
            DataClassification = ToBeClassified;
        }
        field(2; Period; Date)
        {
            Caption = 'Period';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Period <> 0D then
                    Period := CalcDate('CM', Period);
            end;
        }
        field(3; "Gross Monthly Income"; Decimal)
        {
            Caption = 'Gross Monthly Income';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Appraisal: Record "Member Salary Appraisal";
            begin
                if Appraisal.Get("Appraisal No.") then begin


                    "Monthly Repayment" := Appraisal."Monthly Repayment";
                    "Deficit/Surplus" := "Gross Monthly Income" - Appraisal."Monthly Repayment";
                end;
            end;

        }
        field(4; "Monthly Repayment"; Decimal)
        {
            Caption = 'Monthly Repayment';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Deficit/Surplus"; Decimal)
        {
            Caption = 'Deficit/Surplus';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Appraisal No.", Period)
        {
            Clustered = true;
        }
    }
}
