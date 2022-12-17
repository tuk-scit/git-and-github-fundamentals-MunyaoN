
TableExtension 52188508 tableextension52188408 extends "Purchase Line"
{
    fields
    {
        field(50000; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39005600; "Grant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005601; "Job Contract Entry No."; Integer)
        {
            Caption = 'Job Contract Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                /*JobPlanningLine.SETCURRENTKEY("Job Contract Entry No.");
                JobPlanningLine.SETRANGE("Job Contract Entry No.","Job Contract Entry No.");
                JobPlanningLine.FINDFIRST;
                CreateDim(
                  DimMgt.TypeToTableID3(Type),"No.",
                  DATABASE::Table167,JobPlanningLine."Job No.",
                    DATABASE::"Responsibility Center","Responsibility Center");
                */

            end;
        }
        field(39005602; "Grant Task Line No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005605; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                //"Manual Requisition No":="Requisition No";
            end;
        }
        field(39005606; "RFQ Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39005607; "Requisition Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(39005608; "Qty Ordered"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39005609; "Qty UnOrdered"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}

