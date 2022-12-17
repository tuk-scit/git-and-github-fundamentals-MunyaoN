
Table 52188454 "Monthly Checkoff Lines"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Checkoff Header"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Payroll No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Multiple; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Credit Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Savings Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "ID Number"; Code[11])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Principal,Interest,Penalty;
        }
        field(15; "Product ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup";
        }
        field(16; "Excess Amount"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Product Category"; OPtion)
        {

            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            OptionCaption = ' ,Registration Fee,Share Capital,Deposit Contribution,Benevolent Fund,Unallocated Fund,Dividend Account,Micro Member Deposit,Micro Group Deposit,Ordinary Savings,Holiday Savings,School Fee,Fixed Deposit,Junior Savings,Welfare,Housing,Asset Finance,FOSA Shares,Business,Jipange';
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Asset Finance","FOSA Shares",Business,Jipange;
        }
    }

    keys
    {
        key(Key1; "Entry No", "Checkoff Header")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

