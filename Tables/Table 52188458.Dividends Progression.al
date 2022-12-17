
Table 52188458 "Dividends Progression"
{

    fields
    {
        field(50001; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50002; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Processing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Dividend Calc. Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Flat Rate,Prorated';
            OptionMembers = " ","Flat Rate",Prorated;
        }
        field(50005; "Product Type"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Product Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Qualifying Shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; Shares; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Gross Dividends"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Witholding Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Net Dividends"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Payment Mode"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Dividend Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50017; "Name"; TExt[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Account No", "End Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

