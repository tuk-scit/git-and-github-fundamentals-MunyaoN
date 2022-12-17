
Table 52188492 "Default Savings Products."
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = "Member Registration";
        }
        field(2; Product; Code[20])
        {
            NotBlank = true;
            TableRelation = "Product Setup" where("Product Class" = const(Savings));

            trigger OnValidate()
            begin
                ProductSetup.Get(Product);
                "Product Category" := ProductSetup."Product Category";
                "Product Name" := ProductSetup.Description;
                "Monthly Contribution" := ProductSetup."Minimum Contribution";
            end;
        }
        field(50001; "Product Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Registration Fee,Share Capital,Deposit Contribution,Benevolent Fund,Unallocated Fund,Dividend Account,Micro Member Deposit,Micro Group Deposit,Ordinary Savings,Holiday Savings,School Fee,Fixed Deposit,Junior Savings,Welfare,Housing,Asset Finance,FOSA Shares,Business,Jipange';
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Asset Finance","FOSA Shares",Business,Jipange;
        }


        field(50080; "Repay Mode"; Enum "Repay Mode Enum")
        {
        }
    }

    keys
    {
        key(Key1; "Code", Product)
        {
            Clustered = true;
        }
        key(Key2; Product, "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ProductSetup: Record "Product Setup";
}

