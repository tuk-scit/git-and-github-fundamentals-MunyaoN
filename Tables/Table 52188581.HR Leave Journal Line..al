
Table 52188581 "HR Leave Journal Line."
{

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            TableRelation = "HR Leave Journal Template.".Name;
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "HR Leave Journal Batch.".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4; "Leave Calendar Code"; Code[20])
        {
            Editable = true;
            TableRelation = "HR Leave Calendar."."Calendar Code" where("Current Leave Calendar" = const(true));

            trigger OnValidate()
            begin
                /*IF "Leave Application No." = '' THEN BEGIN
                  CreateDim(DATABASE::Table5628,"Leave Application No.");
                  EXIT;
                END;
                
                Insurance.GET("Leave Application No.");
                //Insurance.TESTFIELD(Blocked,FALSE);
                Description := Insurance.Description;
                "Leave Approval Date":=Insurance."HOD Start Date";
                "No. of Days":=Insurance."HOD Approved Days";
                "Leave Type Code":=Insurance."Leave Code";
                CreateDim(DATABASE::Table5628,"Leave Application No.");
                  */

            end;
        }
        field(6; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if "Staff No." = '' then begin
                    "Staff Name" := '';
                    exit;
                end;
                FA.Get("Staff No.");
                "Staff Name" := FA."First Name" + ' ' + FA."Middle Name" + ' ' + FA."Last Name";
                //"Global Dimension 1 Code":=FA."Department Code";
                //"Global Dimension 2 Code":=FA.Office;
            end;
        }
        field(7; "Staff Name"; Text[120])
        {
            Caption = 'Staff Name';
            Editable = false;
        }
        field(8; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(9; "Leave Entry Type"; Option)
        {
            Caption = 'Leave Entry Type';
            Editable = true;
            OptionCaption = 'Positive,Negative,Reimbursement';
            OptionMembers = Positive,Negative,Reimbursement;
        }
        field(10; "Leave Approval Date"; Date)
        {
            Caption = 'Leave Approval Date';
            Editable = false;
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(12; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(13; "No. of Days"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'No. of Days';
            Editable = true;

            trigger OnValidate()
            begin
                if LeaveType.Get("Leave Type") then begin
                    if (LeaveType."Fixed Days" = true) then begin
                        if "No. of Days" > LeaveType.Days then
                            Error(Text001, "Leave Type");

                    end;
                end;
            end;
        }
        field(14; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                /*ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
                MODIFY;
                */

            end;
        }
        field(16; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                /*ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
                MODIFY;*/

            end;
        }
        field(17; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(18; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(20; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
        }
        field(21; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(22; "Leave Type"; Code[20])
        {
            Editable = true;
            TableRelation = "HR Leave Types.".Code;

            trigger OnValidate()
            begin
                //   IF HRLeaveTypes.GET("Leave Type") THEN
                //  "No. of Days":=HRLeaveTypes.Days;
            end;
        }
        field(23; "Leave Recalled No."; Code[20])
        {
            Caption = 'Leave Application No.';

            trigger OnValidate()
            begin
                /*IF "Document No." = '' THEN BEGIN
                  CreateDim(DATABASE::Table5628,"Leave Application No.");
                  EXIT;
                END;
                
                Insurance.GET("Leave Application No.");
                //Insurance.TESTFIELD(Blocked,FALSE);
                Description := Insurance.Description;
                "Leave Approval Date":=Insurance."HOD Start Date";
                "No. of Days":=Insurance."HOD Approved Days";
                "Leave Type Code":=Insurance."Leave Code";
                CreateDim(DATABASE::Table5628,"Leave Application No.");
                */

            end;
        }
        field(26; "Leave Period Start Date"; Date)
        {
        }
        field(27; "Leave Period End Date"; Date)
        {
        }
        field(28; "Positive Transaction Type"; Option)
        {
            OptionCaption = ' ,Leave Allocation,Leave Recall,OverTime';
            OptionMembers = " ","Leave Allocation","Leave Recall",OverTime;
        }
        field(29; "Negative Transaction Type"; Option)
        {
            OptionCaption = ' ,Leave Taken,Leave Forfeited ';
            OptionMembers = " ","Leave Taken","Leave Forfeited ";
        }
        field(30; "Leave Application No."; Code[20])
        {
            Caption = 'Leave Application No.';
            //TableRelation = Table39003925.Field1;

            trigger OnValidate()
            begin
                /*
                IF "Leave Application No." = '' THEN BEGIN
                  CreateDim(DATABASE::Insurance,"Leave Application No.");
                  EXIT;
                END;
                Insurance.RESET;
                Insurance.SETRANGE(Insurance."Application Code","Leave Application No.");
                IF Insurance.FIND('-')THEN BEGIN
                //Insurance.GET("Leave Application No.");
                //Insurance.TESTFIELD(Blocked,FALSE);
                Description := Insurance."Applicant Comments";
                "Leave Approval Date":=Insurance."Start Date";
                "No. of Days":=Insurance."Approved days";
                "Leave Type":=Insurance."Leave Type";
                END;
                CreateDim(DATABASE::Insurance,"Leave Application No.");
                */

            end;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "Posting Date")
        {
            MaintainSQLIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        HRLeaveCal.Reset;
        HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
        if HRLeaveCal.Find('-') then begin
            "Leave Period Start Date" := HRLeaveCal."Start Date";
            "Leave Period End Date" := HRLeaveCal."End Date";
        end else begin
            Error('No Leave Calendar has been created under HR Setup');
        end;
    end;

    var
        Insurance: Record "HR Leave Application.";
        FA: Record Employee;
        InsuranceJnlTempl: Record "HR Leave Journal Template.";
        InsuranceJnlBatch: Record "HR Leave Journal Batch.";
        InsuranceJnlLine: Record "HR Leave Journal Line.";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        LeaveType: Record "HR Leave Types.";
        Text001: label 'You can not post more than maximum days allowed for this leave type %1';
        HRSetup: Record "HR Setup.";
        HRLeaveCal: Record "HR Leave Calendar.";


    procedure SetUpNewLine()
    begin
        /*InsuranceJnlTempl.GET("Journal Template Name");
        InsuranceJnlBatch.GET("Journal Template Name","Journal Batch Name");
        InsuranceJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
        InsuranceJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");
        IF InsuranceJnlLine.FIND('-') THEN BEGIN
          "Posting Date" := LastInsuranceJnlLine."Posting Date";
          "Document No." := LastInsuranceJnlLine."Document No.";
        END ELSE BEGIN
          "Posting Date" := WORKDATE;
          IF InsuranceJnlBatch."No. Series" <> '' THEN BEGIN
            CLEAR(NoSeriesMgt);
            "Document No." := NoSeriesMgt.TryGetNextNo(InsuranceJnlBatch."No. Series","Posting Date");
          END;
        END;
        "Source Code" := InsuranceJnlTempl."Source Code";
        "Reason Code" := InsuranceJnlBatch."Reason Code";
        "Posting No. Series" := InsuranceJnlBatch."Posting No. Series";
        */

    end;


    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        /*TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        DimMgt.GetDefaultDim(
          TableID,No,"Source Code",
          "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        IF "Line No." <> 0 THEN
          DimMgt.UpdateJnlLineDefaultDim(
            DATABASE::Table5635,
            "Journal Template Name","Journal Batch Name","Line No.",0,
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
          */

    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /*DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        IF "Line No." <> 0 THEN BEGIN
          DimMgt.SaveJnlLineDim(
            DATABASE::Table5635,"Journal Template Name",
            "Journal Batch Name","Line No.",0,FieldNumber,ShortcutDimCode);
          IF MODIFY THEN;
        END ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
         */

    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /*DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
        IF "Line No." <> 0 THEN BEGIN
          DimMgt.SaveJnlLineDim(
            DATABASE::Table5635,"Journal Template Name",
            "Journal Batch Name","Line No.",0,FieldNumber,ShortcutDimCode);
          MODIFY;
        END ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
        */

    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        /*IF "Line No." <> 0 THEN
          DimMgt.ShowJnlLineDim(
            DATABASE::Table5635,"Journal Template Name",
            "Journal Batch Name","Line No.",0,ShortcutDimCode)
        ELSE
          DimMgt.ShowTempDim(ShortcutDimCode);
        */

    end;
}

