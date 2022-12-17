
TableExtension 52188517 tableextension52188417 extends "Detailed Cust. Ledg. Entry"
{
    fields
    {

        field(50050; "Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Staff No."; Code[20])
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
        field(50058; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }


        field(50060; "Transfered"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50061; "Reversed - FLF"; Boolean)
        {

            CalcFormula = lookup("Cust. Ledger Entry".Reversed WHERE("Entry No." = FIELD("Cust. Ledger Entry No.")));
            Editable = false;
            FieldClass = FlowField;

        }

        field(50062; "From Legacy"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "Description - FLF"; Text[100])
        {

            CalcFormula = lookup("Cust. Ledger Entry".Description WHERE("Entry No." = FIELD("Cust. Ledger Entry No.")));
            Editable = false;
            FieldClass = FlowField;

        }

        field(50064; "Duplicates"; Integer)
        {

            CalcFormula = count("Detailed Cust. Ledg. Entry" WHERE("Posting Date" = field("Posting Date"), "Transaction Type" = field("Transaction Type"), Amount = field(Amount), "Document No." = field("Document No."), "Loan No." = field("Loan No.")));
            Editable = false;
            FieldClass = FlowField;

        }

        field(50065; "Loan Product"; Code[20])
        {

            CalcFormula = lookup(Loans."Loan Product Type" WHERE("Loan No." = FIELD("Loan No.")));
            Editable = false;
            FieldClass = FlowField;

        }


        field(50066; "Amount Back Up"; Decimal)
        {

        }

    }
}

