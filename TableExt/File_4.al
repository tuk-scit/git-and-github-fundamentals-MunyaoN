
TableExtension 52188509 tableextension52188409 extends "Company Information"
{
    fields
    {
        field(50050; "KRA PIN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Teller Slip Msg"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Letter Head"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50053; "Year Start"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50054; "Year End"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
    }
}

