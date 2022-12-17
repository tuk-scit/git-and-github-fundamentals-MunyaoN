
TableExtension 52188505 tableextension52188405 extends "Cust. Ledger Entry"
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
        field(50061; "Loan Type"; Code[20])
        {

            CalcFormula = lookup(Loans."Loan Product Type" WHERE("Loan No." = field("Loan No.")));
            Editable = false;
            FieldClass = FlowField;
        }


    }
}

