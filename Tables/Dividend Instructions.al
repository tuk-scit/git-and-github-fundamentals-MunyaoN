table 52188709 "Dividend Instructions"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ","Pay Internal Loan","Pay Internal Savings";

            trigger OnValidate()
            begin
                "Account No." := '';
                "Account Name" := '';
                Amount := 0;
                "Loan No." := '';
            end;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No,';
            DataClassification = ToBeClassified;

            TableRelation = if (Type = const("Pay Internal Loan")) Customer where(Type = filter(<> " "), "No." = field("Member No."))
            else
            if (Type = const("Pay Internal Savings")) Vendor where("Creditor Type" = filter(Fosa), "Member No." = field("Member No."));

            trigger OnValidate()
            var
                Cust: Record Customer;
                Vend: Record Vendor;
            begin
                "Account Name" := '';

                if Cust.get("Account No.") then
                    "Account Name" := Cust.Name;

                If Vend.get("Account No.") then
                    "Account Name" := Vend.Name;
            end;

            trigger OnLookUp()
            var
                Vend: Record Vendor;
                Cust: Record Customer;
            begin

                if (Type = Type::"Pay Internal Savings") then begin
                    Vend.RESET;
                    Vend.SETRANGE("Creditor Type", Vend."Creditor Type"::FOSA);
                    if Vend.FindFirst() then begin

                        IF PAGE.RUNMODAL(52188556, Vend) = ACTION::LookupOK THEN BEGIN
                            "Account No." := Vend."No.";
                            VALIDATE("Account No.");
                        END
                    end;
                end;

                if (Type = Type::"Pay Internal Loan") then begin
                    Cust.RESET;
                    Cust.SetFilter(Type, '<>%1', Cust.Type::" ");
                    if Cust.FindFirst() then begin

                        IF PAGE.RUNMODAL(52188511, Cust) = ACTION::LookupOK THEN BEGIN
                            "Account No." := Cust."No.";
                            VALIDATE("Account No.");
                        END
                    end;
                end;
            end;
        }
        field(5; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = ToBeClassified;
            TableRelation = Loans Where("Member No." = field("Account No."), "Total Outstanding Balance" = filter(> 0));
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Member No.", "Account No.", "Loan No.")
        {
            Clustered = true;
        }
    }
}
