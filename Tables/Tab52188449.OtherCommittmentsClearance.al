table 52188449 "Other Committments Clearance"
{
    Caption = 'Other Committments Clearance';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan Application No."; Code[20])
        {
            Caption = 'Loan Application No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Document No,"; Code[20])
        {
            Caption = 'Document No,';
            DataClassification = ToBeClassified;
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ","Pay External Loan","Pay Internal Loan","Pay Internal Savings","Pay Supplier";

            trigger OnValidate()
            begin
                "Account No." := '';
                Description := '';
                "Account Name" := '';
                Amount := 0;
                "Loan No." := '';
            end;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No,';
            DataClassification = ToBeClassified;

            TableRelation = if ("Type" = const("Pay External Loan")) Vendor where("Creditor Type" = filter(<> Fosa))
            else
            if (Type = const("Pay Internal Loan")) Customer where(Type = filter(<> " "))
            else
            if (Type = const("Pay Internal Savings")) Vendor where("Creditor Type" = filter(Fosa))
            else
            if (Type = const("Pay Supplier")) Vendor where("Creditor Type" = filter(<> Fosa));

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
                if (Type = Type::"Pay External Loan") or (Type = Type::"Pay Supplier") then begin
                    Vend.RESET;
                    Vend.SetFilter("Creditor Type", '<>%1', Vend."Creditor Type"::FOSA);
                    if Vend.FindFirst() then begin
                        IF PAGE.RUNMODAL(34, Vend) = ACTION::LookupOK THEN BEGIN
                            "Account No." := Vend."No.";
                            VALIDATE("Account No.");
                        END
                    end;
                end;

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
        field(6; Description; Text[50])
        {
            Caption = 'Description';
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
        key(PK; "Loan Application No.", "Document No,")
        {
            Clustered = true;
        }
    }
}
