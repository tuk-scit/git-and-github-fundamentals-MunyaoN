
Table 52188500 "Loan Interest Buffer"
{

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(3; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Savings,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Savings,Credit;
        }
        field(4; "Interest Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Interest Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Loan No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Loans;
        }
        field(16; "Loan Product type"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Product Setup";
        }
        field(17; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Bal. Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Bal. Account Type" = const(Credit)) Customer;
        }
        field(23; "Issued Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; Blocked; Enum "Customer Blocked")
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
                AccountingPeriod: Record "Accounting Period";
                IdentityManagement: Codeunit "Identity Management";
            begin
            end;
        }
        field(40; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Annual Interest %"; Decimal)
        {
            Caption = 'Annual Interest';
            DataClassification = ToBeClassified;
        }
        field(42; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Active,Dormant,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            OptionMembers = " ",Active,Dormant,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        }
        field(43; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Employer Code"; Code[20])
        {
            CalcFormula = lookup(Customer."Employer Code" where("No." = field("Account No")));
            FieldClass = FlowField;
        }
        field(45; Name; Text[200])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Account No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Interest Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

