table 52188687 "Sacco Journal Header"
{
    Caption = 'Sacco Journal Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Captured By"; Code[50])
        {
            Caption = 'Captured By';
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Type"; Option)
        {
            Caption = 'Posting Type';
            OptionMembers = "Use Line Document No","User Header Document No.";
        }
        field(4; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(5; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            DataClassification = ToBeClassified;
        }
        field(6; "No. Series"; Code[20])
        {
        }
        field(7; "Date"; Date)
        {
        }
        field(8; "Time"; Time)
        {
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()

    begin
        if "Document No." = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."Sacco Journal Nos");
            NoSeriesMgt.InitSeries(NoSetup."Sacco Journal Nos", xRec."No. Series", 0D, "Document NO.", "No. Series");
        end;

        "Date" := Today;
        "Time" := Time;
        "Captured By" := UserId;

    end;


    procedure ImportJournalLinesFromExcel()

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
        //Buffer: Record "Sacco Journal Line";
    begin
        /*FileName := FileMgt.OpenFileDialog(OpenExcelFile,FileName,ExcelFileFilter);

        File.Upload(OpenExcelFile, FromFolder, ExcelFileFilter, FileName, ServerFileName);

        if not File.Exists(ServerFileName) then exit;

        ServerFileName := FileMgt.UploadFileSilent(FileName);

        Buffer.Reset();
        Buffer.SetRange("Batch No.", "Document No.");
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
                    2:
                        begin
                            Buffer.Init;
                            Buffer."Batch No." := "Document No.";
                            Evaluate(Buffer."Posting Date", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Posting Date");
                        end;
                    3:
                        begin
                            Evaluate(Buffer."Document No.", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Document No.");
                        end;
                    4:
                        Begin

                            Evaluate(Buffer."Account Type", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Account Type");

                        end;
                    5:
                        Begin

                            Evaluate(Buffer."Account No.", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Account No.");

                        end;
                    6:
                        Begin

                            Evaluate(Buffer.Description, TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate(Description);

                        end;
                    7:
                        Begin

                            Evaluate(Buffer."Debit Amount", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Debit Amount");

                        end;
                    8:
                        Begin

                            Evaluate(Buffer."Credit Amount", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Credit Amount");

                        end;
                    9:
                        Begin

                            Evaluate(Buffer."Transaction Type", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Transaction Type");

                        end;
                    10:
                        Begin

                            Evaluate(Buffer."Loan No", TempExcelBuffer."Cell Value as Text");
                            Buffer.Validate("Loan No");

                        end;
                    11:
                        Begin

                            Evaluate(Buffer."External Document No.", TempExcelBuffer."Cell Value as Text");

                        end;
                    12:
                        Begin

                            Evaluate(Buffer."Shortcut Dimension 1 Code", TempExcelBuffer."Cell Value as Text");

                            Buffer.Validate("Shortcut Dimension 1 Code");

                        end;
                    13:
                        Begin

                            Evaluate(Buffer."Shortcut Dimension 2 Code", TempExcelBuffer."Cell Value as Text");

                            Buffer.Validate("Shortcut Dimension 2 Code");
                        end;

                    1:
                        begin

                            Evaluate(Buffer."Line No.", TempExcelBuffer."Cell Value as Text");

                            Buffer.Insert();
                            //
                        end;
                end;

                if CurrentDatetime - WindowLastUpdated > 100 then begin
                    Window.Update(1, ROUND(Counter / Total * 10000, 1));
                    Window.Update(2, Counter);
                    WindowLastUpdated := CurrentDatetime;
                end;
            until TempExcelBuffer.Next = 0;
        Window.Close;*/
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
}
