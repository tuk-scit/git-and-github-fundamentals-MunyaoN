
TableExtension 52188513 DetVendLedger extends "Detailed Vendor Ledg. Entry"
{
    fields
    {

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
        field(50060; "Reversed - FLF"; Boolean)
        {

            CalcFormula = lookup("Vendor Ledger Entry".Reversed WHERE("Entry No." = FIELD("Vendor Ledger Entry No.")));
            Editable = false;
            FieldClass = FlowField;

        }
        field(50062; "Narration"; Text[100])
        {

            CalcFormula = lookup("Vendor Ledger Entry".Description WHERE("Entry No." = FIELD("Vendor Ledger Entry No.")));
            Editable = false;
            FieldClass = FlowField;

        }

        field(50061; "From Legacy"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


    }
}

