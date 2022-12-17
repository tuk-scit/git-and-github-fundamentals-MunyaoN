table 52188674 Nominee
{
    Caption = 'Nominee';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "ID No."; Code[20])
        {
            NotBlank = false;
        }
        field(15; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(17; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin

                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(50000; Relationship; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Relationship;
        }
        field(50001; Beneficiary; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" > Today then
                    Error('Invalid Date of Birth. Future Date Detected');
            end;
        }
        field(50003; Email; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "%Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                TotalA: Decimal;
                NOK: Record "Service Item";
            begin
                TotalA := 0;
                /*
                NOK.RESET;
                NOK.SETRANGE(NOK."Customer No.","Customer No.");
                IF NOK.FIND('-') THEN BEGIN
                    REPEAT
                        TotalA:=TotalA+NOK."%Allocation"
                    UNTIL NOK.NEXT = 0;
                END;
                
                TotalA:=TotalA+"%Allocation";
                IF TotalA > 100 THEN
                ERROR('Total allocation cannot be more than 100%.');
                */

            end;
        }
        field(50006; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Next of Kin,Benevolent Beneficiary';
            OptionMembers = "Next of Kin","Benevolent Beneficiary";
        }
        field(50007; Deceased; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; Spouse; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "ID No.", Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        Contact: Record Contact;
        ContAltAddrDateRange: Record "Contact Alt. Addr. Date Range";
    begin
    end;

    trigger OnInsert()
    var
        Contact: Record Contact;
    begin
    end;

    trigger OnModify()
    var
        Contact: Record Contact;
    begin
    end;

    trigger OnRename()
    var
        Contact: Record Contact;
    begin
    end;

    var
        PostCode: Record "Post Code";
}

