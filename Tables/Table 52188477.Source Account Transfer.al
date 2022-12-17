
Table 52188477 "Source Account Transfer"
{

    fields
    {
        field(50001; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Source Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Source Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                                 Blocked = const(false))
            else
            if ("Source Account Type" = const(Customer)) Customer
            else
            if ("Source Account Type" = const(Vendor)) Vendor
            else
            if ("Source Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Source Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Source Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Source Account Type" = const(Savings)) Vendor where("Member No." = field("Member No."))
            else
            if ("Source Account Type" = const(Credit)) Customer where("No." = field("Member No."));

            trigger OnValidate()
            begin
                "Source Account Name" := '';
                "Available Balance" := 0;
                Balance := 0;
                "Source Loan No." := '';


                if "Source Account Type" = "source account type"::"G/L Account" then begin
                    if "G/L".Get("Source Account No.") then begin
                        "Source Account Name" := "G/L".Name;
                        Validate("Source Loan No.");
                    end;
                end;

                if "Source Account Type" = "source account type"::Vendor then begin
                    if Vend.Get("Source Account No.") then begin
                        "Source Account Name" := Vend.Name;
                        Vend.CalcFields(Vend."Balance (LCY)", Vend.Balance);
                        Balance := Vend.Balance;
                        "Available Balance" := Vend."Balance (LCY)";
                    end;
                end;

                if "Source Account Type" = "source account type"::Credit then begin
                    Credit.Reset;
                    if Credit.Get("Source Account No.") then begin
                        "Source Account Name" := Credit.Name;
                    end;
                end;

                if "Source Account Type" = "source account type"::Savings then begin
                    Saving.Reset;
                    if Saving.Get("Source Account No.") then begin
                        Saving.CalcFields(Saving.Balance);
                        "Source Account Name" := Saving.Name;
                        "Product Name" := Saving."Product Name";
                        Balance := Saving.Balance;
                        "Available Balance" := MemberActivities.GetAccountBalance("Source Account No.");
                    end;
                end;

                if "Source Account Type" = "source account type"::Customer then begin
                    Cust.Reset;
                    if Cust.Get("Source Account No.") then begin
                        "Source Account Name" := Cust.Name;
                        Cust.CalcFields(Cust."Balance (LCY)", Cust.Balance);
                        Balance := Cust.Balance;
                        "Available Balance" := Cust."Balance (LCY)";
                    end;
                end;



                if "Source Account Type" = "source account type"::"Bank Account" then begin
                    Bank.Reset;
                    if Bank.Get("Source Account No.") then begin
                        "Source Account Name" := Bank.Name;
                        Bank.CalcFields(Bank."Balance (LCY)", Bank.Balance);
                        Balance := Bank.Balance;
                        "Available Balance" := Bank."Balance (LCY)";
                    end;
                end;
            end;
        }
        field(50003; "Source Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Source Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Source Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."),
                                         "Total Outstanding Balance" = filter(<> 0));
        }
        field(50006; "Source Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //VALIDATE("Source Account No.");

                if "Source Account Type" = "source account type"::Savings then begin

                    Message('"Source Amount" %1\"Available Balance" %2', "Source Amount", "Available Balance");

                    if "Source Amount" > "Available Balance" then
                        Error('Amount cannot be more than the avaiable balance');
                end;


                if "Source Amount" < 0 then
                    Error('Invalid Amount');
            end;
        }
        field(50007; "Source Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50010; "Product Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50012; "Available Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50013; "Product Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Members));
        }
    }

    keys
    {
        key(Key1; "No.", "Source Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        Vend: Record Vendor;
        Bank: Record "Bank Account";
        //Transfer: Record "Account Transfers";
        "G/L": Record "G/L Account";
        memb: Record Customer;
        Credit: Record Customer;
        Saving: Record Vendor;
        TChargeAmount: Decimal;
        SaccoSetup: Record "Sacco Setup";
        transtype: Code[20];
        ChargeAmount: Decimal;
        Account: Record Vendor;
        AccountTypes: Record "Product Setup";
        MemberActivities: Codeunit "Member Activities";
}

