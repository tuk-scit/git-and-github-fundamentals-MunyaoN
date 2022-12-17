
Table 52188432 "Approval Tracker"
{

    fields
    {
        field(1; "Tracker ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
        }
        field(3; "Document Type"; Enum "Approval Document Type")
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(6; "Record ID to Approve"; RecordID)
        {
            Caption = 'Record ID to Approve';
            DataClassification = ToBeClassified;
        }
        field(7; "Document Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(10; Status; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;

        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Loan Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(38; Name; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
            DataClassification = ToBeClassified;
            TableRelation = "Job Titles";
        }
        field(40; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Tracker ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        NSetup.Get;
        if "Tracker ID" = '' then begin
            NSetup.TestField("Tracker Nos.");
            NoSeriesMgt.InitSeries(NSetup."Tracker Nos.", xRec."No. Series", 0D, "Tracker ID", "No. Series");
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NSetup: Record "Sales & Receivables Setup";
}

