
Table 52188518 "Loan Witness"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member,Non-Member';
            OptionMembers = Member,"Non-Member";
        }
        field(3; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Member)) Customer."No.";
            //else
            //if (Type = const("Non-Member")) "Non-Member Listing"."ID No.";

            trigger OnValidate()
            begin
                Name := '';
                "ID No." := '';
                "Mobile Phone No" := '';

                if Type = Type::Member then begin
                    Cust.Get("Member No.");
                    Name := Cust.Name;
                    "ID No." := Cust."ID No.";
                    "Mobile Phone No" := Cust."Mobile Phone No.";

                    /*
                    Loans.GET("Loan No.");
                    IF Loans.Source<>Loans.Source::MICRO THEN
                    IF "Member No."<>'' THEN BEGIN
                        LoanG.RESET;
                        LoanG.SETRANGE("Loan No","Loan No.");
                        IF LoanG.FIND('-') THEN BEGIN
                            REPEAT
                              IF LoanG."Member No" = "Member No." THEN
                                  ERROR('Guarantor Cannot be a Witness');
                            UNTIL LoanG.NEXT=0;
                        END;
                    END;
                    */
                end;


                if Type = Type::"Non-Member" then begin
                    NonMemberListing.Get("Member No.");

                    Name := NonMemberListing.Name;
                    "ID No." := NonMemberListing."ID No.";
                    "Mobile Phone No" := NonMemberListing."Mobile Phone No.";
                end;

            end;
        }
        field(4; Name; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Mobile Phone No" = '' then
                    "Mobile Phone No" := '+2547';
            end;
        }
        field(5; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                Loans.GET("Loan No.");
                IF Loans.Source<>Loans.Source::MICRO THEN
                IF "ID No."<>'' THEN BEGIN
                    LoanG.RESET;
                    LoanG.SETRANGE("Loan No","Loan No.");
                    IF LoanG.FIND('-') THEN BEGIN
                        REPEAT
                
                          Cust.GET(LoanG."Member No");
                          IF Cust."ID No." = "ID No." THEN
                              ERROR('Guarantor Cannot be a Witness');
                        UNTIL LoanG.NEXT=0;
                    END;
                END;
                */

            end;
        }
        field(6; "Mobile Phone No"; Code[13])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Mobile Phone No" := DelChr("Mobile Phone No", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-|_');

                if StrLen("Mobile Phone No") <> 13 then
                    Error('Phone No. should be equal to 13 characters');
            end;
        }
        field(7; Spouse; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Witness,Chairperson,Secretary,Treasurer,Magistrate';
            OptionMembers = Witness,Chairperson,Secretary,Treasurer,Magistrate;
            ValuesAllowed = Witness;
        }
        field(9; "SMS Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Member),
                                Micro = const(false)) Customer."No.";

            trigger OnValidate()
            begin
                "Member No." := '';

                if SavingsAccounts.Get("Account No.") then
                    "Member No." := SavingsAccounts."Member No.";

                Validate("Member No.");
            end;
        }
        field(11; Micro; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                IF Loans.GET("Loan No.") THEN
                    IF ProductSetup.GET(Loans."Loan Product Type") THEN
                        IF ProductSetup."Loan Source" = ProductSetup."Loan Source"::MICRO THEN BEGIN
                            IF Cust.GET(Loans."Member No.") THEN
                                "Group Code":=Cust."Group Code";
                        END;
                
                */

            end;
        }
        field(12; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.", Category, "Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        LoanG: Record "Loan Security";
        SavingsAccounts: Record Vendor;
        Loans: Record Loans;
        ProductSetup: Record "Product Setup";
        NonMemberListing: Record "Non-Member Listing";
}

