
Table 52188482 "Salary Header"
{

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Salary Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(6; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Entered By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Posting date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer where("Account Type" = const(Employer))
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Savings)) Vendor where("Product Category" = filter("Ordinary Savings" | Business))
            else
            if ("Account Type" = const(Credit)) Customer;

            trigger OnValidate()
            begin

                if "Account Type" = "account type"::Customer then begin
                    cust.Reset;
                    cust.SetRange(cust."No.", "Account No");
                    if cust.Find('-') then begin
                        "Account Name" := cust.Name;
                    end;
                end;

                if "Account Type" = "account type"::Vendor then begin
                    Vend.Reset;
                    Vend.SetRange(Vend."No.", "Account No");
                    if Vend.Find('-') then begin
                        "Account Name" := Vend.Name;
                    end;
                end;

                if "Account Type" = "account type"::Savings then begin
                    Savings.Reset;
                    Savings.SetRange(Savings."No.", "Account No");
                    if Savings.Find('-') then begin
                        "Account Name" := Savings.Name;
                    end;
                end;


                if "Account Type" = "account type"::"G/L Account" then begin
                    "GL Account".Reset;
                    "GL Account".SetRange("GL Account"."No.", "Account No");
                    if "GL Account".Find('-') then begin
                        "Account Name" := "GL Account".Name;
                    end;
                end;

                if "Account Type" = "account type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "Account No");
                    if BANKACC.Find('-') then begin
                        "Account Name" := BANKACC.Name;

                    end;
                end;
            end;
        }
        field(24; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Scheduled Amount"; Decimal)
        {
            CalcFormula = sum("Salary Lines".Amount where("Salary Header No." = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = count("Salary Lines" where("Salary Header No." = field(No)));
            FieldClass = FlowField;
        }
        field(28; "Account Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Employer Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(30; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(31; "Income Type"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Recovery Type" := "recovery type"::" ";


                "Recovery Type" := "recovery type"::"Full Amount";
            end;
        }
        field(32; "Destination Transaction Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges".Code where(Type = const("Salary Processing"));

            trigger OnValidate()
            begin
                "Document No" := No;
            end;
        }
        field(33; Validated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Mutiple Salaries Checked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Last Loan Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Source Transaction Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges".Code where(Type = const("Salary Processing"));

            trigger OnValidate()
            begin
                "Document No" := No;
            end;
        }
        field(37; "Unidentified Amount"; Decimal)
        {
            CalcFormula = sum("Salary Lines".Amount where("Salary Header No." = field(No),
                                                           "Account Not Found" = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Unidentified Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin

                if "Account Type" = "account type"::Customer then begin
                    cust.Reset;
                    cust.SetRange(cust."No.", "Account No");
                    if cust.Find('-') then begin
                        "Account Name" := cust.Name;
                    end;
                end;

                if "Account Type" = "account type"::"G/L Account" then begin
                    "GL Account".Reset;
                    "GL Account".SetRange("GL Account"."No.", "Account No");
                    if "GL Account".Find('-') then begin
                        "Account Name" := "GL Account".Name;
                    end;
                end;

                if "Account Type" = "account type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "Account No");
                    if BANKACC.Find('-') then begin
                        "Account Name" := BANKACC.Name;

                    end;
                end;
            end;
        }
        field(39; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Salaries,Annual Payout,Semi-Annual,Quarterly';
            OptionMembers = " ",Salaries,"Annual Payout","Semi-Annual",Quarterly;
        }
        field(40; "Recovery Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Full Amount,Half Amount,Skip Loans';
            OptionMembers = " ","Full Amount","Half Amount","Skip Loans";

            trigger OnValidate()
            begin

                if "Recovery Type" = "recovery type"::"Half Amount" then
                    Error('Invalid Option');
            end;
        }
        field(41; "Cheque No."; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Additional SMS"; Text[80])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                IF "Additional SMS"<>'' THEN
                    IF "Income Type"<>"Income Type"::Tea THEN
                        ERROR('This option is for Tea only');
                
                */

            end;
        }
        field(43; "Process Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,General Process,Branch Process';
            OptionMembers = " ","General Process","Branch Process";
        }
        field(44; "Posted Entries"; Integer)
        {
            CalcFormula = count("Salary Lines" where("Salary Header No." = field(No),
                                                      Posted = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "UnPosted Entries"; Integer)
        {
            CalcFormula = count("Salary Lines" where("Salary Header No." = field(No),
                                                      Posted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(47; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Dont Send SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(49; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Add. Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Add. Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Add. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Add. Account Type" = const(Customer)) Customer where("Account Type" = const(Employer))
            else
            if ("Add. Account Type" = const(Vendor)) Vendor
            else
            if ("Add. Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Add. Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Add. Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Add. Account Type" = const(Savings)) Vendor
            else
            if ("Add. Account Type" = const(Credit)) Customer;

            trigger OnValidate()
            begin

                if "Account Type" = "account type"::Customer then begin
                    cust.Reset;
                    cust.SetRange(cust."No.", "Account No");
                    if cust.Find('-') then begin
                        "Account Name" := cust.Name;
                    end;
                end;

                if "Account Type" = "account type"::Vendor then begin
                    Vend.Reset;
                    Vend.SetRange(Vend."No.", "Account No");
                    if Vend.Find('-') then begin
                        "Account Name" := Vend.Name;
                    end;
                end;

                if "Account Type" = "account type"::Savings then begin
                    Savings.Reset;
                    Savings.SetRange(Savings."No.", "Account No");
                    if Savings.Find('-') then begin
                        "Account Name" := Savings.Name;
                    end;
                end;


                if "Account Type" = "account type"::"G/L Account" then begin
                    "GL Account".Reset;
                    "GL Account".SetRange("GL Account"."No.", "Account No");
                    if "GL Account".Find('-') then begin
                        "Account Name" := "GL Account".Name;
                    end;
                end;

                if "Account Type" = "account type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "Account No");
                    if BANKACC.Find('-') then begin
                        "Account Name" := BANKACC.Name;

                    end;
                end;
            end;
        }
        field(52; "Additional Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Additional Ded. Details"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(55; "Batch Entries"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "No. of Batches"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Salary Nos.");
            NoSeriesMgt.InitSeries(NoSetup."Salary Nos.", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Entered By" := UpperCase(UserId);
        "Date Entered" := Today;
        "Time Entered" := Time;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
        cust: Record Customer;
        Vend: Record Vendor;
        Savings: Record Vendor;



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
        Buffer: Record "Salary Lines";
    begin
        //FileName := FileMgt.OpenFileDialog(OpenExcelFile,FileName,ExcelFileFilter);

        File.Upload(OpenExcelFile, FromFolder, ExcelFileFilter, FileName, ServerFileName);

        if not File.Exists(ServerFileName) then exit;

        //ServerFileName := FileMgt.UploadFileSilent(FileName);

        Buffer.Reset();
        Buffer.SetRange("Salary Header No.", "No");
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
                            Buffer."No." := Counter;
                            Buffer."Salary Header No." := "No";
                            Evaluate(Buffer."Staff No.", TempExcelBuffer."Cell Value as Text");
                        end;

                    2:
                        Begin

                            Evaluate(Buffer.Amount, TempExcelBuffer."Cell Value as Text");
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

