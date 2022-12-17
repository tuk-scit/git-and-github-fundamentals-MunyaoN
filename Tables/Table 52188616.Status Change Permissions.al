
Table 52188616 "Status Change Permissions"
{

    fields
    {
        field(1; "User ID"; Code[80])
        {
            Caption = 'User ID.';
            TableRelation = "User Setup"."User ID";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(48; "Reset Mpesa Pin"; Boolean)
        {
        }
        field(49; "Update Paybill Transaction"; Boolean)
        {
        }
        field(50000; "Update Transactional Mobile No"; Boolean)
        {
        }
        field(50050; "Sky Mobile Setups"; Boolean)
        {
        }
        field(50051; "Reverse Sky Transactions"; Boolean)
        {
        }
        field(50052; "Black-List Accounts"; Boolean)
        {
        }
        field(50056; "Update MPESA Withdrawal"; Boolean)
        {
        }
        field(50060; "View BlackListed Accounts"; Boolean)
        {
        }
        field(50062; "Clear Transactional Mobile"; Boolean)
        {
        }
        field(50063; "Update Partial Disbursement"; Boolean)
        {
        }

    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RestrictAccess(UserId);
    end;

    trigger OnInsert()
    begin
        //RestrictAccess(USERID);
    end;

    trigger OnModify()
    begin
        //RestrictAccess(USERID);
    end;

    var
        UserMgt: Codeunit "User Setup Management";
        Temp: Record "User Setup";


    procedure RestrictAccess(UserNo: Code[100])
    var
        StatusPermission: Record "Status Change Permissions";
        ErrorOnRestrictViewTxt: label 'You do not have permissions to MODIFY or DELETE on this Page. Contact your system administrator for further details';
    begin
        //StatusPermission.RESET;
        //StatusPermission.SETRANGE("User ID",UserNo);
        //StatusPermission.SETRANGE("Edit Setup",TRUE);
        //IF NOT StatusPermission.FIND('-') THEN BEGIN
        // ERROR(ErrorOnRestrictViewTxt);
        //  END;
    end;
}

