
TableExtension 52188507 tableextension52188407 extends "Purchase Header"
{



    fields
    {
        field(50000; Copied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Debit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39005531; "Order Posting Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ",Frozen,UnFrozen;
        }
        field(39005532; "Frozen By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39005533; "UnFrozen By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39005536; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39005537; "Cancelled By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005538; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39005539; DocApprovalType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Purchase,Requisition,Quote;
        }
        field(39005540; "Procurement Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005541; "Invoice Basis"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = "PO Based","Direct Invoice";
        }
    }


    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    end;


    trigger OnAfterInsert()
    var
        UserSetup: Record "User Setup";
    begin
        "Posting Description" := '';


    end;



    //    OnAfterInitPostingNoSeries(Rec, xRec);



}

