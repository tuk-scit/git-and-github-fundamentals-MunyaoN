
TableExtension 52188511 VendLedger extends "Vendor Ledger Entry"
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


        field(50061; "Product Type"; Code[20])
        {

            CalcFormula = lookup(Vendor."Product Type" WHERE("Product Type" = field("Vendor No.")));
            Editable = false;
            FieldClass = FlowField;
        }



    }
}

