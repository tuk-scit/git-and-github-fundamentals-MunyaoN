
Table 52188481 "Loan Repayment Schedule"
{

    fields
    {
        field(1;"Loan No.";Code[20])
        {
            Caption = 'No.';
            TableRelation = "Bank Account"."No.";
        }
        field(50002;"Repayment Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003;"Loan Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004;"Monthly Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005;"Monthly Interest";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006;"Monthly Appraisal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007;"Monthly Repayment";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008;"Loan Balance";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009;"Line No.";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50010;"Deposit Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Loan No.","Repayment Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

