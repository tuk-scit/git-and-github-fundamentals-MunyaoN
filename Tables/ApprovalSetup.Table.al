Table 52188705 "Approval Setup"
{
    Caption = 'Approval Setup';

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "Due Date Formula"; DateFormula)
        {
            Caption = 'Due Date Formula';

            trigger OnValidate()
            begin
                if CopyStr(Format("Due Date Formula"), 1, 1) = '-' then
                    Error(StrSubstNo(Text001, FieldCaption("Due Date Formula")));
            end;
        }
        field(3; "Approval Administrator"; Code[50])
        {
            Caption = 'Approval Administrator';
            TableRelation = "User Setup";
        }
        field(5; "Request Rejection Comment"; Boolean)
        {
            Caption = 'Request Rejection Comment';
        }
        field(6; Approvals; Boolean)
        {
            Caption = 'Approvals';
        }
        field(7; Cancellations; Boolean)
        {
            Caption = 'Cancellations';
        }
        field(8; Rejections; Boolean)
        {
            Caption = 'Rejections';
        }
        field(9; Delegations; Boolean)
        {
            Caption = 'Delegations';
        }
        field(10; "Last Run Time"; Time)
        {
            Caption = 'Last Run Time';
        }
        field(11; "Last Run Date"; Date)
        {
            Caption = 'Last Run Date';
        }
        field(12; "Overdue Template"; Blob)
        {
            Caption = 'Overdue Template';
            SubType = UserDefined;
        }
        field(13; "Approval Template"; Blob)
        {
            Caption = 'Approval Template';
            SubType = UserDefined;
        }
        field(50000; "Responsibility Center Required"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label 'You cannot have negative values in %1.';
}

