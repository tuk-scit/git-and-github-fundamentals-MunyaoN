
Table 52188452 "Monthly Checkoff Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Checkoff No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = Customer, "G/L Account";
        }
        field(8; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = filter(Customer)) Customer."No." where("Account Type" = const("Employer"))
            else
            if ("Account Type" = filter("Bank Account")) "Bank Account"."No."
            else
            if ("Account Type" = filter("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
                BankAcc: Record "Bank Account";
            begin
                "Employer Code" := '';
                "Employer Name" := '';

                if Customer.Get("Account No.") then begin
                    "Account Name" := Customer.Name;
                    validate("Employer Code", "Account No.");
                end else
                    if GLAcc.Get("Account No.") then begin
                        "Account Name" := GLAcc.Name;
                    end else
                        if BankAcc.Get("Account No.") then begin
                            "Account Name" := BankAcc.Name;
                        end else
                            "Account Name" := '';
            end;
        }
        field(9; "Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "CHK Line Amount"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Monthly Checkoff Lines".Amount where("Checkoff Header" = field("No.")));
            FieldClass = FlowField;
        }
        field(13; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));

            trigger OnValidate()
            begin
                if Customer.Get("Employer Code") then begin
                    "Employer Name" := Customer.Name;
                end else
                    "Employer Name" := '';
            end;
        }
        field(14; "Employer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Total Count"; Integer)
        {
            Editable = false;
            CalcFormula = count("Monthly Checkoff Lines" where("Checkoff Header" = field("No.")));
            FieldClass = FlowField;
        }
        field(16; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(19; "Posted Records"; Integer)
        {
            Editable = false;
            CalcFormula = count("Monthly Checkoff Lines" where("Checkoff Header" = field("No."),
                                                                Posted = filter(true)));
            FieldClass = FlowField;
        }
        field(20; "Vendor No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." where("Creditor Type" = filter(<> Fosa));
        }
        field(21; "CHK Buffer Amount"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Monthly Checkoff Buffer".Amount where("Checkoff No" = field("No.")));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(34; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(35; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(36; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Receipt Header"."No." where(Posted = const(true), "Account No." = field("Account No."));
            trigger OnValidate()
            var
                CLedger: Record "Cust. Ledger Entry";
                RecAmt: Decimal;
                RecHeader: Record "Receipt Header";
            begin
                "Amount Already Posted" := 0;
                "Amount Pending" := 0;

                if "Receipt No." <> '' then begin

                    CLedger.Reset();
                    CLedger.SetRange("Customer No.", "Account No.");
                    CLedger.SetRange("External Document No.", "Receipt No.");
                    CLedger.SetRange(Reversed, false);
                    if CLedger.FindFirst() then begin
                        repeat
                            CLedger.CalcFields("Amount (LCY)");
                            "Amount Already Posted" += CLedger."Amount (LCY)";
                        until CLedger.Next() = 0;
                    end;
                    RecHeader.Get("Receipt No.");
                    "Amount Pending" := RecHeader."Amount Recieved" - "Amount Already Posted";
                    if "Amount Pending" = 0 then
                        Error('CheckOff has got zero balance pending');
                end;

            end;
        }

        field(37; "Receipt Amount"; Decimal)
        {
            Editable = false;
            CalcFormula = sum("Receipt Header"."Amount Recieved" where(Posted = const(true), "No." = field("Receipt No.")));
            FieldClass = FlowField;
        }

        field(38; "Amount Already Posted"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; "Amount Pending"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(40; "Batch Entries"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(41; "No. Of Batches"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Checkoff No.");
            NoSeriesMgt.InitSeries(NoSetup."Checkoff No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
        UserSetup.Get(UserId);
        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Customer: Record Customer;
        UserSetup: Record "User Setup";



    procedure ImportCheckOffLinesFromExcel()

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        FileName: Text;
        ServerFileName: Text;
        SheetName: Text;
        FileMgt: Codeunit "File Management";
        OpenObjectFile: label 'Open Object Text File';
        SaveObjectFile: label 'Save Object Text File';
        OpenExcelFile: label 'Open Excel File';
        TextFileFilter: label 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*';
        ExcelFileFilter: label 'Excel Files (*.xls*)|*.xls*|All Files (*.*)|*.*';
        MenuSuiteProcess: label 'Updating MenuSuite';
        ReplacingProcess: label 'Replacing';
        ReadingFile: label 'Reading File';
        WritingFile: label 'Writing File';
        ReadingLines: label 'Reading Lines';
        TypeNotFoundError: label 'Type %1 not found';
        RenumberLines: label 'Renumbering Lines';
        NoOfLines: label 'No. of Lines';
        CurrentLine: label 'Current Line No.';
        OpeningExcel: label 'Opening Excel';
        AvailableObject: label 'Available Object';
        FindAvailableObjects: label 'Finding Available Objects';
        CreatingSuggestion: label 'Creating Suggestion';
        UploadingFile: label 'Uploading File to the Server temporary storage';
        UseInMemoryObjects: label 'Object are in memory, use them ?';
        Window: Dialog;
        WindowLastUpdated: DateTime;
        Counter: Integer;
        Total: Integer;
        FromFolder: Text;
        Buffer: Record "Monthly Checkoff Buffer";
    begin
        //FileName := FileMgt.OpenFileDialog(OpenExcelFile,FileName,ExcelFileFilter);

        File.Upload(OpenExcelFile, FromFolder, ExcelFileFilter, FileName, ServerFileName);

        if not File.Exists(ServerFileName) then exit;

        //ServerFileName := FileMgt.UploadFileSilent(FileName);

        Buffer.Init();
        Buffer.SetRange("Checkoff No", "No.");
        if Buffer.FindFirst() then
            Buffer.DeleteAll();

        SheetName := TempExcelBuffer.SelectSheetsName(ServerFileName);
        TempExcelBuffer.OpenBook(ServerFileName, SheetName);
        TempExcelBuffer.ReadSheet;
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        Total := TempExcelBuffer.Count;
        Counter := 0;
        Window.Open(
          ReadingFile + ' @1@@@@@@@@@@@@@@@@@@@@@@@@\' +
          CurrentLine + ' #2#######\' +
          NoOfLines + '#3#######');
        Window.Update(3, Total);
        WindowLastUpdated := CurrentDatetime;

        if TempExcelBuffer.Find('-') then
            repeat
                Counter += 1;

                case TempExcelBuffer."Column No." of
                    1:
                        begin

                            Buffer.Init;
                            Buffer."Checkoff No" := "No.";
                            Evaluate(Buffer.Payroll, TempExcelBuffer."Cell Value as Text");
                        end;
                    2:
                        begin
                            Evaluate(Buffer."Savings Amount", TempExcelBuffer."Cell Value as Text");
                        end;
                    3:
                        begin
                            Evaluate(Buffer."Loan Amount", TempExcelBuffer."Cell Value as Text");
                        end;
                    4:
                        Begin

                            Evaluate(Buffer."Search Code", TempExcelBuffer."Cell Value as Text");

                        end;
                    5:
                        Begin

                            Evaluate(Buffer.No, TempExcelBuffer."Cell Value as Text");
                            Buffer.Insert;
                        end;
                end;

                if CurrentDatetime - WindowLastUpdated > 100 then begin
                    Window.Update(1, ROUND(Counter / Total * 10000, 1));
                    Window.Update(2, Counter);
                    WindowLastUpdated := CurrentDatetime;
                end;
            until TempExcelBuffer.Next = 0;
        Window.Close;
    end;
}

