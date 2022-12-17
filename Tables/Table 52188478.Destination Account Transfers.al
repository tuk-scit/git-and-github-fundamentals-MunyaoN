
Table 52188478 "Destination Account Transfers"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Currency,Transfers;
        }
        field(50002; "Destination Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Destination Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Destination Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                                      Blocked = const(false))
            else
            if ("Destination Account Type" = const(Customer)) Customer
            else
            if ("Destination Account Type" = const(Vendor)) Vendor
            else
            if ("Destination Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Destination Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Destination Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Destination Account Type" = const(Savings)) Vendor
            else
            if ("Destination Account Type" = const(Credit)) Customer where("No." = field("Member No."));

            trigger OnValidate()
            begin


                "Destination Account Name" := '';
                "Destination Loan No." := '';


                if "Destination Account Type" = "destination account type"::"G/L Account" then begin
                    if "G/L".Get("Destination Account No.") then begin
                        "Destination Account Name" := "G/L".Name;
                        Validate("Destination Loan No.");
                    end;
                end;

                if "Destination Account Type" = "destination account type"::Vendor then begin
                    if Vend.Get("Destination Account No.") then begin
                        "Destination Account Name" := Vend.Name;

                    end;
                end;

                if "Destination Account Type" = "destination account type"::Credit then begin
                    Credit.Reset;
                    if Credit.Get("Destination Account No.") then begin
                        "Destination Account Name" := Credit.Name;
                    end;
                end;

                if "Destination Account Type" = "destination account type"::Savings then begin
                    Saving.Reset;
                    if Saving.Get("Destination Account No.") then begin
                        Saving.CalcFields(Saving.Balance);
                        "Destination Account Name" := Saving.Name;
                        "Product Name" := Saving."Product Name";
                    end;
                end;

                if "Destination Account Type" = "destination account type"::Customer then begin
                    Cust.Reset;
                    if Cust.Get("Destination Account No.") then begin
                        "Destination Account Name" := Cust.Name;
                    end;
                end;



                if "Destination Account Type" = "destination account type"::"Bank Account" then begin
                    Bank.Reset;
                    if Bank.Get("Destination Account No.") then begin
                        "Destination Account Name" := Bank.Name;
                    end;
                end;
            end;
        }
        field(50004; "Destination Loan No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."),
                                         "Total Outstanding Balance" = filter(<> 0));
        }
        field(50005; "Destination Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Destination Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Destination Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Destination Account Type" = "destination account type"::Credit then begin
                    if "Destination Transaction Type" = "destination transaction type"::" " then
                        Error('Kindly specify transaction type for credit accounts');

                    TestField("Destination Loan No.");
                    Loans.Reset;
                    Loans.SetRange("Loan No.", "Destination Loan No.");
                    if Loans.FindFirst then begin
                        Loans.CalcFields("Outstanding Interest", "Outstanding Penalty", "Outstanding Principal");

                        if "Destination Transaction Type" = "destination transaction type"::"Interest Paid" then
                            if "Destination Amount" > Loans."Outstanding Interest" then
                                Error('This will lead to overpayment of Interest. Current Interest Balance is KES %1', Loans."Outstanding Interest");
                        if "Destination Transaction Type" = "destination transaction type"::"Penalty Paid" then
                            if "Destination Amount" > Loans."Outstanding Penalty" then
                                Error('This will lead to overpayment of Interest. Current Penalty Balance is KES %1', Loans."Outstanding Penalty");
                        if "Destination Transaction Type" = "destination transaction type"::"Principal Repayment" then
                            if "Destination Amount" > Loans."Outstanding Principal" then
                                Error('This will lead to overpayment of Interest. Current Principal Balance is KES %1', Loans."Outstanding Principal");
                    end;

                end;

                if "Destination Amount" < 0 then
                    Error('Invalid Amount');
            end;
        }
        field(50008; "External Document No."; Code[35])
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
        field(50011; "Product Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Members));
        }
    }

    keys
    {
        key(Key1; "No.", "Destination Account No.", "Destination Loan No.", "Destination Transaction Type")
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
        GenJournalLine: Record "Gen. Journal Line";
        Loans: Record Loans;
}

