
TableExtension 52188510 GenJournalLnine extends "Gen. Journal Line"
{
    fields
    {
        modify("Account No.")
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer where("Account Type" = filter(<> Members))
            else
            if ("Account Type" = const(Vendor)) Vendor where("Creditor Type" = filter(<> Fosa))
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Employee)) Employee
            else
            if ("Account Type" = const(Savings), "Member No." = const('')) Vendor where("Creditor Type" = const(Fosa))
            else
            if ("Account Type" = const(Savings)) Vendor where("Creditor Type" = const(Fosa), "Member No." = field("Member No."))
            else
            if ("Account Type" = const(Credit)) Customer where("Type" = filter(<> " "), "Member No." = field("Member No."));
        }
        field(50050; "Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = filter(Credit)) Loans where("Member No." = field("Account No."));
        }
        field(50052; "Member No."; Code[20])
        {
            TableRelation = Customer where("Account Type" = const(Members));
            DataClassification = ToBeClassified;
        }
        field(50053; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Staff No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Credit Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Loan Disbursement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }


    procedure GetSavingsAccount()
    var
        Vend: Record Vendor;
        LoanLedgerEntry: Record "Cust. Ledger Entry";
        Members: Record Customer;
    begin
        Vend.Get("Account No.");
        //Vend.CheckBlockedVendOnJnls(Vend, "Document Type", false);


        Description := CopyStr(Vend.Name, 1, 50);

        //UpdateDescription(Vend.Name);
        "Posting Group" := Vend."Vendor Posting Group";

        Members.Get(Vend."Member No.");

        "Member No." := Members."No.";
        "Group Code" := Members."Test No";
        "Staff No." := Members."Payroll/Staff No.";
    end;

    procedure GetLoanAccount()
    var
        LoanLedgerEntry: Record "Cust. Ledger Entry";
        Members: Record Customer;
    begin

        Members.Get("Account No.");

        Description := CopyStr(Members.Name, 1, 50);

        //UpdateDescription(Members.Name);
        "Posting Group" := 'LOANS';

        "Member No." := Members."No.";
        "Group Code" := Members."Test No";
        "Staff No." := Members."Payroll/Staff No.";
    end;

}

