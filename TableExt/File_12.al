
TableExtension 52188426 tableextension52188426 extends "FA Depreciation Book"
{
    fields
    {
        field(50050; "Customized Depr. Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }



    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Depreciation Starting Date" := CalcDate('1Y-CY', today)
    end;
}

