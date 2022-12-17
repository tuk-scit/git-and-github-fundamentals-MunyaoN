
Codeunit 52188427 "Sacco Activities"
{

    trigger OnRun()
    var
        Path: Text;
        Loans: Record Loans;
    begin

        //Loans.GET('SL0000001');
        //SendLoanDisbursementNotifications(Loans);
    end;

    var
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        LoanNo: Code[20];
        DocType: Enum "Gen. Journal Document Type";
        AppliesToDocType: Enum "Gen. Journal Document Type";
        AppliesToDocNo: Code[20];
        AppliesToID: Code[20];
        DimensionSetID: Integer;
        SaccoSetup: Record "Sacco Setup";
        SMSSource: Enum "SMS Source Enum";
        FileManagement: Codeunit "File Management";
        Path: Text;
        dWindow: Dialog;
        UserSetup: Record "User Setup";
        MemberActivities: Codeunit "Member Activities";
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        SharingAmt: Decimal;
        SharingDuty: Decimal;
        SharingChargeAcctType: Enum "Gen. Journal Account Type";
        SharingChargeAcct: Code[20];
        Value: Decimal;
        TotalCharge: Decimal;
        TotalDuty: Decimal;
        ExtDocNo: Code[20];
        Source: Enum "SMS Source Enum";
        BalAcctNo: Code[20];
        Loans: Record Loans;
        SaccoActivities: Codeunit "Sacco Activities";
        //PaymentHeader: Record "Payment Header";


    procedure JournalInit(JTemplate: Code[10]; JBatch: Code[10])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then begin
            GenJournalLine.DeleteAll;
        end;
    end;


    procedure JournalInsert(Jtemplate: Code[20]; JBatch: Code[20]; DocNo: Code[20]; PDate: Date; AcctType: Enum "Gen. Journal Account Type"; AcctNo: Code[20]; Desc: Text[150]; BalAcctType: Enum "Gen. Journal Account Type"; BalAcctNo: Code[20]; Amt: Decimal; ExtDocNo: Code[20]; Loan: Code[20]; TransType: Enum "Transaction Type Enum"; Dim1: Code[20]; Dim2: Code[20]; SystemCreated: Boolean)
    var
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
    begin

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        LineNo := GenJournalLine.Count;

        LineNo += 1;


        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := Jtemplate;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Posting Date" := PDate;
        GenJournalLine."Account Type" := AcctType;
        GenJournalLine."Account No." := AcctNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description := CopyStr(Desc, 1, 50);
        GenJournalLine."Bal. Account Type" := BalAcctType;
        GenJournalLine."Bal. Account No." := BalAcctNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine.Amount := Amt;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."External Document No." := ExtDocNo;
        GenJournalLine."Loan No." := Loan;
        GenJournalLine."Transaction Type" := TransType;
        GenJournalLine."Shortcut Dimension 1 Code" := Dim1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dim2;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."System-Created Entry" := SystemCreated;

        //MESSAGE('%1', GenJournalLine);
        //MESSAGE('%1\%2\%3\%4', GenJournalLine."Document No.", GenJournalLine."Account Type", GenJournalLine."Account No.", GenJournalLine.Amount);
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure DetailedJournalInsert(Jtemplate: Code[20]; JBatch: Code[20]; DocNo: Code[20]; PDate: Date; AcctType: Enum "Gen. Journal Account Type"; AcctNo: Code[20]; Desc: Text[150]; BalAcctType: Enum "Gen. Journal Account Type"; BalAcctNo: Code[20]; Amt: Decimal; ExtDocNo: Code[20]; Loan: Code[20]; TransType: Enum "Transaction Type Enum"; Dim1: Code[20]; Dim2: Code[20]; SystemCreated: Boolean; DocType: Enum "Gen. Journal Document Type"; DocDate: Date; Currency: Code[20]; AppliesToDocType: Enum "Gen. Journal Document Type"; AppliesToDocNo: Code[20]; AppliesToID: Code[20]; DimensionSetID: Integer)
    var
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
    begin

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        LineNo := GenJournalLine.Count;

        LineNo += 1;


        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := Jtemplate;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Posting Date" := PDate;
        GenJournalLine."Account Type" := AcctType;
        GenJournalLine."Account No." := AcctNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description := CopyStr(Desc, 1, 50);
        GenJournalLine."Bal. Account Type" := BalAcctType;
        GenJournalLine."Bal. Account No." := BalAcctNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine.Amount := Amt;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."External Document No." := ExtDocNo;
        GenJournalLine."Loan No." := Loan;
        GenJournalLine."Transaction Type" := TransType;
        GenJournalLine."Document Type" := DocType;
        GenJournalLine."Document Date" := DocDate;
        GenJournalLine."Currency Code" := Currency;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine."Applies-to Doc. Type" := AppliesToDocType;
        GenJournalLine."Applies-to Doc. No." := AppliesToDocNo;
        GenJournalLine.Validate("Applies-to Doc. No.");
        GenJournalLine."Applies-to ID" := AppliesToID;
        GenJournalLine.Validate(GenJournalLine."Applies-to ID");
        GenJournalLine."Dimension Set ID" := DimensionSetID;
        GenJournalLine."Shortcut Dimension 1 Code" := Dim1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dim2;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."System-Created Entry" := SystemCreated;

        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        //MESSAGE('%1',GenJournalLine);
    end;


    procedure JournalPost(JTemplate: Code[10]; JBatch: Code[10]) Posted: Boolean;
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        Posted := false;
        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            Posted := true;
        end;
        //Post New
    end;


    procedure GetJournalDebits(Jtemplate: Code[20]; JBatch: Code[20]; AcctType: Enum "Gen. Journal Account Type"; AccNo: Code[20]): Decimal
    var
        GenJournalLine: Record "Gen. Journal Line";
        JDebits: Decimal;
        JCredits: Decimal;
    begin
        JDebits := 0;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.SetRange("Account Type", AcctType);
        GenJournalLine.SetRange("Account No.", AccNo);
        GenJournalLine.SetFilter(Amount, '>0');
        if GenJournalLine.Find('-') then begin
            repeat
                JDebits += GenJournalLine.Amount;
            until GenJournalLine.Next = 0;
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.SetRange("Bal. Account Type", AcctType);
        GenJournalLine.SetRange("Bal. Account No.", AccNo);
        GenJournalLine.SetFilter(Amount, '<0');
        if GenJournalLine.Find('-') then begin
            repeat
                JDebits += GenJournalLine.Amount * -1;
            until GenJournalLine.Next = 0;
        end;

        exit(JDebits);
    end;


    procedure GetJournalCredits(Jtemplate: Code[20]; JBatch: Code[20]; AcctType: Enum "Gen. Journal Account Type"; AccNo: Code[20]): Decimal
    var
        GenJournalLine: Record "Gen. Journal Line";
        JDebits: Decimal;
        JCredits: Decimal;
    begin
        JCredits := 0;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.SetRange("Account Type", AcctType);
        GenJournalLine.SetRange("Account No.", AccNo);
        GenJournalLine.SetFilter(Amount, '<0');
        if GenJournalLine.Find('-') then begin
            repeat
                JCredits += GenJournalLine.Amount * -1;
            until GenJournalLine.Next = 0;
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.SetRange("Bal. Account Type", AcctType);
        GenJournalLine.SetRange("Bal. Account No.", AccNo);
        GenJournalLine.SetFilter(Amount, '>0');
        if GenJournalLine.Find('-') then begin
            repeat
                JCredits += GenJournalLine.Amount;
            until GenJournalLine.Next = 0;
        end;

        exit(JCredits);
    end;


    procedure GetJournalLoanDebits(Jtemplate: Code[20]; JBatch: Code[20]; AcctType: Enum "Gen. Journal Account Type"; AccNo: Code[20]; LoanNo: Code[20]; TransType: Enum "Transaction Type Enum"): Decimal
    var
        GenJournalLine: Record "Gen. Journal Line";
        JDebits: Decimal;
        JCredits: Decimal;
    begin
        JDebits := 0;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.SetRange("Account Type", AcctType);
        GenJournalLine.SetRange("Account No.", AccNo);
        GenJournalLine.SetRange("Transaction Type", TransType);
        GenJournalLine.SetRange("Loan No.", LoanNo);
        GenJournalLine.SetFilter(Amount, '>0');
        if GenJournalLine.Find('-') then begin
            repeat
                JDebits += GenJournalLine.Amount;
            until GenJournalLine.Next = 0;
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.SetRange("Bal. Account Type", AcctType);
        GenJournalLine.SetRange("Bal. Account No.", AccNo);
        GenJournalLine.SetRange("Transaction Type", TransType);
        GenJournalLine.SetRange("Loan No.", LoanNo);
        GenJournalLine.SetFilter(Amount, '<0');
        if GenJournalLine.Find('-') then begin
            repeat
                JDebits += GenJournalLine.Amount * -1;
            until GenJournalLine.Next = 0;
        end;

        exit(JDebits);
    end;


    procedure GetJournalLoanCredits(Jtemplate: Code[20]; JBatch: Code[20]; AcctType: Enum "Gen. Journal Account Type"; AccNo: Code[20]; LoanNo: Code[20]; TransType: Enum "Transaction Type Enum"): Decimal
    var
        GenJournalLine: Record "Gen. Journal Line";
        JDebits: Decimal;
        JCredits: Decimal;
    begin
        JCredits := 0;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.SetRange("Account Type", AcctType);
        GenJournalLine.SetRange("Account No.", AccNo);
        GenJournalLine.SetRange("Transaction Type", TransType);
        GenJournalLine.SetRange("Loan No.", LoanNo);
        GenJournalLine.SetFilter(Amount, '<0');
        if GenJournalLine.Find('-') then begin
            repeat
                JCredits += GenJournalLine.Amount * -1;
            until GenJournalLine.Next = 0;
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.SetRange("Bal. Account Type", AcctType);
        GenJournalLine.SetRange("Bal. Account No.", AccNo);
        GenJournalLine.SetRange("Transaction Type", TransType);
        GenJournalLine.SetRange("Loan No.", LoanNo);
        GenJournalLine.SetFilter(Amount, '>0');
        if GenJournalLine.Find('-') then begin
            repeat
                JCredits += GenJournalLine.Amount;
            until GenJournalLine.Next = 0;
        end;

        exit(JCredits);
    end;


    /*procedure PostReceipt(ReceiptNo: Code[20])
    var
        ReceiptHeader: Record "Receipt Header";
        //DocLine: Record "Document Line";
        RunBal: Decimal;
        PrAmt: Decimal;
        IntAmt: Decimal;
        PenaltyAmt: Decimal;
        AppraisalAmt: Decimal;
    begin

        if ReceiptHeader.Get(ReceiptNo) then begin
            with ReceiptHeader do begin
                TestField(Posted, false);
                TestField("Posting Date");
                //TestField("Document Date");
                TestField(Narration);
                if ("Pay Mode" = "pay mode"::Cheque) or ("Pay Mode" = "pay mode"::"Deposit Slip") then begin
                    TestField("Cheque No.");
                    TestField("Cheque/Deposit Slip Date");
                end;


                CalcFields("Total Amount");
                if "Total Amount" <> "Amount Recieved" then
                    Error('Amount Received MUST be equal to total line amount');

                JTemplate := '';
                JBatch := '';
                GetReceiptJournalTemplate(JTemplate, JBatch);

                LoanNo := '';
                JournalInit(JTemplate, JBatch);
                DetailedJournalInsert(JTemplate,
                                      JBatch,
                                      "No.",
                                      "Posting Date",
                                      Accttype::"Bank Account",
                                      "Bank Code",
                                      Narration,
                                      Balaccttype::"G/L Account",
                                      '',
                                      "Amount Recieved",
                                      "Cheque No.",
                                      LoanNo,
                                      Transtype::" ",
                                      "Global Dimension 1 Code",
                                      "Global Dimension 2 Code",
                                      true,
                                      DocType,
                                      "Document Date",
                                      "Currency Code",
                                      AppliesToDocType,
                                      AppliesToDocNo,
                                      AppliesToID,
                                      DimensionSetID);


                DocLine.Reset;
                DocLine.SetRange("Header No.", "No.");
                if DocLine.FindFirst then begin
                    repeat
                        DocLine.TestField("Account No.");
                        DocLine.TestField(Amount);
                        DocLine.TestField(Description);
                        if DocLine."Account Type" = DocLine."account type"::Credit then begin
                            DocLine.TestField("Loan No.");
                            Loans.Reset;
                            Loans.SetRange("Loan No.", DocLine."Loan No.");
                            if Loans.FindFirst then begin
                                RunBal := DocLine.Amount;
                                Loans.CalcFields("Outstanding Appraisal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Principal");

                                if Loans."Outstanding Penalty" > 0 then begin
                                    PenaltyAmt := Loans."Outstanding Penalty";
                                    if PenaltyAmt > RunBal then
                                        PenaltyAmt := RunBal;

                                    DetailedJournalInsert(JTemplate,
                                                          JBatch,
                                                          "No.",
                                                          "Posting Date",
                                                          DocLine."Account Type",
                                                          DocLine."Account No.",
                                                          DocLine.Description,
                                                          Balaccttype::"G/L Account",
                                                          '',
                                                          PenaltyAmt * -1,
                                                          "Cheque No.",
                                                          DocLine."Loan No.",
                                                          DocLine."transaction type"::"Penalty Paid",
                                                          DocLine."Shortcut Dimension 1 Code",
                                                          DocLine."Shortcut Dimension 2 Code",
                                                          true,
                                                          DocLine."Document Type",
                                                          "Document Date",
                                                          "Currency Code",
                                                          DocLine."Applies-to Doc. Type",
                                                          DocLine."Applies-to Doc. No.",
                                                          DocLine."Applies-to ID",
                                                          DocLine."Dimension Set ID");
                                    RunBal -= PenaltyAmt;
                                end;

                                if Loans."Outstanding Appraisal" > 0 then begin
                                    AppraisalAmt := Loans."Outstanding Appraisal";
                                    if AppraisalAmt > RunBal then
                                        AppraisalAmt := RunBal;

                                    DetailedJournalInsert(JTemplate,
                                                          JBatch,
                                                          "No.",
                                                          "Posting Date",
                                                          DocLine."Account Type",
                                                          DocLine."Account No.",
                                                          DocLine.Description,
                                                          Balaccttype::"G/L Account",
                                                          '',
                                                          AppraisalAmt * -1,
                                                          "Cheque No.",
                                                          DocLine."Loan No.",
                                                          DocLine."transaction type"::"Appraisal Paid",
                                                          DocLine."Shortcut Dimension 1 Code",
                                                          DocLine."Shortcut Dimension 2 Code",
                                                          true,
                                                          DocLine."Document Type",
                                                          "Document Date",
                                                          "Currency Code",
                                                          DocLine."Applies-to Doc. Type",
                                                          DocLine."Applies-to Doc. No.",
                                                          DocLine."Applies-to ID",
                                                          DocLine."Dimension Set ID");
                                    RunBal -= AppraisalAmt;
                                end;

                                if Loans."Outstanding Interest" > 0 then begin
                                    IntAmt := SaccoActivities.GetInterestDue(Loans, Today);

                                    if IntAmt > RunBal then
                                        IntAmt := RunBal;

                                    DetailedJournalInsert(JTemplate,
                                                          JBatch,
                                                          "No.",
                                                          "Posting Date",
                                                          DocLine."Account Type",
                                                          DocLine."Account No.",
                                                          DocLine.Description,
                                                          Balaccttype::"G/L Account",
                                                          '',
                                                          IntAmt * -1,
                                                          "Cheque No.",
                                                          DocLine."Loan No.",
                                                          DocLine."transaction type"::"Interest Paid",
                                                          DocLine."Shortcut Dimension 1 Code",
                                                          DocLine."Shortcut Dimension 2 Code",
                                                          true,
                                                          DocLine."Document Type",
                                                          "Document Date",
                                                          "Currency Code",
                                                          DocLine."Applies-to Doc. Type",
                                                          DocLine."Applies-to Doc. No.",
                                                          DocLine."Applies-to ID",
                                                          DocLine."Dimension Set ID");
                                    RunBal -= IntAmt;
                                end;

                                if RunBal > 0 then begin
                                    PrAmt := RunBal;

                                    DetailedJournalInsert(JTemplate,
                                                          JBatch,
                                                          "No.",
                                                          "Posting Date",
                                                          DocLine."Account Type",
                                                          DocLine."Account No.",
                                                          DocLine.Description,
                                                          Balaccttype::"G/L Account",
                                                          '',
                                                          PrAmt * -1,
                                                          "Cheque No.",
                                                          DocLine."Loan No.",
                                                          DocLine."transaction type"::"Principal Repayment",
                                                          DocLine."Shortcut Dimension 1 Code",
                                                          DocLine."Shortcut Dimension 2 Code",
                                                          true,
                                                          DocLine."Document Type",
                                                          "Document Date",
                                                          "Currency Code",
                                                          DocLine."Applies-to Doc. Type",
                                                          DocLine."Applies-to Doc. No.",
                                                          DocLine."Applies-to ID",
                                                          DocLine."Dimension Set ID");
                                    RunBal -= PrAmt;
                                end;
                            end;
                        end
                        else begin

                            DetailedJournalInsert(JTemplate,
                                                  JBatch,
                                                  "No.",
                                                  "Posting Date",
                                                  DocLine."Account Type",
                                                  DocLine."Account No.",
                                                  DocLine.Description,
                                                  Balaccttype::"G/L Account",
                                                  '',
                                                  DocLine.Amount * -1,
                                                  "Cheque No.",
                                                  DocLine."Loan No.",
                                                  DocLine."Transaction Type",
                                                  DocLine."Shortcut Dimension 1 Code",
                                                  DocLine."Shortcut Dimension 2 Code",
                                                  true,
                                                  DocLine."Document Type",
                                                  "Document Date",
                                                  "Currency Code",
                                                  DocLine."Applies-to Doc. Type",
                                                  DocLine."Applies-to Doc. No.",
                                                  DocLine."Applies-to ID",
                                                  DocLine."Dimension Set ID");
                        end;

                    until DocLine.Next = 0;


                    Posted := true;
                    "Date Posted" := Today;
                    "Time Posted" := Time;
                    "Posted By" := UserId;
                    Modify;

                    JournalPost(JTemplate, JBatch);





                    dWindow.Open('#1#################');
                    dWindow.Update(1, 'Sending Email/SMS Notification');
                    SendReceiptNotifications(ReceiptHeader."No.");
                    dWindow.Close;
                    Message('Receipt Posted Successfully');

                end;

            end;
        end;
    end;


    procedure PostPV(PVNo: Code[20])
    var
        PaymentHeader: Record "Payment Header";
        DocLine: Record "Document Line";
        BankAcc: Record "Bank Account";
        LnAmt: Decimal;
        PvaAmt: Decimal;
        OrdinaryChequeRegister: Record "Ordinary Cheque Register";
    begin

        if PaymentHeader.Get(PVNo) then begin
            with PaymentHeader do begin
                TestField(Posted, false);

                TESTFIELD(Status, Status::Approved);
                TestField("Paying Bank Account");
                TestField("Pay Mode");
                TestField("Payment Release Date");
                TestField(Date);

                if Date <> Today then
                    Error('Date is reading %1 kindly reset it to Today to proceed', Date);

                TestField("Payment Narration");
                if ("Pay Mode" = "pay mode"::Cheque) or ("Pay Mode" = "pay mode"::EFT) then begin
                    TestField("Cheque No.");
                end;

                if "Pay Mode" = "pay mode"::Cash then begin
                    BankAcc.Reset;
                    BankAcc.SetRange(BankAcc."No.", "Paying Bank Account");
                    BankAcc.SetRange(BankAcc."Bank Type", BankAcc."bank type"::Cash);
                    if BankAcc.FindFirst then begin
                        BankAcc.CalcFields(BankAcc.Balance);
                        "Current Source A/C Bal." := BankAcc.Balance;
                        if ("Current Source A/C Bal." - "Total Net Amount") < 0 then begin
                            Error('The transaction will result in a negative balance in the BANK ACCOUNT. %1:%2', BankAcc."No.", BankAcc.Name);
                        end;
                    end;
                end;

                CalcFields("Total Net Amount", "Total VAT Amount", "Total VAT Withholding Amount", "Total Witholding Tax Amount", "Total Payment Amount");
                PvaAmt := "Total Net Amount" * -1;

                if "Payment Type" = "payment type"::Staff then
                    PvaAmt := "Total Payment Amount";

                if "Payment Type" = "payment type"::Board then
                    PvaAmt := "Total Payment Amount";


                OrdinaryChequeRegister.Reset;
                OrdinaryChequeRegister.SetRange("Ordinary Cheque No.", "Cheque No.");
                if OrdinaryChequeRegister.FindFirst then begin
                    OrdinaryChequeRegister.Issued := true;
                    OrdinaryChequeRegister.Modify;
                end;

                JTemplate := '';
                JBatch := '';
                GetPaymentJournalTemplate(JTemplate, JBatch);

                LoanNo := '';
                JournalInit(JTemplate, JBatch);

                //Net Amount
                DetailedJournalInsert(
                    JTemplate,
                    JBatch,
                    "No.",
                    "Payment Release Date",
                    "Paying Account Type",
                    "Paying Bank Account",
                    "Payment Narration",
                    Balaccttype::"G/L Account",
                    '',
                    PvaAmt,
                    "Cheque No.",
                    LoanNo,
                    Transtype::" ",
                    "Global Dimension 1 Code",
                    "Shortcut Dimension 2 Code",
                    true,
                    DocType,
                    Date,
                    "Currency Code",
                    AppliesToDocType,
                    AppliesToDocNo,
                    AppliesToID,
                    DimensionSetID
                    );


                DocLine.Reset;
                DocLine.SetRange("Header No.", "No.");
                if DocLine.FindFirst then begin

                    repeat
                        DocLine.TestField("Account No.");
                        DocLine.TestField(Amount);
                        DocLine.TestField(Description);

                        LnAmt := DocLine.Amount;

                        if "Payment Type" = "payment type"::Staff then
                            LnAmt := DocLine.Amount * -1;

                        if "Payment Type" = "payment type"::Board then
                            LnAmt := DocLine.Amount * -1;


                        DetailedJournalInsert(
                            JTemplate,
                            JBatch,
                            "No.",
                            "Payment Release Date",
                            DocLine."Account Type",
                            DocLine."Account No.",
                            "Payment Narration" + ': ' + DocLine."KRA PIN No.",
                            Balaccttype::"G/L Account",
                            '',
                            LnAmt,
                            "Cheque No.",
                            DocLine."Loan No.",
                            DocLine."Transaction Type",
                            DocLine."Shortcut Dimension 1 Code",
                            DocLine."Shortcut Dimension 2 Code",
                            true,
                            DocLine."Document Type",
                            Date,
                            "Currency Code",
                            DocLine."Applies-to Doc. Type",
                            DocLine."Applies-to Doc. No.",
                            DocLine."Applies-to ID",
                            DocLine."Dimension Set ID"
                            );


                        if ("Payment Type" = "payment type"::Staff) or ("Payment Type" = "payment type"::Board) then begin
                            Message('Payment Type %1', "Payment Type");


                            DetailedJournalInsert(
                                JTemplate,
                                JBatch,
                                "No.",
                                "Payment Release Date",
                                DocLine."Account Type",
                                DocLine."Account No.",
                                'Withholding Tax',
                                //"Payment Narration"+': '+DocLine."KRA PIN No.",
                                Balaccttype::"G/L Account",
                                '',
                                DocLine."Withholding VAT",
                                "Cheque No.",
                                DocLine."Loan No.",
                                DocLine."Transaction Type",
                                DocLine."Shortcut Dimension 1 Code",
                                DocLine."Shortcut Dimension 2 Code",
                                true,
                                DocLine."Document Type",
                                Date,
                                "Currency Code",
                                DocLine."Applies-to Doc. Type",
                                DocLine."Applies-to Doc. No.",
                                DocLine."Applies-to ID",
                                DocLine."Dimension Set ID"
                                );



                            DetailedJournalInsert(
                                JTemplate,
                                JBatch,
                                "No.",
                                "Payment Release Date",
                                DocLine."Account Type",
                                DocLine."Account No.",
                                'Withholding Tax ',
                                Balaccttype::"G/L Account",
                                '',
                                DocLine."Withholding Tax",
                                "Cheque No.",
                                DocLine."Loan No.",
                                DocLine."Transaction Type",
                                DocLine."Shortcut Dimension 1 Code",
                                DocLine."Shortcut Dimension 2 Code",
                                true,
                                DocLine."Document Type",
                                Date,
                                "Currency Code",
                                DocLine."Applies-to Doc. Type",
                                DocLine."Applies-to Doc. No.",
                                DocLine."Applies-to ID",
                                DocLine."Dimension Set ID"
                                );


                        end;


                        JournalInsert(
                            JTemplate,
                            JBatch,
                            "No.",
                            "Payment Release Date",
                            Accttype::"G/L Account",
                            DocLine."VAT GL Account",
                            "Payment Narration" + ': ' + DocLine."KRA PIN No.",
                            Balaccttype::"G/L Account",
                            '',
                            DocLine."Withholding VAT" * -1,
                            "Cheque No.",
                            DocLine."Loan No.",
                            DocLine."Transaction Type",
                            DocLine."Shortcut Dimension 1 Code",
                            DocLine."Shortcut Dimension 2 Code",
                            true
                            );


                        JournalInsert(
                            JTemplate,
                            JBatch,
                            "No.",
                            "Payment Release Date",
                            Accttype::"G/L Account",
                            DocLine."WTax GL Account",
                            'Withholding Tax',
                            Balaccttype::"G/L Account",
                            '',
                            DocLine."Withholding Tax" * -1,
                            "Cheque No.",
                            DocLine."Loan No.",
                            DocLine."Transaction Type",
                            DocLine."Shortcut Dimension 1 Code",
                            DocLine."Shortcut Dimension 2 Code",
                            true
                            );

                    until DocLine.Next = 0;



                    Posted := true;
                    "Posted By" := UserId;
                    "Date Posted" := Today;
                    "Time Posted" := Time;
                    Modify;

                    JournalPost(JTemplate, JBatch);
                    Message('PV Posted Successfully');

                end;

            end;
        end;
    end;


    procedure PostBoardPV(PVNo: Code[20])
    var
        PaymentHeader: Record "Payment Header";
        DocLine: Record "Document Line";
        BankAcc: Record "Bank Account";
        LnAmt: Decimal;
        PvaAmt: Decimal;
        OrdinaryChequeRegister: Record "Ordinary Cheque Register";
    begin

        if PaymentHeader.Get(PVNo) then begin
            with PaymentHeader do begin
                TestField(Posted, false);

                TESTFIELD(Status, Status::Approved);
                TestField("Paying Bank Account");
                TestField("Pay Mode");
                TestField("Payment Release Date");
                TestField(Date);

                if Date <> Today then
                    Error('Date is reading %1 kindly reset it to Today to proceed', Date);

                TestField("Payment Narration");
                if ("Pay Mode" = "pay mode"::Cheque) or ("Pay Mode" = "pay mode"::EFT) then begin
                    TestField("Cheque No.");
                end;

                if "Pay Mode" = "pay mode"::Cash then begin
                    BankAcc.Reset;
                    BankAcc.SetRange(BankAcc."No.", "Paying Bank Account");
                    BankAcc.SetRange(BankAcc."Bank Type", BankAcc."bank type"::Cash);
                    if BankAcc.FindFirst then begin
                        BankAcc.CalcFields(BankAcc.Balance);
                        "Current Source A/C Bal." := BankAcc.Balance;
                        if ("Current Source A/C Bal." - "Total Net Amount") < 0 then begin
                            Error('The transaction will result in a negative balance in the BANK ACCOUNT. %1:%2', BankAcc."No.", BankAcc.Name);
                        end;
                    end;
                end;

                CalcFields("Total Net Amount", "Total VAT Amount", "Total VAT Withholding Amount", "Total Witholding Tax Amount", "Total Payment Amount");
                PvaAmt := "Total Net Amount" * -1;

                if "Payment Type" = "payment type"::Staff then
                    PvaAmt := "Total Payment Amount";

                if "Payment Type" = "payment type"::Board then
                    PvaAmt := "Total Payment Amount";


                OrdinaryChequeRegister.Reset;
                OrdinaryChequeRegister.SetRange("Ordinary Cheque No.", "Cheque No.");
                if OrdinaryChequeRegister.FindFirst then begin
                    OrdinaryChequeRegister.Issued := true;
                    OrdinaryChequeRegister.Modify;
                end;

                JTemplate := '';
                JBatch := '';
                GetPaymentJournalTemplate(JTemplate, JBatch);

                LoanNo := '';
                JournalInit(JTemplate, JBatch);

                //Net Amount
                DetailedJournalInsert(
                    JTemplate,
                    JBatch,
                    "No.",
                    "Payment Release Date",
                    "Paying Account Type",
                    "Paying Bank Account",
                    "Payment Narration" + ': ' + DocLine."KRA PIN No.",
                    Balaccttype::"G/L Account",
                    '',
                    PvaAmt,
                    "Cheque No.",
                    LoanNo,
                    Transtype::" ",
                    "Global Dimension 1 Code",
                    "Shortcut Dimension 2 Code",
                    true,
                    DocType,
                    Date,
                    "Currency Code",
                    AppliesToDocType,
                    AppliesToDocNo,
                    AppliesToID,
                    DimensionSetID
                    );


                DocLine.Reset;
                DocLine.SetRange("Header No.", "No.");
                if DocLine.FindFirst then begin

                    repeat
                        DocLine.TestField("Account No.");
                        DocLine.TestField(Amount);
                        DocLine.TestField(Description);

                        LnAmt := DocLine.Amount;

                        if "Payment Type" = "payment type"::Staff then
                            LnAmt := DocLine.Amount * -1;

                        if "Payment Type" = "payment type"::Board then
                            LnAmt := DocLine.Amount * -1;


                        DetailedJournalInsert(
                            JTemplate,
                            JBatch,
                            "No.",
                            "Payment Release Date",
                            DocLine."Account Type",
                            DocLine."Account No.",
                            "Payment Narration" + ': ' + DocLine."KRA PIN No.",
                            Balaccttype::"G/L Account",
                            '',
                            LnAmt,
                            "Cheque No.",
                            DocLine."Loan No.",
                            DocLine."Transaction Type",
                            DocLine."Shortcut Dimension 1 Code",
                            DocLine."Shortcut Dimension 2 Code",
                            true,
                            DocLine."Document Type",
                            Date,
                            "Currency Code",
                            DocLine."Applies-to Doc. Type",
                            DocLine."Applies-to Doc. No.",
                            DocLine."Applies-to ID",
                            DocLine."Dimension Set ID"
                            );


                        if ("Payment Type" = "payment type"::Staff) or ("Payment Type" = "payment type"::Board) then begin
                            Message('Payment Type %1', "Payment Type");


                            DetailedJournalInsert(
                                JTemplate,
                                JBatch,
                                "No.",
                                "Payment Release Date",
                                DocLine."Account Type",
                                DocLine."Account No.",
                                'Withholding Tax',
                                //"Payment Narration"+': '+DocLine."KRA PIN No.",
                                Balaccttype::"G/L Account",
                                '',
                                DocLine."Withholding VAT",
                                "Cheque No.",
                                DocLine."Loan No.",
                                DocLine."Transaction Type",
                                DocLine."Shortcut Dimension 1 Code",
                                DocLine."Shortcut Dimension 2 Code",
                                true,
                                DocLine."Document Type",
                                Date,
                                "Currency Code",
                                DocLine."Applies-to Doc. Type",
                                DocLine."Applies-to Doc. No.",
                                DocLine."Applies-to ID",
                                DocLine."Dimension Set ID"
                                );



                            DetailedJournalInsert(
                                JTemplate,
                                JBatch,
                                "No.",
                                "Payment Release Date",
                                DocLine."Account Type",
                                DocLine."Account No.",
                                'Withholding Tax ',
                                Balaccttype::"G/L Account",
                                '',
                                DocLine."Withholding Tax",
                                "Cheque No.",
                                DocLine."Loan No.",
                                DocLine."Transaction Type",
                                DocLine."Shortcut Dimension 1 Code",
                                DocLine."Shortcut Dimension 2 Code",
                                true,
                                DocLine."Document Type",
                                Date,
                                "Currency Code",
                                DocLine."Applies-to Doc. Type",
                                DocLine."Applies-to Doc. No.",
                                DocLine."Applies-to ID",
                                DocLine."Dimension Set ID"
                                );


                        end;


                        JournalInsert(
                            JTemplate,
                            JBatch,
                            "No.",
                            "Payment Release Date",
                            Accttype::"G/L Account",
                            DocLine."VAT GL Account",
                            "Payment Narration" + ': ' + DocLine."KRA PIN No.",
                            Balaccttype::"G/L Account",
                            '',
                            DocLine."Withholding VAT" * -1,
                            "Cheque No.",
                            DocLine."Loan No.",
                            DocLine."Transaction Type",
                            DocLine."Shortcut Dimension 1 Code",
                            DocLine."Shortcut Dimension 2 Code",
                            true
                            );


                        JournalInsert(
                            JTemplate,
                            JBatch,
                            "No.",
                            "Payment Release Date",
                            Accttype::"G/L Account",
                            DocLine."WTax GL Account",
                            'Withholding Tax',
                            Balaccttype::"G/L Account",
                            '',
                            DocLine."Withholding Tax" * -1,
                            "Cheque No.",
                            DocLine."Loan No.",
                            DocLine."Transaction Type",
                            DocLine."Shortcut Dimension 1 Code",
                            DocLine."Shortcut Dimension 2 Code",
                            true
                            );


                        DocLine.TESTFIELD("Board MNo");
                        InsertP9Record(DocLine."Board MNo", DocLine.Amount, DocLine."Withholding Tax", Date);

                    until DocLine.Next = 0;



                    Posted := true;
                    "Posted By" := UserId;
                    "Date Posted" := Today;
                    "Time Posted" := Time;
                    Modify;

                    JournalPost(JTemplate, JBatch);
                    Message('PV Posted Successfully');

                end;

            end;
        end;
    end;*/

    local procedure InsertP9Record(P9EmployeeCode: Code[20]; P9Allowances: Decimal; P9TaxCharged: Decimal; dtCurrPeriod: Date)
    var
        myInt: Integer;
        PayrollP9Buffer: Record "Board P9 Buffer";
        intYear: Integer;
        intMonth: Integer;
        P9BasicPay: Integer;
        P9Benefits: Decimal;
        P9ValueOfQuarters: Decimal;
        P9DefinedContribution: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9TaxablePay: Decimal;
        P9InsuranceRelief: Decimal;
        P9TaxRelief: Decimal;
        P9Paye: Decimal;
        P9NSSF: Decimal;
        P9NHIF: Decimal;
        P9Deductions: Decimal;
        P9NetPay: Decimal;
        P9GrossPay: Decimal;
        LNo: Integer;
    begin

        intMonth := DATE2DMY(dtCurrPeriod, 2);
        intYear := DATE2DMY(dtCurrPeriod, 3);

        PayrollP9Buffer.RESET;
        IF PayrollP9Buffer.FINDLAST THEN
            LNo := PayrollP9Buffer."Entry No";


        LNo += 1;
        PayrollP9Buffer.RESET;
        WITH PayrollP9Buffer DO BEGIN
            INIT;
            "Entry No" := LNo;
            "Employee Code" := P9EmployeeCode;
            "Basic Pay" := P9BasicPay;
            Allowances := P9Allowances;
            Benefits := P9Benefits;
            "Value Of Quarters" := P9ValueOfQuarters;
            "Defined Contribution" := P9DefinedContribution;
            "Owner Occupier Interest" := P9OwnerOccupierInterest;
            "Gross Pay" := P9Allowances;
            "Taxable Pay" := P9Allowances;
            "Tax Charged" := P9TaxCharged;
            "Insurance Relief" := P9InsuranceRelief;
            "Tax Relief" := P9TaxRelief;
            PAYE := P9TaxCharged;
            NSSF := P9NSSF;
            NHIF := P9NHIF;
            Deductions := P9Deductions;
            "Net Pay" := "Gross Pay" - "Tax Charged";
            "Period Month" := intMonth;
            "Period Year" := intYear;
            "Monthly Period" := FORMAT(intMonth) + '-' + FORMAT(intYear);
            "Payroll Period" := dtCurrPeriod;
            INSERT;
        END;

    end;

    procedure GetReceiptJournalTemplate(var JTemplate: Code[10]; var JBatch: Code[10])
    var
        CashUser: Record "User Setup";
    begin

        JTemplate := '';
        JBatch := '';

        CashUser.Get(UserId);
        CashUser.TestField("CashRec Journal Template");
        CashUser.TestField("CashRec Journal Batch");
        JTemplate := CashUser."CashRec Journal Template";
        JBatch := CashUser."CashRec Journal Batch";
    end;


    procedure GetPaymentJournalTemplate(var JTemplate: Code[10]; var JBatch: Code[10])
    var
        CashUser: Record "User Setup";
    begin

        JTemplate := '';
        JBatch := '';

        CashUser.Get(UserId);
        CashUser.TestField("Payment Journal Template");
        CashUser.TestField("Payment Journal Batch");
        JTemplate := CashUser."Payment Journal Template";
        JBatch := CashUser."Payment Journal Batch";
    end;


    procedure GetGeneralJournalTemplate(var JTemplate: Code[10]; var JBatch: Code[10])
    var
        CashUser: Record "User Setup";
    begin

        JTemplate := '';
        JBatch := '';

        CashUser.Get(UserId);
        CashUser.TestField("General Journal Template");
        CashUser.TestField("General Journal Batch");
        JTemplate := CashUser."General Journal Template";
        JBatch := CashUser."General Journal Batch";
    end;


    procedure PostLoan(LoanNo: Code[20]; DocNo: Code[20]; BankAccNo: Code[20]; BatchPosting: Boolean; var BatchAmt: Decimal; PDate: Date)
    var
        Loans: Record Loans;
        JTemplate: Code[10];
        JBatch: Code[10];
        USetup: Record "User Setup";

        Desc: Text[50];
        ExtDocNo: Code[20];
        Dim1: Code[10];
        Dim2: Code[10];
        RecoverInt: Boolean;
        LoanType: Record "Product Setup";
        NetLoanAmt: Decimal;
        LoanCharges: Record "Loan Charges";
        TopUp: Record "Loan Top Up";
        TopUpLoan: Record Loans;
        TopUpAmt: Decimal;
        MonthlyInterest: Decimal;
        TDays: Integer;
        Days: Integer;
        EndMonth: Date;
        IntDue: Decimal;
        MemberAccounts: Record Vendor;
        TopUpProduct: Record "Product Setup";
        //PortalLoans: Record "Portal Loans";
        OtherClearance: Record "Other Committments Clearance";
        LRec: Record Loans;
        LoanRunBal: Decimal;
    begin


        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        if Loans.FindFirst then begin
            if Loans.Posted then
                Error('Loan No. %1 has already been posted', Loans."Loan No.");
            if Loans.Status <> Loans.Status::Approved then
                Error('Loan No. %1 has not been Approved');
            if Loans."Mode of Disbursement" = Loans."mode of disbursement"::" " then
                Error('Mode of Disbursement Not Captured for Loan No. %1', Loans."Loan No.");

            Loans.TestField("Approved Amount");
            Loans.TestField("Amount To Disburse");
            Loans.TestField("Member No.");
            Loans.TestField("Loan Product Type");
            if Loans."Mode of Disbursement" = Loans."mode of disbursement"::"Transfer to Fosa" then
                Loans.TestField("Disbursement Account No");


            UserSetup.Get(UserId);
            UserSetup.TestField("Payment Journal Template");
            UserSetup.TestField("Payment Journal Batch");
            JTemplate := UserSetup."Payment Journal Template";
            JBatch := UserSetup."Payment Journal Batch";
            Dim1 := Loans."Global Dimension 1 Code";
            Dim2 := Loans."Booking Branch";

            PDate := Loans."Disbursement Date";
            SaccoSetup.Get;
            LoanType.Get(Loans."Loan Product Type");
            LoanType.TestField(Description);
            Loans."Loan Product Type Name" := LoanType.Description;

            if not BatchPosting then begin

                JournalInit(JTemplate, JBatch);

                if Loans."Mode of Disbursement" <> Loans."mode of disbursement"::"Transfer to Fosa" then begin
                    Loans.TestField("Cheque No.");
                end;
                Loans.TestField("Disbursement Account No");
            end;

            ExtDocNo := Loans."Loan No.";
            NetLoanAmt := Loans."Amount To Disburse";

            Desc := 'Loan Disbursement: ' + Loans."Loan Product Type Name";
            JournalInsert(
                JTemplate,
                JBatch,
                DocNo,
                PDate,
                Accttype::Credit,
                Loans."Member No.",
                Desc,
                Balaccttype::"G/L Account",
                '',
                Loans."Amount To Disburse",
                ExtDocNo,
                Loans."Loan No.",
                Transtype::"Loan Disbursement",
                Dim1,
                Dim2,
                true
                );

            if Loans."Mode of Disbursement" = Loans."mode of disbursement"::"Transfer to Fosa" then begin
                Desc := 'Loan Disbursement: ' + Loans."Loan Product Type Name";
                JournalInsert(
                    JTemplate,
                    JBatch,
                    DocNo,
                    PDate,
                    Accttype::Savings,
                    Loans."Disbursement Account No",
                    Desc,
                    Balaccttype::"G/L Account",
                    '',
                    Loans."Amount To Disburse" * -1,
                    ExtDocNo,
                    Loans."Loan No.",
                    Transtype::" ",
                    Dim1,
                    Dim2,
                    true
                    );
            end;

            if Loans."Registration Fee" > 0 then begin

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Loans."Member No.");
                MemberAccounts.SetRange("Product Category", MemberAccounts."product category"::"Registration Fee");
                if MemberAccounts.FindFirst then begin

                    Desc := 'Member Registration Fee ' + MemberAccounts."Member No.";
                    JournalInsert(
                        JTemplate,
                        JBatch,
                        DocNo,
                        PDate,
                        Accttype::Savings,
                        MemberAccounts."No.",
                        Desc,
                        Balaccttype::"G/L Account",
                        '',
                        Loans."Registration Fee" * -1,
                        ExtDocNo,
                        Loans."Loan No.",
                        Transtype::" ",
                        Dim1,
                        Dim2,
                        true
                        );
                    NetLoanAmt -= Loans."Registration Fee";

                    if Loans."Mode of Disbursement" = Loans."mode of disbursement"::"Transfer to Fosa" then begin

                        Desc := 'Member Registration Fee ' + MemberAccounts."Member No.";
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Savings,
                            Loans."Disbursement Account No",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            Loans."Registration Fee",
                            ExtDocNo,
                            Loans."Loan No.",
                            Transtype::" ",
                            Dim1,
                            Dim2,
                            true
                            );
                    end;
                end;


            end;




            if Loans."Deposit Boosting" > 0 then begin

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Loans."Member No.");
                MemberAccounts.SetRange("Product Category", MemberAccounts."product category"::"Deposit Contribution");
                if MemberAccounts.FindFirst then begin

                    Desc := 'Deposit Boosting ' + Loans."Loan No.";
                    JournalInsert(
                        JTemplate,
                        JBatch,
                        DocNo,
                        PDate,
                        Accttype::Savings,
                        MemberAccounts."No.",
                        Desc,
                        Balaccttype::"G/L Account",
                        '',
                        Loans."Deposit Boosting" * -1,
                        ExtDocNo,
                        Loans."Loan No.",
                        Transtype::" ",
                        Dim1,
                        Dim2,
                        true
                        );
                    NetLoanAmt -= Loans."Deposit Boosting";


                    if Loans."Mode of Disbursement" = Loans."mode of disbursement"::"Transfer to Fosa" then begin

                        Desc := 'Deposit Boosting ' + MemberAccounts."Member No.";
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Savings,
                            Loans."Disbursement Account No",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            Loans."Deposit Boosting",
                            ExtDocNo,
                            Loans."Loan No.",
                            Transtype::" ",
                            Dim1,
                            Dim2,
                            true
                            );
                    end;
                end;


            end;




            if Loans."Share Capital Boosting" > 0 then begin

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Loans."Member No.");
                MemberAccounts.SetRange("Product Category", MemberAccounts."product category"::"Share Capital");
                if MemberAccounts.FindFirst then begin

                    Desc := 'Share Capital Boosting ' + Loans."Loan No.";
                    JournalInsert(
                        JTemplate,
                        JBatch,
                        DocNo,
                        PDate,
                        Accttype::Savings,
                        MemberAccounts."No.",
                        Desc,
                        Balaccttype::"G/L Account",
                        '',
                        Loans."Share Capital Boosting" * -1,
                        ExtDocNo,
                        Loans."Loan No.",
                        Transtype::" ",
                        Dim1,
                        Dim2,
                        true
                        );
                    NetLoanAmt -= Loans."Share Capital Boosting";


                    if Loans."Mode of Disbursement" = Loans."mode of disbursement"::"Transfer to Fosa" then begin

                        Desc := 'Share Capital Boosting ' + MemberAccounts."Member No.";
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Savings,
                            Loans."Disbursement Account No",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            Loans."Share Capital Boosting",
                            ExtDocNo,
                            Loans."Loan No.",
                            Transtype::" ",
                            Dim1,
                            Dim2,
                            true
                            );
                    end;
                end;


            end;

            LoanCharges.Reset;
            LoanCharges.SetRange("Loan No.", Loans."Loan No.");
            LoanCharges.SetRange("Loan Product Type", Loans."Loan Product Type");
            if LoanCharges.FindFirst then begin
                repeat
                    if LoanCharges.Amount > 0 then begin
                        LoanCharges.TestField(Description);
                        Desc := LoanCharges.Description;
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            LoanCharges."Account Type",
                            LoanCharges."Account No.",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            LoanCharges.Amount * -1,
                            ExtDocNo,
                            Loans."Loan No.",
                            Transtype::" ",
                            Dim1,
                            Dim2,
                            true
                            );

                        if LoanCharges."Posting Type" = LoanCharges."Posting Type"::"Deduct From Net Payable" then begin
                            NetLoanAmt -= LoanCharges.Amount;

                            if Loans."Mode of Disbursement" = Loans."mode of disbursement"::"Transfer to Fosa" then begin

                                Desc := LoanCharges.Description;
                                JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    DocNo,
                                    PDate,
                                    Accttype::Savings,
                                    Loans."Disbursement Account No",
                                    Desc,
                                    Balaccttype::"G/L Account",
                                    '',
                                    LoanCharges.Amount,
                                    ExtDocNo,
                                    Loans."Loan No.",
                                    Transtype::" ",
                                    Dim1,
                                    Dim2,
                                    true
                                    );
                            end;
                        end
                        else
                            if LoanCharges."Posting Type" = LoanCharges."Posting Type"::"Add to Loan Amount" then begin

                                Desc := LoanCharges.Description;
                                JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    DocNo,
                                    PDate,
                                    Accttype::Credit,
                                    Loans."Member No.",
                                    Desc,
                                    Balaccttype::"G/L Account",
                                    '',
                                    LoanCharges.Amount,
                                    ExtDocNo,
                                    Loans."Loan No.",
                                    Transtype::"Loan Disbursement",
                                    Dim1,
                                    Dim2,
                                    true
                                    );

                            end;
                    end;


                    if LoanCharges."Excise Duty" > 0 then begin

                        LoanCharges.TestField(Description);
                        Desc := 'Excise Duty: ' + LoanCharges.Description;
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::"G/L Account",
                            SaccoSetup."Excise Duty GL",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            LoanCharges."Excise Duty" * -1,
                            ExtDocNo,
                            Loans."Loan No.",
                            Transtype::" ",
                            Dim1,
                            Dim2,
                            true
                            );


                        if LoanCharges."Posting Type" = LoanCharges."Posting Type"::"Deduct From Net Payable" then begin

                            NetLoanAmt -= LoanCharges."Excise Duty";

                            if Loans."Mode of Disbursement" = Loans."mode of disbursement"::"Transfer to Fosa" then begin
                                Desc := 'Excise Duty: ' + LoanCharges.Description;
                                JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    DocNo,
                                    PDate,
                                    Accttype::Savings,
                                    Loans."Disbursement Account No",
                                    Desc,
                                    Balaccttype::"G/L Account",
                                    '',
                                    LoanCharges."Excise Duty",
                                    ExtDocNo,
                                    Loans."Loan No.",
                                    Transtype::" ",
                                    Dim1,
                                    Dim2,
                                    true
                                    );
                            end;
                        end
                        else
                            if LoanCharges."Posting Type" = LoanCharges."Posting Type"::"Add to Loan Amount" then begin

                                Desc := 'Excise Duty: ' + LoanCharges.Description;
                                JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    DocNo,
                                    PDate,
                                    Accttype::Credit,
                                    Loans."Member No.",
                                    Desc,
                                    Balaccttype::"G/L Account",
                                    '',
                                    LoanCharges."Excise Duty",
                                    ExtDocNo,
                                    Loans."Loan No.",
                                    Transtype::"Loan Disbursement",
                                    Dim1,
                                    Dim2,
                                    true
                                    );

                            end;
                    end;
                until LoanCharges.Next = 0;
            end;



            TopUp.Reset;
            TopUp.SetRange("Loan No.", Loans."Loan No.");
            TopUp.SetRange("Member No.", Loans."Member No.");
            if TopUp.FindFirst then begin
                TopUpAmt := 0;
                repeat

                    TopUpLoan.Get(TopUp."Loan Top Up");
                    TopUpProduct.Get(TopUpLoan."Loan Product Type");
                    if TopUp."Appraisal Top Up" > 0 then begin
                        Desc := 'Loan Appraisal Top Up: ' + Loans."Loan No.";
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Credit,
                            TopUpLoan."Member No.",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            TopUp."Appraisal Top Up" * -1,
                            ExtDocNo,
                            TopUpLoan."Loan No.",
                            Transtype::"Appraisal Paid",
                            Dim1,
                            Dim2,
                            true
                            );
                        NetLoanAmt -= TopUp."Appraisal Top Up";
                        TopUpAmt += TopUp."Appraisal Top Up";
                    end;


                    if TopUp."Penalty Top Up" > 0 then begin
                        Desc := 'Loan Penalty Top Up: ' + Loans."Loan No.";
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Credit,
                            TopUpLoan."Member No.",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            TopUp."Penalty Top Up" * -1,
                            ExtDocNo,
                            TopUpLoan."Loan No.",
                            Transtype::"Penalty Paid",
                            Dim1,
                            Dim2,
                            true
                            );
                        NetLoanAmt -= TopUp."Penalty Top Up";
                        TopUpAmt += TopUp."Penalty Top Up";
                    end;

                    if TopUp."Uncharged Interest" > 0 then begin
                        Desc := 'Loan Interest Due: ' + Loans."Loan No.";
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Credit,
                            TopUpLoan."Member No.",
                            Desc,
                            Balaccttype::"G/L Account",
                            TopUpProduct."Loan Interest Income [G/L]",
                            TopUp."Uncharged Interest",
                            ExtDocNo,
                            TopUpLoan."Loan No.",
                            Transtype::"Interest Due",
                            Dim1,
                            Dim2,
                            true
                            );
                    end;

                    if TopUp."Interest Top Up" + TopUp."Uncharged Interest" > 0 then begin
                        Desc := 'Loan Interest Top Up: ' + Loans."Loan No.";
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Credit,
                            TopUpLoan."Member No.",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            (TopUp."Interest Top Up" + TopUp."Uncharged Interest") * -1,
                            ExtDocNo,
                            TopUpLoan."Loan No.",
                            Transtype::"Interest Paid",
                            Dim1,
                            Dim2,
                            true
                            );
                        NetLoanAmt -= TopUp."Interest Top Up" + TopUp."Uncharged Interest";
                        TopUpAmt += TopUp."Interest Top Up" + TopUp."Uncharged Interest";
                    end;

                    if TopUp."Principle Top Up" > 0 then begin
                        Desc := 'Loan Principal Top Up: ' + Loans."Loan No.";
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Credit,
                            TopUpLoan."Member No.",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            TopUp."Principle Top Up" * -1,
                            ExtDocNo,
                            TopUpLoan."Loan No.",
                            Transtype::"Principal Repayment",
                            Dim1,
                            Dim2,
                            true
                            );
                        NetLoanAmt -= TopUp."Principle Top Up";
                        TopUpAmt += TopUp."Principle Top Up";
                    end;

                    if TopUp.Commision > 0 then begin
                        TopUp.TestField("Commission GL");
                        Desc := 'Loan Top Up Commission: ' + Loans."Loan No.";
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::"G/L Account",
                            TopUp."Commission GL",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            TopUp.Commision * -1,
                            ExtDocNo,
                            TopUpLoan."Loan No.",
                            Transtype::"Principal Repayment",
                            Dim1,
                            Dim2,
                            true
                            );
                        NetLoanAmt -= TopUp.Commision;
                    end;
                until TopUp.Next = 0;



                if Loans."Mode of Disbursement" = Loans."mode of disbursement"::"Transfer to Fosa" then begin
                    Desc := 'Loan Top Up';
                    JournalInsert(
                        JTemplate,
                        JBatch,
                        DocNo,
                        PDate,
                        Accttype::Savings,
                        Loans."Disbursement Account No",
                        Desc,
                        Balaccttype::"G/L Account",
                        '',
                        TopUpAmt,
                        ExtDocNo,
                        Loans."Loan No.",
                        Transtype::" ",
                        Dim1,
                        Dim2,
                        true
                        );


                    TopUp.Reset;
                    TopUp.SetRange("Loan No.", Loans."Loan No.");
                    TopUp.SetRange("Member No.", Loans."Member No.");
                    if TopUp.FindFirst then begin
                        TopUp.CalcSums(Commision);
                        Desc := 'Commission on Loan Top Up';
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Savings,
                            Loans."Disbursement Account No",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            TopUp.Commision,
                            ExtDocNo,
                            Loans."Loan No.",
                            Transtype::" ",
                            Dim1,
                            Dim2,
                            true
                            );

                    end;

                end;
            end;


            OtherClearance.Reset;
            OtherClearance.SetRange("Loan Application No.", Loans."Loan No.");
            if OtherClearance.FindFirst then begin
                repeat
                    OtherClearance.testfield(Description);
                    if OtherClearance.Type = OtherClearance.Type::"Pay External Loan" then
                        Accttype := Accttype::Vendor;
                    if OtherClearance.Type = OtherClearance.Type::"Pay Internal Loan" then
                        Accttype := Accttype::Credit;
                    if OtherClearance.Type = OtherClearance.Type::"Pay Internal Savings" then
                        Accttype := Accttype::Savings;
                    if OtherClearance.Type = OtherClearance.Type::"Pay Supplier" then
                        Accttype := Accttype::Vendor;


                    if OtherClearance.Amount > 0 then begin

                        if OtherClearance.Type = OtherClearance.Type::"Pay Internal Loan" then begin
                            LRec.get(OtherClearance."Loan No.");
                            LRec.CalcFields("Outstanding Principal", "Outstanding Interest");
                            LRec.CalcFields("Outstanding Penalty");

                            LoanRunBal := OtherClearance.Amount;
                            if LRec."Outstanding Interest" > 0 then begin
                                if LRec."Outstanding Interest" > LoanRunBal then
                                    LRec."Outstanding Interest" := LoanRunBal;

                                if LRec."Outstanding Interest" > 0 then begin

                                    Desc := OtherClearance.Description + ': ' + Loans."Loan No.";
                                    JournalInsert(
                                        JTemplate,
                                        JBatch,
                                        DocNo,
                                        PDate,
                                        Accttype,
                                        OtherClearance."Account No.",
                                        Desc,
                                        Balaccttype::"G/L Account",
                                        '',
                                        LRec."Outstanding Interest" * -1,
                                        ExtDocNo,
                                        OtherClearance."Loan No.",
                                        Transtype::"Interest Paid",
                                        Dim1,
                                        Dim2,
                                        true
                                        );

                                    LoanRunBal -= LRec."Outstanding Interest";
                                end;
                            end;


                            if LoanRunBal > 0 then begin

                                if LRec."Outstanding Penalty" > 0 then begin
                                    if LRec."Outstanding Penalty" > LoanRunBal then
                                        LRec."Outstanding Penalty" := LoanRunBal;

                                    if LRec."Outstanding Penalty" > 0 then begin

                                        Desc := OtherClearance.Description + ': ' + Loans."Loan No.";
                                        JournalInsert(
                                            JTemplate,
                                            JBatch,
                                            DocNo,
                                            PDate,
                                            Accttype,
                                            OtherClearance."Account No.",
                                            Desc,
                                            Balaccttype::"G/L Account",
                                            '',
                                            LRec."Outstanding Penalty" * -1,
                                            ExtDocNo,
                                            OtherClearance."Loan No.",
                                            Transtype::"Penalty Paid",
                                            Dim1,
                                            Dim2,
                                            true
                                            );

                                        LoanRunBal -= LRec."Outstanding Penalty";
                                    end;
                                end;

                            end;


                            if LoanRunBal > 0 then begin


                                Desc := OtherClearance.Description + ': ' + Loans."Loan No.";
                                JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    DocNo,
                                    PDate,
                                    Accttype,
                                    OtherClearance."Account No.",
                                    Desc,
                                    Balaccttype::"G/L Account",
                                    '',
                                    LoanRunBal * -1,
                                    ExtDocNo,
                                    OtherClearance."Loan No.",
                                    Transtype::"Principal Repayment",
                                    Dim1,
                                    Dim2,
                                    true
                                    );

                            end;
                        end
                        else begin

                            Desc := OtherClearance.Description + ': ' + Loans."Loan No.";
                            JournalInsert(
                                JTemplate,
                                JBatch,
                                DocNo,
                                PDate,
                                Accttype,
                                OtherClearance."Account No.",
                                Desc,
                                Balaccttype::"G/L Account",
                                '',
                                OtherClearance.Amount * -1,
                                ExtDocNo,
                                OtherClearance."Loan No.",
                                Transtype::" ",
                                Dim1,
                                Dim2,
                                true
                                );
                            NetLoanAmt -= OtherClearance.Amount;

                        end;

                    end;


                    if Loans."Mode of Disbursement" = Loans."mode of disbursement"::"Transfer to Fosa" then begin

                        Desc := OtherClearance.Description + ': ' + Loans."Loan No.";
                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DocNo,
                            PDate,
                            Accttype::Savings,
                            Loans."Disbursement Account No",
                            Desc,
                            Balaccttype::"G/L Account",
                            '',
                            OtherClearance.Amount,
                            ExtDocNo,
                            Loans."Loan No.",
                            Transtype::" ",
                            Dim1,
                            Dim2,
                            true
                            );
                    end;


                until OtherClearance.Next = 0;
            end;



            if LoanType."Interest Recovered Upfront" then
                if LoanType."Interest Due on Disbursement" = LoanType."interest due on disbursement"::" " then
                    Error('Interest Due on Disbursement MUST have a value if interest is to be recovered upfront for Loan Product %1', LoanType.Description);

            if LoanType."Interest Due on Disbursement" <> LoanType."interest due on disbursement"::" " then begin

                MonthlyInterest := ROUND(Loans."Amount To Disburse" * Loans."Annual Interest %" / 1200, 0.01, '=');
                IntDue := 0;
                EndMonth := CalcDate('CM', PDate);
                TDays := Date2dmy(EndMonth, 1);
                Days := TDays - Date2dmy(PDate, 1) + 1;


                if LoanType."Interest Due on Disbursement" = LoanType."interest due on disbursement"::"Total Loan Interest - Straight Line" then
                    IntDue := ROUND(MonthlyInterest * Loans.Installments);
                if LoanType."Interest Due on Disbursement" = LoanType."interest due on disbursement"::"Full Interest" then
                    IntDue := ROUND(MonthlyInterest);
                if LoanType."Interest Due on Disbursement" = LoanType."interest due on disbursement"::"Prorated Interest" then
                    IntDue := ROUND(MonthlyInterest * Days / TDays);
                if LoanType."Interest Due on Disbursement" = LoanType."interest due on disbursement"::"Full Interest Before Cutoff" then begin
                    LoanType.TestField("Interest Due Cutoff Day");
                    if Days <= LoanType."Interest Due Cutoff Day" then
                        IntDue := MonthlyInterest;
                end;
                if LoanType."Interest Due on Disbursement" = LoanType."interest due on disbursement"::"Prorated Interest After CutOff" then begin
                    LoanType.TestField("Interest Due Cutoff Day");
                    if Days > LoanType."Interest Due Cutoff Day" then
                        IntDue := ROUND(MonthlyInterest * Days / TDays);
                end;
                if LoanType."Interest Due on Disbursement" = LoanType."interest due on disbursement"::"Full/Prorated Interest Based on CutOff" then begin
                    LoanType.TestField("Interest Due Cutoff Day");
                    if Days <= LoanType."Interest Due Cutoff Day" then
                        IntDue := MonthlyInterest;
                    if Days > LoanType."Interest Due Cutoff Day" then
                        IntDue := ROUND(MonthlyInterest * Days / TDays);
                end;

                if IntDue > 0 then begin

                    BalAcctNo := LoanType."Loan Interest Income [G/L]";

                    if LoanType."Pre-Earned Interest" then begin
                        BalAcctNo := '';
                        Loans."Monthly Pre-Earned Interest" := MonthlyInterest;
                    end;

                    LoanType.TestField("Loan Interest Income [G/L]");
                    Desc := 'Interest Due on Disbursement';
                    JournalInsert(
                        JTemplate,
                        JBatch,
                        DocNo,
                        PDate,
                        Accttype::Credit,
                        Loans."Member No.",
                        Desc,
                        Balaccttype::"G/L Account",
                        BalAcctNo,
                        IntDue,
                        ExtDocNo,
                        Loans."Loan No.",
                        Transtype::"Interest Due",
                        Dim1,
                        Dim2,
                        true
                        );



                    RecoverInt := false;
                    if LoanType."Interest Recovered Upfront" then begin

                        if LoanType."Recover Int. Due on Disb." = LoanType."Recover Int. Due on Disb."::"Full Interest" then
                            RecoverInt := true;

                        if LoanType."Recover Int. Due on Disb." = LoanType."Recover Int. Due on Disb."::"Interest After CutOff" then begin

                            LoanType.TestField("Interest Due Cutoff Day");
                            if Days > LoanType."Interest Due Cutoff Day" then
                                RecoverInt := true;
                        end;


                        Desc := 'Interest Recovered Upfront';
                        if RecoverInt then
                            JournalInsert(
                                JTemplate,
                                JBatch,
                                DocNo,
                                PDate,
                                Accttype::Credit,
                                TopUpLoan."Member No.",
                                Desc,
                                Balaccttype::"G/L Account",
                                '',
                                IntDue * -1,
                                ExtDocNo,
                                TopUpLoan."Loan No.",
                                Transtype::"Interest Paid",
                                Dim1,
                                Dim2,
                                true
                                );
                        NetLoanAmt -= IntDue;



                        if Loans."Mode of Disbursement" = Loans."mode of disbursement"::"Transfer to Fosa" then begin
                            Desc := 'Interest Recovered Upfront';
                            JournalInsert(
                                JTemplate,
                                JBatch,
                                DocNo,
                                PDate,
                                Accttype::Savings,
                                Loans."Disbursement Account No",
                                Desc,
                                Balaccttype::"G/L Account",
                                '',
                                IntDue,
                                ExtDocNo,
                                Loans."Loan No.",
                                Transtype::" ",
                                Dim1,
                                Dim2,
                                true
                                );
                        end;
                    end;

                end;
            end;




            IF NOT BatchPosting then
                if Loans."Mode of Disbursement" <> Loans."mode of disbursement"::"Transfer to Fosa" then begin
                    Desc := CopyStr(Loans."Loan Product Type Name" + ': ' + Loans."Member No." + '-' + Loans."Member Name", 1, 50);
                    JournalInsert(
                        JTemplate,
                        JBatch,
                        DocNo,
                        PDate,
                        Accttype::"Bank Account",
                        BankAccNo,
                        Desc,
                        Balaccttype::"G/L Account",
                        '',
                        -NetLoanAmt,
                        ExtDocNo,
                        Loans."Loan No.",
                        Transtype::" ",
                        Dim1,
                        Dim2,
                        true
                        );
                end;
            BatchAmt := NetLoanAmt;

            Loans.Posted := true;
            Loans."Disbursement Date" := PDate;

            if Loans."Repay Mode" = Loans."Repay Mode"::"Internal Standing Order" then begin

                //CreateStandingOrder(Loans);
            end;


            Loans.Modify;

            /*PortalLoans.Reset();
            ;
            PortalLoans.SetRange("Loan No.", Loans."Loan No.");
            if PortalLoans.FindFirst() then begin

                PortalLoans.Status := PortalLoans.Status::Successful;
                PortalLoans.Posted := true;
                PortalLoans."Date Posted" := CurrentDateTime;
                PortalLoans.Modify();
            end;*/


            if not BatchPosting then begin
                JournalPost(JTemplate, JBatch);

                dWindow.Open('#1#################');
                dWindow.Update(1, 'Generating Schedule');
                GenerateRepaymentSchedule(Loans);
                Commit;
                dWindow.Update(1, 'Sending Email/SMS Notification');
                SendLoanDisbursementNotifications(Loans);
                dWindow.Close;
                Message('Loan Posted Successfuly');
            end;

        end;
    end;


    procedure SendLoanDisbursementNotifications(Loans: Record Loans)
    var
        MemberActivities: Codeunit "Member Activities";
        Msg: Text;
        Member: Record Customer;
        SMSSource: Enum "SMS Source Enum";
        ProductSetup: Record "Product Setup";
        SenderAddress: Text;
        SenderName: Text;
        CompanyInfo: Record "Company Information";
        LRec: Record Loans;
        FileName: Text;
    begin


        Member.Get(Loans."Member No.");
        ProductSetup.Get(Loans."Loan Product Type");

        Msg := 'Dear ' + Member.Name + ', Your ' + ProductSetup.Description + ' of KES ' + Format(Loans."Approved Amount") + ' has been Approved and disbursed to your FOSA account.';
        MemberActivities.SendSms(Smssource::"Loan Posted", Member."Mobile Phone No.", Msg, Member."No.", Loans."Disbursement Account No", true, false);

        //MESSAGE(Msg);
        Commit;

        /*
        IF SMTPSetup.GET THEN BEGIN
        
            CompanyInfo.GET;
            SenderName := CompanyInfo.Name;
            SenderAddress := SMTPSetup."User ID";
            IF SenderName = '' THEN
                SenderName := COMPANYNAME;
        
            FileName := SMTPSetup."File Path"+'LoanSchedule'+Loans."Loan No."+'.pdf';
        
            IF FILE.EXISTS(FileName) THEN
                FILE.ERASE(FileName);
        
            LRec.RESET;
            LRec.SETRANGE("Loan No.",Loans."Loan No.");
            IF LRec.FINDFIRST THEN
                REPORT.SAVEASPDF(50001,FileName,LRec);
        
        
            SMTP.CreateMessage(SenderName,SenderAddress,Member."E-Mail",'LOAN DISBURESMENT: '+UPPERCASE(SenderName),'',TRUE);
        
        
            SMTPSetup.CALCFIELDS("Email Footer Image","Email Header Image");
        
            IF SMTPSetup."Email Header Image".HASVALUE THEN
                SMTP.AppendBody('<img src="data:image/png;base64,'+MemberActivities.Base64Header+'" alt="" />');
            SMTP.AppendBody('<br><br>');
            SMTP.AppendBody('Dear '+Member."First Name");
            SMTP.AppendBody('<br><br>');
            SMTP.AppendBody('Your '+ProductSetup.Description+' of KES '+FORMAT(Loans."Approved Amount")+' has been Approved and will reflect in your Account.');
            SMTP.AppendBody('<br><br>');
            SMTP.AppendBody('Find attached your Loan Repayment Schedule.');
            SMTP.AppendBody('<br><br>');
        
            SMTP.AppendBody('<br><br>');
            SMTP.AppendBody('Kind Regards,');
            SMTP.AppendBody('<br>');
            SMTP.AppendBody(SenderName);
            SMTP.AppendBody('<br><br>');
            IF SMTPSetup."Email Footer Image".HASVALUE THEN
                SMTP.AppendBody('<img src="data:image/png;base64,'+MemberActivities.Base64Footer+'" alt="" />');
            SMTP.AppendBody('<br><br>');
            SMTP.AppendBody('<hr>');
            SMTP.AddAttachment(FileName,'LoanSchedule'+Loans."Loan No."+'.pdf');
            SLEEP(3000);
        
        
            IF SMTP.TrySend THEN;
        END;
        */

    end;


    procedure GenerateRepaymentSchedule(Loans: Record Loans)
    var
        LSchedule: Record "Loan Repayment Schedule";
        QCounter: Integer;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        GrPrinciple: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrInterest: Decimal;
        RepayCode: Code[10];
        TInterest: Decimal;
        IntDen: Integer;
        DisbDay: Integer;
        Months: Integer;
        BonusDate: Date;
        CheckDate: Date;
        DisbDate: Date;
        LoanType: Record "Product Setup";
        InitDF: DateFormula;
        PrincipalStartDate: Date;
        InterestStartDate: Date;
    begin

        with Loans do begin

            //Delete schedule
            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", "Loan No.");
            LSchedule.DeleteAll;


            TestField("Disbursement Date");
            Validate("Disbursement Date");

            TestField("Repayment Start Date");
            if "Schedule Start Date" = 0D then
                "Schedule Start Date" := "Repayment Start Date";

            LoanType.Get("Loan Product Type");
            if Loans."Interest Calculation Method" <> LoanType."Interest Calculation Method" then
                Loans."Interest Calculation Method" := LoanType."Interest Calculation Method";


            LoanAmount := "Approved Amount";
            InterestRate := "Annual Interest %";
            RepayPeriod := Installments;
            InitialInstal := Installments;
            LBalance := "Approved Amount";
            //RunDate:="Repayment Start Date";
            RunDate := "Schedule Start Date";

            if "Principal Grace Period" = InitDF then
                "Principal Grace Period" := LoanType."Grace Period - Principal";
            if "Interest Grace Period" = InitDF then
                "Interest Grace Period" := LoanType."Grace Period - Interest";
            PrincipalStartDate := 0D;
            InterestStartDate := 0D;

            if "Principal Grace Period" <> InitDF then begin
                PrincipalStartDate := CalcDate("Principal Grace Period", "Schedule Start Date");
            end;
            if "Interest Grace Period" <> InitDF then begin
                InterestStartDate := CalcDate("Interest Grace Period", "Schedule Start Date");
            end;


            LoanType.Get("Loan Product Type");

            InstalNo := 0;
            IntDen := 12;
            //Repayment Frequency
            if "Repayment Frequency" = "repayment frequency"::Daily then
                "Repayment Frequency" := "Repayment Frequency"::Monthly;

            //Repayment -Frequency
            if "Repayment Frequency" = "repayment frequency"::Daily then
                IntDen := 365
            else
                if "Repayment Frequency" = "repayment frequency"::Weekly then
                    IntDen := 52
                else
                    if "Repayment Frequency" = "repayment frequency"::Monthly then
                        IntDen := 12
                    else
                        if "Repayment Frequency" = "repayment frequency"::Quarterly then
                            IntDen := 4
                        else
                            if "Repayment Frequency" = "repayment frequency"::"Tri-Annual" then
                                IntDen := 3
                            else
                                if "Repayment Frequency" = "repayment frequency"::"Bi-Annual" then
                                    IntDen := 2
                                else
                                    if "Repayment Frequency" = "repayment frequency"::Yearly then
                                        IntDen := 1
                                    else
                                        if "Repayment Frequency" = "repayment frequency"::Bonus then begin
                                            IntDen := 1;
                                        end;


            InstalNo := 1;


            repeat


                Months := 12;
                if InstalNo = 1 then begin
                    if "Repayment Frequency" = "repayment frequency"::Bonus then begin
                        BonusDate := Dmy2date(31, 10, Date2dmy("Disbursement Date", 3));
                        if BonusDate < "Disbursement Date" then
                            BonusDate := CalcDate('1Y', BonusDate);

                        CheckDate := CalcDate('1M-CM', "Disbursement Date");
                        Months := 0;
                        while CheckDate <= BonusDate do begin
                            Months += 1;
                            CheckDate := CalcDate('1M', CheckDate);
                        end;
                    end;
                end;

                if "Interest Calculation Method" = "interest calculation method"::Amortised then begin
                    if "Annual Interest %" = 0 then
                        "Interest Calculation Method" := "interest calculation method"::"Reducing Balance"

                end;

                if ("Interest Calculation Method" = "interest calculation method"::Amortised) then begin
                    TestField("Annual Interest %");
                    TestField(Installments);

                    TotalMRepay := ROUND((InterestRate / IntDen / 100) / (1 - Power((1 + (InterestRate / IntDen / 100)), -(RepayPeriod))) * (LoanAmount), 0.01, '=');
                    LInterest := ROUND(Months / 12 * LBalance * InterestRate / IntDen / 100, 0.01, '=');
                    LPrincipal := TotalMRepay - LInterest;
                end;

                if ("Interest Calculation Method" = "interest calculation method"::"Straight Line") then begin
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.01, '=');
                    LInterest := ROUND(LoanAmount * InterestRate / IntDen / 100, 0.01, '=');
                    TotalMRepay := LPrincipal + LInterest;
                end;

                if ("Interest Calculation Method" = "interest calculation method"::"Reducing Balance") or ("Interest Calculation Method" = "interest calculation method"::"Reducing Flat") then begin
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.01, '=');
                    LInterest := ROUND(Months / 12 * LBalance * InterestRate / IntDen / 100, 0.01, '=');
                    TotalMRepay := LPrincipal + LInterest;
                end;


                if LoanType.Get("Loan Product Type") then begin
                    if LoanType."Appraisal Parameter Type" = LoanType."appraisal parameter type"::"Staff Salary" then begin

                        TestField("Annual Interest %");
                        TestField(Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := ("Approved Amount" * InterestRate * Installments) / (200 * InterestRate * Installments);
                        Repayment := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;
                end;


                if PrincipalStartDate <> 0D then
                    if RunDate < PrincipalStartDate then
                        LPrincipal := 0;


                if InterestStartDate <> 0D then
                    if RunDate < InterestStartDate then
                        LInterest := 0;

                if InstalNo = 0 then begin
                    LPrincipal := 0;
                    //Repayment Frequency
                    if "Repayment Frequency" = "repayment frequency"::Daily then
                        RunDate := CalcDate('-1D', RunDate)
                    else
                        if "Repayment Frequency" = "repayment frequency"::Weekly then
                            RunDate := CalcDate('-1W', RunDate)
                        else
                            if "Repayment Frequency" = "repayment frequency"::Monthly then
                                RunDate := CalcDate('-1M', RunDate)
                            else
                                if "Repayment Frequency" = "repayment frequency"::Quarterly then
                                    RunDate := CalcDate('-1Q', RunDate)
                                else
                                    if "Repayment Frequency" = "repayment frequency"::"Bi-Annual" then
                                        RunDate := CalcDate('-6M', RunDate)
                                    else
                                        if "Repayment Frequency" = "repayment frequency"::Yearly then
                                            RunDate := CalcDate('-1Y', RunDate)
                                        else
                                            if "Repayment Frequency" = "repayment frequency"::Bonus then begin
                                                RunDate := CalcDate('-1Y', RunDate);
                                            end;
                end;

                LBalance := LBalance - LPrincipal;

                Evaluate(RepayCode, Format(InstalNo));



                LSchedule.Init;
                LSchedule."Line No." := InstalNo;
                LSchedule."Loan No." := "Loan No.";
                LSchedule."Loan Amount" := LoanAmount;
                LSchedule."Repayment Date" := RunDate;
                LSchedule."Monthly Repayment" := LInterest + LPrincipal;
                LSchedule."Monthly Interest" := LInterest;
                LSchedule."Monthly Principal" := LPrincipal;
                LSchedule."Loan Balance" := LBalance;
                LSchedule.Insert;

                "Completion Date" := LSchedule."Repayment Date";


                //Repayment Frequency
                if "Repayment Frequency" = "repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if "Repayment Frequency" = "repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if "Repayment Frequency" = "repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if "Repayment Frequency" = "repayment frequency"::Quarterly then
                                RunDate := CalcDate('1Q', RunDate)
                            else
                                if "Repayment Frequency" = "repayment frequency"::"Bi-Annual" then
                                    RunDate := CalcDate('6M', RunDate)
                                else
                                    if "Repayment Frequency" = "repayment frequency"::Yearly then
                                        RunDate := CalcDate('1Y', RunDate)
                                    else
                                        if "Repayment Frequency" = "repayment frequency"::Bonus then begin
                                            RunDate := CalcDate('1Y', RunDate);
                                        end;

                InstalNo := InstalNo + 1;

            until LBalance < 1;


            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", "Loan No.");
            LSchedule.SetFilter("Monthly Principal", '>0');
            if LSchedule.FindFirst then begin
                "Loan Interest Repayment" := LSchedule."Monthly Interest";
                "Loan Principle Repayment" := LSchedule."Monthly Principal";
                Repayment := LSchedule."Monthly Repayment";
            end;
            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", "Loan No.");
            LSchedule.SetFilter("Monthly Principal", '>0');
            if LSchedule.FindLast() then begin
                if "Completion Date" <> LSchedule."Repayment Date" then
                    "Completion Date" := LSchedule."Repayment Date";
            end;

            Modify;
        end;
    end;



    procedure GenerateAppraisalRepaymentSchedule(Loans: Record "Member Salary Appraisal")
    var
        LSchedule: Record "Loan Repayment Schedule";
        QCounter: Integer;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        GrPrinciple: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrInterest: Decimal;
        RepayCode: Code[10];
        TInterest: Decimal;
        IntDen: Integer;
        DisbDay: Integer;
        Months: Integer;
        BonusDate: Date;
        CheckDate: Date;
        DisbDate: Date;
        LoanType: Record "Product Setup";
        InitDF: DateFormula;
        PrincipalStartDate: Date;
        InterestStartDate: Date;
        RepDate: Date;
    begin

        with Loans do begin

            //Delete schedule
            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", "Appraisal No.");
            LSchedule.DeleteAll;


            DisbDate := Today;

            LoanAmount := "Recommended Amount";
            InterestRate := "Annual Interest %";
            RepayPeriod := Period;
            InitialInstal := Period;
            LBalance := "Requested Amount";
            //RunDate:="Repayment Start Date";
            RunDate := DisbDate;

            PrincipalStartDate := 0D;
            InterestStartDate := 0D;
            LoanType.Get("Loan Product Type");

            InstalNo := 0;

            IntDen := 12;

            InstalNo := 1;


            repeat


                Months := 12;


                if LoanType."Interest Calculation Method" = LoanType."interest calculation method"::Amortised then begin
                    if "Annual Interest %" = 0 then
                        LoanType."Interest Calculation Method" := LoanType."interest calculation method"::"Reducing Balance"

                end;

                if (LoanType."Interest Calculation Method" = LoanType."Interest Calculation Method"::Amortised) then begin
                    TestField("Annual Interest %");
                    TestField(Period);

                    TotalMRepay := ROUND((InterestRate / IntDen / 100) / (1 - Power((1 + (InterestRate / IntDen / 100)), -(RepayPeriod))) * (LoanAmount), 0.01, '=');
                    LInterest := ROUND(Months / 12 * LBalance * InterestRate / IntDen / 100, 0.01, '=');
                    LPrincipal := TotalMRepay - LInterest;
                end;

                if (LoanType."Interest Calculation Method" = LoanType."Interest Calculation Method"::"Straight Line") then begin
                    TestField(Period);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.01, '=');
                    LInterest := ROUND(LoanAmount * InterestRate / IntDen / 100, 0.01, '=');
                    TotalMRepay := LPrincipal + LInterest;
                end;

                if (LoanType."Interest Calculation Method" = LoanType."Interest Calculation Method"::"Reducing Balance") or (LoanType."Interest Calculation Method" = LoanType."Interest Calculation Method"::"Reducing Flat") then begin
                    TestField(Period);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.01, '=');
                    LInterest := ROUND(Months / 12 * LBalance * InterestRate / IntDen / 100, 0.01, '=');
                    TotalMRepay := LPrincipal + LInterest;
                end;


                if LoanType.Get("Loan Product Type") then begin
                    if LoanType."Appraisal Parameter Type" = LoanType."appraisal parameter type"::"Staff Salary" then begin

                        TestField("Annual Interest %");
                        TestField(Period);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := ("Requested Amount" * InterestRate * Period) / (200 * InterestRate * Period);
                        //Repayment := LPrincipal + LInterest;
                        //"Loan Principle Repayment" := LPrincipal;
                        //"Loan Interest Repayment" := LInterest;
                    end;
                end;


                if PrincipalStartDate <> 0D then
                    if RunDate < PrincipalStartDate then
                        LPrincipal := 0;


                if InterestStartDate <> 0D then
                    if RunDate < InterestStartDate then
                        LInterest := 0;

                if InstalNo = 0 then begin
                    LPrincipal := 0;
                    RunDate := CalcDate('-1M', RunDate);
                end;

                LBalance := LBalance - LPrincipal;

                Evaluate(RepayCode, Format(InstalNo));



                LSchedule.Init;
                LSchedule."Line No." := InstalNo;
                LSchedule."Loan No." := "Appraisal No.";
                LSchedule."Loan Amount" := LoanAmount;
                LSchedule."Repayment Date" := RunDate;
                LSchedule."Monthly Repayment" := LInterest + LPrincipal;
                LSchedule."Monthly Interest" := LInterest;
                LSchedule."Monthly Principal" := LPrincipal;
                LSchedule."Loan Balance" := LBalance;
                LSchedule.Insert;


                //Repayment Frequency
                RunDate := CalcDate('1M', RunDate);

                InstalNo := InstalNo + 1;

            until LBalance < 1;


            "Interest Repayment" := LSchedule."Monthly Interest";
            "Principal Repayment" := LSchedule."Monthly Principal";
            "Monthly Repayment" := LSchedule."Monthly Repayment";


            Modify;
        end;
    end;

    procedure GetDefaultedAmount(LoanNo: Code[20]; AsAt: Date; var ExpectedAmt: Decimal; var AmtPaid: Decimal; var DefAmount: Decimal; var DaysInArrear: Integer; var ArrearsDate: Date; CurrentPayment: Boolean)
    var
        Loans: Record Loans;
        LSchedule: Record "Loan Repayment Schedule";
        LastDate: Date;
        TRep: Decimal;
    begin

        ExpectedAmt := 0;
        AmtPaid := 0;
        DefAmount := 0;
        DaysInArrear := 0;

        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        if CurrentPayment then
            Loans.SetFilter("Date Filter", '..%1', Today)
        else
            Loans.SetFilter("Date Filter", '..%1', AsAt);
        if Loans.FindFirst then begin
            Loans.CalcFields("Outstanding Principal");
            AmtPaid := Loans."Approved Amount" - Loans."Outstanding Principal";

            if (Loans."Loan Rescheduled") then begin

                LSchedule.Reset;
                LSchedule.SetRange("Loan No.", Loans."Loan No.");
                //LSchedule.SETFILTER("Monthly Principal",'>%1',0);
                if LSchedule.FindFirst then begin

                    Loans.Reset;
                    Loans.SetRange("Loan No.", LoanNo);
                    if CurrentPayment then
                        Loans.SetFilter("Date Filter", '%1..%2', CalcDate('-CM', LSchedule."Repayment Date"), Today)
                    else
                        Loans.SetFilter("Date Filter", '%1..%2', CalcDate('-CM', LSchedule."Repayment Date"), AsAt);
                    if Loans.FindFirst then begin
                        Loans.CalcFields("Principal Repayment");
                        AmtPaid := Loans."Principal Repayment";
                    end;
                end;
            end;
        end;



        if AmtPaid < 0 then
            AmtPaid := 0;





        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        Loans.SetFilter("Date Filter", '..%1', AsAt);
        if Loans.FindFirst then begin
            Loans.CalcFields("Schedule Principal");
            if Loans."Disbursement Date" = 0D then
                Loans."Disbursement Date" := Loans."Application Date";

            //Loans.TestField("Disbursement Date");

            ExpectedAmt := Loans."Schedule Principal";

            LastDate := Loans."Repayment Start Date";
        end;

        DefAmount := ExpectedAmt - AmtPaid;

        if DefAmount < 0 then
            DefAmount := 0;

        LSchedule.Reset;
        LSchedule.SetRange("Loan No.", Loans."Loan No.");
        LSchedule.SetFilter("Monthly Principal", '>%1', 0);
        if LSchedule.FindFirst then begin
            repeat
                TRep += LSchedule."Monthly Principal";
                if AmtPaid >= TRep then
                    LastDate := LSchedule."Repayment Date";
            until (LSchedule.Next = 0);
        end;

        //MESSAGE('%1',DefAmount);
        if DefAmount > 0 then begin
            ArrearsDate := Loans."Repayment Start Date";
            LSchedule.Reset;
            LSchedule.SetRange("Loan No.", Loans."Loan No.");
            LSchedule.SetFilter("Repayment Date", '%1..', LastDate);
            if LSchedule.FindFirst then
                ArrearsDate := LSchedule."Repayment Date" + 1;

            DaysInArrear := AsAt - ArrearsDate;
            DaysInArrear += 1;
        end;
    end;


    procedure RecoverLoanFromSavingsAccounts(LoanNo: Code[20]; LoanProduct: Code[20]; Defaulter: Boolean; JTransfer: Boolean)
    var
        Loans: Record Loans;
        Interest: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LRepayment: Decimal;
        ProductType: Record "Product Setup";
        j: Integer;
        SkipLoan: Boolean;
        SavAccts: Record Vendor;
        SavingsAccounts: Record Vendor;
        AvailAmount: Decimal;
        DedAmount: Decimal;
        RunBal: Decimal;
        ProductSetup: Record "Product Setup";
        Dim1: Code[20];
        Dim2: Code[20];
        LRec: Record Loans;
        DocNo: Code[20];
        RSchedule: Record "Loan Repayment Schedule";
        SchDate: Date;
        IncomeType: Enum "Repay Mode Enum";
        DepCont: Decimal;
        DepAccount: Code[20];
        SavingsACC: Record Vendor;
        ExpAmt: Decimal;
        AmtPaid: Decimal;
        DefAmt: Decimal;
        DaysDef: Integer;
        ArrearsDate: Date;
    begin


        DocNo := 'RECOVERY';

        ProductSetup.Get(LoanProduct);
        //if ProductSetup."AutoRecovery From Savings" then 
        begin

            GetGeneralJournalTemplate(JTemplate, JBatch);

            for j := 1 to 4 do begin

                Loans.Reset;
                Loans.SetRange("Loan No.", LoanNo);
                Loans.SetFilter("Repayment Start Date", '..%1', Today);
                Loans.SetFilter("Date Filter", '..%1', Today);
                if j = 1 then
                    Loans.SetFilter("Outstanding Penalty", '>0')
                else
                    if j = 2 then
                        Loans.SetFilter("Outstanding Appraisal", '>0')
                    else
                        if j = 3 then
                            Loans.SetFilter("Outstanding Interest", '>0')
                        else
                            if j = 4 then
                                Loans.SetFilter("Outstanding Principal", '>0')
                            else
                                Error('Invalid Code - Programming Error');

                if Defaulter then
                    Loans.SetFilter("Loans Category-SACCO", '%1|%2|%3', Loans."loans category-SACCO"::Substandard, Loans."loans category-SACCO"::Doubtful, Loans."loans category-SACCO"::Loss);

                //Loans.SETFILTER(Source,'<>%1',Loans.Source::MICRO);
                Loans.SetFilter("Disbursement Account No", '<>%1', '');

                if Loans.Find('-') then begin
                    repeat
                        //MESSAGE('2: '+Loans."Loan No.");
                        //MESSAGE('T1');
                        Loans.CalcFields("Outstanding Penalty", "Outstanding Appraisal", "Outstanding Interest", "Outstanding Principal");
                        Loans.CalcFields("Appraisal Fee Paid", "Schedule Appraisal", "Schedule Interest", "Interest Paid");



                        if Loans."Outstanding Penalty" < 0 then
                            Loans."Outstanding Penalty" := 0;
                        if Loans."Outstanding Appraisal" < 0 then
                            Loans."Outstanding Appraisal" := 0;
                        if Loans."Outstanding Interest" < 0 then
                            Loans."Outstanding Interest" := 0;
                        if Loans."Outstanding Principal" < 0 then
                            Loans."Outstanding Principal" := 0;


                        Dim1 := Loans."Global Dimension 1 Code";
                        Dim2 := Loans."Booking Branch";

                        if j = 1 then
                            RunBal := Loans."Outstanding Penalty"
                        else
                            if j = 2 then begin
                                RunBal := Loans."Outstanding Appraisal";
                            end
                            else
                                if j = 3 then begin
                                    RunBal := Loans."Outstanding Interest";
                                end
                                else
                                    if j = 4 then begin
                                        RunBal := 0;
                                        DefAmt := 0;
                                        GetDefaultedAmount(LoanNo, Today, ExpAmt, AmtPaid, DefAmt, DaysDef, ArrearsDate, true);
                                        if DefAmt > 0 then
                                            RunBal := DefAmt;
                                    end
                                    else
                                        RunBal := 0;



                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                        SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Ordinary Savings");
                        SavingsAccounts.SetRange("No.", Loans."Disbursement Account No");
                        if (RunBal > 0) and (SavingsAccounts.FindFirst) then begin
                            repeat

                                if RunBal > 0 then begin

                                    if not JTransfer then
                                        JournalInit(JTemplate, JBatch);

                                    SavingsAccounts."Test Blocked" := SavingsAccounts."test blocked"::" ";
                                    if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then begin
                                        SavingsAccounts."Test Blocked" := SavingsAccounts.Blocked;
                                        SavingsAccounts.Blocked := SavingsAccounts.Blocked::" ";
                                        SavingsAccounts.Modify;
                                    end;

                                    AvailAmount := MemberActivities.GetAccountBalance(SavingsAccounts."No.");

                                    if AvailAmount < 0 then
                                        AvailAmount := 0;

                                    AvailAmount -= GetJournalDebits(JTemplate, JBatch, Accttype::Savings, SavingsAccounts."No.");



                                    if AvailAmount > 0 then begin
                                        DedAmount := RunBal;


                                        if DedAmount > AvailAmount then
                                            DedAmount := AvailAmount;


                                        if DedAmount > 0 then begin
                                            if j = 1 then begin
                                                RecoverLoans(JTemplate, JBatch, DocNo, Today, 'Penalty Recovered', DedAmount, Loans."Loan No.", Transtype::"Penalty Paid", Loans."Member No.", SavingsAccounts."No.", Dim1, Dim2);
                                                RunBal -= DedAmount;
                                            end
                                            else
                                                if j = 2 then begin
                                                    RecoverLoans(JTemplate, JBatch, DocNo, Today, 'Appraisal Recovered', DedAmount, Loans."Loan No.", Transtype::"Appraisal Paid", Loans."Member No.", SavingsAccounts."No.", Dim1, Dim2);
                                                    RunBal -= DedAmount;
                                                end
                                                else
                                                    if j = 3 then begin
                                                        RecoverLoans(JTemplate, JBatch, DocNo, Today, 'Interest Recovered', DedAmount, Loans."Loan No.", Transtype::"Interest Paid", Loans."Member No.", SavingsAccounts."No.", Dim1, Dim2);
                                                        RunBal -= DedAmount;
                                                    end
                                                    else
                                                        if j = 4 then begin
                                                            RecoverLoans(JTemplate, JBatch, DocNo, Today, 'Principle Recovered', DedAmount, Loans."Loan No.", Transtype::"Principal Repayment", Loans."Member No.", SavingsAccounts."No.", Dim1, Dim2);
                                                            RunBal -= DedAmount;
                                                        end;
                                        end;

                                    end;

                                    if not JTransfer then
                                        JournalPost(JTemplate, JBatch);

                                    if SavingsAccounts."Test Blocked" <> SavingsAccounts."test blocked"::" " then begin
                                        SavingsAccounts.Blocked := SavingsAccounts."Test Blocked";
                                        SavingsAccounts."Test Blocked" := SavingsAccounts."test blocked"::" ";
                                        SavingsAccounts.Modify;
                                    end;

                                end;

                            until SavingsAccounts.Next = 0;
                        end;



                    until Loans.Next = 0;
                end;

            end;
        end;
    end;

    local procedure RecoverLoans(Jtemplate: Code[20]; JBatch: Code[20]; DocNo: Code[20]; PDate: Date; Desc: Text[50]; Amount: Decimal; LoanNo: Code[20]; Transaction: Enum "Transaction Type Enum"; LoanAccount: Code[20]; SavAccount: Code[20]; Dim1: Code[20]; Dim2: Code[20])
    var
        LineNo: Integer;
        FosaAcc: Record Vendor;
        LoanRec: Record Loans;
        ProdFact: Record "Product Setup";
    begin

        if FosaAcc.Get(SavAccount) then begin

            JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::Credit, LoanAccount, Desc + ' - From: ' + SavAccount, Accttype::"G/L Account", '', Amount * -1, SavAccount, LoanNo, Transaction, Dim1, Dim2, true);

            JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::Savings, SavAccount, Desc + ' - To: ' + LoanNo, Accttype::"G/L Account", '', Amount, LoanNo, '', Transaction::" ", Dim1, Dim2, true);

        end;
    end;


    procedure LoanRecoveryFromDefaulterSavings(LoanRecovery: Record "Defaulter Loan Recovery")
    var
        ConfMessage: label 'Are you sure you want to recover loan from Deposits and Guarantors';
        Txt0001: label 'Interest Recovery from deposits';
        Txt0003: label 'Principle Recovery from deposits';
        Txt0004: label 'Principle Recovery:-';
        Txt0002: label 'Interest Recovered:-';
        Txt0005: label 'Principle Amount';
        Txt0006: label 'Cleared by Guarantor loan:';
        Txt0007: label 'Bill Recoverd:-';
        Txt0008: label 'Interest Recovery from Savings';
        Txt0009: label 'Principle Recovery from Savings';
        Err001: label 'There are no loan to recover';
        j: Integer;
        Loans: Record Loans;
        UserSetup: Record "User Setup";
    begin

        if (LoanRecovery."Outstanding Interest" = 0)
            and (LoanRecovery."Outstanding Principal" = 0)
            and (LoanRecovery."Outstanding Interest" = 0)
            and (LoanRecovery."Outstanding Principal" = 0) then
            Error(Err001);


        UserSetup.Get(UserId);

        JTemplate := UserSetup."General Journal Template";
        JBatch := UserSetup."General Journal Batch";

        JournalInit(JTemplate, JBatch);

        for j := 1 to 4 do begin

            Loans.Reset;
            Loans.SetCurrentkey("Recovery Priority");
            Loans.SetRange(Loans."Member No.", LoanRecovery."Member No.");

            if LoanRecovery."Recovery Type" = LoanRecovery."recovery type"::"Single Loan" then
                Loans.SetRange("Loan No.", LoanRecovery."Loan No.")
            else
                if LoanRecovery."Recovery Type" = LoanRecovery."recovery type"::" " then
                    Error('Recovery Type Must have a value');

            if j = 1 then
                Loans.SetFilter("Outstanding Penalty", '>0')
            else
                if j = 2 then
                    Loans.SetFilter("Outstanding Appraisal", '>0')
                else
                    if j = 3 then
                        Loans.SetFilter("Outstanding Interest", '>0')
                    else
                        if j = 4 then
                            Loans.SetFilter("Outstanding Principal", '>0')
                        else
                            Error('Invalid Code - Programming Error');

            if Loans.Find('-') then begin
                repeat

                    if j = 1 then
                        DefaulterOffsetLoan(LoanRecovery, Loans, LoanRecovery."No.", LoanRecovery."Posting Date", '', Transtype::"Penalty Paid")
                    else
                        if j = 2 then
                            DefaulterOffsetLoan(LoanRecovery, Loans, LoanRecovery."No.", LoanRecovery."Posting Date", '', Transtype::"Appraisal Paid")
                        else
                            if j = 3 then
                                DefaulterOffsetLoan(LoanRecovery, Loans, LoanRecovery."No.", LoanRecovery."Posting Date", '', Transtype::"Interest Paid")
                            else
                                if j = 4 then
                                    DefaulterOffsetLoan(LoanRecovery, Loans, LoanRecovery."No.", LoanRecovery."Posting Date", '', Transtype::"Principal Repayment")
                                else
                                    Error('Invalid Code - Programming Error');


                until Loans.Next = 0;
            end;



        end;//For j

        JournalPost(JTemplate, JBatch);

        Message('Recovered Successfully');
    end;


    procedure DefaulterOffsetLoan(LoanRecoveryHeader: Record "Defaulter Loan Recovery"; LoanRec: Record Loans; DocNo: Code[20]; Pdate: Date; ExtDocNo: Code[20]; TransactionType: Enum "Transaction Type Enum")
    var
        Desc: Text[50];
        ConfMessage: label 'Are you sure you want to recover loan from Deposits and Guarantors';
        AvailAmount: Decimal;
        AmountToRecover: Decimal;
        TotGuaranteed: Decimal;
        RunBal: Decimal;
        IntBalance: Decimal;
        PrinBalance: Decimal;
        Loans: Record Loans;
        LGuarantors: Record "Loan Security";
        SavingsAccounts: Record Vendor;
        ShorttermAcc: Code[25];
        LongtermAcc: Code[25];
        LineNo: Integer;
        Txt0001: label 'Interest Recovery from deposits';
        Txt0003: label 'Principle Recovery from deposits';
        Txt0004: label 'Principle Recovery:-';
        Txt0002: label 'Interest Recovered:-';
        JnlAmt: Decimal;
        LoanAllocation: Decimal;
        ExistPac: Boolean;
        ProductFactory: Record "Product Setup";
        AcctNo: Code[25];
        CreditAccounts: Record Customer;
        NewLoans: Record Loans;
        Txt0005: label 'Principle Amount';
        Txt0006: label 'Cleared by Guarantor loan:';
        CreditAcc: Code[20];
        RecoveryLines: Record "Defaulter Recovery Lines";
        CountNo: Integer;
        Dim1: Code[20];
        Dim2: Code[20];
        UserSetup: Record "User Setup";
        LoansLoop: Record Loans;
        LoanAmount: Decimal;
        GurAmount: Decimal;
        LoanAmountBal: Decimal;
        Members: Record Customer;
        Txt0007: label 'Bill Recoverd:-';
        ProdFac: Record "Product Setup";
        SavingsAcc: Code[20];
        SavingsAmt: Decimal;
        Txt0008: label 'Interest Recovery from Savings';
        Txt0009: label 'Principle Recovery from Savings';
        TotalRecoveryAmount: Decimal;
        Err001: label 'There are no loan to recover';
        ProductSetup: Record "Product Setup";
        LoanSched: Record "Loan Repayment Schedule";
        MonthRepay: Decimal;
        Install: Integer;
        TotalBalanceLoan: Decimal;
        NoLoop: Integer;
        LoanAllocationT: Decimal;
        AccountTypes: Record "Product Setup";
        GuarantorAmount: Decimal;
        Skip: Boolean;
    begin

        UserSetup.Get(UserId);

        JTemplate := UserSetup."General Journal Template";
        JBatch := UserSetup."General Journal Batch";
        Dim1 := UserSetup."Global Dimension 1 Code";
        Dim2 := UserSetup."Global Dimension 2 Code";


        LoanRec.CalcFields("Outstanding Principal", "Outstanding Appraisal", "Outstanding Interest", "Outstanding Penalty");
        LoanRec.CalcFields("Total Outstanding Balance");

        if LoanRec."Outstanding Appraisal" < 0 then
            LoanRec."Outstanding Appraisal" := 0;

        if LoanRec."Outstanding Interest" < 0 then
            LoanRec."Outstanding Interest" := 0;




        if TransactionType = Transactiontype::"Penalty Paid" then
            AmountToRecover := LoanRec."Outstanding Penalty";

        if TransactionType = Transactiontype::"Appraisal Paid" then begin
            AmountToRecover := LoanRec."Outstanding Appraisal";
        end;

        if TransactionType = Transactiontype::"Interest Paid" then begin
            AmountToRecover := LoanRec."Outstanding Interest";
        end;

        if TransactionType = Transactiontype::"Principal Repayment" then
            AmountToRecover := LoanRec."Outstanding Principal";


        with LoanRec do begin

            if AmountToRecover > 0 then begin


                if LoanRecoveryHeader."Recovery Option" = LoanRecoveryHeader."recovery option"::"Recover from Single Account" then begin


                    //Check share balance
                    if (AmountToRecover > 0) then begin
                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange(SavingsAccounts."No.", LoanRecoveryHeader."Source Account");
                        if SavingsAccounts.Find('-') then begin

                            AvailAmount := MemberActivities.GetAccountBalance(SavingsAccounts."No.");
                            AvailAmount := LoanRecoveryHeader."Amount to Recover";
                            AvailAmount -= GetJournalDebits(JTemplate, JBatch, Accttype::Savings, SavingsAccounts."No.");

                            if AvailAmount > 0 then begin

                                JnlAmt := AmountToRecover;

                                if JnlAmt > AvailAmount then
                                    JnlAmt := AvailAmount;

                                Desc := CopyStr(Format(TransactionType) + ' Loan Recovery - ' + "Loan Product Type", 1, 50);
                                JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Savings, SavingsAccounts."No.", Desc, Balaccttype::"G/L Account", '', JnlAmt, ExtDocNo, '', Transactiontype::" ", Dim1, Dim2, true);

                                Desc := CopyStr(Format(TransactionType) + ' Loan Recovery - ' + SavingsAccounts."Product Type", 1, 50);
                                JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Credit, "Member No.", Desc, Balaccttype::"G/L Account", '', -JnlAmt, ExtDocNo, "Loan No.", TransactionType, Dim1, Dim2, true);


                                AvailAmount -= JnlAmt;
                                AmountToRecover -= JnlAmt;

                                LoanRec."Recovered from Savings" := true;
                                LoanRec.Modify;
                            end;

                        end;
                    end;



                end
                else
                    if LoanRecoveryHeader."Recovery Option" = LoanRecoveryHeader."recovery option"::"Recover from Multiple Accounts" then begin
                        Skip := true;

                        ProductSetup.Reset;
                        ProductSetup.SetRange("Can Offset Loan", true);
                        ProductSetup.SetRange("Product Class", ProductSetup."product class"::Savings);
                        if (LoanRecoveryHeader."Recovery Source" = LoanRecoveryHeader."recovery source"::"Defaulter Withdrawable Savings") then begin
                            ProductSetup.SetRange("Savings Type", ProductSetup."savings type"::Withdrawable);
                            Skip := false;
                        end;
                        if (LoanRecoveryHeader."Recovery Source" = LoanRecoveryHeader."recovery source"::"Defaulter Non-Withdrawable Deposits") then begin
                            ProductSetup.SetRange("Savings Type", ProductSetup."savings type"::"Non-Withdrawable");
                            Skip := false;
                        end;

                        if (ProductSetup.Find('-')) and (not Skip) then begin
                            repeat
                                //Check share balance
                                if (AmountToRecover > 0) then begin
                                    SavingsAccounts.Reset;
                                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
                                    SavingsAccounts.SetRange(SavingsAccounts."Product Type", ProductSetup."Product ID");
                                    if SavingsAccounts.Find('-') then begin
                                        repeat
                                            AvailAmount := MemberActivities.GetAccountBalance(SavingsAccounts."No.");
                                            AvailAmount -= GetJournalDebits(JTemplate, JBatch, Accttype::Savings, SavingsAccounts."No.");

                                            if AvailAmount > 0 then begin

                                                JnlAmt := AmountToRecover;

                                                if JnlAmt > AvailAmount then
                                                    JnlAmt := AvailAmount;

                                                Desc := CopyStr(Format(TransactionType) + ' Defaulter Recovery - ' + "Loan Product Type", 1, 50);
                                                JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Savings, SavingsAccounts."No.", Desc, Balaccttype::"G/L Account", '', JnlAmt, ExtDocNo, '', Transactiontype::" ", Dim1, Dim2, true);

                                                Desc := CopyStr(Format(TransactionType) + ' Defaulter Recovery - ' + ProductSetup.Description, 1, 50);
                                                JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Credit, "Member No.", Desc, Balaccttype::"G/L Account", '', -JnlAmt, ExtDocNo, "Loan No.", TransactionType, Dim1, Dim2, true);


                                                AvailAmount -= JnlAmt;
                                                AmountToRecover -= JnlAmt;

                                            end;
                                        until SavingsAccounts.Next = 0;
                                    end;
                                end;
                            until ProductSetup.Next = 0;
                        end;

                        //Guarantor Recovery
                        if (LoanRecoveryHeader."Recovery Source" = LoanRecoveryHeader."recovery source"::"Guarantor Withdrawable Savings") or
                            (LoanRecoveryHeader."Recovery Source" = LoanRecoveryHeader."recovery source"::"Guarantor Non-Withdrawable Deposits") then begin

                            RecoveryLines.Reset;
                            RecoveryLines.SetRange("Header No.", LoanRecoveryHeader."No.");
                            RecoveryLines.SetFilter("Amount to Recover", '>0');
                            if RecoveryLines.Find('-') then begin
                                repeat
                                    GuarantorAmount := RecoveryLines."Amount to Recover";


                                    ProductSetup.Reset;
                                    ProductSetup.SetRange("Product Class", ProductSetup."product class"::Savings);
                                    if (LoanRecoveryHeader."Recovery Source" = LoanRecoveryHeader."recovery source"::"Guarantor Withdrawable Savings") then begin
                                        ProductSetup.SetRange("Savings Type", ProductSetup."savings type"::Withdrawable);
                                    end;
                                    if (LoanRecoveryHeader."Recovery Source" = LoanRecoveryHeader."recovery source"::"Guarantor Non-Withdrawable Deposits") then begin
                                        ProductSetup.SetRange("Savings Type", ProductSetup."savings type"::"Non-Withdrawable");
                                    end;
                                    ProductSetup.SetRange("Can Offset Loan", true);
                                    if ProductSetup.Find('-') then begin
                                        repeat
                                            //Check share balance
                                            if (AmountToRecover > 0) then begin

                                                SavingsAccounts.Reset;
                                                SavingsAccounts.SetRange(SavingsAccounts."Member No.", RecoveryLines."Guarantor Member No.");
                                                SavingsAccounts.SetRange(SavingsAccounts."Product Type", ProductSetup."Product ID");
                                                if SavingsAccounts.Find('-') then begin
                                                    repeat
                                                        AvailAmount := MemberActivities.GetAccountBalance(SavingsAccounts."No.");

                                                        AvailAmount -= GetJournalDebits(JTemplate, JBatch, Accttype::Savings, SavingsAccounts."No.");
                                                        GuarantorAmount -= GetJournalDebits(JTemplate, JBatch, Accttype::Savings, SavingsAccounts."No.");

                                                        if AvailAmount > GuarantorAmount then
                                                            AvailAmount := GuarantorAmount;


                                                        if AvailAmount > 0 then begin

                                                            JnlAmt := AmountToRecover;

                                                            if JnlAmt > AvailAmount then
                                                                JnlAmt := AvailAmount;

                                                            Desc := CopyStr(Format(TransactionType) + ' Defaulter Recovery - ' + "Loan Product Type", 1, 50);
                                                            JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Savings, SavingsAccounts."No.", Desc, Balaccttype::"G/L Account",
                                                            '', JnlAmt, ExtDocNo, '', Transactiontype::" ", Dim1, Dim2, true);

                                                            Desc := CopyStr(Format(TransactionType) + ' Defaulter Recovery - ' + ProductSetup.Description, 1, 50);
                                                            JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Credit, "Member No.", Desc, Balaccttype::"G/L Account", '', -JnlAmt,
                                                            ExtDocNo, "Loan No.", TransactionType, Dim1, Dim2, true);

                                                            AvailAmount -= JnlAmt;
                                                            AmountToRecover -= JnlAmt;
                                                            GuarantorAmount -= JnlAmt;

                                                        end;
                                                    until SavingsAccounts.Next = 0;
                                                end;
                                            end;
                                        until ProductSetup.Next = 0;
                                    end;

                                until RecoveryLines.Next = 0;
                            end
                            else
                                Error('Nothing to Post. Amount to Recover not Captured');

                        end;

                    end;


            end;
        end;
    end;


    procedure DefaulterLoanDisbursement(LoanRecovery: Record "Defaulter Loan Recovery"; LoanRec: Record Loans; DocNo: Code[20]; Pdate: Date; ExtDocNo: Code[20])
    var
        TransactionType: Enum "Transaction Type Enum";
        Desc: Text[50];
        ConfMessage: label 'Are you sure you want to recover loan from Deposits and Guarantors';
        AvailAmount: Decimal;
        AmountToRecover: Decimal;
        TotGuaranteed: Decimal;
        RunBal: Decimal;
        IntBalance: Decimal;
        PrinBalance: Decimal;
        Loans: Record Loans;
        LGuarantors: Record "Loan Security";
        SavingsAccounts: Record Vendor;
        ShorttermAcc: Code[25];
        LongtermAcc: Code[25];
        LineNo: Integer;
        Txt0001: label 'Interest Recovery from deposits';
        Txt0003: label 'Principle Recovery from deposits';
        Txt0004: label 'Principle Recovery:-';
        Txt0002: label 'Interest Recovered:-';
        JnlAmt: Decimal;
        LoanAllocation: Decimal;
        ExistPac: Boolean;
        ProductFactory: Record "Product Setup";
        AcctNo: Code[25];
        CreditAccounts: Record Customer;
        NewLoans: Record Loans;
        Txt0005: label 'Principle Amount';
        Txt0006: label 'Cleared by Guarantor loan:';
        CreditAcc: Code[20];
        RecoveryLines: Record "Defaulter Recovery Lines";
        CountNo: Integer;
        Dim1: Code[20];
        Dim2: Code[20];
        UserSetup: Record "User Setup";
        LoansLoop: Record Loans;
        LoanAmount: Decimal;
        GurAmount: Decimal;
        LoanAmountBal: Decimal;
        Members: Record Customer;
        Txt0007: label 'Bill Recoverd:-';
        ProdFac: Record "Product Setup";
        SavingsAcc: Code[20];
        SavingsAmt: Decimal;
        Txt0008: label 'Interest Recovery from Savings';
        Txt0009: label 'Principle Recovery from Savings';
        TotalRecoveryAmount: Decimal;
        Err001: label 'There are no loan to recover';
        ProductSetup: Record "Product Setup";
        LoanSched: Record "Loan Repayment Schedule";
        MonthRepay: Decimal;
        Install: Integer;
        TotalBalanceLoan: Decimal;
        NoLoop: Integer;
        LoanAllocationT: Decimal;
        AccountTypes: Record "Product Setup";
        GuarantorAmount: Decimal;
        TotalLoanRecovery: Decimal;
        AmountRecovered: Decimal;
    begin

        UserSetup.Get(UserId);

        JTemplate := UserSetup."General Journal Template";
        JBatch := UserSetup."General Journal Batch";
        Dim1 := UserSetup."Global Dimension 1 Code";
        Dim2 := UserSetup."Global Dimension 2 Code";


        LoanRec.CalcFields("Outstanding Principal", "Outstanding Appraisal", "Outstanding Interest", "Outstanding Penalty");
        if LoanRec."Outstanding Appraisal" < 0 then
            LoanRec."Outstanding Appraisal" := 0;
        if LoanRec."Outstanding Penalty" < 0 then
            LoanRec."Outstanding Penalty" := 0;
        if LoanRec."Outstanding Interest" < 0 then
            LoanRec."Outstanding Interest" := 0;
        if LoanRec."Outstanding Principal" < 0 then
            LoanRec."Outstanding Principal" := 0;


        TotalLoanRecovery := LoanRec."Outstanding Appraisal" + LoanRec."Outstanding Penalty" + LoanRec."Outstanding Interest" + LoanRec."Outstanding Principal";


        with LoanRec do begin

            Members.Get("Member No.");
            MemberActivities.SendSms(Smssource::"Loan defaulted", Members."Mobile Phone No.", 'Dear Member, Your loan of ' + Format(TotalLoanRecovery) + 'has been attahed to your guarantors'
                    , "Loan No.", "Disbursement Account No", true, true);

            if TotalLoanRecovery > 0 then begin


                //Guarantor Recovery
                if (LoanRecovery."Recovery Source" = LoanRecovery."recovery source"::"Issue Guarantor Defaulter Loan") then begin

                    LoanRec."Recovered from Guarantors" := true;
                    LoanRec.Modify;

                    AmountRecovered := 0;
                    RecoveryLines.Reset;
                    RecoveryLines.SetRange("Header No.", LoanRecovery."No.");
                    RecoveryLines.SetRange("Loan No.", "Loan No.");
                    RecoveryLines.SetFilter("Loan Allocation", '>0');
                    if RecoveryLines.Find('-') then begin
                        repeat
                            GuarantorAmount := RecoveryLines."Loan Allocation";
                            AmountRecovered := 0;

                            Members.Reset;
                            Members.SetRange("No.", RecoveryLines."Guarantor Member No.");
                            Members.SetRange("Member Status", Members."Member Status"::Active);
                            if Members.FindFirst then begin
                                AmountToRecover := ROUND("Outstanding Appraisal" / TotalLoanRecovery * GuarantorAmount, 0.01, '>');
                                Desc := CopyStr('Appraisal Fee Defaulter Recovery - ' + ProductSetup.Description, 1, 50);
                                JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Credit, "Member No.", Desc, Balaccttype::"G/L Account", '', -AmountToRecover, ExtDocNo, "Loan No.", Transactiontype::"Appraisal Paid", Dim1, Dim2, true);
                                AmountRecovered += AmountToRecover;

                                AmountToRecover := ROUND("Outstanding Penalty" / TotalLoanRecovery * GuarantorAmount, 0.01, '>');
                                Desc := CopyStr('Penalty Defaulter Recovery - ' + ProductSetup.Description, 1, 50);
                                JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Credit, "Member No.", Desc, Balaccttype::"G/L Account", '', -AmountToRecover, ExtDocNo, "Loan No.", Transactiontype::"Penalty Paid", Dim1, Dim2, true);
                                AmountRecovered += AmountToRecover;

                                AmountToRecover := ROUND("Outstanding Interest" / TotalLoanRecovery * GuarantorAmount, 0.01, '>');
                                Desc := CopyStr('Loan Interest Defaulter Recovery - ' + ProductSetup.Description, 1, 50);
                                JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Credit, "Member No.", Desc, Balaccttype::"G/L Account", '', -AmountToRecover, ExtDocNo, "Loan No.", Transactiontype::"Interest Paid", Dim1, Dim2, true);
                                AmountRecovered += AmountToRecover;


                                AmountToRecover := ROUND("Outstanding Principal" / TotalLoanRecovery * GuarantorAmount, 0.01, '>');
                                Desc := CopyStr('Loan Principal Defaulter Recovery - ' + ProductSetup.Description, 1, 50);
                                JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Credit, "Member No.", Desc, Balaccttype::"G/L Account", '', -AmountToRecover, ExtDocNo, "Loan No.", Transactiontype::"Principal Repayment", Dim1, Dim2, true);
                                AmountRecovered += AmountToRecover;



                                LoanAllocation := AmountRecovered;

                                //Get defaulter loan type
                                //Defaulter Loan No creted**
                                ProductSetup.Reset;
                                ProductSetup.SetCurrentkey(ProductSetup."Product ID");
                                ProductSetup.SetRange(ProductSetup."Product Class", ProductSetup."product class"::Credit);
                                ProductSetup.SetRange(ProductSetup."Nature of Loan Type", ProductSetup."nature of loan type"::Defaulter);
                                if ProductSetup.Find('-') then begin

                                    NewLoans.Reset;
                                    NewLoans.SetRange(NewLoans."Member No.", Members."No.");
                                    NewLoans.SetRange(NewLoans."Loan Product Type", ProductSetup."Product ID");
                                    NewLoans.SetRange(NewLoans.Posted, false);
                                    if NewLoans.Find('-') then begin
                                        NewLoans.DeleteAll;
                                        LoanSched.Reset;
                                        LoanSched.SetRange(LoanSched."Loan No.", NewLoans."Loan No.");
                                        if LoanSched.Find('-') then
                                            LoanSched.DeleteAll;
                                    end;


                                    NewLoans.Init;
                                    NewLoans."Loan No." := '';
                                    NewLoans."Member No." := Members."No.";
                                    NewLoans."Member Name" := Members.Name;
                                    NewLoans."Staff No" := Members."Payroll/Staff No.";
                                    NewLoans."Employer Code" := Members."Employer Code";
                                    NewLoans."Application Date" := LoanRecovery."Posting Date";
                                    NewLoans."Loan Product Type" := ProductSetup."Product ID";
                                    NewLoans."Loan Product Type Name" := ProductSetup.Description;
                                    NewLoans."Annual Interest %" := ProductSetup."Interest Rate (Min.)";
                                    NewLoans."Interest Calculation Method" := ProductSetup."Interest Calculation Method";
                                    NewLoans.Source := ProductSetup."Loan Source";

                                    Install := 0;
                                    // Check schedule details
                                    LoanSched.Reset;
                                    LoanSched.SetRange(LoanSched."Loan No.", "Loan No.");
                                    LoanSched.SetFilter("Repayment Date", '%1..', Today);
                                    if LoanSched.FindFirst then begin
                                        Install := LoanSched.Count;
                                    end;

                                    if Install = 0 then
                                        Install := 1;

                                    NewLoans.Installments := Install;
                                    NewLoans."Repayment Frequency" := ProductSetup."Repayment Frequency";
                                    NewLoans."Repay Mode" := ProductSetup."Repay Mode";
                                    NewLoans."Recovery Priority" := ProductSetup."Recovery Priority";

                                    NewLoans."Application Date" := LoanRecovery."Posting Date";
                                    NewLoans."Requested Amount" := LoanAllocation;
                                    NewLoans."Approved Amount" := LoanAllocation;
                                    NewLoans.Validate(NewLoans."Approved Amount");
                                    if NewLoans."Loan Principle Repayment" = 0 then
                                        NewLoans."Loan Principle Repayment" := ROUND(NewLoans."Approved Amount" / NewLoans.Installments, 1, '>');
                                    NewLoans.Status := NewLoans.Status::Approved;
                                    NewLoans."Disbursement Date" := LoanRecovery."Posting Date";
                                    NewLoans."Repayment Start Date" := LoanRecovery."Posting Date";
                                    NewLoans."Recovered Loan" := "Loan No.";
                                    NewLoans."Member No." := "Member No.";
                                    NewLoans."Loan Recovery No." := LoanRecovery."No.";
                                    NewLoans."Advice Type" := NewLoans."advice type"::"New Loan";
                                    NewLoans."Last Advice Date" := Today;
                                    NewLoans.Insert(true);


                                    NewLoans.Reset;
                                    NewLoans.SetRange(NewLoans."Member No.", Members."No.");
                                    NewLoans.SetRange(NewLoans."Loan Product Type", ProductSetup."Product ID");
                                    NewLoans.SetRange(NewLoans.Posted, false);
                                    if NewLoans.Find('-') then begin

                                        Desc := CopyStr('Defaulter Loan Principal - ' + "Loan Product Type", 1, 50);
                                        JournalInsert(JTemplate, JBatch, DocNo, Pdate, Accttype::Credit, NewLoans."Member No.", Desc,
                                            Balaccttype::"G/L Account", '', NewLoans."Approved Amount", ExtDocNo, NewLoans."Loan No.", Transactiontype::"Loan Disbursement", Dim1, Dim2, true);



                                        NewLoans.Posted := true;
                                        NewLoans.Modify;
                                        GenerateRepaymentSchedule(NewLoans);


                                        MemberActivities.SendSms(Smssource::"Defaulter Loan Issued", Members."Mobile Phone No.", 'Dear Member, You have been assigned a Loan of ' + Format(NewLoans."Approved Amount") + ' ' + 'recovered from defaulter: ' +
         "Member Name"
                                             , NewLoans."Loan No.", NewLoans."Disbursement Account No", true, true);

                                    end;
                                end;
                            end;
                        until RecoveryLines.Next = 0;
                    end;

                end;


            end;
        end;
    end;


    procedure LoanRecoveryFromGuarantors(LoanRecovery: Record "Defaulter Loan Recovery")
    var
        ConfMessage: label 'Are you sure you want to recover loan from Deposits and Guarantors';
        Txt0001: label 'Interest Recovery from deposits';
        Txt0003: label 'Principle Recovery from deposits';
        Txt0004: label 'Principle Recovery:-';
        Txt0002: label 'Interest Recovered:-';
        Txt0005: label 'Principle Amount';
        Txt0006: label 'Cleared by Guarantor loan:';
        Txt0007: label 'Bill Recoverd:-';
        Txt0008: label 'Interest Recovery from Savings';
        Txt0009: label 'Principle Recovery from Savings';
        Err001: label 'There are no loan to recover';
        j: Integer;
        Loans: Record Loans;
    begin

        if (LoanRecovery."Outstanding Interest" = 0)
            and (LoanRecovery."Outstanding Principal" = 0)
            and (LoanRecovery."Outstanding Interest" = 0)
            and (LoanRecovery."Outstanding Principal" = 0) then
            Error(Err001);



        UserSetup.Get(UserId);

        JTemplate := UserSetup."General Journal Template";
        JBatch := UserSetup."General Journal Batch";

        JournalInit(JTemplate, JBatch);

        Loans.Reset;
        Loans.SetCurrentkey("Recovery Priority");
        Loans.SetRange(Loans."Member No.", LoanRecovery."Member No.");

        if LoanRecovery."Recovery Type" = LoanRecovery."recovery type"::"Single Loan" then
            Loans.SetRange("Loan No.", LoanRecovery."Loan No.")
        else
            if LoanRecovery."Recovery Type" = LoanRecovery."recovery type"::" " then
                Error('Recovery Type Must have a value');

        Loans.SetFilter("Total Outstanding Balance", '>0');

        if Loans.Find('-') then begin
            repeat
                DefaulterLoanDisbursement(LoanRecovery, Loans, LoanRecovery."No.", LoanRecovery."Posting Date", '')
            until Loans.Next = 0;
        end;

        JournalPost(JTemplate, JBatch);
        Message('Recovered Successfully');
    end;


    procedure LoanRecoveryFromSavings(LoanRecovery: Record "Defaulter Loan Recovery")
    var
        ConfMessage: label 'Are you sure you want to recover loan from Deposits and Guarantors';
        Txt0001: label 'Interest Recovery from deposits';
        Txt0003: label 'Principle Recovery from deposits';
        Txt0004: label 'Principle Recovery:-';
        Txt0002: label 'Interest Recovered:-';
        Txt0005: label 'Principle Amount';
        Txt0006: label 'Cleared by Guarantor loan:';
        Txt0007: label 'Bill Recoverd:-';
        Txt0008: label 'Interest Recovery from Savings';
        Txt0009: label 'Principle Recovery from Savings';
        Err001: label 'There are no loan to recover';
        j: Integer;
        Loans: Record Loans;
    begin

        if (LoanRecovery."Outstanding Interest" = 0)
            and (LoanRecovery."Outstanding Principal" = 0)
            and (LoanRecovery."Outstanding Interest" = 0)
            and (LoanRecovery."Outstanding Principal" = 0) then
            Error(Err001);



        UserSetup.Get(UserId);

        JTemplate := UserSetup."General Journal Template";
        JBatch := UserSetup."General Journal Batch";

        JournalInit(JTemplate, JBatch);


        for j := 1 to 4 do begin

            Loans.Reset;
            Loans.SetCurrentkey("Recovery Priority");
            Loans.SetRange(Loans."Member No.", LoanRecovery."Member No.");

            if LoanRecovery."Recovery Type" = LoanRecovery."recovery type"::"Single Loan" then
                Loans.SetRange("Loan No.", LoanRecovery."Loan No.")
            else
                if LoanRecovery."Recovery Type" = LoanRecovery."recovery type"::" " then
                    Error('Recovery Type Must have a value');

            if j = 1 then
                Loans.SetFilter("Outstanding Penalty", '>0')
            else
                if j = 2 then
                    Loans.SetFilter("Outstanding Appraisal", '>0')
                else
                    if j = 3 then
                        Loans.SetFilter("Outstanding Interest", '>0')
                    else
                        if j = 4 then
                            Loans.SetFilter("Outstanding Principal", '>0')
                        else
                            Error('Invalid Code - Programming Error');

            if Loans.Find('-') then begin
                repeat

                    if j = 1 then
                        DefaulterOffsetLoan(LoanRecovery, Loans, LoanRecovery."No.", LoanRecovery."Posting Date", '', Transtype::"Penalty Paid")
                    else
                        if j = 2 then
                            DefaulterOffsetLoan(LoanRecovery, Loans, LoanRecovery."No.", LoanRecovery."Posting Date", '', Transtype::"Appraisal Paid")
                        else
                            if j = 3 then
                                DefaulterOffsetLoan(LoanRecovery, Loans, LoanRecovery."No.", LoanRecovery."Posting Date", '', Transtype::"Interest Paid")
                            else
                                if j = 4 then
                                    DefaulterOffsetLoan(LoanRecovery, Loans, LoanRecovery."No.", LoanRecovery."Posting Date", '', Transtype::"Principal Repayment")
                                else
                                    Error('Invalid Code - Programming Error');


                until Loans.Next = 0;
            end;



        end;//For j

        JournalPost(JTemplate, JBatch);
        Message('Recovered Successfully');
    end;


    procedure LoanChangesFn(LoanChanges: Record "Loan Changes")
    var
        Loans: Record Loans;
        RSchedule: Record "Loan Repayment Schedule";
        LastCount: Integer;
        InPeriod: DateFormula;
        QCounter: Integer;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[10];
        LoanSch: Record "Loan Repayment Schedule";
        LRepayment: Decimal;
        ProductType: Record "Product Setup";
        PCharges: Record "Loan Product Charges.";
        Amt: Decimal;
        SaccoSetup: Record "Sacco Setup";
        NewLoans: Record Loans;
        Members: Record Customer;
        BUser: Record "User Setup";
        StaggeredLines: Record "Staggered Lines.";
        ChargeCode: Code[20];
        Value: Decimal;
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        Counter: Integer;
        Lines: Integer;
        Desc: Text;
        TCharges: Decimal;
        LoanType: Record "Product Setup";
        LoanSecurity: Record "Loan Security";
        NewLoanSecurity: Record "Loan Security";
    begin
        with LoanChanges do begin
            if Loans.Get(LoanChanges."Loan No.") then begin


                if "Type of Change" = "type of change"::"Debt Collector" then begin
                    Loans."Debt Coll. Date" := Today;
                    "Debt Coll. Date" := Today;
                    Loans."Debt Coll. Def Amount" := "Debt Coll. Def Amount";
                    Loans."Debt Collector Type" := "Debt Collector Type";
                    Loans."Debt Collector" := "Debt Collector";
                    Loans."Debt Collector Name" := "Debt Collector Name";
                    Loans.Modify;
                end else
                    if "Type of Change" = "type of change"::"Stop Interest" then begin
                        Loans."Int Stop Date" := "Rescheduling Date";
                        Loans."Stop Interest Due" := true;
                        Loans.Modify;
                    end else
                        if "Type of Change" = "Type of Change"::"Loan Suspension" then begin
                            Loans."Loan Suspended" := "Loan Suspended";
                            Loans."Loan Suspension Start Date" := "Loan Suspension Start Date";
                            Loans."Loan Suspension End Date" := "Loan Suspension End Date";
                            Loans.Modify();
                        end
                        else
                            if "Type of Change" = "type of change"::"Repay Mode" then begin
                                Loans."Repay Mode" := "New Recovery Mode";
                                Loans.Modify;
                            end
                            else
                                if "Type of Change" = "type of change"::"Interest Rate" then begin


                                    RSchedule.Reset;
                                    RSchedule.SetRange("Loan No.", LoanChanges."No.");
                                    if not RSchedule.FindFirst then begin
                                        LoanSch.Reset;
                                        LoanSch.SetRange("Loan No.", Loans."Loan No.");
                                        if LoanSch.FindFirst then begin
                                            repeat
                                                RSchedule.Init;
                                                RSchedule."Loan No." := LoanChanges."No.";
                                                RSchedule."Repayment Date" := LoanSch."Repayment Date";
                                                RSchedule."Monthly Appraisal" := LoanSch."Monthly Appraisal";
                                                RSchedule."Monthly Interest" := LoanSch."Monthly Interest";
                                                RSchedule."Monthly Principal" := LoanSch."Monthly Principal";
                                                RSchedule."Monthly Repayment" := LoanSch."Monthly Repayment";
                                                RSchedule."Line No." := LoanSch."Line No.";
                                                RSchedule."Loan Amount" := LoanSch."Loan Amount";
                                                RSchedule."Loan Balance" := LoanSch."Loan Balance";
                                                RSchedule.Insert;
                                            until LoanSch.Next = 0;
                                        end;
                                    end;

                                    Loans."Annual Interest %" := "New Interest Rate";
                                    Loans.Modify;

                                end
                                else
                                    if "Type of Change" = "type of change"::"Loan Rescheduling" then begin

                                        BUser.Get(UserId);
                                        BUser.TestField("General Journal Template");
                                        BUser.TestField("General Journal Batch");

                                        JTemplate := BUser."General Journal Template";
                                        JBatch := BUser."General Journal Batch";
                                        RSchedule.Reset;
                                        RSchedule.SetRange("Loan No.", LoanChanges."No.");
                                        if not RSchedule.FindFirst then begin
                                            LoanSch.Reset;
                                            LoanSch.SetRange("Loan No.", Loans."Loan No.");
                                            if LoanSch.FindFirst then begin
                                                repeat
                                                    RSchedule.Init;
                                                    RSchedule."Loan No." := LoanChanges."No.";
                                                    RSchedule."Repayment Date" := LoanSch."Repayment Date";
                                                    RSchedule."Monthly Appraisal" := LoanSch."Monthly Appraisal";
                                                    RSchedule."Monthly Interest" := LoanSch."Monthly Interest";
                                                    RSchedule."Monthly Principal" := LoanSch."Monthly Principal";
                                                    RSchedule."Monthly Repayment" := LoanSch."Monthly Repayment";
                                                    RSchedule."Line No." := LoanSch."Line No.";
                                                    RSchedule."Loan Amount" := LoanSch."Loan Amount";
                                                    RSchedule."Loan Balance" := LoanSch."Loan Balance";
                                                    RSchedule.Insert;
                                                until LoanSch.Next = 0;
                                            end;
                                        end;


                                        JournalInit(JTemplate, JBatch);
                                        SaccoSetup.Get;


                                        if "Type of Change" = "type of change"::"Loan Rescheduling" then begin

                                            if LoanChanges."Rescheduling Type" = LoanChanges."rescheduling type"::"Create New Loan" then begin

                                                Loans.CalcFields("Outstanding Interest", "Outstanding Principal", "Outstanding Appraisal", "Outstanding Penalty", "Total Outstanding Balance");
                                                Members.Get(Loans."Member No.");

                                                NewLoans.Init;
                                                NewLoans."Loan No." := '';
                                                NewLoans."Member No." := Members."No.";
                                                NewLoans."Member Name" := Members.Name;
                                                NewLoans."Staff No" := Members."Payroll/Staff No.";
                                                NewLoans."Employer Code" := Members."Employer Code";
                                                NewLoans."Application Date" := Today;
                                                NewLoans."Loan Product Type" := Loans."Loan Product Type";
                                                NewLoans."Loan Product Type Name" := Loans."Loan Product Type Name";
                                                //NewLoans."Grace Period":=Loans."Grace Period";
                                                NewLoans."Annual Interest %" := Loans."Annual Interest %";
                                                NewLoans."Interest Calculation Method" := Loans."Interest Calculation Method";
                                                NewLoans.Source := Loans.Source;
                                                NewLoans.Installments := LoanChanges."New Installments";
                                                NewLoans."Repayment Frequency" := Loans."Repayment Frequency";
                                                NewLoans."Repay Mode" := Loans."Repay Mode";
                                                NewLoans."Recovery Priority" := Loans."Recovery Priority";
                                                NewLoans."Requested Amount" := LoanChanges."New Loan Amount";//+LoanChanges.Charges;
                                                NewLoans."Approved Amount" := LoanChanges."New Loan Amount";//+LoanChanges.Charges;
                                                NewLoans.Validate(NewLoans."Approved Amount");
                                                NewLoans.Status := NewLoans.Status::Approved;
                                                NewLoans."Disbursement Date" := Today;
                                                NewLoans.Validate("Disbursement Date");
                                                NewLoans."Disbursement Account No" := Loans."Disbursement Account No";
                                                NewLoans.TestField("Disbursement Account No");
                                                NewLoans.Installments := LoanChanges."New Installments";

                                                NewLoans."Last Advice Date" := Today;

                                                NewLoans."Advice Type" := NewLoans."Advice Type"::"New Loan";
                                                NewLoans.Insert(true);

                                                LoanSecurity.Reset;
                                                LoanSecurity.SetRange("Loan No.", Loans."Loan No.");
                                                if LoanSecurity.FindFirst then begin
                                                    repeat
                                                        NewLoanSecurity.Init;
                                                        NewLoanSecurity.TransferFields(LoanSecurity);
                                                        NewLoanSecurity."Loan No." := NewLoans."Loan No.";
                                                        NewLoanSecurity.Insert;
                                                    until LoanSecurity.Next = 0;
                                                end;
                                                JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Savings, NewLoans."Disbursement Account No", 'Loan ' + Format("Charge Type"),
                                                Accttype::"G/L Account", '', -(Loans."Total Outstanding Balance" + LoanChanges.Charges), '', NewLoans."Loan No.", Transtype::" ", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, NewLoans."Member No.", 'Loan ' + Format("Charge Type"),
                                                Accttype::"G/L Account", '', Loans."Total Outstanding Balance" + LoanChanges.Charges, '', NewLoans."Loan No.", Transtype::"Loan Disbursement", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Savings, NewLoans."Disbursement Account No", 'Loan ' + Format("Charge Type") + ': Loan Clearance - ' + LoanChanges."Loan No.",
                                                Accttype::"G/L Account", '', Loans."Total Outstanding Balance", '', NewLoans."Loan No.", Transtype::" ", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);


                                                if Loans."Outstanding Interest" < 0 then
                                                    Loans."Outstanding Interest" := 0;

                                                JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, Loans."Member No.", 'Cleared By ' + Format("Charge Type"),
                                                Accttype::"G/L Account", '', -Loans."Outstanding Principal", '', Loans."Loan No.", Transtype::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, Loans."Member No.", 'Cleared By ' + Format("Charge Type"),
                                                Accttype::"G/L Account", '', -Loans."Outstanding Interest", '', Loans."Loan No.", Transtype::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, Loans."Member No.", 'Cleared By ' + Format("Charge Type"),
                                                Accttype::"G/L Account", '', -Loans."Outstanding Penalty", '', Loans."Loan No.", Transtype::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, Loans."Member No.", 'Cleared By ' + Format("Charge Type"),
                                                Accttype::"G/L Account", '', -Loans."Outstanding Appraisal", '', Loans."Loan No.", Transtype::"Appraisal Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);


                                                NewLoans.Posted := true;


                                                NewLoans.Installments := "New Installments";
                                                NewLoans."Reschedule by" := UserId;
                                                if "Charge Type" = "charge type"::Reschedule then
                                                    NewLoans."Loan Rescheduled" := true;
                                                if "Charge Type" = "charge type"::Restructure then
                                                    NewLoans."Loan Restructured" := true;
                                                NewLoans."Loan Principle Repayment" := ROUND(RSchedule."Monthly Principal", 0.01, '>');
                                                NewLoans.Repayment := ROUND(RSchedule."Monthly Repayment", 0.01, '>');
                                                NewLoans."Adjusted Repayment" := "Adjusted Repayment";

                                                NewLoans.Modify;
                                                GenerateRepaymentSchedule(NewLoans);

                                                LoanChanges.Processed := true;
                                                LoanChanges."Rescheduling Date" := Today;
                                                LoanChanges.Modify;

                                                //ERROR('Inst %1',NewLoans.Installments);
                                            end
                                            else begin

                                                GenerateNewLoanSchedule(LoanChanges);

                                                RSchedule.Reset;
                                                RSchedule.SetRange("Loan No.", Loans."Loan No.");
                                                if RSchedule.FindFirst then begin

                                                    Loans.Installments := "New Installments";
                                                    Loans."Reschedule by" := UserId;


                                                    Loans."Loan Rescheduled" := true;

                                                    if "Charge Type" = "charge type"::Reschedule then
                                                        Loans."Loan Rescheduled" := true;
                                                    if "Charge Type" = "charge type"::Restructure then
                                                        Loans."Loan Restructured" := true;

                                                    Loans
                                                    ."Old Repayment" := Loans.Repayment;
                                                    Loans."Loan Principle Repayment" := ROUND(RSchedule."Monthly Principal", 0.01, '>');
                                                    Loans.Repayment := ROUND(RSchedule."Monthly Repayment", 0.01, '>');
                                                    Loans."Adjusted Repayment" := "Adjusted Repayment";

                                                    Loans."Last Advice Date" := Today;
                                                    Loans."Advice Type" := Loans."Advice Type"::Adjustment;
                                                    Loans.Modify;
                                                end
                                                else
                                                    Error('Schedule Not Generated');

                                                LoanChanges.Processed := true;
                                                LoanChanges."Rescheduling Date" := Today;
                                                LoanChanges.Modify;

                                            end;

                                            TCharges := 0;
                                            if "Charge Type" = "charge type"::Reschedule then begin
                                                ChargeCode := SaccoSetup."Loan Rescheduling Fee";
                                                Value := "Total Outstanding";
                                                ChargeAmt := 0;
                                                ChargeDuty := 0;
                                                Counter := 1;
                                                Lines := 1;
                                                while Counter <= Lines do begin

                                                    MemberActivities.GetGeneralChargeAmountWithCounter(ChargeCode, Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, Counter, Lines, Desc);

                                                    if ChargeAmt > 0 then begin

                                                        JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::"G/L Account", ChargeAcct, Desc,
                                                        Accttype::"G/L Account", '', -ChargeAmt, '', Loans."Loan No.", Transtype::" ", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                        TCharges += ChargeAmt;

                                                        SaccoSetup.TestField("Excise Duty GL");
                                                        SaccoSetup.TestField("Excise Duty (%)");


                                                        JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::"G/L Account", SaccoSetup."Excise Duty GL", Desc + '-Excise Duty',
                                                        Accttype::"G/L Account", '', -ChargeDuty, '', Loans."Loan No.", Transtype::" ", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                        TCharges += ChargeDuty;

                                                    end;


                                                    JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, Loans."Member No.", 'Loan ' + Format("Charge Type"),
                                                    Accttype::"G/L Account", '', TCharges, '', Loans."Loan No.", Transtype::"Loan Disbursement", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                    Loans.CalcFields("Outstanding Interest", "Outstanding Penalty");

                                                    if "New Interest Due" > 0 then begin
                                                        LoanType.Get(Loans."Loan Product Type");
                                                        JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, Loans."Member No.", 'Interest Due: ' + Format("Charge Type"),
                                                         Accttype::"G/L Account", LoanType."Loan Interest Income [G/L]", "New Interest Due", '', Loans."Loan No.", Transtype::"Interest Due", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                                    end;
                                                    Loans."Outstanding Interest" += "New Interest Due";

                                                    if Loans."Outstanding Interest" > 0 then begin
                                                        JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, Loans."Member No.", 'Loan Interest Transfer' + Format("Charge Type"),
                                                        Accttype::"G/L Account", '', Loans."Outstanding Interest", '', Loans."Loan No.", Transtype::"Loan Disbursement", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                                        JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, Loans."Member No.", 'Loan Interest Transfer' + Format("Charge Type"),
                                                        Accttype::"G/L Account", '', -Loans."Outstanding Interest", '', Loans."Loan No.", Transtype::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                                    end;

                                                    if Loans."Outstanding Penalty" > 0 then begin
                                                        JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, Loans."Member No.", 'Loan Penalty Transfer' + Format("Charge Type"),
                                                        Accttype::"G/L Account", '', Loans."Outstanding Penalty", '', Loans."Loan No.", Transtype::"Loan Disbursement", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                                        JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Credit, Loans."Member No.", 'Loan Penalty Transfer' + Format("Charge Type"),
                                                        Accttype::"G/L Account", '', -Loans."Outstanding Penalty", '', Loans."Loan No.", Transtype::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                                    end;

                                                end;


                                            end;

                                            if "Charge Type" = "charge type"::Restructure then begin
                                                ChargeCode := SaccoSetup."Loan Restructure Fee";
                                                Value := "Total Outstanding";
                                                ChargeAmt := 0;
                                                ChargeDuty := 0;
                                                Counter := 1;
                                                Lines := 1;
                                                TCharges := 0;
                                                while Counter <= Lines do begin

                                                    MemberActivities.GetGeneralChargeAmountWithCounter(ChargeCode, Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, Counter, Lines, Desc);

                                                    if ChargeAmt > 0 then begin

                                                        JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Savings, Loans."Disbursement Account No", Desc,
                                                        Accttype::"G/L Account", ChargeAcct, ChargeAmt, '', Loans."Loan No.", Transtype::" ", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                        TCharges += ChargeAmt;

                                                        SaccoSetup.TestField("Excise Duty GL");
                                                        SaccoSetup.TestField("Excise Duty (%)");
                                                        JournalInsert(JTemplate, JBatch, LoanChanges."No.", Today, Accttype::Savings, Loans."Disbursement Account No", Desc + '-Excise Duty',
                                                        Accttype::"G/L Account", SaccoSetup."Excise Duty GL", ChargeDuty, '', Loans."Loan No.", Transtype::" ", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                        TCharges += ChargeDuty;

                                                    end;



                                                end;

                                            end;


                                        end;

                                        JournalPost(JTemplate, JBatch);
                                        //MESSAGE('%1\%2',JTemplate,JBatch);
                                    end;
            end;
        end;
    end;


    procedure GenerateNewLoanSchedule(LoanChanges: Record "Loan Changes")
    var
        RSchedule: Record "Loan Repayment Schedule";
        QCounter: Integer;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        GrPrinciple: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrInterest: Decimal;
        RepayCode: Code[10];
        TInterest: Decimal;
        LoanRec: Record Loans;
        Day: Integer;
        Month: Integer;
        Year: Integer;
    begin
        LoanRec.Get(LoanChanges."Loan No.");



        with LoanRec do begin

            CalcFields("Total Outstanding Balance");

            //Delete schedule
            RSchedule.Reset;
            RSchedule.SetRange(RSchedule."Loan No.", "Loan No.");
            //RSchedule.SETFILTER("Repayment Date",'%1..',CALCDATE('-CM',LoanRescheduling."Rescheduling Date"));
            RSchedule.DeleteAll;



            TestField("Disbursement Date");
            TestField("Repayment Start Date");

            Day := Date2dmy("Disbursement Date", 1);
            Month := Date2dmy(LoanChanges."Rescheduling Date", 2);
            Year := Date2dmy(LoanChanges."Rescheduling Date", 3);
            LoanAmount := LoanChanges."New Loan Amount";
            InterestRate := "Annual Interest %";
            RepayPeriod := LoanChanges."New Installments";
            InitialInstal := RepayPeriod;
            LBalance := LoanAmount;
            RunDate := CalcDate('1M', LoanChanges."Rescheduling Date");//DMY2DATE(Day,Month,Year);


            InstalNo := 0;

            //Repayment Frequency

            repeat
                InstalNo := InstalNo + 1;
                if "Interest Calculation Method" = "interest calculation method"::Amortised then begin
                    if "Annual Interest %" = 0 then
                        "Interest Calculation Method" := "interest calculation method"::"Reducing Balance";
                end;
                //kma

                if "Interest Calculation Method" = "interest calculation method"::Amortised then begin
                    TestField("Annual Interest %");
                    TestField(Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.01, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.01, '>');
                    LPrincipal := TotalMRepay - LInterest;
                end;

                if "Interest Calculation Method" = "interest calculation method"::"Straight Line" then begin
                    //TESTFIELD(Interest);
                    TestField(Installments);
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 12 / 100) * LoanAmount;
                    TotalMRepay := LPrincipal + LInterest;
                end;

                if ("Interest Calculation Method" = "interest calculation method"::"Reducing Balance") or ("Interest Calculation Method" = "interest calculation method"::"Reducing Flat") then begin
                    // TESTFIELD(Interest);
                    TestField(Installments);
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.01, '>');
                    TotalMRepay := LPrincipal + LInterest;
                end;


                LBalance := LBalance - LPrincipal;


                Evaluate(RepayCode, Format(InstalNo));

                RSchedule.Init;
                RSchedule."Line No." := InstalNo;
                RSchedule."Loan No." := "Loan No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Loan Balance" := LBalance;
                RSchedule."Repayment Date" := RunDate;
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Monthly Principal" := LPrincipal;
                RSchedule.Insert;



                //Repayment Frequency
                if "Repayment Frequency" = "repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if "Repayment Frequency" = "repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if "Repayment Frequency" = "repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if "Repayment Frequency" = "repayment frequency"::Quarterly then
                                RunDate := CalcDate('1Q', RunDate)
                            else
                                if "Repayment Frequency" = "repayment frequency"::"Bi-Annual" then
                                    RunDate := CalcDate('6M', RunDate)
                                else
                                    if "Repayment Frequency" = "repayment frequency"::Yearly then
                                        RunDate := CalcDate('1Y', RunDate)
                                    else
                                        if "Repayment Frequency" = "repayment frequency"::Bonus then begin
                                            RunDate := CalcDate('1Y', RunDate);
                                        end;

            until LBalance < 1;

        end;
    end;

    local procedure VerifyLoanDuplumRule(Loan: Record Loans; AsAt: Date; InterestAmount: Decimal) SkipLoan: Boolean
    var
        SaccoSetup: Record "Sacco Setup";
        ODateFormula: DateFormula;
    begin
        SkipLoan := false;
        SaccoSetup.Get();
        SaccoSetup.TestField("Duplum Interest Period");
        if (SaccoSetup."Duplum Interest Period" <> ODateFormula) then begin
            Loan.SetFilter("Date Filter", '..%1', AsAt);
            Loan.CalcFields("Last Int. Due Date", "Outstanding Interest", "Outstanding Principal");
            SkipLoan := ((Loan."Outstanding Interest" + InterestAmount) > Loan."Outstanding Principal");
            if not SkipLoan then begin
                if Loan."Last Int. Due Date" <> 0D then
                    SkipLoan := CalcDate(SaccoSetup."Duplum Interest Period", Loan."Last Int. Due Date") < AsAt;
            end;
        end;

    end;

    procedure GenerateLoanMonthlyInterest(LoanNo: Code[20]; BDate: Date; PDate: Date)
    var
        Loans: Record Loans;
        LoanType: Record "Product Setup";
        LineNo: Integer;
        DocNo: Code[20];
        "Document No.": Code[20];
        LoansInterest: Record "Loan Interest Buffer";
        LoanAmount: Decimal;
        CustMember: Record Customer;
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        AlreadyPostedErr: label 'This transaction Is Already posted';
        Memb: Record Customer;
        InterestAmount: Decimal;
        BalDate: Date;
        MemberAccounts: Record Vendor;
        SkipLoan: Boolean;
        SaccoSetup: Record "Sacco Setup";
    begin


        //BalDate:=CALCDATE('-1M+CM',BDate);
        BalDate := BDate;

        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        Loans.SetFilter("Date Filter", '..%1', BalDate);
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.FindSet() then begin
            repeat


                Loans.CalcFields("Loans Category-SASRA");

                begin
                    if LoanType.Get(Loans."Loan Product Type") then begin

                        InterestAmount := ROUND(GetInterestAmount(Loans."Loan No.", BDate, false), 0.01, '>');

                        SkipLoan := VerifyLoanDuplumRule(Loans, BDate, InterestAmount);

                        if not SkipLoan then begin

                            LoansInterest.Reset;
                            LoansInterest.SetRange("Loan No.", Loans."Loan No.");
                            LoansInterest.SetRange("Interest Date", BDate);
                            //LoansInterest.SETRANGE(Reversed,FALSE);
                            if LoansInterest.FindFirst then begin
                                if (LoansInterest.Posted) and (LoansInterest.Reversed = false) then
                                    InterestAmount := 0
                                else
                                    LoansInterest.Delete;
                            end;



                            if InterestAmount > 0 then begin
                                Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");

                                LoansInterest.Init;
                                LoansInterest."Loan No." := Loans."Loan No.";
                                LoansInterest."Account Type" := LoansInterest."account type"::Credit;
                                LoansInterest."Account No" := Loans."Member No.";
                                LoansInterest."Interest Date" := BDate;
                                LoansInterest."Issued Date" := Loans."Disbursement Date";
                                LoansInterest."Interest Amount" := InterestAmount;
                                LoansInterest."Posting Date" := PDate;
                                LoansInterest.Description := 'Interest Due' + ' ' + CopyStr(Format(BDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(BDate, 3));
                                ;
                                LoansInterest."Global Dimension 1 Code" := Loans."Global Dimension 1 Code";
                                LoansInterest."Global Dimension 2 Code" := Loans."Booking Branch";
                                LoansInterest."Loan Product type" := Loans."Loan Product Type";

                                LoanType.TestField("Loan Interest Income [G/L]");
                                LoansInterest."Bal. Account No." := LoanType."Loan Interest Income [G/L]";


                                if CustMember.Get(Loans."Member No.") then begin
                                    LoansInterest.Status := CustMember.Status;
                                    LoansInterest.Blocked := CustMember.Blocked;
                                end;

                                LoansInterest."Outstanding Balance" := Loans."Outstanding Principal";
                                LoansInterest."Outstanding Interest" := Loans."Outstanding Interest";
                                LoansInterest.Insert;
                            end;
                        end;
                    end;
                end;
            until Loans.Next = 0;
        end;
    end;


    procedure GetInterestAmount(LoanNo: Code[20]; IntDate: Date; CheckExistingBill: Boolean): Decimal
    var
        LoanRec: Record Loans;
        CLedger: Record "Cust. Ledger Entry";
        RSchedule: Record "Loan Repayment Schedule";
        LastDate: Date;
        IntAmount: Decimal;
        LoanBalance: Decimal;
        BalDate: Date;
        Days: Integer;
        TDays: Integer;
        ProductSetup: Record "Product Setup";
        SaccoSetup: Record "Sacco Setup";
    begin

        BalDate := IntDate;

        LoanRec.Get(LoanNo);
        ProductSetup.Get(LoanRec."Loan Product Type");

        LoanRec.Reset;
        LoanRec.SetRange("Loan No.", LoanNo);
        LoanRec.SetFilter("Date Filter", '..%1', BalDate);
        LoanRec.SetFilter("Outstanding Principal", '<=0');
        if LoanRec.FindFirst then
            exit(0);


        if CheckExistingBill then begin
            CLedger.Reset;
            CLedger.SetRange("Loan No.", LoanNo);
            CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Interest Due");
            CLedger.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', IntDate), CalcDate('CM', IntDate));
            //CLedger.SETFILTER("Posting Date",'%1..%2',20180608D,CALCDATE('CM',IntDate));
            CLedger.SetFilter(Amount, '>0');
            CLedger.SetRange(Reversed, false);
            if CLedger.FindFirst then
                exit(0);
        end;


        RSchedule.Reset;
        RSchedule.SetRange("Loan No.", LoanRec."Loan No.");
        RSchedule.SetFilter("Monthly Principal", '>0');
        if not RSchedule.FindFirst then
            GenerateRepaymentSchedule(LoanRec);

        /*
        RSchedule.RESET;
        RSchedule.SETRANGE("Loan No.",LoanRec."Loan No.");
        RSchedule.SETFILTER("Monthly Principal",'>0');
        IF NOT RSchedule.FINDFIRST THEN
            ERROR('Loan Schedule for Loan No. %1 does not exist',LoanNo);
        */


        SaccoSetup.Get;

        LoanBalance := 0;
        IntAmount := 0;




        LoanRec.Reset;
        LoanRec.SetRange("Loan No.", LoanNo);
        LoanRec.SetFilter("Date Filter", '..%1', BalDate);
        if LoanRec.FindFirst then begin
            LoanRec.CalcFields("Outstanding Principal", "Outstanding Interest");

            if SaccoSetup."Calc. Loan Interest On" = SaccoSetup."calc. loan interest on"::"Principal Only" then
                LoanBalance := LoanRec."Outstanding Principal"
            else
                if SaccoSetup."Calc. Loan Interest On" = SaccoSetup."calc. loan interest on"::"Principal plus Outstanding Interest" then
                    LoanBalance := LoanRec."Outstanding Principal" + LoanRec."Outstanding Interest";

            if LoanBalance < 0 then
                LoanBalance := 0;

            IntAmount := LoanBalance * LoanRec."Annual Interest %" / 1200;

            if SaccoSetup."Calc. Loan Interest On" = SaccoSetup."calc. loan interest on"::"User Defined Interest Amount" then
                IntAmount := LoanRec."Loan Interest Repayment";

            if LoanRec."Interest Calculation Method" = LoanRec."interest calculation method"::"Straight Line" then
                IntAmount := LoanRec."Approved Amount" * LoanRec."Annual Interest %" / 1200;


            /*
            IF LoanRec."Disbursement Date" >= CALCDATE('-CM',BalDate) THEN BEGIN
                IF LoanRec."Disbursement Date" <= CALCDATE('CM',BalDate) THEN BEGIN
                    Days := DATE2DMY(LoanRec."Disbursement Date",1);
                    TDays := DATE2DMY(CALCDATE('CM',LoanRec."Disbursement Date"),1);
                    IntAmount := ROUND(IntAmount * (TDays-Days)/TDays);
                END;
            END;
            */

        end;


        if LoanRec."Outstanding Principal" <= LoanRec."Outstanding Interest" + IntAmount then
            IntAmount := 0;

        if IntAmount < 0 then
            IntAmount := 0;



        exit(IntAmount);

    end;


    procedure GetLoanRePaymentDate(Loans: Record Loans; Date: Date) RepayDate: Date
    var
        d: Integer;
        m: Integer;
        y: Integer;
        EndMonth: Date;
        RepDay: Integer;
        SDate: Date;
        ProductSetup: Record "Product Setup";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        if Date = 0D then
            Error('Invalid Date for this parameter');

        EndMonth := CalcDate('CM', Date);
        RepDay := Date2dmy(EndMonth, 1);

        SDate := CalcDate('1M', Loans."Disbursement Date");


        ProductSetup.Get(Loans."Loan Product Type");
        if CalcDate('CM', Loans."Disbursement Date") = CalcDate('CM', Date) then begin
            if ProductSetup."Interest Due on Disbursement" = ProductSetup."interest due on disbursement"::" " then
                Date := SDate;
        end;


        d := Date2dmy(SDate, 1);

        if (Loans."Loan Rescheduled") or (Loans."Loan Restructured") then begin
            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
            LoanRepaymentSchedule.SetFilter("Repayment Date", '<>%1', 0D);
            if LoanRepaymentSchedule.FindFirst then
                if LoanRepaymentSchedule."Repayment Date" <> 0D then
                    d := Date2dmy(LoanRepaymentSchedule."Repayment Date", 1);
        end;


        m := Date2dmy(Date, 2);
        y := Date2dmy(Date, 3);

        if d > RepDay then
            d := RepDay;

        RepayDate := Dmy2date(d, m, y);
    end;


    procedure GenerateDivdends(MemberNo: Code[20]; StartDate: Date; EndDate: Date; TaxExempt: Boolean)
    var
        GrossDiv: Decimal;
        WTaxDiv: Decimal;
        NetDiv: Decimal;
        FromDate: Date;
        ToDate: Date;
        EntrNo: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
        timProgress: Time;
        intProgressI: Integer;
        intProgressTotal: Integer;
        Members: Record Customer;
        Savings: Record Vendor;
        Counter1: Integer;
        Counter2: Integer;
        GrossDividend: Decimal;
        i: Integer;
        DivLines: Record "Dividends Progression";
        ProductSetup: Record "Product Setup";
        DateFilter: Text;
        MAccounts: Record Vendor;
        IntPass: Integer;
    begin

        //ERROR('%1\%2',StartDate,EndDate);

        DivLines.Reset;
        DivLines.SetRange(DivLines."End Date", CalcDate('-1D', StartDate), EndDate);
        DivLines.SetRange("Member No", MemberNo);
        if DivLines.Find('-') then
            DivLines.DeleteAll;

        ProductSetup.Reset;
        ProductSetup.SetFilter(ProductSetup."Product Class", '%1', ProductSetup."product class"::Savings);
        ProductSetup.SetFilter(ProductSetup."Dividend Calc. Method", '<>%1', ProductSetup."dividend calc. method"::" ");
        if ProductSetup.Find('-') then begin
            repeat

                Savings.Reset;
                Savings.SetRange(Savings."Product Type", ProductSetup."Product ID");
                Savings.SetRange("Member No.", MemberNo);
                if Savings.Find('-') then begin


                    case ProductSetup."Dividend Calc. Method" of

                        ProductSetup."dividend calc. method"::"Flat Rate":
                            begin
                                DateFilter := '..' + Format(EndDate);
                                MAccounts.Reset;
                                MAccounts.SetRange("No.", Savings."No.");
                                MAccounts.SetFilter("Date Filter", DateFilter);
                                if MAccounts.FindFirst then begin
                                    MAccounts.CalcFields("Balance (LCY)");
                                    GrossDiv := (ProductSetup."Interest Rate (Min.)" / 100) * MAccounts."Balance (LCY)";
                                    WTaxDiv := GrossDiv * (ProductSetup."WithHolding Tax" / 100);
                                    if TaxExempt then
                                        WTaxDiv := 0;
                                    NetDiv := GrossDiv - WTaxDiv;
                                    //MESSAGE('%1',GrossDiv);
                                    CreateDivLines(
                                        MAccounts."No.",
                                        Today,
                                        MAccounts."Product Type",
                                        MAccounts."Product Name",
                                        MAccounts."Member No.",
                                        MAccounts."Balance (LCY)",
                                        MAccounts."Balance (LCY)",
                                        GrossDiv,
                                        WTaxDiv,
                                        NetDiv,
                                        StartDate,
                                        EndDate,
                                        ProductSetup."Dividend Calc. Method"
                                        );

                                end;
                            end;

                        ProductSetup."dividend calc. method"::Prorated:
                            begin
                                ToDate := CalcDate('-1D', StartDate);
                                FromDate := 0D;
                                if ProductSetup."Product Category" = ProductSetup."product category"::"Deposit Contribution" then
                                    IntPass := 0
                                else
                                    IntPass := 1;

                                CalculateProratedDividends(Savings."No.", 12, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 11, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 10, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 9, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 8, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 7, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 6, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 5, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 4, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 3, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 2, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);
                                CalculateProratedDividends(Savings."No.", 1, ProductSetup."Interest Rate (Min.)", ProductSetup."WithHolding Tax", TaxExempt, ProductSetup."Dividend Calc. Method", FromDate, ToDate, IntPass);

                            end;
                    end;
                end;
            until ProductSetup.Next = 0;
        end;
    end;


    procedure CreateDivLines(AccountNo: Code[20]; Date: Date; ProductID: Code[20]; ProductName: Text; MemberNo: Code[20]; QualifyingShares: Decimal; Shares: Decimal; GrossDiv: Decimal; WTax: Decimal; NetDiv: Decimal; StartDate: Date; EndDate: Date; DivMethod: Option " ","Flat Rate",Prorated)
    var
        FAcc: Record Vendor;
        Cust: Record Customer;
        DivLines: Record "Dividends Progression";
    begin

        DivLines.Init;
        DivLines."Account No" := AccountNo;
        DivLines."Processing Date" := Today;
        DivLines."Product Type" := ProductID;
        DivLines."Product Name" := ProductName;
        DivLines."Member No" := MemberNo;
        DivLines."Qualifying Shares" := QualifyingShares;
        DivLines.Shares := Shares;
        DivLines."Gross Dividends" := GrossDiv;
        DivLines."Witholding Tax" := WTax;
        DivLines."Net Dividends" := NetDiv;
        DivLines."Start Date" := StartDate;
        DivLines."End Date" := EndDate;
        DivLines."Dividend Calc. Method" := DivMethod;
        DivLines.Insert;
    end;

    local procedure CalculateProratedDividends(AccNo: Code[20]; i: Integer; divRate: Decimal; taxRate: Decimal; TaxExempt: Boolean; DivMethod: Option " ","Flat Rate",Prorated; var FromDate: Date; var ToDate: Date; ipass: Integer)
    var
        MAccounts: Record Vendor;
        DateFilter: Text;
        GrossDiv: Decimal;
        WTaxDiv: Decimal;
        NetDiv: Decimal;
        QualShares: Decimal;
        Shares: Decimal;
        Impo: Record MemberBalancesFromOld;
    begin

        //if i = 8 then
        DateFilter := '..' + Format(ToDate);
        //else
        //  DateFilter := Format(FromDate) + '..' + Format(ToDate);

        MAccounts.Reset;
        MAccounts.SetRange("No.", AccNo);
        MAccounts.SetFilter("Date Filter", DateFilter);
        if MAccounts.FindFirst then begin

            MAccounts.CalcFields("Old Member No.");

            if (i = 10000) then begin

                Impo.Reset;
                Impo.SetRange(Impo.MNo, MAccounts."Old Member No.");
                if Impo.Find('-') then begin
                    if i = 12 then begin
                        if ipass = 0 then
                            Shares := Impo.DecDepo
                        else
                            Shares := Impo.DecShare;

                        QualShares := Shares * i / 12;

                        GrossDiv := (divRate / 100) * QualShares;
                        WTaxDiv := GrossDiv * (taxRate / 100);
                        if TaxExempt then
                            WTaxDiv := 0;
                        NetDiv := GrossDiv - WTaxDiv;

                    end
                    else
                        if i = 11 then begin
                            if ipass = 0 then
                                Shares := Impo.JanDepo
                            else
                                Shares := Impo.JanShare;

                            QualShares := Shares * i / 12;

                            GrossDiv := (divRate / 100) * QualShares;
                            WTaxDiv := GrossDiv * (taxRate / 100);
                            if TaxExempt then
                                WTaxDiv := 0;
                            NetDiv := GrossDiv - WTaxDiv;
                        end
                        else
                            if i = 10 then begin
                                if ipass = 0 then
                                    Shares := Impo.FebDepo
                                else
                                    Shares := Impo.FebShare;

                                QualShares := Shares * i / 12;

                                GrossDiv := (divRate / 100) * QualShares;
                                WTaxDiv := GrossDiv * (taxRate / 100);
                                if TaxExempt then
                                    WTaxDiv := 0;
                                NetDiv := GrossDiv - WTaxDiv;
                            end
                            else
                                if i = 9 then begin
                                    if ipass = 0 then
                                        Shares := Impo.MarDepo
                                    else
                                        Shares := Impo.MarShare;

                                    QualShares := Shares * i / 12;

                                    GrossDiv := (divRate / 100) * QualShares;
                                    WTaxDiv := GrossDiv * (taxRate / 100);
                                    if TaxExempt then
                                        WTaxDiv := 0;
                                    NetDiv := GrossDiv - WTaxDiv;
                                end;
                end;
            end
            else begin
                MAccounts.CalcFields("Net Change (LCY)");
                Shares := MAccounts."Net Change (LCY)";
                QualShares := Shares * 1 / 12;

                GrossDiv := (divRate / 100) * QualShares;
                WTaxDiv := GrossDiv * (taxRate / 100);
                if TaxExempt then
                    WTaxDiv := 0;
                NetDiv := GrossDiv - WTaxDiv;
            end;

            CreateDivLines(
                MAccounts."No.",
                Today,
                MAccounts."Product Type",
                MAccounts."Product Name",
                MAccounts."Member No.",
                QualShares,
                Shares,
                GrossDiv,
                WTaxDiv,
                NetDiv,
                FromDate,
                ToDate,
                DivMethod
                );

        end;


        FromDate := CalcDate('1M-CM', ToDate);
        ToDate := CalcDate('CM', FromDate);
    end;


    procedure GenerateDividendPostingBuffer(MemberNo: Code[20]; DivYear: Integer; DivAcc: Code[20]; GlobalDim1: Code[10]; GlobalDim2: Code[10]; PDate: Date)
    var
        DivLines: Record "Dividends Progression";
        Instructions: Record "Dividend Instructions";
        DedAmt: Decimal;
        Savings: Record Vendor;
        RunBal: Decimal;
        DivProduct: Record "Product Setup";
        SCapitalDiff: Decimal;
        TopupShares: label 'Topup Share Capital :-';
        DividendEarned: label 'Dividend Earned :-';
        DividendDeductions: label 'Dividend Deductions :-';
        LoanInterest: label 'Loan Interest :-';
        LoanBills: label 'Loan Bill :-';
        LoanPrincipal: label 'Loan Principal :-';
        Loans: Record Loans;
        InterestonLoan: Decimal;
        PrincipalonLoan: Decimal;
        Defaulter: Boolean;
        DividendInstructionsExists: Boolean;
        DivPosting: Record "Dividend Posting";
        EntrNo: Integer;
        Members: Record Customer;
        TransactionCharge: label 'Transaction Charge :-';
        ExciseDuty: label 'Excise Duty :-';
        diaProgress: Dialog;
        intProgress: Integer;
        timProgress: Time;
        intProgressI: Integer;
        intProgressTotal: Integer;
        GeneratepostLines: label 'Create Posting Lines :';
        TotalNetAmount: Decimal;
        SavAccts: Record Vendor;
        Year: Integer;
        DocNo: Code[20];
        WTax: Decimal;
        NetAmt: Decimal;
        j: Integer;
        LnDefAmt: Decimal;
        DivCap: Decimal;
        TGross: Decimal;
        DividendSMSCharge: Decimal;
        ProductSetup: Record "Product Setup";
        GrossAmount: Decimal;
        SaccoSetup: Record "Sacco Setup";
        TCharge: Record "Transaction Charges";
        SMSCharges: Record "SMS Charges";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
    begin

        DivPosting.Reset;
        DivPosting.SetRange("Member No.", MemberNo);
        DivPosting.SetRange(Posted, false);
        if DivPosting.Find('-') then
            DivPosting.DeleteAll;


        DivPosting.Reset;
        if DivPosting.FindLast then
            EntrNo := DivPosting."Entry No.";


        Members.Reset;
        Members.SetFilter(Members."No.", MemberNo);
        if Members.FindFirst then begin

            RunBal := 0;
            DocNo := '';
            TGross := 0;


            ProductSetup.Reset;
            ProductSetup.SetFilter("Dividend Calc. Method", '<>%1', ProductSetup."dividend calc. method"::" ");
            if ProductSetup.FindFirst then begin
                //MESSAGE('RUnBal %1',RunBal);
                repeat


                    DivLines.Reset;
                    DivLines.SetRange(DivLines."Member No", Members."No.");
                    DivLines.SetRange("Product Type", ProductSetup."Product ID");
                    if DivLines.Find('-') then begin

                        DocNo := 'DIV ' + Format(DivYear);

                        DivLines.CalcSums(DivLines."Net Dividends", DivLines."Gross Dividends", DivLines."Witholding Tax");
                        DivLines."Dividend Account" := DivAcc;

                        if DivAcc = '' then
                            Error('Dividend Account not found for Member No. %1', MemberNo);

                        GrossAmount := ROUND(DivLines."Gross Dividends", 0.01, '=');
                        TGross += GrossAmount;
                        WTax := ROUND(DivLines."Witholding Tax", 0.01, '=');
                        NetAmt := ROUND(DivLines."Net Dividends", 0.01, '=');


                        ProductSetup.TestField("Interest Payable Account");
                        ProductSetup.TestField("Withholding Tax Account");

                        //+++++++++++++++++++++++++++++++++++++++++++++++++++PAYABLE DIV--

                        EntrNo += 1;
                        DivPosting.Init;
                        DivPosting."Entry No." := EntrNo;
                        DivPosting."Posting Date" := PDate;
                        DivPosting."Document No." := DocNo;
                        DivPosting."Account Type" := DivPosting."account type"::Savings;
                        DivPosting."Account No." := DivLines."Dividend Account";
                        DivPosting.Description := CopyStr('Dividend Gross Pay: ' + ProductSetup.Description, 1, 50); //*
                        DivPosting."Member No." := Members."No.";
                        DivPosting.Amount := -GrossAmount;
                        DivPosting."Debit Amount" := 0;
                        DivPosting."Credit Amount" := GrossAmount;
                        DivPosting."Bal. Account Type" := DivPosting."bal. account type"::"G/L Account";
                        DivPosting."Bal. Account No." := ProductSetup."Interest Payable Account";
                        DivPosting."Product Type Name" := ProductSetup.Description;
                        DivPosting.Transaction := DivPosting.Transaction::Gross;
                        DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                        DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                        if DivPosting.Amount <> 0 then
                            DivPosting.Insert;
                        RunBal += DivPosting.Amount * -1;
                        //MESSAGE('RUnBal %1\AmtDed_Add %2',RunBal,DivPosting.Amount);

                        EntrNo += 1;
                        DivPosting.Init;
                        DivPosting."Entry No." := EntrNo;
                        DivPosting."Posting Date" := Today;
                        DivPosting."Document No." := DocNo;
                        DivPosting."Account Type" := DivPosting."account type"::Savings;
                        DivPosting."Account No." := DivLines."Dividend Account";
                        DivPosting.Description := CopyStr('Dividend WTax: ' + ProductSetup.Description, 1, 50); //*
                        DivPosting."Member No." := Members."No.";
                        DivPosting.Amount := WTax;
                        DivPosting."Debit Amount" := WTax;
                        DivPosting."Credit Amount" := 0;
                        DivPosting."Bal. Account Type" := DivPosting."bal. account type"::"G/L Account";
                        DivPosting."Bal. Account No." := ProductSetup."Withholding Tax Account";
                        DivPosting."Product Type Name" := ProductSetup.Description;
                        DivPosting.Transaction := DivPosting.Transaction::Tax;
                        DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                        DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                        if DivPosting.Amount <> 0 then
                            DivPosting.Insert;
                        RunBal -= DivPosting.Amount;
                        //MESSAGE('RUnBal %1\AmtDed_Add %2',RunBal,DivPosting.Amount);

                    end;


                until ProductSetup.Next = 0;
            end;


            if RunBal > 0 then begin

                SaccoSetup.Get;
                if SaccoSetup."Dividend Charge" = SaccoSetup."dividend charge"::"Use General Charge" then begin

                    TCharge.Reset;
                    TCharge.SetRange(Code, SaccoSetup."Dividend Processing Charge");
                    if TCharge.Find('-') then begin
                        Value := TGross;
                        ChargeAmt := 0;
                        ChargeDuty := 0;
                        ChargeAcctType := Chargeaccttype::"G/L Account";
                        ChargeAcct := '';
                        SharingAmt := 0;
                        SharingChargeAcct := '';
                        SharingChargeAcctType := Sharingchargeaccttype::"G/L Account";
                        SharingDuty := 0;
                        MemberActivities.GetGeneral_SharingChargeAmount(TCharge.Code, Value, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);
                        TotalCharge := ChargeAmt + SharingAmt;
                        TotalDuty := ChargeDuty + SharingDuty;


                        if (RunBal > (TotalCharge + TotalDuty)) and (TotalCharge > 0) then begin

                            EntrNo += 1;
                            DivPosting.Init;
                            DivPosting."Entry No." := EntrNo;
                            DivPosting."Posting Date" := Today;
                            DivPosting."Document No." := DocNo;
                            DivPosting."Account Type" := DivPosting."account type"::Savings;
                            DivPosting."Account No." := DivAcc;
                            DivPosting.Description := 'Dividend Processing Charges';
                            DivPosting."Member No." := Members."No.";
                            DivPosting.Amount := TotalCharge;
                            DivPosting."Debit Amount" := TotalCharge;
                            DivPosting."Credit Amount" := 0;
                            DivPosting."Bal. Account Type" := ChargeAcctType;
                            DivPosting."Bal. Account No." := ChargeAcct;
                            DivPosting."Product Type Name" := 'Processing Fee';
                            DivPosting.Transaction := DivPosting.Transaction::"Processing Fee";
                            DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                            DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                            if DivPosting.Amount <> 0 then
                                DivPosting.Insert;
                            RunBal -= DivPosting.Amount;
                            //MESSAGE('RUnBal %1\AmtDed_Add %2',RunBal,DivPosting.Amount);


                            if TotalDuty > 0 then begin
                                EntrNo += 1;
                                DivPosting.Init;
                                DivPosting."Entry No." := EntrNo;
                                DivPosting."Posting Date" := Today;
                                DivPosting."Document No." := DocNo;
                                DivPosting."Account Type" := DivPosting."account type"::Savings;
                                DivPosting."Account No." := DivAcc;
                                DivPosting.Description := 'Dividend Processing Charge Excise Duty';
                                DivPosting."Member No." := Members."No.";
                                DivPosting.Amount := TotalDuty;
                                DivPosting."Debit Amount" := TotalDuty;
                                DivPosting."Credit Amount" := 0;
                                DivPosting."Bal. Account Type" := DivPosting."bal. account type"::"G/L Account";
                                DivPosting."Bal. Account No." := SaccoSetup."Excise Duty GL";
                                DivPosting."Product Type Name" := 'Duty';
                                DivPosting.Transaction := DivPosting.Transaction::"Duty on Processing Fee";
                                DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                if DivPosting.Amount <> 0 then
                                    DivPosting.Insert;
                                RunBal -= DivPosting.Amount;
                                //MESSAGE('RUnBal %1\AmtDed_Add %2',RunBal,DivPosting.Amount);

                            end;
                        end;
                    end;
                end;
            end;


            if RunBal > 0 then begin

                DividendSMSCharge := 0;
                SMSCharges.Reset;
                SMSCharges.SetRange(Source, SMSCharges.Source::Dividend);
                if SMSCharges.FindFirst then begin
                    DividendSMSCharge := SMSCharges."Charge Amount";
                end;

                if (Members."Mobile Phone No." <> '') and (DividendSMSCharge > 0) and (RunBal >= DividendSMSCharge) then begin
                    EntrNo += 1;
                    DivPosting.Init;
                    DivPosting."Entry No." := EntrNo;
                    DivPosting."Posting Date" := Today;
                    DivPosting."Document No." := DocNo;
                    DivPosting."Account Type" := DivPosting."account type"::Savings;
                    DivPosting."Account No." := DivAcc;
                    DivPosting.Description := 'Dividend SMS';
                    DivPosting."Member No." := Members."No.";
                    DivPosting.Amount := DividendSMSCharge;
                    DivPosting."Debit Amount" := DividendSMSCharge;
                    DivPosting."Credit Amount" := 0;
                    DivPosting."Bal. Account Type" := DivPosting."bal. account type"::"G/L Account";
                    DivPosting."Bal. Account No." := SMSCharges."Charge G/L Account";
                    DivPosting."Product Type" := 'SMS';
                    DivPosting."Product Type Name" := 'SMS';
                    DivPosting.Transaction := DivPosting.Transaction::SMS;
                    DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                    DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                    if DivPosting.Amount <> 0 then
                        DivPosting.Insert;
                    RunBal -= DivPosting.Amount;

                end;
            end;


            //Dividend Capitalization
            if (RunBal > 0) and (ProductSetup."Dividend Capitalization %" > 0) then begin

                DivCap := Round(RunBal * ProductSetup."Dividend Capitalization %" / 100);


                if (DivCap > 0) then begin
                    EntrNo += 1;
                    DivPosting.Init;
                    DivPosting."Entry No." := EntrNo;
                    DivPosting."Posting Date" := Today;
                    DivPosting."Document No." := DocNo;
                    DivPosting."Account Type" := DivPosting."account type"::Savings;
                    DivPosting."Account No." := DivAcc;
                    DivPosting.Description := 'Dividend Capitalized';
                    DivPosting."Member No." := Members."No.";
                    DivPosting.Amount := DivCap;
                    DivPosting."Debit Amount" := DivCap;
                    DivPosting."Credit Amount" := 0;
                    DivPosting."Bal. Account Type" := DivPosting."bal. account type"::"G/L Account";
                    DivPosting."Bal. Account No." := '';
                    DivPosting."Product Type" := ProductSetup."Product ID";
                    DivPosting."Product Type Name" := ProductSetup."Product ID";
                    DivPosting.Transaction := DivPosting.Transaction::Capitalized;
                    DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                    DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                    if DivPosting.Amount <> 0 then
                        DivPosting.Insert;
                    RunBal -= DivPosting.Amount;


                    SavAccts.Reset();
                    ;
                    SavAccts.SetRange("Member No.", Members."No.");
                    SavAccts.SetRange("Product Type", ProductSetup."Product ID");
                    if SavAccts.FindFirst() then begin

                        EntrNo += 1;
                        DivPosting.Init;
                        DivPosting."Entry No." := EntrNo;
                        DivPosting."Posting Date" := Today;
                        DivPosting."Document No." := DocNo;
                        DivPosting."Account Type" := DivPosting."account type"::Savings;
                        DivPosting."Account No." := SavAccts."No.";
                        DivPosting.Description := 'Dividend Capitalized';
                        DivPosting."Member No." := Members."No.";
                        DivPosting.Amount := -DivCap;
                        DivPosting."Debit Amount" := 0;
                        DivPosting."Credit Amount" := DivCap;
                        DivPosting."Bal. Account Type" := DivPosting."bal. account type"::"G/L Account";
                        DivPosting."Bal. Account No." := '';
                        DivPosting."Product Type" := ProductSetup."Product ID";
                        DivPosting."Product Type Name" := ProductSetup."Product ID";
                        DivPosting.Transaction := DivPosting.Transaction::Capitalized;
                        DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                        DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                        if DivPosting.Amount <> 0 then
                            DivPosting.Insert;
                    end;
                end;
            end;
            if RunBal > 0 then begin
                //Recover Dividend Advance
                DivProduct.Reset();
                DivProduct.SetRange("Repay Mode", DivProduct."Repay Mode"::Dividends);
                if DivProduct.FindFirst() then
                    for j := 1 to 4 do begin


                        Loans.Reset;
                        Loans.SetRange(Loans."Member No.", Members."No.");
                        Loans.SetFilter("Loan Product Type", DivProduct."Product ID");

                        if j = 1 then
                            Loans.SetFilter("Outstanding Penalty", '>0')
                        else
                            if j = 2 then
                                Loans.SetFilter("Outstanding Appraisal", '>0')
                            else
                                if j = 3 then
                                    Loans.SetFilter("Outstanding Interest", '>0')
                                else
                                    if j = 4 then
                                        Loans.SetFilter("Outstanding Principal", '>0')
                                    else
                                        Error('Invalid Code - Programming Error');

                        if Loans.Find('-') then begin
                            repeat
                                LnDefAmt := 0;
                                if RunBal > 0 then begin
                                    TransType := Transtype::" ";

                                    if j = 1 then begin
                                        Loans.CalcFields("Outstanding Penalty");
                                        LnDefAmt := Loans."Outstanding Penalty";
                                        TransType := Transtype::"Penalty Paid";
                                        if LnDefAmt > RunBal then
                                            LnDefAmt := RunBal;

                                    end
                                    else
                                        if j = 2 then begin
                                            Loans.CalcFields("Outstanding Appraisal");
                                            LnDefAmt := Loans."Outstanding Appraisal";

                                            if LnDefAmt > RunBal then
                                                LnDefAmt := RunBal;
                                            TransType := Transtype::"Appraisal Paid";
                                        end
                                        else
                                            if j = 3 then begin
                                                Loans.CalcFields("Outstanding Interest");
                                                LnDefAmt := Loans."Outstanding Interest";

                                                if LnDefAmt > RunBal then
                                                    LnDefAmt := RunBal;

                                                TransType := Transtype::"Interest Paid";
                                            end
                                            else
                                                if j = 4 then begin

                                                    DefAmount := Loans."Outstanding Principal";
                                                    LnDefAmt := DefAmount;
                                                    if LnDefAmt < 0 then
                                                        LnDefAmt := 0;

                                                    if LnDefAmt > RunBal then
                                                        LnDefAmt := RunBal;
                                                    TransType := Transtype::"Principal Repayment";
                                                end;

                                    //MESSAGE('TransType %1 \LnDefAmt %2\RunBal %3',TransType,LnDefAmt,RunBal);
                                    EntrNo += 1;
                                    DivPosting.Init;
                                    DivPosting."Entry No." := EntrNo;
                                    DivPosting."Posting Date" := Today;
                                    DivPosting."Document No." := DocNo;
                                    DivPosting."Account Type" := DivPosting."account type"::Savings;
                                    DivPosting."Account No." := DivAcc;
                                    DivPosting.Description := CopyStr(Format(TransType) + ' - From Dividends ' + DivAcc + ' LNo:' + Loans."Loan No.", 1, 50); //*
                                    DivPosting."Member No." := Members."No.";
                                    DivPosting.Amount := LnDefAmt;
                                    DivPosting."Debit Amount" := LnDefAmt;
                                    DivPosting."Credit Amount" := 0;
                                    DivPosting."Loan No" := '';
                                    DivPosting."Transaction Type" := DivPosting."transaction type"::" ";
                                    DivPosting."Product Type" := '';
                                    DivPosting."Product Type Name" := '';
                                    DivPosting.Transaction := DivPosting.Transaction::Loan;
                                    DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                    DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                    if DivPosting.Amount <> 0 then
                                        DivPosting.Insert;
                                    RunBal -= DivPosting.Amount;
                                    //MESSAGE('RUnBal %1\AmtDed_Add %2',RunBal,DivPosting.Amount);




                                    EntrNo += 1;
                                    DivPosting.Init;
                                    DivPosting."Entry No." := EntrNo;
                                    DivPosting."Posting Date" := Today;
                                    DivPosting."Document No." := DocNo;
                                    DivPosting."Account Type" := DivPosting."account type"::Savings;
                                    DivPosting."Account No." := Loans."Member No.";
                                    DivPosting.Description := CopyStr(Format(TransType) + ' - From Dividends ' + DivAcc + ' LNo:' + Loans."Loan No.", 1, 50); //*
                                    DivPosting."Member No." := Members."No.";
                                    DivPosting.Amount := -LnDefAmt;
                                    DivPosting."Debit Amount" := 0;
                                    DivPosting."Credit Amount" := -LnDefAmt;
                                    DivPosting."Loan No" := Loans."Loan No.";
                                    DivPosting."Transaction Type" := TransType;
                                    DivPosting."Product Type" := Loans."Loan Product Type";
                                    DivPosting."Product Type Name" := PadStr(Loans."Loan Product Type Name", 20);
                                    DivPosting.Transaction := DivPosting.Transaction::Loan;
                                    DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                    DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                    if DivPosting.Amount <> 0 then
                                        DivPosting.Insert;


                                end;
                            until Loans.Next = 0;
                        end;


                    end;//For j
                //Recover Dividend Advance
            end;


            if RunBal > 0 then begin
                //Recover Defaulted Loans
                for j := 1 to 4 do begin

                    Loans.Reset;
                    Loans.SetRange(Loans."Member No.", Members."No.");
                    Loans.SetFilter("Loans Category-SASRA", '%1|%2|%3',
                    Loans."loans category-sasra"::Substandard, Loans."loans category-sasra"::Doubtful, Loans."loans category-sasra"::Loss);

                    if j = 1 then
                        Loans.SetFilter("Outstanding Penalty", '>0')
                    else
                        if j = 2 then
                            Loans.SetFilter("Outstanding Appraisal", '>0')
                        else
                            if j = 3 then
                                Loans.SetFilter("Outstanding Interest", '>0')
                            else
                                if j = 4 then
                                    Loans.SetFilter("Outstanding Principal", '>0')
                                else
                                    Error('Invalid Code - Programming Error');

                    if Loans.Find('-') then begin
                        repeat
                            LnDefAmt := 0;
                            if RunBal > 0 then begin
                                TransType := Transtype::" ";

                                if j = 1 then begin
                                    Loans.CalcFields("Outstanding Penalty");
                                    LnDefAmt := Loans."Outstanding Penalty";
                                    TransType := Transtype::"Penalty Paid";
                                    if LnDefAmt > RunBal then
                                        LnDefAmt := RunBal;

                                end
                                else
                                    if j = 2 then begin
                                        Loans.CalcFields("Outstanding Appraisal");
                                        LnDefAmt := Loans."Outstanding Appraisal";

                                        if LnDefAmt > RunBal then
                                            LnDefAmt := RunBal;
                                        TransType := Transtype::"Appraisal Paid";
                                    end
                                    else
                                        if j = 3 then begin
                                            Loans.CalcFields("Outstanding Interest");
                                            LnDefAmt := Loans."Outstanding Interest";

                                            if LnDefAmt > RunBal then
                                                LnDefAmt := RunBal;

                                            TransType := Transtype::"Interest Paid";
                                        end
                                        else
                                            if j = 4 then begin

                                                DefAmount := 0;
                                                GetDefaultedAmount(Loans."Loan No.", Today, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, true);
                                                LnDefAmt := DefAmount;
                                                if LnDefAmt < 0 then
                                                    LnDefAmt := 0;

                                                if LnDefAmt > RunBal then
                                                    LnDefAmt := RunBal;
                                                TransType := Transtype::"Principal Repayment";
                                            end;

                                //MESSAGE('TransType %1 \LnDefAmt %2\RunBal %3',TransType,LnDefAmt,RunBal);
                                EntrNo += 1;
                                DivPosting.Init;
                                DivPosting."Entry No." := EntrNo;
                                DivPosting."Posting Date" := Today;
                                DivPosting."Document No." := DocNo;
                                DivPosting."Account Type" := DivPosting."account type"::Savings;
                                DivPosting."Account No." := DivAcc;
                                DivPosting.Description := CopyStr(Format(TransType) + ' - From Dividends ' + DivAcc + ' LNo:' + Loans."Loan No.", 1, 50); //*
                                DivPosting."Member No." := Members."No.";
                                DivPosting.Amount := LnDefAmt;
                                DivPosting."Debit Amount" := LnDefAmt;
                                DivPosting."Credit Amount" := 0;
                                DivPosting."Loan No" := '';
                                DivPosting."Transaction Type" := DivPosting."transaction type"::" ";
                                DivPosting."Product Type" := '';
                                DivPosting."Product Type Name" := '';
                                DivPosting.Transaction := DivPosting.Transaction::Loan;
                                DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                if DivPosting.Amount <> 0 then
                                    DivPosting.Insert;
                                RunBal -= DivPosting.Amount;
                                //MESSAGE('RUnBal %1\AmtDed_Add %2',RunBal,DivPosting.Amount);




                                EntrNo += 1;
                                DivPosting.Init;
                                DivPosting."Entry No." := EntrNo;
                                DivPosting."Posting Date" := Today;
                                DivPosting."Document No." := DocNo;
                                DivPosting."Account Type" := DivPosting."account type"::Savings;
                                DivPosting."Account No." := Loans."Member No.";
                                DivPosting.Description := CopyStr(Format(TransType) + ' - From Dividends ' + DivAcc + ' LNo:' + Loans."Loan No.", 1, 50); //*
                                DivPosting."Member No." := Members."No.";
                                DivPosting.Amount := -LnDefAmt;
                                DivPosting."Debit Amount" := 0;
                                DivPosting."Credit Amount" := -LnDefAmt;
                                DivPosting."Loan No" := Loans."Loan No.";
                                DivPosting."Transaction Type" := TransType;
                                DivPosting."Product Type" := Loans."Loan Product Type";
                                DivPosting."Product Type Name" := PadStr(Loans."Loan Product Type Name", 20);
                                DivPosting.Transaction := DivPosting.Transaction::Loan;
                                DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                if DivPosting.Amount <> 0 then
                                    DivPosting.Insert;


                            end;
                        until Loans.Next = 0;
                    end;


                end;//For j
                //Recover Defaulter Loans


            end;



            if RunBal > 0 then begin

                //Recover Dividend Instructions
                Instructions.Reset();
                Instructions.SetCurrentKey(Priority);
                Instructions.SetRange("Member No.", Members."No.");
                Instructions.SetFilter(Amount, '>0');
                if Instructions.FindFirst() then begin
                    repeat

                        if Instructions.Type = Instructions.Type::"Pay Internal Savings" then begin
                            DedAmt := Instructions.Amount;
                            if DedAmt > RunBal then
                                DedAmt := RunBal;

                            if DedAmt > 0 then begin


                                EntrNo += 1;
                                DivPosting.Init;
                                DivPosting."Entry No." := EntrNo;
                                DivPosting."Posting Date" := Today;
                                DivPosting."Document No." := DocNo;
                                DivPosting."Account Type" := DivPosting."account type"::Savings;
                                DivPosting."Account No." := DivAcc;
                                DivPosting.Description := CopyStr('Dividend Instruction Transfer To: ' + Instructions."Account No.", 1, 50); //*
                                DivPosting."Member No." := Members."No.";
                                DivPosting.Amount := DedAmt;
                                DivPosting."Debit Amount" := DedAmt;
                                DivPosting."Credit Amount" := 0;
                                DivPosting."Loan No" := '';
                                DivPosting."Transaction Type" := DivPosting."transaction type"::" ";
                                DivPosting."Product Type" := '';
                                DivPosting."Product Type Name" := '';
                                DivPosting.Transaction := DivPosting.Transaction::Loan;
                                DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                if DivPosting.Amount <> 0 then
                                    DivPosting.Insert;
                                RunBal -= DivPosting.Amount;


                                EntrNo += 1;
                                DivPosting.Init;
                                DivPosting."Entry No." := EntrNo;
                                DivPosting."Posting Date" := Today;
                                DivPosting."Document No." := DocNo;
                                DivPosting."Account Type" := DivPosting."account type"::Savings;
                                DivPosting."Account No." := Instructions."Account No.";
                                DivPosting.Description := CopyStr('Dividend Instruction Transfer To: ' + Instructions."Account No.", 1, 50); //*
                                DivPosting."Member No." := Members."No.";
                                DivPosting.Amount := -DedAmt;
                                DivPosting."Debit Amount" := 0;
                                DivPosting."Credit Amount" := DedAmt;
                                DivPosting."Loan No" := '';
                                DivPosting."Transaction Type" := DivPosting."transaction type"::" ";
                                DivPosting."Product Type" := '';
                                DivPosting."Product Type Name" := '';
                                DivPosting.Transaction := DivPosting.Transaction::Loan;
                                DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                if DivPosting.Amount <> 0 then
                                    DivPosting.Insert;

                            end;
                        end;
                        if Instructions.Type = Instructions.Type::"Pay Internal Loan" then begin
                            DivPosting.Reset();
                            DivPosting.SetRange("Loan No", Instructions."Loan No.");
                            if not DivPosting.FindFirst() then begin
                                DedAmt := Instructions.Amount;
                                for j := 1 to 4 do begin


                                    Loans.Reset;
                                    Loans.SetRange(Loans."Member No.", Members."No.");
                                    Loans.SetFilter("Loan No.", Instructions."Loan No.");

                                    if j = 1 then
                                        Loans.SetFilter("Outstanding Penalty", '>0')
                                    else
                                        if j = 2 then
                                            Loans.SetFilter("Outstanding Appraisal", '>0')
                                        else
                                            if j = 3 then
                                                Loans.SetFilter("Outstanding Interest", '>0')
                                            else
                                                if j = 4 then
                                                    Loans.SetFilter("Outstanding Principal", '>0')
                                                else
                                                    Error('Invalid Code - Programming Error');

                                    if Loans.Find('-') then begin
                                        repeat
                                            LnDefAmt := 0;
                                            if RunBal > 0 then begin
                                                TransType := Transtype::" ";

                                                if j = 1 then begin
                                                    Loans.CalcFields("Outstanding Penalty");
                                                    LnDefAmt := Loans."Outstanding Penalty";
                                                    TransType := Transtype::"Penalty Paid";
                                                    if LnDefAmt > RunBal then
                                                        LnDefAmt := RunBal;

                                                end
                                                else
                                                    if j = 2 then begin
                                                        Loans.CalcFields("Outstanding Appraisal");
                                                        LnDefAmt := Loans."Outstanding Appraisal";

                                                        if LnDefAmt > RunBal then
                                                            LnDefAmt := RunBal;
                                                        TransType := Transtype::"Appraisal Paid";
                                                    end
                                                    else
                                                        if j = 3 then begin
                                                            Loans.CalcFields("Outstanding Interest");
                                                            LnDefAmt := Loans."Outstanding Interest";

                                                            if LnDefAmt > RunBal then
                                                                LnDefAmt := RunBal;

                                                            TransType := Transtype::"Interest Paid";
                                                        end
                                                        else
                                                            if j = 4 then begin

                                                                DefAmount := Loans."Outstanding Principal";
                                                                LnDefAmt := DefAmount;
                                                                if LnDefAmt < 0 then
                                                                    LnDefAmt := 0;

                                                                if LnDefAmt > RunBal then
                                                                    LnDefAmt := RunBal;
                                                                TransType := Transtype::"Principal Repayment";
                                                            end;

                                                //MESSAGE('TransType %1 \LnDefAmt %2\RunBal %3',TransType,LnDefAmt,RunBal);
                                                if LnDefAmt > DedAmt then
                                                    LnDefAmt := DedAmt;


                                                if LnDefAmt > 0 then begin

                                                    EntrNo += 1;
                                                    DivPosting.Init;
                                                    DivPosting."Entry No." := EntrNo;
                                                    DivPosting."Posting Date" := Today;
                                                    DivPosting."Document No." := DocNo;
                                                    DivPosting."Account Type" := DivPosting."account type"::Savings;
                                                    DivPosting."Account No." := DivAcc;
                                                    DivPosting.Description := CopyStr(Format(TransType) + ' - From Dividends Instructions LNo:' + Loans."Loan No.", 1, 50); //*
                                                    DivPosting."Member No." := Members."No.";
                                                    DivPosting.Amount := LnDefAmt;
                                                    DivPosting."Debit Amount" := LnDefAmt;
                                                    DivPosting."Credit Amount" := 0;
                                                    DivPosting."Loan No" := '';
                                                    DivPosting."Transaction Type" := DivPosting."transaction type"::" ";
                                                    DivPosting."Product Type" := '';
                                                    DivPosting."Product Type Name" := '';
                                                    DivPosting.Transaction := DivPosting.Transaction::Loan;
                                                    DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                                    DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                                    if DivPosting.Amount <> 0 then
                                                        DivPosting.Insert;
                                                    RunBal -= DivPosting.Amount;
                                                    DedAmt -= DivPosting.Amount;
                                                    //MESSAGE('RUnBal %1\AmtDed_Add %2',RunBal,DivPosting.Amount);




                                                    EntrNo += 1;
                                                    DivPosting.Init;
                                                    DivPosting."Entry No." := EntrNo;
                                                    DivPosting."Posting Date" := Today;
                                                    DivPosting."Document No." := DocNo;
                                                    DivPosting."Account Type" := DivPosting."account type"::Savings;
                                                    DivPosting."Account No." := Loans."Member No.";
                                                    DivPosting.Description := CopyStr(Format(TransType) + ' - From Dividends Instructions LNo:' + Loans."Loan No.", 1, 50); //*
                                                    DivPosting."Member No." := Members."No.";
                                                    DivPosting.Amount := -LnDefAmt;
                                                    DivPosting."Debit Amount" := 0;
                                                    DivPosting."Credit Amount" := -LnDefAmt;
                                                    DivPosting."Loan No" := Loans."Loan No.";
                                                    DivPosting."Transaction Type" := TransType;
                                                    DivPosting."Product Type" := Loans."Loan Product Type";
                                                    DivPosting."Product Type Name" := PadStr(Loans."Loan Product Type Name", 20);
                                                    DivPosting.Transaction := DivPosting.Transaction::Loan;
                                                    DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                                    DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                                    if DivPosting.Amount <> 0 then
                                                        DivPosting.Insert;

                                                end;

                                            end;
                                        until Loans.Next = 0;
                                    end;


                                end;//For j

                            end;


                            DedAmt := Instructions.Amount;
                            if DedAmt > RunBal then
                                DedAmt := RunBal;

                            if DedAmt > 0 then begin


                                EntrNo += 1;
                                DivPosting.Init;
                                DivPosting."Entry No." := EntrNo;
                                DivPosting."Posting Date" := Today;
                                DivPosting."Document No." := DocNo;
                                DivPosting."Account Type" := DivPosting."account type"::Savings;
                                DivPosting."Account No." := DivAcc;
                                DivPosting.Description := CopyStr('Dividend Instruction Transfer To: ' + Instructions."Account No.", 1, 50); //*
                                DivPosting."Member No." := Members."No.";
                                DivPosting.Amount := DedAmt;
                                DivPosting."Debit Amount" := DedAmt;
                                DivPosting."Credit Amount" := 0;
                                DivPosting."Loan No" := '';
                                DivPosting."Transaction Type" := DivPosting."transaction type"::" ";
                                DivPosting."Product Type" := '';
                                DivPosting."Product Type Name" := '';
                                DivPosting.Transaction := DivPosting.Transaction::Loan;
                                DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                if DivPosting.Amount <> 0 then
                                    DivPosting.Insert;
                                RunBal -= DivPosting.Amount;


                                EntrNo += 1;
                                DivPosting.Init;
                                DivPosting."Entry No." := EntrNo;
                                DivPosting."Posting Date" := Today;
                                DivPosting."Document No." := DocNo;
                                DivPosting."Account Type" := DivPosting."account type"::Savings;
                                DivPosting."Account No." := Instructions."Account No.";
                                DivPosting.Description := CopyStr('Dividend Instruction Transfer To: ' + Instructions."Account No.", 1, 50); //*
                                DivPosting."Member No." := Members."No.";
                                DivPosting.Amount := -DedAmt;
                                DivPosting."Debit Amount" := 0;
                                DivPosting."Credit Amount" := DedAmt;
                                DivPosting."Loan No" := '';
                                DivPosting."Transaction Type" := DivPosting."transaction type"::" ";
                                DivPosting."Product Type" := '';
                                DivPosting."Product Type Name" := '';
                                DivPosting.Transaction := DivPosting.Transaction::Loan;
                                DivPosting."Shortcut Dimension 1 Code" := GlobalDim1;
                                DivPosting."Shortcut Dimension 2 Code" := GlobalDim2;
                                if DivPosting.Amount <> 0 then
                                    DivPosting.Insert;

                            end;
                        end;

                    until Instructions.Next() = 0;
                end;
                //Recover Dividend Instructions


            end;

        end;
        //MESSAGE('Done');
    end;


    procedure PostDividendLines(MemberNo: Code[20]; JTransfer: Boolean; DivProduct: Code[20]; GrossDividends: Decimal; MobilePhoneNo: Code[20])
    var
        LoanType: Record "Product Setup";
        Savings: Record Vendor;
        Text0005: label 'Your Dividend of ';
        Text0006: label ' has been credited to your account at ';
        Text0007: label ' on ';
        DivPosting: Record "Dividend Posting";
        Msg: Text;
        ExtDocNo: Code[20];
    begin


        UserSetup.Get(UserId);
        UserSetup.TestField("Payment Journal Template");
        UserSetup.TestField("Payment Journal Batch");

        JBatch := UserSetup."Payment Journal Batch";
        JTemplate := UserSetup."Payment Journal Template";

        Savings.Reset;
        Savings.SetRange("Member No.", MemberNo);
        Savings.SetRange("Product Type", DivProduct);
        if Savings.FindFirst then begin


            Savings."Test Blocked" := Savings."test blocked"::" ";
            if Savings.Blocked <> Savings.Blocked::" " then begin
                Savings."Test Blocked" := Savings.Blocked;
                Savings.Blocked := Savings.Blocked::" ";
                Savings.Modify;
            end;

            if not JTransfer then begin
                JournalInit(JTemplate, JBatch);
            end;

            DivPosting.Reset;
            DivPosting.SetRange("Member No.", MemberNo);
            DivPosting.SetRange(Posted, false);
            if DivPosting.Find('-') then begin

                repeat

                    if not JTransfer then begin

                        if DivPosting."Product Type" = 'SMS' then begin
                            Msg := 'Dear Member, Your Gross Dividends of KES ' + Format(GrossDividends) + ' has been processed';
                            MemberActivities.SendSms(Smssource, MobilePhoneNo, Msg, Savings."No.", Savings."No.", true, false);

                        end;
                    end;

                    ExtDocNo := '';

                    if DivPosting."Product Type" <> 'SMS' then begin

                        JournalInsert(
                            JTemplate,
                            JBatch,
                            DivPosting."Document No.",
                            DivPosting."Posting Date",
                            DivPosting."Account Type",
                            DivPosting."Account No.",
                            DivPosting.Description,
                            DivPosting."Bal. Account Type",
                            DivPosting."Bal. Account No.",
                            DivPosting.Amount,
                            ExtDocNo,
                            DivPosting."Loan No",
                            DivPosting."Transaction Type",
                            DivPosting."Shortcut Dimension 1 Code",
                            DivPosting."Shortcut Dimension 2 Code",
                            true
                            );

                    end;

                    if not JTransfer then begin
                        DivPosting.Posted := true;
                        DivPosting.Modify;
                    end;



                until DivPosting.Next = 0;


                if not JTransfer then begin
                    JournalPost(JTemplate, JBatch);
                end;

            end;


            if Savings."Test Blocked" <> Savings."test blocked"::" " then begin
                Savings.Blocked := Savings."Test Blocked";
                Savings."Test Blocked" := Savings."test blocked"::" ";
                Savings.Modify;
            end;
        end;
    end;


    procedure PostSaccoJournal(JVNo: Code[20])
    var
        LoanType: Record "Product Setup";
        Savings: Record Vendor;
        //JnlLine: Record "Sacco Journal Line";
        Msg: Text;
        ExtDocNo: Code[20];
        JnlHeader: Record "Sacco Journal Header";
    begin
/*

        GetGeneralJournalTemplate(JTemplate, JBatch);

        JnlHeader.Get(JVNo);
        JournalInit(JTemplate, JBatch);

        JnlLine.Reset;
        JnlLine.SetRange("Batch No.", JVNo);
        if JnlLine.Find('-') then begin

            repeat

                JournalInsert(
                    JTemplate,
                    JBatch,
                    JnlLine."Document No.",
                    JnlLine."Posting Date",
                    JnlLine."Account Type",
                    JnlLine."Account No.",
                    JnlLine.Description,
                    JnlLine."Bal. Account Type",
                    JnlLine."Bal. Account No.",
                    JnlLine.Amount,
                    JnlLine."External Document No.",
                    JnlLine."Loan No",
                    JnlLine."Transaction Type",
                    JnlLine."Shortcut Dimension 1 Code",
                    JnlLine."Shortcut Dimension 2 Code",
                    true
                    );

                JnlLine.Posted := true;
                JnlLine.Modify;



            until JnlLine.Next = 0;



            if JournalPost(JTemplate, JBatch) then begin
                JnlHeader.Posted := true;
                JnlHeader."Date Posted" := today;
                JnlHeader.Modify();
            end;


        end;
*/
    
    end;

    procedure PostTreasuryTellerIssue(TreasuryTellerTransactions: Record "Treasury/Teller Transactions")
    var
        Text0004: label 'The money has already been issued.';
        BankingUser: Record "Banking User Setup";
        Text0005: label 'You do not have permission to transact on this teller till/Account.';
        Banks: Record "Bank Account";
        BankBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        JTemplate: Code[20];
        JBatch: Code[20];
        TillNo: Code[20];
        DBranch: Code[20];
        DActivity: Code[20];
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        UserSetup: Record "User Setup";
        Text0007: label 'Please specify an amount greater than zero.';
        ToAccount: Code[20];
        FromAccount: Code[20];
        Text0008: label 'Coinage Amount must be equal to the amount';
        PDate: Date;
        Cust: Record Customer;
    begin

        with TreasuryTellerTransactions do begin


            BankingUser.Get(UserId);

            BankingUser.TestField("Cashier Journal Template");
            BankingUser.TestField("Cashier Journal Batch");
            BankingUser.TestField("Default  Bank");

            JTemplate := BankingUser."Cashier Journal Template";
            JBatch := BankingUser."Cashier Journal Batch";
            TillNo := BankingUser."Default  Bank";

            if "Transaction Type" = "transaction type"::"Mpesa to Teller" then
                TillNo := "From Account";


            CheckTillCurrency(TillNo, "Currency Code");

            UserSetup.Reset;
            UserSetup.SetRange(UserSetup."User ID", UpperCase(UserId));
            if UserSetup.Find('-') then begin
                UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                DBranch := UserSetup."Global Dimension 2 Code";
                DActivity := UserSetup."Global Dimension 1 Code";
            end;

            TestField(Amount);
            TestField("From Account");
            TestField("To Account");

            if Amount <= 0 then
                Error(Text0007);

            if Amount <> "Total Cash on Treasury Coinage" then
                Error(Text0008);



            if Issued = Issued::Yes then
                Error(Text0004);


            if ("Transaction Type" <> "transaction type"::"Bank to Treasury") and ("Transaction Type" <> "transaction type"::"Bank to Bank") then begin
                BankingUser.Reset;
                BankingUser.SetRange(BankingUser."User Name", "From Account");
                if BankingUser.Find('-') then begin

                    if UserId <> BankingUser."User Name" then begin
                        ;
                        Banks.Reset;
                        Banks.SetRange(Banks."No.", "From Bank");
                        Banks.SetFilter("Responsible User", UserId);
                        if not Banks.Find('-') then begin
                            Error(Text0005);
                        end
                    end;


                end;
            end
            else begin


                Banks.Reset;
                Banks.SetRange(Banks."No.", "From Bank");
                if Banks.Find('-') then begin
                    if Banks."Responsible User" <> '' then
                        if UserId <> Banks."Responsible User" then
                            Error(Text0005);

                    Banks.CalcFields(Banks."Balance (LCY)");
                    BankBal := Banks."Balance (LCY)";
                    if Amount > BankBal then begin
                        Error('You cannot issue more than the account balance.')
                    end;
                end;
            end;


            Banks.Reset;
            Banks.SetRange(Banks."No.", "From Bank");
            if Banks.Find('-') then begin
                Banks.CalcFields(Banks."Balance (LCY)");
                BankBal := Banks."Balance (LCY)";
                if Amount > BankBal then begin
                    Error('You cannot issue more than the account balance.')
                end;
            end;

            if Confirm('Are you sure you want to make this issue?', false) = true then begin
                Issued := Issued::Yes;
                "Date Issued" := Today;
                "Time Issued" := Time;
                "Issued By" := UserId;
                Modify;
            end;
            Message('Money successfully issued/Returned.');

        end;
    end;


    procedure PostTreasuryTellerReceive(TreasuryTellerTransactions: Record "Treasury/Teller Transactions")
    var
        CurrentTellerAmount: Decimal;
        BankingUser: Record "Banking User Setup";
        Banks: Record "Bank Account";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemplate: Code[20];
        JBatch: Code[20];
        TillNo: Code[20];
        DBranch: Code[20];
        DActivity: Code[20];
        UserSetup: Record "User Setup";
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        Text0007: label 'Please specify an amount greater than zero.';
        ToAccount: Code[20];
        FromAccount: Code[20];
        ShortageAcc: Code[20];
        ExcessAcc: Code[20];
        Amt: Decimal;
        PDate: Date;
        MemberActivities: Codeunit "Member Activities";
        SaccoSetup: Record "Sacco Setup";
        Heading: text;
        SalutationTxt: Text;
        BodyTxt: text;
        RegardsTxt: Text;
        Receiver: Text;
        FilePath_Name: Text;
        Cust: Record Customer;


    begin

        with TreasuryTellerTransactions do begin

            FromAccount := "From Bank";
            ToAccount := "To Bank";

            BankingUser.Get(UserId);
            UserSetup.Get(UserId);

            BankingUser.TestField("Cashier Journal Template");
            BankingUser.TestField("Cashier Journal Batch");
            BankingUser.TestField("Default  Bank");

            JTemplate := BankingUser."Cashier Journal Template";
            JBatch := BankingUser."Cashier Journal Batch";
            TillNo := BankingUser."Default  Bank";

            CheckTillCurrency(TillNo, "Currency Code");

            UserSetup.Reset;
            UserSetup.SetRange(UserSetup."User ID", UpperCase(UserId));
            if UserSetup.Find('-') then begin
                UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                DBranch := UserSetup."Global Dimension 2 Code";
                DActivity := UserSetup."Global Dimension 1 Code";
            end;

            TestField(Amount);
            TestField("From Account");
            TestField("To Account");

            if Amount <= 0 then
                Error(Text0007);


            if "Transaction Type" = "transaction type"::"Bank to Treasury" then begin
                TestField("External Document No.");


            end;



            CurrentTellerAmount := 0;

            if Posted then
                Error('The transaction has already been received and posted.');


            if ("Transaction Type" = "transaction type"::"Treasury To Teller") or
                ("Transaction Type" = "transaction type"::"Mpesa to Teller") or
                ("Transaction Type" = "transaction type"::"Treasury to Treasury") or
                ("Transaction Type" = "transaction type"::"Teller To Treasury") or
                ("Transaction Type" = "transaction type"::"Treasury to Mpesa") or
                ("Transaction Type" = "transaction type"::"Treasury to Equity") or
                //("Transaction Type"="Transaction Type"::"Treasury To Bank") OR
                ("Transaction Type" = "transaction type"::"Mpesa to Treasury") or
                ("Transaction Type" = "transaction type"::"Equity to Treasury") or
                ("Transaction Type" = "transaction type"::"End of Day Teller to Treasury") or
                ("Transaction Type" = "transaction type"::"Bank to Bank") or
                ("Transaction Type" = "transaction type"::"Teller to Teller") then begin

                if Issued = Issued::No then
                    Error('The issue has not yet been made and therefore you cannot continue with this transaction.');


                BankingUser.Reset;
                BankingUser.SetRange(BankingUser."User Name", "To Account");
                if BankingUser.Find('-') then begin
                    if UserId <> BankingUser."User Name" then begin

                        Banks.Reset;
                        Banks.SetRange(Banks."No.", "To Bank");
                        Banks.SetRange("Responsible User", UserId);
                        if not Banks.Find('-') then begin

                            Error('You do not have permission to transact on this teller till/Account.');
                        end;

                    end;


                    Banks.Reset;
                    Banks.SetRange(Banks."No.", "To Bank");
                    if Banks.Find('-') then begin



                        if ("Transaction Type" = "transaction type"::"Bank to Bank") then
                            if Banks."PV User" <> UserId then
                                Error('You are not allowed to receive funds to this Bank Account');


                        Banks.CalcFields(Banks."Balance (LCY)");
                        CurrentTellerAmount := Banks."Balance (LCY)";

                        if CurrentTellerAmount + Amount > BankingUser."Max. Cashier Withholding" then
                            Error('The transaction will result in the teller having a balance more than the maximum allowable therefor terminated.');
                    end;

                end
                else begin
                    if "Transaction Type" = "transaction type"::"Bank to Bank" then begin
                        if not UserSetup."Allow Bank to Bank Trans" then
                            Error('You do not have permission to transact on this teller till/Account.');


                        Banks.Reset;
                        Banks.SetRange(Banks."No.", "To Bank");
                        if Banks.Find('-') then begin




                            if ("Transaction Type" = "transaction type"::"Bank to Bank") then
                                if Banks."PV User" <> UserId then
                                    Error('You are not allowed to receive funds to this Bank Account');
                        end;

                    end
                    else
                        Error('You do not have permission to transact on this teller till/Account.');
                end;

                BankingUser.Reset;
                BankingUser.SetRange(BankingUser."User Name", "From Account");
                if BankingUser.Find('-') then begin
                    ExcessAcc := BankingUser."Excess Account";
                    ShortageAcc := BankingUser."Shortage Account";
                end;

            end;

            if not Confirm('Are you sure you want to make this receipt?', false) then
                exit;

            JournalInit(JTemplate, JBatch);

            Amt := 0;

            if Type = Type::Excess then
                Amt := -(Amount - "Excess/Shortage Amount")
            else
                if Type = Type::Shortage then
                    Amt := -Amount
                else
                    if Type = Type::" " then
                        Amt := -Amount;



            PDate := Today;

            JournalInsert(
                JTemplate,
                JBatch,
                Code,
                PDate,
                Accttype::"Bank Account",
                FromAccount,
                Description,
                Balaccttype::"Bank Account",
                ToAccount,
                Amt,
                "External Document No.",
                '',
                Transtype::" ",
                DActivity,
                DBranch,
                true
                );



            //Posting Excess
            if Type = Type::Excess then begin

                JournalInsert(
                    JTemplate,
                    JBatch,
                    Code,
                    PDate,
                    Accttype::"Bank Account",
                    ToAccount,
                    'Excess From Cashier',
                    Balaccttype::Customer,
                    ExcessAcc,
                    "Excess/Shortage Amount",
                    "External Document No.",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true
                    );
            end;
            //Posting Excess


            //Posting Shortage
            if Type = Type::Shortage then begin

                JournalInsert(
                    JTemplate,
                    JBatch,
                    Code,
                    PDate,
                    Accttype::"Bank Account",
                    ToAccount,
                    'Shortage From Cashier',
                    Balaccttype::Customer,
                    ShortageAcc,
                    -"Excess/Shortage Amount",
                    "External Document No.",
                    '',
                    Transtype::" ",
                    DActivity,
                    DBranch,
                    true
                    );
            end;
            //Posting Shortage


            Posted := true;
            "Date Posted" := Today;
            "Time Posted" := Time;
            "Posted By" := UserId;
            Received := Received::Yes;
            "Date Received" := Today;
            "Time Received" := Time;
            "Received By" := UserId;
            Modify;

            JournalPost(JTemplate, JBatch);

            if "Excess/Shortage Amount" > 0 then begin
                SaccoSetup.Get();
                if SaccoSetup."Teller Shortage Email" <> '' then begin

                    Heading := 'TELLER ' + UpperCase(Format(Type));
                    SalutationTxt := 'Dear Sir/Madam';
                    Cust.Reset();
                    if Type = Type::Shortage then begin
                        Cust.get(ShortageAcc);
                    end;
                    if Type = Type::Excess then begin
                        Cust.get(ExcessAcc);
                    end;

                    BodyTxt := 'Please Note that Teller ' + Cust.Name + ' has a ' + Format(Type) + ' of KES ' + Format("Excess/Shortage Amount");
                    BodyTxt += '<br>';
                    BodyTxt += 'Transaction Reference: ' + Code;
                    ;
                    BodyTxt += '<br>';
                    RegardsTxt := 'Kind Regards';
                    Receiver := SaccoSetup."Teller Shortage Email";
                    FilePath_Name := '';

                    if MemberActivities.SendEmailNotification(Heading, SalutationTxt, BodyTxt, RegardsTxt, Receiver, FilePath_Name) then;


                end;
            end;


        end;
    end;


    procedure CheckTillCurrency(BankAcc: Code[20]; CurrCode: Code[20])
    var
        BankAcct: Record "Bank Account";
    begin
        BankAcct.Reset;
        BankAcct.SetRange(BankAcct."No.", BankAcc);
        if BankAcct.Find('-') then begin
            if BankAcct."Currency Code" <> CurrCode then begin
                if BankAcct."Currency Code" = '' then
                    Error('This bank [%1:- %2] can only transact in LOCAL Currency', BankAcct."No.", BankAcct.Name)
                else
                    Error('This bank [%1:- %2] can only transact in %3', BankAcct."No.", BankAcct.Name, BankAcct."Currency Code");
            end;
        end;
    end;

    local procedure "**********Salary Processing***********"()
    begin
    end;


    procedure PostSalary(SalHeaD: Record "Salary Header"; PostLinebyLine: Boolean)
    var
        SalLines: Record "Salary Lines";
        UserSetup: Record "User Setup";
        Jtemplate: Code[20];
        JBatch: Code[20];
        Text0001: label 'Ensure the Salary  Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        Text0004: label 'The transaction has already been posted.';
        RunBal: Decimal;
        SaccoSetup: Record "Sacco Setup";
        PDate: Date;
        DocNo: Code[20];
        PostingRemarks: Text[50];
        DActivity2: Code[20];
        DBranch2: Code[20];
        Account: Record Vendor;
        AvailableBal: Decimal;
        ProductSetup: Record "Product Setup";
        SalFee: Decimal;
        SalaryHeader: Record "Salary Header";
        SalGLAccount: Code[20];
        TCharges: Decimal;
        MemberNo: Code[20];
        Salaccno: Code[20];
        Text0005: label 'Your Income of ';
        Text0006: label ' has been credited to your account at ';
        Text0007: label ' on ';
        NetAmount: Decimal;
        IncomeSMSCharge: Decimal;
        SMSSent: Boolean;
        SMSCharges: Record "SMS Charges";
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        SavingsACC: Record Vendor;
        SavAcc: Record Vendor;
        RegFee: Decimal;
        Memb: Record Customer;
        GLEntry: Record "G/L Entry";
        TestBatch: Code[20];
    begin
        with SalHeaD do begin

            //Cyrus
            if Posted = true then
                Error(Text0004);

            if Status <> Status::Approved then
                Error('The document is not fully approved');

            UserSetup.Get(UserId);
            UserSetup.TestField("CashRec Journal Template");
            UserSetup.TestField("CashRec Journal Batch");


            Jtemplate := UserSetup."CashRec Journal Template";
            JBatch := UserSetup."CashRec Journal Batch";

            JournalInit(Jtemplate, JBatch);


            CalcFields("Total Count", "Scheduled Amount");

            RunBal := 0;

            SaccoSetup.Get;

            TestField(Remarks);
            TestField("Document No");
            TestField("Posting date");
            TestField(Amount);

            if "Scheduled Amount" <> Amount then
                Error('Scheduled amount and Amount must be the same');

            PDate := "Posting date";
            DocNo := "Document No";
            ExtDocNo := No;
            PostingRemarks := Remarks;


            if PostLinebyLine then begin
                if Confirm('Are you sure you want to post Salaries?', false) = false then
                    exit;
            end
            else begin
                if Confirm('Are you sure you want to transfer to Journal?', false) = false then
                    exit;
            end;


            IncomeSMSCharge := 0;
            SMSCharges.Reset;
            if "Income Type" = "income type"::Bonus then
                SMSCharges.SetRange(Source, SMSCharges.Source::Bonus)
            else
                if "Income Type" = "income type"::"Mini-Bonus" then
                    SMSCharges.SetRange(Source, SMSCharges.Source::"Mini Bonus")
                else
                    SMSCharges.SetRange(Source, SMSCharges.Source::"Salary Processing");
            if SMSCharges.FindFirst then begin
                IncomeSMSCharge := SMSCharges."Charge Amount";
            end;


            if "Dont Send SMS" then
                if not Confirm('Are you sure you do not want to send sms?') then
                    Error('Aborted');

            TestBatch := '001';



            while TestBatch <= "No. of Batches" do begin

                //if not PostLinebyLine then begin
                dWindow.Open('Generating Journal Lines:      #1#########\'
                                    + 'Accounts:             #2#########\'
                                    + 'Counter:              #3#########\'
                                    + 'Progress:             @4@@@@@@@@@\'
                                    + 'Press Esc to abort');

                CurrentRecordNo := 0;
                NoOfRecords := 0;
                //end;

                SalLines.Reset;
                SalLines.SetRange(SalLines."Salary Header No.", No);
                //SalLines.SETRANGE(SalLines."Account No.",'100-0032875-00');
                SalLines.SetRange("Batch No.", TestBatch);
                SalLines.SetRange(Posted, false);
                if SalLines.Find('-') then begin

                    //if not PostLinebyLine then begin
                    NoOfRecords := SalLines.Count;
                    dWindow.Update(1, TestBatch);
                    dWindow.Update(2, NoOfRecords);
                    //end;

                    if PostLinebyLine then begin
                        JournalInit(Jtemplate, JBatch);
                    end;

                    repeat

                        //if not PostLinebyLine then begin
                        CurrentRecordNo += 1;
                        dWindow.Update(1, SalLines."Account Name");
                        //end;
                        if SalLines."Account Not Found" = false then begin
                            MemberNo := '';
                            Salaccno := '';

                            MemberNo := SalLines."Member No.";
                            Salaccno := SalLines."Account No.";


                            if Account.Get(SalLines."Account No.") then begin


                                SavingsACC.Reset;
                                SavingsACC.SetRange("Member No.", Account."Member No.");
                                if SavingsACC.Find('-') then begin
                                    repeat
                                        SavingsACC."Test Blocked" := SavingsACC.Blocked;
                                        SavingsACC.Blocked := SavingsACC.Blocked::" ";
                                        SavingsACC.Modify;
                                    until SavingsACC.Next = 0;
                                end;

                                /*
                                Account."Test Blocked":=Account."Test Blocked"::" ";
                                IF Account.Blocked<>Account.Blocked::" " THEN BEGIN
                                    Account."Blocked 2":=Account.Blocked;
                                    Account.Blocked:=Account.Blocked::" ";
                                    Account.MODIFY;
                                END;
                                */

                                UserSetup.TestField("Global Dimension 2 Code");


                                DActivity2 := Account."Global Dimension 1 Code";
                                if SalHeaD."Process Type" = SalHeaD."process type"::"General Process" then begin
                                    Account.TestField("Global Dimension 2 Code");
                                    DBranch2 := Account."Global Dimension 2 Code";
                                end;
                                if SalHeaD."Process Type" = SalHeaD."process type"::"Branch Process" then
                                    DBranch2 := UserSetup."Global Dimension 2 Code";

                                if DBranch2 = '' then
                                    Error('Branch Code Must have a value');
                                //Check Account Bal
                                AvailableBal := MemberActivities.GetAccountBalance(Account."No.");

                                RunBal := AvailableBal + SalLines.Amount;

                                if RunBal < 0 then
                                    RunBal := 0;

                                JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::Savings, SalLines."Account No.", PostingRemarks,
                                        Balaccttype::"G/L Account", '', -SalLines.Amount, ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                                //SaccoSetup.TESTFIELD("Income Control Account");

                                JournalInsert(Jtemplate, JBatch, DocNo, PDate, "Account Type", "Account No", CopyStr(SalLines.Name + '-' + PostingRemarks, 1, 50),
                                        Balaccttype::"G/L Account", '', SalLines.Amount, ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);



                                MemberActivities.GetGeneralChargeAmount("Destination Transaction Type", SalLines.Amount, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct);


                                JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::Savings, SalLines."Account No.", 'Income Fee',
                                        Balaccttype::"G/L Account", ChargeAcct, ChargeAmt, ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                                RunBal := RunBal - ChargeAmt;

                                //Excise Duty

                                SaccoSetup.TestField("Excise Duty GL");
                                JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::Savings, SalLines."Account No.", 'Excise Duty on Income Fee',
                                        Balaccttype::"G/L Account", SaccoSetup."Excise Duty GL", ChargeDuty, ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                                RunBal := RunBal - ChargeDuty;

                                if RunBal < 0 then
                                    RunBal := 0;

                                NetAmount := RunBal;


                                if SalLines."Member No." <> '' then begin

                                    if not SalHeaD."Dont Send SMS" then begin
                                        SMSSent := false;
                                        if Account.Get(SalLines."Account No.") then begin
                                            if PostLinebyLine then
                                                if RunBal > 0 then begin

                                                    if PostLinebyLine then begin
                                                        if Memb.Get(Account."Member No.") then begin
                                                            MemberActivities.SendSms(Source::"Salary Processing", Memb."Mobile Phone No.", Text0005 + Format(SalLines.Amount) + Text0006 + COMPANYNAME
                                                            + Text0007 + Format(Today) + ' ' + Format(Time) + '. ' + SalHeaD."Additional SMS", SalLines."Account No.", SalLines."Account No.", true, false);
                                                            SMSSent := true;
                                                        end;

                                                    end;



                                                    if SMSSent then
                                                        RunBal -= (IncomeSMSCharge + IncomeSMSCharge * 0.01);

                                                end;
                                        end;
                                    end;

                                    SavAcc.Reset;
                                    SavAcc.SetRange("Member No.", SalLines."Member No.");
                                    SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"Registration Fee");
                                    if not SavAcc.FindFirst then begin
                                        Memb.get(SalLines."Member No.");
                                        ProductSetup.Reset();
                                        ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Registration Fee");
                                        if ProductSetup.FindFirst() then
                                            MemberActivities.CreateSavingsAccount(ProductSetup, Memb, 0, true, ProductSetup."Repay Mode");
                                    end;

                                    SavAcc.Reset;
                                    SavAcc.SetRange("Member No.", SalLines."Member No.");
                                    SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"Registration Fee");
                                    SavAcc.SetRange("Balance (LCY)", 0);
                                    if SavAcc.FindFirst then begin
                                        ProductSetup.Reset();
                                        ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Registration Fee");
                                        if ProductSetup.FindFirst() then begin
                                            RegFee := ProductSetup."Minimum Contribution";
                                            if RunBal >= RegFee then begin

                                                JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::Savings, SalLines."Account No.", 'Registration Fee',
                                                        Balaccttype::"G/L Account", '', RegFee, ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                                                //SaccoSetup.TESTFIELD("Income Control Account");

                                                JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::Savings, SavAcc."No.", CopyStr('Registration Fee', 1, 50),
                                                        Balaccttype::"G/L Account", '', -RegFee, ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                                                RunBal -= RegFee;

                                            end;

                                        end;
                                    end;




                                    //IF SalHeaD."Payment Type"=SalHeaD."Payment Type"::Salaries THEN
                                    PostSalaryLoans(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, JBatch, RunBal, MemberNo, Salaccno, RunBal, SalLines.Amount, PostLinebyLine, SalLines."Staff No.");

                                end;



                            end;

                            if PostLinebyLine then begin
                                //JournalPost(Jtemplate, JBatch);

                                /*
                                SavingsACC.Reset;
                                SavingsACC.SetRange("Member No.", Account."Member No.");
                                if SavingsACC.Find('-') then begin
                                    repeat
                                        SavingsACC.Blocked := SavingsACC."Test Blocked";
                                        SavingsACC."Test Blocked" := SavingsACC."test blocked"::" ";
                                        SavingsACC.Modify;
                                    until SavingsACC.Next = 0;
                                end;
                                */



                                SalLines.Posted := true;
                                SalLines."Posted By" := UserId;
                                SalLines."Posting Date" := PDate;
                                SalLines."Posting Time" := Time;
                                SalLines.Modify;
                                Commit;//*


                            end;
                        end
                        else
                            if SalLines."Account Not Found" = true then begin

                                if PostLinebyLine then
                                    JournalInit(Jtemplate, JBatch);

                                JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::Vendor, "Unidentified Account No", CopyStr((SalLines."Account No." + '-' + SalLines.Name), 1, 50),
                                        Balaccttype::"G/L Account", '', -SalLines.Amount, SalLines."Account No.", '', Transtype::" ", DActivity2, DBranch2, true);


                                //SalProcessingHeader.GET(SalLines."Salary Header No.");
                                SaccoSetup.TestField("Income Control Account");

                                JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoSetup."Income Control Account", PostingRemarks,
                                        Balaccttype::"G/L Account", '', SalLines.Amount, '', '', Transtype::" ", DActivity2, DBranch2, true);

                                if PostLinebyLine then begin
                                    JournalPost(Jtemplate, JBatch);


                                    SalLines.Posted := true;
                                    SalLines."Posted By" := UserId;
                                    SalLines."Posting Date" := PDate;
                                    SalLines."Posting Time" := Time;
                                    SalLines.Modify;
                                    Commit;//*
                                end;
                            end;

                        //if not PostLinebyLine then begin
                        dWindow.Update(3, CurrentRecordNo);
                        dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                    //end;
                    until SalLines.Next = 0;

                    if PostLinebyLine then begin
                        JournalPost(Jtemplate, JBatch);

                        SavingsACC.Reset;
                        SavingsACC.SetRange("Member No.", Account."Member No.");
                        if SavingsACC.Find('-') then begin
                            repeat
                                SavingsACC.Blocked := SavingsACC."Test Blocked";
                                SavingsACC."Test Blocked" := SavingsACC."test blocked"::" ";
                                SavingsACC.Modify;
                            until SavingsACC.Next = 0;
                        end;



                        SalLines.Posted := true;
                        SalLines."Posted By" := UserId;
                        SalLines."Posting Date" := PDate;
                        SalLines."Posting Time" := Time;
                        SalLines.Modify;
                        Commit;//*


                    end;
                end;

                //if not PostLinebyLine then begin
                dWindow.Close;
                //end;

                TestBatch := IncStr(TestBatch);
            end;
            if PostLinebyLine then begin

                SalLines.Reset;
                SalLines.SetRange(SalLines."Salary Header No.", No);
                if SalLines.Find('-') then begin
                    SalLines.Reset;
                    SalLines.SetRange(SalLines."Salary Header No.", No);
                    SalLines.SetRange(Posted, false);
                    if SalLines.Find('-') then begin

                        Posted := true;
                        "Posted By" := UserId;
                        Message('The salary batch has been posted successfully');

                    end;
                end;
                /*
                GLEntry.RESET;
                GLEntry.SETRANGE("Document No.",DocNo);
                GLEntry.SETRANGE("Posting Date",PDate);
                GLEntry.SETRANGE("G/L Account No.",SaccoSetup."Income Control Account");
                GLEntry.SETFILTER(Amount,'>0');
                GLEntry.SETRANGE(Reversed,FALSE);
                IF GLEntry.FINDFIRST THEN BEGIN
                    GLEntry.CALCSUMS(Amount);
                    MESSAGE('Income Control Account %1 \Income Amount %2',GLEntry.Amount,Amount);
                    IF GLEntry.Amount=Amount THEN BEGIN
                        JournalInit(Jtemplate,JBatch);
                        JournalInsert(Jtemplate,JBatch,DocNo,PDate,"Account Type","Account No",PostingRemarks,
                                BalAcctType::"G/L Account",SaccoSetup."Income Control Account",Amount,'','',TransType::" ",DActivity2,DBranch2,TRUE);

                        Posted:=TRUE;
                        "Posted By":=USERID;

                        MODIFY;
                        JournalPost(Jtemplate,JBatch);
                        MESSAGE('The salary batch has been posted successfully');
                    END;
                END;
                */
            end
            else
                Message('Template %1\Batch %2', Jtemplate, JBatch);

        end;

    end;

    local procedure PostSalaryLoans(SalHeaD: Record "Salary Header"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; Salaccno: Code[20]; AmtReceived: Decimal; IncomeAmount: Decimal; PostLinebyLine: Boolean; FactoryNo: Code[30])
    var
        Loans: Record Loans;
        Interest: Decimal;
        LRepayment: Decimal;
        SalLines: Record "Salary Lines";
        CreditLedger: Record "Cust. Ledger Entry";
        ProductType: Record "Product Setup";
        LedgerFee: Decimal;
        GenSetup: Record "Sacco Setup";
        j: Integer;
        AvailableAmt: Decimal;
        Percentage: Decimal;
        Amt: Decimal;
        BenevAmt: Decimal;
        NHIFAmt: Decimal;
        NHIFCharge: Decimal;
        NHIFDuty: Decimal;
        TotalNHIF: Decimal;
        Cust: Record Customer;
        AddBenevAmt: Decimal;
        MemberFactory: Record "Product Setup";
        DepCont: Decimal;
        DepAccount: Code[20];
        SavingsACC: Record Vendor;
        SkipLoans: Boolean;
    begin
        with SalHeaD do begin
            GenSetup.Get;

            RunBal := AmtReceived;
            AvailableAmt := RunBal;
            Percentage := 0;
            ExtDocNo := No;


            //Bonus - Income
            if (SalHeaD."Income Type" <> SalHeaD."income type"::" ") then begin

                //Recover Tea
                for j := 1 to 4 do begin

                    SkipLoans := false;
                    ProductType.Reset;
                    ProductType.SetCurrentkey("Recovery Priority");
                    if (SalHeaD."Income Type" = SalHeaD."income type"::Bonus) or (SalHeaD."Income Type" = SalHeaD."income type"::"Mini-Bonus") or (SalHeaD."Income Type" = SalHeaD."income type"::Tea) then
                        ProductType.SetRange("Repay Mode", ProductType."repay mode"::Tea)
                    else
                        if (SalHeaD."Income Type" = SalHeaD."income type"::Milk) then
                            ProductType.SetRange("Repay Mode", ProductType."repay mode"::Milk)
                        else
                            if (SalHeaD."Income Type" = SalHeaD."income type"::Salary) then
                                ProductType.SetRange("Repay Mode", ProductType."repay mode"::Salary)
                            else
                                if (SalHeaD."Income Type" = SalHeaD."income type"::"Staff Salary") then
                                    ProductType.SetRange("Repay Mode", ProductType."repay mode"::"Staff Salary")
                                else
                                    SkipLoans := true;

                    ProductType.SetRange("Product Class", ProductType."product class"::Credit);
                    if (ProductType.Find('-')) and (not SkipLoans) then begin
                        repeat

                            Loans.Reset;
                            Loans.SetRange(Loans."Member No.", MemberNo);
                            Loans.SetRange("Loan Product Type", ProductType."Product ID");
                            //Loans.SETRANGE(Loans."Disbursement Date",0D,"Last Loan Issue Date");
                            if j = 1 then
                                Loans.SetFilter("Outstanding Penalty", '>0')
                            else
                                if j = 2 then
                                    Loans.SetFilter("Outstanding Appraisal", '>0')
                                else
                                    if j = 3 then
                                        Loans.SetFilter("Outstanding Interest", '>0')
                                    else
                                        if j = 4 then begin
                                            Loans.SetFilter("Outstanding Principal", '>0');
                                        end
                                        else
                                            Error('Invalid Code - Programming Error');

                            if Loans.Find('-') then begin
                                repeat


                                    if RunBal > 0 then begin
                                        if j = 1 then
                                            RecoverSalaryLoans(Loans, SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, Salaccno, Transtype::"Penalty Paid")
                                        else
                                            if j = 2 then
                                                RecoverSalaryLoans(Loans, SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, Salaccno, Transtype::"Appraisal Paid")
                                            else
                                                if j = 3 then
                                                    RecoverSalaryLoans(Loans, SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, Salaccno, Transtype::"Interest Paid")
                                                else
                                                    if j = 4 then
                                                        RecoverSalaryLoans(Loans, SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, Salaccno, Transtype::"Principal Repayment");

                                    end;
                                until Loans.Next = 0;
                            end;

                        until ProductType.Next = 0;
                    end;

                end;//For j


            end;
            //Bonus - Income




            PostSalarySTO(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, Salaccno, PostLinebyLine, FactoryNo);



            if "Additional Deduction" > 0 then begin
                TestField("Add. Account No");
                TestField("Additional Ded. Details");

                if RunBal > "Additional Deduction" then begin
                    JournalInsert(Jtemplate, Jbatch, DocNo, PDate, "Add. Account Type", "Add. Account No", "Additional Ded. Details",
                              Balaccttype::"G/L Account", '', -"Additional Deduction", ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                    JournalInsert(Jtemplate, Jbatch, DocNo, PDate, Accttype::Savings, Salaccno, "Additional Ded. Details",
                        Balaccttype::"G/L Account", '', "Additional Deduction", ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                    RunBal -= "Additional Deduction";
                end;
            end;


        end;
    end;

    local procedure PostSalarySTO(SalHeaD: Record "Salary Header"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; Salaccno: Code[20]; PostLinebyLine: Boolean; FactoryNo: Code[20])
    var
        StandingOrderHeader: Record "Standing Order Header";
        SavingsAccounts: Record Vendor;
        ProductFactory: Record "Product Setup";
        AvailableBal: Decimal;
        BalAccountType: Enum "Gen. Journal Account Type";
        StandingOrdDeductStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register.";
        TCharges: Decimal;
        SLines: Record "Salary Lines";
        STOHeaderNo: Code[20];
        StandingOrderLines: Record "Standing Order Lines";
        LoanApps: Record Loans;
        LoanInterest: Decimal;
        LoanPrinciple: Decimal;
        STOHead: Record "Standing Order Header";
        STOlinesname: Text[80];
        AmountDedu: Decimal;
        STOAmount: Decimal;
        DeductionStatus: Option " ",Successfull,"Partial Deduction",Failed;
        AcctNo: Code[20];
        Desc: Text;
        Amt: Decimal;
        LoanNo: Code[20];
        LoanPrincipal: Decimal;
        LoanRepayment: Decimal;
        LoanPenalty: Decimal;
        LoanAppraisal: Decimal;
        IncomeAmt: Decimal;
        LineAmt: Decimal;
        SkipSTO: Boolean;
        AccFound: Boolean;
        GLAccRec: Record "G/L Account";
        SavAccRec: Record Vendor;
    begin
        with SalHeaD do begin

            SaccoSetup.Get;

            if RunBal < 0 then
                RunBal := 0;
            ExtDocNo := No;
            StandingOrderHeader.Reset;
            StandingOrderHeader.SetCurrentkey(StandingOrderHeader.Code);
            StandingOrderHeader.SetRange(StandingOrderHeader."Source Account No.", Salaccno);
            StandingOrderHeader.SetRange(StandingOrderHeader.Status, StandingOrderHeader.Status::Approved);
            if (SalHeaD."Income Type" = SalHeaD."income type"::Bonus) or (SalHeaD."Income Type" = SalHeaD."income type"::"Mini-Bonus") then begin
                StandingOrderHeader.SetFilter(StandingOrderHeader."Income Type", '%1|%2', SalHeaD."Income Type", StandingOrderHeader."income type"::Tea);
            end
            else begin
                StandingOrderHeader.SetRange(StandingOrderHeader."Income Type", SalHeaD."Income Type");
            end;
            StandingOrderHeader.SetFilter(Amount, '>0');


            if StandingOrderHeader.Find('-') then begin //*Header Info
                repeat


                    if RunBal < 0 then
                        RunBal := 0;


                    SkipSTO := false;

                    if StandingOrderHeader."Grower No." <> '' then
                        if StandingOrderHeader."Grower No." <> FactoryNo then
                            SkipSTO := true;



                    if not SkipSTO then begin


                        STOHeaderNo := StandingOrderHeader.Code;

                        AvailableBal := RunBal;
                        AmountDedu := 0;




                        if StandingOrderHeader."Next Run Date" <= CalcDate('CM', PDate) then
                            if SavingsAccounts.Get(StandingOrderHeader."Source Account No.") then begin
                                //TCharges:=getTransactionCharges(StandingOrderHeader,FALSE);
                                //AvailableBal-=TCharges;
                                RunBal := MemberActivities.GetAccountBalance(SavingsAccounts."No.");
                                RunBal += GetJournalCredits(Jtemplate, Jbatch, Accttype::Savings, SavingsAccounts."No.");
                                RunBal -= GetJournalDebits(Jtemplate, Jbatch, Accttype::Savings, SavingsAccounts."No.");

                                IncomeAmt := 0;
                                if StandingOrderHeader."STO Type" = StandingOrderHeader."sto type"::Amount then
                                    STOAmount := StandingOrderHeader.Amount
                                else
                                    if StandingOrderHeader."STO Type" = StandingOrderHeader."sto type"::Percentage then begin

                                        SLines.Reset;
                                        SLines.SetRange("Salary Header No.", No);
                                        SLines.SetRange("Account No.", Salaccno);
                                        SLines.SetRange(Posted, false);
                                        if SLines.Find('-') then begin
                                            SLines.CalcSums(Amount);
                                            IncomeAmt := SLines.Amount;
                                        end;
                                        if IncomeAmt <= 0 then
                                            Error('Income Amount MUST be greater than Zero');

                                        STOAmount := ROUND(StandingOrderHeader.Amount / 100 * IncomeAmt);
                                    end;

                                if StandingOrderHeader.Balance > STOAmount then
                                    StandingOrderHeader.Balance := STOAmount;

                                if StandingOrderHeader.Balance > 0 then
                                    STOAmount := StandingOrderHeader.Balance;

                                //IF SavingsAccounts."No." = '1024745' THEN
                                //  MESSAGE('STOAmount %1 Bal %2',STOAmount,RunBal);


                                if AvailableBal >= STOAmount then begin
                                    DeductionStatus := Deductionstatus::Successfull;
                                    StandingOrderHeader.Balance := 0;
                                end
                                else begin
                                    if not StandingOrderHeader."Allow Partial Deduction" then begin
                                        DeductionStatus := Deductionstatus::Failed;
                                        StandingOrderHeader.Balance := STOAmount;
                                        RunBal := 0;
                                    end
                                    else begin
                                        if AvailableBal > TCharges then begin
                                            DeductionStatus := Deductionstatus::"Partial Deduction";
                                            StandingOrderHeader.Balance := STOAmount - AvailableBal;
                                        end
                                        else begin
                                            DeductionStatus := Deductionstatus::Failed;
                                            StandingOrderHeader.Balance := STOAmount;
                                            RunBal := 0;
                                        end;
                                    end;
                                end;
                                if StandingOrderHeader.Balance < 0 then
                                    StandingOrderHeader.Balance := 0;


                                StandingOrderLines.Reset;
                                StandingOrderLines.SetCurrentkey(Priority);
                                StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader.Code);

                                if SalHeaD."Recovery Type" = SalHeaD."recovery type"::"Skip Loans" then
                                    StandingOrderLines.SetFilter("Destination Account Type", '<>%1', StandingOrderLines."destination account type"::Credit);

                                //StandingOrderLines.SETFILTER("Destination Account No.",'<>%1','');
                                if StandingOrderLines.Find('-') then begin
                                    repeat

                                        if RunBal < 0 then
                                            RunBal := 0;

                                        STOlinesname := StandingOrderLines."Destination Account Name";
                                        LineAmt := StandingOrderLines.Amount;
                                        if StandingOrderHeader."STO Type" = StandingOrderHeader."sto type"::Percentage then
                                            LineAmt := ROUND(IncomeAmt * StandingOrderLines.Amount / 100);

                                        //IF StandingOrderHeader.Code = 'STO019113' THEN
                                        //ERROR('LineAmt %1\RunBal %2',LineAmt,RunBal);

                                        case StandingOrderLines."Destination Account Type" of
                                            StandingOrderLines."destination account type"::Internal,
                                            StandingOrderLines."destination account type"::"G/L Account",
                                            StandingOrderLines."destination account type"::External:
                                                begin

                                                    AccFound := false;
                                                    case StandingOrderLines."Destination Account Type" of
                                                        StandingOrderLines."destination account type"::External:
                                                            begin
                                                                AcctType := Accttype::"G/L Account";
                                                                AcctNo := SaccoSetup."External STO Account No.";
                                                                if GLAccRec.Get(AcctNo) then
                                                                    AccFound := true;
                                                            end;
                                                        StandingOrderLines."destination account type"::Internal:
                                                            begin
                                                                AcctType := AcctType::Savings;
                                                                AcctNo := StandingOrderLines."Destination Account No.";
                                                                if SavAccRec.Get(AcctNo) then
                                                                    AccFound := true;
                                                            end;
                                                        StandingOrderLines."destination account type"::"G/L Account":
                                                            begin
                                                                AcctType := AcctType::"G/L Account";
                                                                AcctNo := StandingOrderLines."Destination Account No.";
                                                                if GLAccRec.Get(AcctNo) then
                                                                    AccFound := true;
                                                            end;
                                                    end;

                                                    Desc := PadStr('STO:-' + Format(StandingOrderHeader.Code) + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
                                                    Amt := LineAmt;

                                                    if AccFound then begin


                                                        LoanNo := StandingOrderLines."Loan No.";
                                                        BalAcctType := Balaccttype::"G/L Account";
                                                        BalAcctNo := '';
                                                        ExtDocNo := StandingOrderHeader.Code;

                                                        if Amt > RunBal then
                                                            Amt := RunBal;

                                                        JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType, AcctNo, Desc, BalAcctType, BalAcctNo, -Amt, ExtDocNo, LoanNo, TransType, DActivity2, DBranch2, true);

                                                        RunBal -= Abs(Amt);
                                                        AmountDedu += Abs(Amt);
                                                    end;

                                                end;

                                            StandingOrderLines."destination account type"::Credit:
                                                begin

                                                    LoanInterest := 0;
                                                    LoanPrincipal := 0;
                                                    LoanRepayment := 0;

                                                    LoanApps.Reset;
                                                    LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                                                    if LoanApps.Find('-') then begin
                                                        if StandingOrderLines."Destination Account No." = '' then begin
                                                            StandingOrderLines."Destination Account No." := LoanApps."Member No.";
                                                            StandingOrderLines.Modify;

                                                        end;
                                                        LoanApps.CalcFields("Outstanding Penalty", "Outstanding Appraisal", "Outstanding Interest", "Outstanding Principal");

                                                        LoanPenalty := 0;
                                                        if LoanApps."Outstanding Penalty" > 0 then begin
                                                            LoanPenalty := LoanApps."Outstanding Penalty" - GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, LoanApps."Member No.", LoanApps."Loan No.", Transtype::"Penalty Paid");
                                                            if LoanPenalty < 0 then
                                                                LoanPenalty := 0;
                                                        end;

                                                        LoanAppraisal := 0;
                                                        if LoanApps."Outstanding Appraisal" > 0 then begin

                                                            LoanAppraisal := LoanApps."Outstanding Appraisal" - GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, LoanApps."Member No.", LoanApps."Loan No.", Transtype::"Appraisal Paid");

                                                            if LoanAppraisal < 0 then
                                                                LoanAppraisal := 0;
                                                        end;

                                                        LoanInterest := 0;
                                                        if LoanApps."Outstanding Interest" > 0 then begin
                                                            LoanInterest := LoanApps."Outstanding Interest" - GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, LoanApps."Member No.", LoanApps."Loan No.", Transtype::"Interest Paid");

                                                            if LoanInterest < 0 then
                                                                LoanInterest := 0;
                                                        end;


                                                        LoanPrincipal := LineAmt;


                                                        if LoanPenalty > 0 then begin

                                                            AcctType := AcctType::Credit;
                                                            AcctNo := StandingOrderLines."Destination Account No.";
                                                            Desc := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                                     Format(Transtype::"Penalty Paid"), 50);

                                                            LoanNo := StandingOrderLines."Loan No.";
                                                            BalAcctType := Balaccttype::"G/L Account";
                                                            BalAcctNo := '';
                                                            ExtDocNo := StandingOrderHeader.Code;
                                                            TransType := Transtype::"Penalty Paid";

                                                            if LoanPenalty > LineAmt then begin
                                                                LoanPenalty := LineAmt;
                                                                LoanAppraisal := 0;
                                                                LoanInterest := 0;
                                                                LoanPrincipal := 0;
                                                            end;

                                                            if RunBal > LoanPenalty then
                                                                Amt := -LoanPenalty
                                                            else
                                                                Amt := -RunBal;

                                                            JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType, AcctNo, Desc, BalAcctType, BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, DActivity2, DBranch2, true);

                                                            RunBal -= Abs(Amt);
                                                            AmountDedu += Abs(Amt);
                                                            LoanPrincipal -= Abs(Amt);
                                                        end;




                                                        if LoanAppraisal > 0 then begin

                                                            AcctType := AcctType::Credit;
                                                            AcctNo := StandingOrderLines."Destination Account No.";
                                                            Desc := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                                     Format(Transtype::"Appraisal Paid"), 50);

                                                            LoanNo := StandingOrderLines."Loan No.";
                                                            BalAcctType := Balaccttype::"G/L Account";
                                                            BalAcctNo := '';
                                                            ExtDocNo := StandingOrderHeader.Code;
                                                            TransType := Transtype::"Appraisal Paid";

                                                            if LoanAppraisal > LineAmt then begin
                                                                LoanAppraisal := LineAmt;
                                                                LoanInterest := 0;
                                                                LoanPrincipal := 0;
                                                            end;

                                                            if RunBal > LoanAppraisal then
                                                                Amt := -LoanAppraisal
                                                            else
                                                                Amt := -RunBal;

                                                            JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType, AcctNo, Desc, BalAcctType, BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, DActivity2, DBranch2, true);

                                                            RunBal -= Abs(Amt);
                                                            AmountDedu += Abs(Amt);
                                                            LoanPrincipal -= Abs(Amt);
                                                        end;



                                                        if LoanInterest > 0 then begin

                                                            AcctType := AcctType::Credit;
                                                            AcctNo := StandingOrderLines."Destination Account No.";
                                                            Desc := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                                     Format(Transtype::"Interest Paid"), 50);

                                                            LoanNo := StandingOrderLines."Loan No.";
                                                            BalAcctType := Balaccttype::"G/L Account";
                                                            BalAcctNo := '';
                                                            ExtDocNo := StandingOrderHeader.Code;
                                                            TransType := Transtype::"Interest Paid";

                                                            if LoanInterest > StandingOrderLines.Amount then begin
                                                                LoanInterest := StandingOrderLines.Amount;
                                                                LoanPrincipal := 0;
                                                            end;

                                                            if RunBal > LoanInterest then
                                                                Amt := -LoanInterest
                                                            else
                                                                Amt := -RunBal;

                                                            JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType, AcctNo, Desc, BalAcctType, BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, DActivity2, DBranch2, true);

                                                            RunBal -= Abs(Amt);
                                                            AmountDedu += Abs(Amt);
                                                            LoanPrincipal -= Abs(Amt);
                                                        end;




                                                        if (LoanPrincipal > 0) then begin


                                                            LoanRepayment := LoanApps."Outstanding Principal" - GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, LoanApps."Member No.", LoanApps."Loan No.", Transtype::"Principal Repayment");

                                                            if LoanRepayment < 0 then
                                                                LoanRepayment := 0;

                                                            AcctType := AcctType::Credit;
                                                            AcctNo := StandingOrderLines."Destination Account No.";

                                                            LoanNo := StandingOrderLines."Loan No.";

                                                            ExtDocNo := StandingOrderHeader.Code;

                                                            if LoanRepayment >= LoanPrincipal then
                                                                LoanRepayment := LoanPrincipal;

                                                            if RunBal >= LoanRepayment then
                                                                Amt := -LoanRepayment
                                                            else
                                                                Amt := -RunBal;


                                                            Desc := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                 Format(Transtype::"Principal Repayment"), 50);

                                                            BalAcctType := Balaccttype::"G/L Account";
                                                            BalAcctNo := '';
                                                            ExtDocNo := StandingOrderHeader.Code;
                                                            TransType := Transtype::"Principal Repayment";

                                                            JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType, AcctNo, Desc, BalAcctType, BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, DActivity2, DBranch2, true);

                                                            RunBal -= Abs(Amt);
                                                            AmountDedu += Abs(Amt);

                                                        end;
                                                    end;
                                                end;
                                        end;
                                    until StandingOrderLines.Next = 0;
                                end;



                                AcctType := Accttype::Savings;
                                AcctNo := Salaccno;
                                Desc := PadStr('STO:-' + Format(StandingOrderHeader.Code) + '-' + Format(STOlinesname), 50);
                                Amt := AmountDedu;
                                LoanNo := '';
                                BalAcctType := Balaccttype::"G/L Account";
                                BalAcctNo := '';
                                ExtDocNo := StandingOrderHeader.Code;

                                JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType, AcctNo, Desc, BalAcctType, BalAcctNo, Amt, ExtDocNo, LoanNo, TransType, DActivity2, DBranch2, true);




                                if PostLinebyLine then begin
                                    if DeductionStatus = Deductionstatus::Successfull then begin
                                        StandingOrderHeader."Next Run Date" := CalcDate(StandingOrderHeader."Frequency (Months)", StandingOrderHeader."Next Run Date");
                                    end
                                    else begin
                                        StandingOrderHeader."Next Run Date" := CalcDate('-CM', PDate);
                                    end;


                                    if StandingOrderHeader."STO Type" = StandingOrderHeader."sto type"::Amount then
                                        STOAmount := StandingOrderHeader.Amount
                                    else
                                        if StandingOrderHeader."STO Type" = StandingOrderHeader."sto type"::Percentage then begin
                                            IncomeAmt := 0;
                                            SLines.Reset;
                                            SLines.SetRange("Salary Header No.", No);
                                            SLines.SetRange("Account No.", Salaccno);
                                            SLines.SetRange(Posted, false);
                                            if SLines.Find('-') then begin
                                                SLines.CalcSums(Amount);
                                                IncomeAmt := SLines.Amount;
                                            end;
                                            if IncomeAmt <= 0 then
                                                Error('Income Amount MUST be greater than Zero');

                                            STOAmount := StandingOrderHeader.Amount / 100 * IncomeAmt;
                                        end;


                                    InitializeStandingOrderRegister('', Today, StandingOrderHeader.Code, '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                                                StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                                                DeductionStatus, STOAmount, AmountDedu, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                                                StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader.Code);

                                    StandingOrderHeader.Modify;
                                end;

                            end;

                    end;


                until StandingOrderHeader.Next = 0;
            end;

        end;
    end;


    procedure RecoverSalaryLoans(Loans: Record Loans; SalHeaD: Record "Salary Header"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; var RunBal: Decimal; MemberNo: Code[20]; Salaccno: Code[20]; Transaction: Enum "Transaction Type Enum")
    var
        LedgerFee: Decimal;
        Interest: Decimal;
        CreditLedger: Record "Cust. Ledger Entry";
        LRepayment: Decimal;
        ProductType: Record "Product Setup";
        Penalty: Decimal;
        Amt: Decimal;
        Appraisal: Decimal;
        AppraisalPaid: Decimal;
        TotalAppraisal: Decimal;
        InterestPaid: Decimal;
        TotalInterest: Decimal;
        LRec: Record Loans;
        PrPaid: Decimal;
        LoanType: Record "Product Setup";
    begin



        Loans.SetFilter("Date Filter", '..%1', Today);
        ExtDocNo := SalHeaD.No;



        if Transaction = Transaction::"Penalty Paid" then begin
            Loans.CalcFields(Loans."Outstanding Penalty");

            if RunBal > 0 then begin

                if Loans."Outstanding Penalty" > 0 then begin
                    Penalty := Loans."Outstanding Penalty";



                    if (SalHeaD."Income Type" = SalHeaD."income type"::Milk) then
                        if SalHeaD."Recovery Type" = SalHeaD."recovery type"::"Half Amount" then
                            Penalty := ROUND(Penalty / 2);

                    Penalty -= GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Member No.", Loans."Loan No.", Transtype::"Penalty Paid");

                    if SalHeaD."Recovery Type" = SalHeaD."recovery type"::"Skip Loans" then
                        Penalty := 0;

                    if Penalty > 0 then begin

                        Penalty := ROUND(Penalty, 0.01, '>');
                        if Penalty > RunBal then
                            Penalty := RunBal;

                        JournalInsert(Jtemplate, Jbatch, DocNo, PDate, Accttype::Credit, Loans."Member No.", 'Penalty Paid',
                                Balaccttype::"G/L Account", '', -Penalty, ExtDocNo, Loans."Loan No.", Transtype::"Penalty Paid", DActivity2, DBranch2, true);


                        JournalInsert(Jtemplate, Jbatch, DocNo, PDate, Accttype::Savings, Salaccno, PadStr('Penalty Paid  - ' + Loans."Loan Product Type Name", 50),
                                Balaccttype::"G/L Account", '', Penalty, ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                        RunBal -= Penalty;

                    end;
                end;

            end;
        end;



        if Transaction = Transaction::"Appraisal Paid" then begin
            Loans.CalcFields(Loans."Outstanding Appraisal");

            if RunBal > 0 then begin

                if Loans."Outstanding Appraisal" > 0 then begin
                    Appraisal := Loans."Outstanding Appraisal";

                    if (SalHeaD."Income Type" = SalHeaD."income type"::Milk) then
                        if SalHeaD."Recovery Type" = SalHeaD."recovery type"::"Half Amount" then
                            Penalty := ROUND(Penalty / 2);

                    Appraisal -= GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Member No.", Loans."Loan No.", Transtype::"Appraisal Paid");

                    if SalHeaD."Recovery Type" = SalHeaD."recovery type"::"Skip Loans" then
                        Penalty := 0;

                    if Appraisal > 0 then begin

                        Appraisal := ROUND(Appraisal, 0.01, '>');
                        if Appraisal > RunBal then
                            Appraisal := RunBal;

                        JournalInsert(Jtemplate, Jbatch, DocNo, PDate, Accttype::Credit, Loans."Member No.", 'Appraisal Paid',
                                Balaccttype::"G/L Account", '', -Appraisal, ExtDocNo, Loans."Loan No.", Transtype::"Appraisal Paid", DActivity2, DBranch2, true);


                        JournalInsert(Jtemplate, Jbatch, DocNo, PDate, Accttype::Savings, Salaccno, PadStr('Appraisal Paid  - ' + Loans."Loan Product Type Name", 50),
                                Balaccttype::"G/L Account", '', Appraisal, ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                        RunBal -= Appraisal;

                    end;
                end;

            end;
        end;


        if Transaction = Transaction::"Interest Paid" then begin
            Loans.CalcFields(Loans."Outstanding Interest");

            if RunBal > 0 then begin

                if Loans."Outstanding Interest" > 0 then begin
                    Interest := Loans."Outstanding Interest";

                    if Interest < 0 then
                        Interest := 0;

                    if (SalHeaD."Income Type" = SalHeaD."income type"::Milk) then
                        if SalHeaD."Recovery Type" = SalHeaD."recovery type"::"Half Amount" then
                            Interest := ROUND(Interest / 2);


                    if SalHeaD."Recovery Type" = SalHeaD."recovery type"::"Skip Loans" then
                        Interest := 0;



                    if Interest > 0 then begin

                        Interest := ROUND(Interest, 0.01, '>');

                        if Interest > RunBal then
                            Interest := RunBal;



                        JournalInsert(Jtemplate, Jbatch, DocNo, PDate, Accttype::Credit, Loans."Member No.", 'Interest Paid',
                                Balaccttype::"G/L Account", '', -Interest, ExtDocNo, Loans."Loan No.", Transtype::"Interest Paid", DActivity2, DBranch2, true);


                        JournalInsert(Jtemplate, Jbatch, DocNo, PDate, Accttype::Savings, Salaccno, PadStr('Interest Paid  - ' + Loans."Loan Product Type Name", 50),
                                Balaccttype::"G/L Account", '', Interest, ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                        RunBal -= Interest;

                    end;
                end;

            end;
        end;






        if Transaction = Transaction::"Principal Repayment" then begin

            Loans.CalcFields(Loans."Outstanding Principal", "Outstanding Interest");


            if RunBal > 0 then begin
                if Loans."Outstanding Principal" > 0 then begin
                    LoanType.Get(Loans."Loan Product Type");

                    LRepayment := Loans."Loan Principle Repayment";

                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then
                        LRepayment := Loans.Repayment - Loans."Outstanding Interest";

                    if LRepayment <= 0 then
                        LRepayment := Loans.Repayment;


                    LRec.Reset;
                    LRec.SetRange("Loan No.", Loans."Loan No.");
                    LRec.SetFilter("Date Filter", '%1..%2', CalcDate('-CM', PDate), CalcDate('CM', PDate));
                    if LRec.FindFirst then begin
                        LRec.CalcFields("Schedule Principal");
                        if LRepayment < LRec."Schedule Principal" then
                            LRepayment := LRec."Schedule Principal";
                    end;




                    if LRepayment <= 0 then
                        if Loans.Installments > 0 then
                            LRepayment := ROUND(Loans."Approved Amount" / Loans.Installments, 0.01, '>');



                    ProductType.Get(Loans."Loan Product Type");
                    if ProductType."Default Installments" = 1 then
                        LRepayment := Loans."Outstanding Principal";


                    if LRepayment <= 0 then
                        LRepayment := Loans."Outstanding Principal";

                    //IF SalHeaD."Income Type"=SalHeaD."Income Type"::Bonus THEN
                    //  LRepayment:=Loans."Outstanding Principal";


                    if (SalHeaD."Income Type" = SalHeaD."income type"::Milk) then
                        if SalHeaD."Recovery Type" = SalHeaD."recovery type"::"Half Amount" then
                            LRepayment := ROUND(LRepayment / 2);


                    LRepayment -= GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Member No.", Loans."Loan No.", Transtype::"Principal Repayment");



                    if SalHeaD."Recovery Type" = SalHeaD."recovery type"::"Skip Loans" then
                        LRepayment := 0;

                    if LRepayment > 0 then begin

                        if LRepayment > Loans."Outstanding Principal" then
                            LRepayment := Loans."Outstanding Principal";


                        LRepayment := ROUND(LRepayment, 0.01, '>');

                        if LRepayment > RunBal then
                            LRepayment := RunBal;


                        JournalInsert(Jtemplate, Jbatch, DocNo, PDate, Accttype::Credit, Loans."Member No.", 'Loan Repayment',
                                Balaccttype::"G/L Account", '', -LRepayment, ExtDocNo, Loans."Loan No.", Transtype::"Principal Repayment", DActivity2, DBranch2, true);


                        JournalInsert(Jtemplate, Jbatch, DocNo, PDate, Accttype::Savings, Salaccno, 'Loan Repayment - ' + Loans."Loan Product Type",
                                Balaccttype::"G/L Account", '', LRepayment, ExtDocNo, '', Transtype::" ", DActivity2, DBranch2, true);

                        RunBal -= LRepayment;
                    end;

                end;
            end;
        end;
    end;


    procedure InitializeStandingOrderRegister(RNo: Code[10]; RDateProcessed: Date; RDocNo: Code[10]; RNoSeries: Code[10]; RSourceAccountNo: Code[20]; RSourceAccountName: Text; RMemberNo: Code[20]; RStaffNo: Code[10]; RPartialDeduction: Boolean; RDeductionStatus: Option " ",Successfull,"Partial Deduction",Failed; RDeductionAmount: Decimal; RAmountDeducted: Decimal; RStartDate: Date; RDuration: DateFormula; RFrequency: DateFormula; REndDate: Date; Rremarks: Text; Reft: Boolean; RTransferEft: Boolean; STONo: Code[20])
    var
        LineNo: Code[10];
        StandingOrdSRegister: Record "Standing Order Register.";
    begin

        StandingOrdSRegister.Reset;
        StandingOrdSRegister.SetRange("Standing Order No.", STONo);
        StandingOrdSRegister.SetRange("Date Processed", RDateProcessed);
        StandingOrdSRegister.SetRange("Deduction Status", RDeductionStatus);
        StandingOrdSRegister.SetRange("Amount Deducted", RAmountDeducted);
        StandingOrdSRegister.SetRange(Amount, RDeductionAmount);
        StandingOrdSRegister.SetRange("Source Account No.", RSourceAccountNo);
        if not StandingOrdSRegister.FindFirst then begin

            StandingOrdSRegister.Init;
            StandingOrdSRegister."No." := RNo;
            StandingOrdSRegister."Date Processed" := RDateProcessed;
            StandingOrdSRegister."Document No." := RDocNo;
            StandingOrdSRegister."No. Series" := RNoSeries;
            StandingOrdSRegister."Source Account No." := RSourceAccountNo;
            StandingOrdSRegister."Source Account Name" := RSourceAccountName;
            StandingOrdSRegister."Member No" := RMemberNo;
            StandingOrdSRegister."Staff/Payroll No." := RStaffNo;
            StandingOrdSRegister."Allow Partial Deduction" := RPartialDeduction;
            StandingOrdSRegister."Deduction Status" := RDeductionStatus;
            StandingOrdSRegister.Amount := RDeductionAmount;
            StandingOrdSRegister."Amount Deducted" := RAmountDeducted;
            StandingOrdSRegister."Effective/Start Date" := RStartDate;
            StandingOrdSRegister.Duration := RDuration;
            StandingOrdSRegister.Frequency := RFrequency;
            StandingOrdSRegister."End Date" := REndDate;
            StandingOrdSRegister.Remarks := Rremarks;
            StandingOrdSRegister.EFT := Reft;
            StandingOrdSRegister."Transfered to EFT" := RTransferEft;
            StandingOrdSRegister."Standing Order No." := STONo;
            StandingOrdSRegister.Insert(true);

        end;
    end;


    procedure SendReceiptNotifications(ReceiptNo: Code[20])
    var
        SaccoSetup: Record "Sacco Setup";
        CompInfo: Record "Company Information";
        FileName: Text;
        FilePath: Text;
        Members: Record Customer;
        Msg: Text;
        SenderName: Text;
        SenderAddress: Text;
        ReceiptHeader: Record "Receipt Header";
    begin
        SaccoSetup.Get;


        ReceiptHeader.Reset;
        ReceiptHeader.SetRange("No.", ReceiptNo);
        if ReceiptHeader.FindFirst then begin

            if Members.Get(ReceiptHeader."Customer No.") then begin

                if SaccoSetup."Send Receipt SMS" then begin
                    Msg := 'Dear ' + Members."First Name" + ', Your Receipt of KES ' + Format(ReceiptHeader."Amount Recieved") + ' has been processed and will reflect in your account.';
                    MemberActivities.SendSms(Smssource::"Deposit Confirmation", Members."Mobile Phone No.", Msg, Members."No.", '', false, false);
                    Message('SMS Sent');
                end;


                if (SaccoSetup."Send Receipt Email") then begin
                    /*     
                    SMTPSetup.Get;

                    CompInfo.Get;

                    SenderName := CompInfo.Name;
                    SenderAddress := SMTPSetup."User ID";
                    if SenderName = '' then
                        SenderName := COMPANYNAME;

                    FileName := ReceiptHeader."No." + '-' + 'Receipt.pdf';
                    FilePath := SMTPSetup."File Path" + FileName;

                    if FILE.Exists(FilePath) then
                        FILE.Erase(FilePath);


                    Report.SaveAsPdf(50007, FilePath, ReceiptHeader);




                    SMTP.CreateMessage(SenderName, SenderAddress, Members."E-Mail", 'RECEIPT: ' + UpperCase(SenderName), '', true);

                    SMTPSetup.CalcFields("Email Footer Image", "Email Header Image");

                    if SMTPSetup."Email Header Image".Hasvalue then
                        SMTP.AppendBody('<img src="data:image/png;base64,' + MemberActivities.Base64Header + '" alt="" />');
                    SMTP.AppendBody('<br><br>');
                    SMTP.AppendBody('Dear ' + Members."First Name");
                    SMTP.AppendBody('<br><br>');
                    SMTP.AppendBody('We have received your deposit of KES ' + Format(ReceiptHeader."Amount Recieved") + ' and will reflect in your Account.');
                    SMTP.AppendBody('<br><br>');
                    SMTP.AppendBody('Find attached your Receipt.');
                    SMTP.AppendBody('<br><br>');

                    SMTP.AppendBody('<br><br>');
                    SMTP.AppendBody('Kind Regards,');
                    SMTP.AppendBody('<br>');
                    SMTP.AppendBody(SenderName);
                    SMTP.AppendBody('<br><br>');
                    if SMTPSetup."Email Footer Image".Hasvalue then
                        SMTP.AppendBody('<img src="data:image/png;base64,' + MemberActivities.Base64Footer + '" alt="" />');
                    SMTP.AppendBody('<br><br>');
                    SMTP.AppendBody('<hr>');

                    SMTP.AddAttachment(FilePath, FileName);
                    Sleep(3000);


                    if SMTP.TrySend then
                        Message('Email Sent'); */
                end;

            end;
        end;
    end;


    procedure PostMonthlyCheckoff(CheckoffHeader: Record "Monthly Checkoff Header"; JTransfer: Boolean)
    var
        Loans: Record Loans;
        CheckoffLines: Record "Monthly Checkoff Lines";
        RunBal: Decimal;
        LineNo: Integer;
        Txt0000: label 'Loan Repayment';
        Txt0001: label 'Interest Paid';
        Amortised: Decimal;
        Recovery: Decimal;
        Interest: Decimal;
        Txt0002: label 'Deposit Contribution';
        SavingsAccounts: Record Vendor;
        DepositCont: Decimal;
        Txt0003: label 'Excess Deposit';
        LoanAmount: Decimal;
        Txt0004: label 'Checkoff schedule and amount is not equal';
        Txt0005: label 'Batch Posted successfully';
        Txt0006: label 'Principle Recovery';
        LoansBill: Record Loans;
        Txt0007: label 'Loan Repayment -Bills';
        ProductType: Record "Product Setup";
        ShareCap: Decimal;
        Txt0008: label 'Share Capital';
        ProgressWindow: Dialog;
        Dim1: Code[20];
        Dim2: Code[20];
        Members: Record Customer;
        UserSetup: Record "User Setup";
        Txt0009: label 'Vendor:-';
        SavingsAcc: Code[20];
        Txt0010: label 'Registration Fee';
        Mdays: Integer;
        Txt0011: label 'Savings Contribution';
        DocNo: Code[20];
        PDate: Date;
        IntPaid: Decimal;
        PrPaid: Decimal;
        Desc: Text;
        ExtDocNo: Code[20];
        PenPaid: Decimal;
        AppPaid: Decimal;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        SaccoSetup: Record "Sacco Setup";
        MemberAccounts: Record Vendor;
        BNo: Code[20];
    begin

        CheckoffHeader.CalcFields(CheckoffHeader."CHK Line Amount");

        if CheckoffHeader."CHK Line Amount" <> CheckoffHeader.Amount then
            Error(Txt0004);

        RunBal := 0;

        JTemplate := '';
        JBatch := '';

        GetReceiptJournalTemplate(JTemplate, JBatch);

        if not JTransfer then
            PDate := CheckoffHeader."Posting Date";

        DocNo := CheckoffHeader."No.";

        JournalInit(JTemplate, JBatch);

        Dim1 := CheckoffHeader."Global Dimension 1 Code";
        Dim2 := CheckoffHeader."Global Dimension 2 Code";


        BNo := '001';
        while (BNo <= CheckoffHeader."No. Of Batches") do begin

            CheckoffLines.Reset;
            CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
            CheckoffLines.SetRange("Batch No.", BNo);
            CheckoffLines.SetRange("Savings Account", true);
            if CheckoffLines.Find('-') then begin
                repeat
                    MemberAccounts.get(CheckoffLines."Account No.");
                    MemberAccounts."Test Blocked" := MemberAccounts."Test Blocked"::" ";
                    if MemberAccounts.Blocked <> MemberAccounts.Blocked::" " then begin
                        MemberAccounts."Test Blocked" := MemberAccounts.Blocked;
                        MemberAccounts.Blocked := MemberAccounts.Blocked::" ";
                    end;

                    MemberAccounts.Modify();
                until CheckoffLines.Next = 0;
            end;

            CheckoffLines.Reset;
            CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
            CheckoffLines.SetRange(CheckoffLines.Posted, false);
            CheckoffLines.SetRange("Batch No.", BNo);
            //CheckoffLines.SetRange("Savings Account", true);
            //CheckoffLines.SetRange("Product ID", 'L03');
            //CheckoffLines.SetRange("Member No.", '02005');
            if CheckoffLines.Find('-') then begin

                //if JTransfer then begin

                dWindow.Open('Generating Journal Lines:          #1#########\'
                                        + 'Accounts:             #2#########\'
                                        + 'Counter:              #3#########\'
                                        + 'Progress:             @4@@@@@@@@@\'
                                        + 'Press Esc to abort');

                CurrentRecordNo := 0;
                NoOfRecords := CheckoffLines.Count;
                dWindow.Update(2, NoOfRecords);

                //end;

                if not JTransfer then
                    JournalInit(JTemplate, JBatch);

                SaccoSetup.Get();
                SaccoSetup.testfield("Checkoff Control");



                repeat
                    CurrentRecordNo += 1;
                    //if JTransfer then
                    dWindow.Update(1, BNo);


                    RunBal := CheckoffLines.Amount;
                    ExtDocNo := CheckoffLines."Batch No.";

                    Desc := CopyStr(CheckoffHeader.Description, 1, 50);
                    JournalInsert(JTemplate, JBatch, DocNo, PDate, CheckoffHeader."Account Type"::"G/L Account", SaccoSetup."Checkoff Control", Desc,
                            Balaccttype::"G/L Account", '', CheckoffLines.Amount, ExtDocNo, '', Transtype::" ", Dim1, Dim2, true);


                    Desc := CopyStr(Format(CheckoffLines.Type) + ' - ' + CheckoffHeader.Description, 1, 50);

                    Transtype := Transtype::" ";
                    if CheckoffLines."Savings Account" then begin

                        Desc := CopyStr(CheckoffHeader.Description, 1, 50);
                        AcctType := AcctType::Savings;

                        JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype, CheckoffLines."Account No.", Desc,
                                Balaccttype::"G/L Account", '', -CheckoffLines.Amount, ExtDocNo, CheckoffLines."Loan No.", Transtype, Dim1, Dim2, true);

                        if not JTransfer then begin
                            CheckoffLines.Posted := true;
                            CheckoffLines.Modify;
                        end;

                    end
                    else begin


                        CheckoffLines.TestField("Loan No.");
                        Loans.Get(CheckoffLines."Loan No.");

                        if CheckoffLines.Type = CheckoffLines.Type::Interest then
                            TransType := TransType::"Interest Paid";
                        if CheckoffLines.Type = CheckoffLines.Type::Penalty then
                            TransType := TransType::"Penalty Paid";
                        if CheckoffLines.Type = CheckoffLines.Type::Principal then
                            TransType := TransType::"Principal Repayment";

                        AcctType := AcctType::Credit;


                        JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype, Loans."Member No.", Desc,
                                Balaccttype::"G/L Account", '', -CheckoffLines.Amount, ExtDocNo, CheckoffLines."Loan No.", Transtype, Dim1, Dim2, true);

                        if not JTransfer then begin
                            CheckoffLines.Posted := true;
                            CheckoffLines.Modify;
                        end;

                    end;


                    //if CheckoffLines."Savings Account" then




                    //if JTransfer then begin
                    dWindow.Update(3, CurrentRecordNo);
                    dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                //end;
                until CheckoffLines.Next = 0;
                //if JTransfer then
                dWindow.Close;


                if not JTransfer then begin
                    JournalPost(JTemplate, JBatch);

                end;

            end;



            CheckoffLines.Reset;
            CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
            CheckoffLines.SetRange("Batch No.", BNo);
            CheckoffLines.SetRange("Savings Account", true);
            if CheckoffLines.Find('-') then begin
                repeat
                    MemberAccounts.get(CheckoffLines."Account No.");

                    if MemberAccounts."Test Blocked" <> MemberAccounts."Test Blocked"::" " then begin
                        MemberAccounts."Blocked" := MemberAccounts."Test Blocked";
                        MemberAccounts."Test Blocked" := MemberAccounts."Test Blocked"::" ";
                    end;

                    MemberAccounts.Modify();
                until CheckoffLines.Next = 0;
            end;
            BNo := IncStr(BNo);
        end;




        if not JTransfer then begin
            CheckoffLines.Reset;
            CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
            CheckoffLines.SetRange(CheckoffLines.Posted, true);
            if CheckoffLines.Find('-') then begin
                CheckoffLines.Reset;
                CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
                CheckoffLines.SetRange(CheckoffLines.Posted, false);
                if not CheckoffLines.Find('-') then begin
                    SaccoSetup.Get();
                    JournalInit(JTemplate, JBatch);
                    Desc := CopyStr(CheckoffHeader.Description, 1, 50);
                    JournalInsert(JTemplate, JBatch, DocNo, PDate, CheckoffHeader."Account Type", CheckoffHeader."Account No.", Desc,
                      Balaccttype::"G/L Account", SaccoSetup."Checkoff Control", CheckoffHeader.Amount, DocNo, '', Transtype::" ", Dim1, Dim2, true);

                    CheckoffHeader.Posted := true;
                    CheckoffHeader.Modify;

                    JournalPost(JTemplate, JBatch);
                    Message(Txt0005);
                end;
            end;
        end
        else begin

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.FindFirst then
                Message('%1 Journal Lines Created.\- %2\- %3', GenJournalLine.Count, JTemplate, JBatch);

        end;
    end;


    procedure ReverseMonthlyCheckoff(CheckoffHeader: Record "Monthly Checkoff Header")
    var
        Loans: Record Loans;
        CheckoffLines: Record "Monthly Checkoff Lines";
        RunBal: Decimal;
        LineNo: Integer;
        Txt0000: label 'Loan Repayment';
        Txt0001: label 'Interest Paid';
        Amortised: Decimal;
        Recovery: Decimal;
        Interest: Decimal;
        Txt0002: label 'Deposit Contribution';
        SavingsAccounts: Record Vendor;
        DepositCont: Decimal;
        Txt0003: label 'Excess Deposit';
        LoanAmount: Decimal;
        Txt0004: label 'Checkoff schedule and amount is not equal';
        Txt0005: label 'Batch Posted successfully';
        Txt0006: label 'Principle Recovery';
        LoansBill: Record Loans;
        Txt0007: label 'Loan Repayment -Bills';
        ProductType: Record "Product Setup";
        ShareCap: Decimal;
        Txt0008: label 'Share Capital';
        ProgressWindow: Dialog;
        Dim1: Code[20];
        Dim2: Code[20];
        Members: Record Customer;
        UserSetup: Record "User Setup";
        Txt0009: label 'Vendor:-';
        SavingsAcc: Code[20];
        Txt0010: label 'Registration Fee';
        Mdays: Integer;
        Txt0011: label 'Savings Contribution';
        DocNo: Code[20];
        PDate: Date;
        IntPaid: Decimal;
        PrPaid: Decimal;
        Desc: Text;
        ExtDocNo: Code[20];
        PenPaid: Decimal;
        AppPaid: Decimal;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        SaccoSetup: Record "Sacco Setup";
        BNo: Code[20];
        GL: Record "G/L Entry";
        GLRegister: Record "G/L Register";
        Custom: Record "Auto Reversal Entry";
        SavingsLedger: Record "Vendor Ledger Entry";
        CreditLedger: Record "Cust. Ledger Entry";

    begin

        if not Confirm('Are you ABSOLUTELY sure you want to Reverse this Checkoff?') then
            Error('ABORTED');

        CheckoffLines.Reset;
        CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
        CheckoffLines.SetRange(CheckoffLines.Posted, true);
        CheckoffLines.SetRange(CheckoffLines.Reversed, false);
        if CheckoffLines.Find('-') then begin

            dWindow.Open('Reversing Lines:                   #1#########\'
                                    + 'Accounts:             #2#########\'
                                    + 'Counter:              #3#########\'
                                    + 'Progress:             @4@@@@@@@@@\'
                                    + 'Press Esc to abort');

            CurrentRecordNo := 0;
            NoOfRecords := CheckoffLines.Count;
            dWindow.Update(2, NoOfRecords);
            repeat
                CurrentRecordNo += 1;
                if CheckoffLines."Credit Account" then begin
                    CreditLedger.Reset();
                    CreditLedger.SetRange("Customer No.", CheckoffLines."Account No.");
                    CreditLedger.SetRange("Document No.", CheckoffHeader."No.");
                    CreditLedger.SetRange("Posting Date", CheckoffHeader."Posting Date");
                    CreditLedger.SetRange(Amount, CheckoffLines.Amount * -1);
                    if CreditLedger.FindFirst() then begin
                        if CreditLedger.Reversed then begin
                            CheckoffLines.Reversed := true;
                            CheckoffLines.Modify();
                        end
                        else begin
                            Custom.ReverseTransaction(CreditLedger."Transaction No.");
                            CheckoffLines.Reversed := true;
                            CheckoffLines.Modify();
                        end;
                    end;
                end;

                if CheckoffLines."Savings Account" then begin

                    SavingsLedger.Reset();
                    SavingsLedger.SetRange("Vendor No.", CheckoffLines."Account No.");
                    SavingsLedger.SetRange("Document No.", CheckoffHeader."No.");
                    SavingsLedger.SetRange("Posting Date", CheckoffHeader."Posting Date");
                    SavingsLedger.SetRange(Amount, CheckoffLines.Amount * -1);
                    if SavingsLedger.FindFirst() then begin
                        if SavingsLedger.Reversed then begin
                            CheckoffLines.Reversed := true;
                            CheckoffLines.Modify();
                        end
                        else begin
                            Custom.ReverseTransaction(SavingsLedger."Transaction No.");
                            CheckoffLines.Reversed := true;
                            CheckoffLines.Modify();
                        end;
                    end;
                end;


                dWindow.Update(3, CurrentRecordNo);
                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            until CheckoffLines.Next = 0;
            dWindow.Close;



        end;

        CreditLedger.Reset();
        CreditLedger.SetRange("Customer No.", CheckoffHeader."Account No.");
        CreditLedger.SetRange("Document No.", CheckoffHeader."No.");
        CreditLedger.SetRange("Posting Date", CheckoffHeader."Posting Date");
        CreditLedger.SetRange(Amount, CheckoffHeader.Amount);
        if CreditLedger.FindFirst() then begin
            if CreditLedger.Reversed then begin
                CheckoffHeader.Reversed := true;
                CheckoffHeader.Modify();
            end
            else begin
                Custom.ReverseTransaction(CreditLedger."Transaction No.");
                CheckoffHeader.Reversed := true;
                CheckoffHeader.Modify();
            end;
        end;

    end;

    procedure BatchMonthlyCheckoff(Var CheckoffHeader: Record "Monthly Checkoff Header"; JTransfer: Boolean)
    var
        CheckoffLines: Record "Monthly Checkoff Lines";
        ProgressWindow: Dialog;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        BatchNo: Code[20];
        BatchCounter: Integer;

    begin


        CheckoffLines.Reset;
        CheckoffLines.SetRange(CheckoffLines."Checkoff Header", CheckoffHeader."No.");
        CheckoffLines.SetRange(CheckoffLines.Posted, false);
        if CheckoffLines.Find('-') then begin
            BatchNo := '001';
            BatchCounter := 1;

            dWindow.Open('Batching Checkoff Lines:         #1#########\'
                                    + 'Accounts:             #2#########\'
                                    + 'Counter:              #3#########\'
                                    + 'Progress:             @4@@@@@@@@@\'
                                    + 'Press Esc to abort');

            CurrentRecordNo := 0;
            NoOfRecords := CheckoffLines.Count;
            dWindow.Update(2, NoOfRecords);

            repeat


                CurrentRecordNo += 1;

                CheckoffLines."Batch No." := BatchNo;
                CheckoffLines.Modify();

                if BatchCounter = CheckoffHeader."Batch Entries" then begin
                    BatchCounter := 0;
                    BatchNo := IncStr(BatchNo);
                end;
                BatchCounter += 1;



            until CheckoffLines.Next = 0;
            dWindow.Close;
            CheckoffHeader."No. Of Batches" := BatchNo;

        end;
    end;


    procedure BatchSalary(Var SalHeader: Record "Salary Header"; JTransfer: Boolean)
    var
        SalLines: Record "Salary lines";
        ProgressWindow: Dialog;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        BatchNo: Code[20];
        BatchCounter: Integer;

    begin


        SalLines.Reset;
        SalLines.SetRange("Salary Header No.", SalHeader."No");
        SalLines.SetRange(SalLines.Posted, false);
        if SalLines.Find('-') then begin
            BatchNo := '001';
            BatchCounter := 1;

            dWindow.Open('Batching Salary Lines:         #1#########\'
                                    + 'Accounts:             #2#########\'
                                    + 'Counter:              #3#########\'
                                    + 'Progress:             @4@@@@@@@@@\'
                                    + 'Press Esc to abort');

            CurrentRecordNo := 0;
            NoOfRecords := SalLines.Count;
            dWindow.Update(2, NoOfRecords);

            repeat


                CurrentRecordNo += 1;

                SalLines."Batch No." := BatchNo;
                SalLines.Modify();

                if BatchCounter = SalHeader."Batch Entries" then begin
                    BatchCounter := 0;
                    BatchNo := IncStr(BatchNo);
                end;
                BatchCounter += 1;



            until SalLines.Next = 0;
            dWindow.Close;
            SalHeader."No. Of Batches" := BatchNo;

        end;
    end;


    procedure GenerateBlockCheckoff(checkoffHeader: Record "Monthly Checkoff Header")
    var
        CheckoffLines: Record "Monthly Checkoff Lines";
        CheckoffBuffer: Record "Monthly Checkoff Buffer";
        Members: Record Customer;
        EntryNo: Integer;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        RunBal: Decimal;
        Loans: Record Loans;
        ExpAmt: Decimal;
        SavAcc: Record Vendor;
        ProductSetup: Record "Product Setup";
        SaccoSetup: Record "Sacco Setup";
    begin

        SaccoSetup.Get();
        CheckoffBuffer.Reset;
        CheckoffBuffer.SetRange("Checkoff No", checkoffHeader."No.");
        CheckoffBuffer.SetRange("Member Not Found", true);
        if CheckoffBuffer.FindFirst then
            Error('%1 Accounts were not found. Kindly Correct this', CheckoffBuffer.Count);



        CheckoffBuffer.Reset;
        CheckoffBuffer.SetRange("Checkoff No", checkoffHeader."No.");
        CheckoffBuffer.SetRange("Member Not Found", false);
        if CheckoffBuffer.FindFirst then begin

            CheckoffLines.Reset;
            CheckoffLines.SetRange("Checkoff Header", CheckoffBuffer."Checkoff No");
            if CheckoffLines.FindFirst then
                CheckoffLines.DeleteAll;


            dWindow.Open('Generating Check-Off Lines:        #1#########\'
                                     + 'Accounts:             #2#########\'
                                     + 'Counter:              #3#########\'
                                     + 'Progress:             @4@@@@@@@@@\'
                                     + 'Press Esc to abort');



            CurrentRecordNo := 0;
            NoOfRecords := CheckoffBuffer.Count;
            dWindow.Update(2, NoOfRecords);

            repeat
                CurrentRecordNo += 1;
                RunBal := CheckoffBuffer.Amount;

                Loans.Reset;
                Loans.SetCurrentKey("Disbursement Date");
                Loans.Ascending(true);
                Loans.SetRange("Member No.", CheckoffBuffer."Member No.");
                Loans.SetFilter("Outstanding Principal", '>0');
                if Loans.FindFirst then begin
                    repeat
                        if RunBal > 0 then begin
                            Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                            if Loans."Outstanding Interest" < 0 then
                                Loans."Outstanding Interest" := 0;

                            ExpAmt := Loans.Repayment;
                            if ExpAmt > Loans."Outstanding Principal" + Loans."Outstanding Interest" then
                                ExpAmt := Loans."Outstanding Principal" + Loans."Outstanding Interest";

                            if ExpAmt > RunBal then
                                ExpAmt := RunBal;

                            EntryNo += 1;
                            CheckoffLines.Init;
                            CheckoffLines."Entry No" := EntryNo;
                            CheckoffLines.Amount := ExpAmt;
                            CheckoffLines."Account No." := Loans."Member No.";
                            CheckoffLines."Loan No." := Loans."Loan No.";
                            CheckoffLines."Payroll No." := CheckoffBuffer.Payroll;
                            CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
                            CheckoffLines."Member No." := CheckoffBuffer."Member No.";
                            CheckoffLines."Savings Account" := false;
                            CheckoffLines."Credit Account" := true;
                            CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
                            CheckoffLines.Name := CheckoffBuffer.Name;
                            CheckoffLines."Product ID" := Loans."Loan Product Type";
                            if CheckoffLines.Amount > 0 then
                                CheckoffLines.Insert;
                            RunBal -= ExpAmt;

                        end;

                    until Loans.Next = 0;
                end;


                if RunBal > 0 then begin

                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", CheckoffBuffer."Member No.");
                    SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Share Capital");
                    if SavAcc.FindFirst then begin
                        repeat
                            if RunBal > 0 then begin
                                ExpAmt := SavAcc."Monthly Contribution";

                                Members.Get(SavAcc."Member No.");

                                ProductSetup.Get(SavAcc."Product Type");

                                if ProductSetup."Minimum Contribution" > ExpAmt then
                                    ExpAmt := ProductSetup."Minimum Contribution";


                                SavAcc.CalcFields("Balance (LCY)");
                                if SavAcc."Balance (LCY)" < ExpAmt then
                                    ExpAmt -= SavAcc."Balance (LCY)";

                                if ExpAmt < 0 then
                                    ExpAmt := 0;

                                if ExpAmt > RunBal then
                                    ExpAmt := RunBal;

                                EntryNo += 1;
                                CheckoffLines.Init;
                                CheckoffLines."Entry No" := EntryNo;
                                CheckoffLines.Amount := ExpAmt;
                                CheckoffLines."Account No." := SavAcc."No.";
                                CheckoffLines."Loan No." := '';
                                CheckoffLines."Payroll No." := CheckoffBuffer.Payroll;
                                CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
                                CheckoffLines."Member No." := CheckoffBuffer."Member No.";
                                CheckoffLines."Savings Account" := true;
                                CheckoffLines."Credit Account" := false;
                                CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
                                CheckoffLines.Name := CheckoffBuffer.Name;
                                CheckoffLines."Product ID" := SavAcc."Product Type";
                                if CheckoffLines.Amount > 0 then
                                    CheckoffLines.Insert;
                                RunBal -= ExpAmt;

                            end;

                        until SavAcc.Next = 0;
                    end;
                end;



                if RunBal > 0 then begin

                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", CheckoffBuffer."Member No.");
                    SavAcc.SetFilter("Product Category", '<>%1', SavAcc."Product Category"::"Share Capital");
                    if SavAcc.FindFirst then begin
                        repeat
                            if RunBal > 0 then begin
                                ExpAmt := SavAcc."Monthly Contribution";

                                if SavAcc."Product Category" = SavAcc."product category"::"Deposit Contribution" then begin
                                    Members.Get(SavAcc."Member No.");

                                    ProductSetup.Get(SavAcc."Product Type");
                                    if ProductSetup."Mandatory Contribution" > ExpAmt then
                                        ExpAmt := ProductSetup."Mandatory Contribution";
                                end;

                                if ExpAmt > RunBal then
                                    ExpAmt := RunBal;

                                EntryNo += 1;
                                CheckoffLines.Init;
                                CheckoffLines."Entry No" := EntryNo;
                                CheckoffLines.Amount := ExpAmt;
                                CheckoffLines."Account No." := SavAcc."No.";
                                CheckoffLines."Loan No." := '';
                                CheckoffLines."Payroll No." := CheckoffBuffer.Payroll;
                                CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
                                CheckoffLines."Member No." := CheckoffBuffer."Member No.";
                                CheckoffLines."Savings Account" := true;
                                CheckoffLines."Credit Account" := false;
                                CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
                                CheckoffLines.Name := CheckoffBuffer.Name;
                                CheckoffLines."Product ID" := SavAcc."Product Type";
                                if CheckoffLines.Amount > 0 then
                                    CheckoffLines.Insert;
                                RunBal -= ExpAmt;

                            end;

                        until SavAcc.Next = 0;
                    end;
                end;


                if RunBal > 0 then begin

                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", CheckoffBuffer."Member No.");
                    SavAcc.SetRange("Product Category", SavAcc."product category"::"Deposit Contribution");
                    if SavAcc.FindFirst then begin

                        EntryNo += 1;
                        CheckoffLines.Init;
                        CheckoffLines."Entry No" := EntryNo;
                        CheckoffLines.Amount := RunBal;
                        CheckoffLines."Account No." := SavAcc."No.";
                        CheckoffLines."Loan No." := '';
                        CheckoffLines."Payroll No." := CheckoffBuffer.Payroll;
                        CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
                        CheckoffLines."Member No." := CheckoffBuffer."Member No.";
                        CheckoffLines."Savings Account" := true;
                        CheckoffLines."Credit Account" := false;
                        CheckoffLines."Excess Amount" := true;
                        CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
                        CheckoffLines.Name := CheckoffBuffer.Name;
                        CheckoffLines."Product ID" := SavAcc."Product Type";
                        if CheckoffLines.Amount > 0 then
                            CheckoffLines.Insert;
                    end;
                end;


                dWindow.Update(3, CurrentRecordNo);
                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            until CheckoffBuffer.Next = 0;
            dWindow.Close;
        end;
    end;


    procedure GenerateSingleCheckoff(checkoffHeader: Record "Monthly Checkoff Header")
    var
        CheckoffLines: Record "Monthly Checkoff Lines";
        CheckoffBuffer: Record "Monthly Checkoff Buffer";
        Members: Record Customer;
        EntryNo: Integer;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        RunBal: Decimal;
        Loans: Record Loans;
        ExpAmt: Decimal;
        SavAcc: Record Vendor;
        ProductSetup: Record "Product Setup";
        RegFee: Decimal;
    begin

        CheckoffBuffer.Reset;
        CheckoffBuffer.SetRange("Checkoff No", checkoffHeader."No.");
        CheckoffBuffer.SetRange("Member Not Found", true);
        if CheckoffBuffer.FindFirst then
            Error('%1 Accounts were not found. Kindly Correct this', CheckoffBuffer.Count);



        CheckoffBuffer.Reset;
        CheckoffBuffer.SetRange("Checkoff No", checkoffHeader."No.");
        CheckoffBuffer.SetRange("Member Not Found", false);
        if CheckoffBuffer.FindFirst then begin

            CheckoffLines.Reset;
            CheckoffLines.SetRange("Checkoff Header", CheckoffBuffer."Checkoff No");
            if CheckoffLines.FindFirst then
                CheckoffLines.DeleteAll;



            SavAcc.Reset;
            SavAcc.SetRange("Product Category", SavAcc."product category"::" ");
            if SavAcc.FindFirst then begin
                repeat
                    if ProductSetup.Get(SavAcc."Product Type") then begin
                        SavAcc."Product Category" := ProductSetup."Product Category";
                        SavAcc.Modify();
                    end;
                until SavAcc.Next() = 0;
            end;



            dWindow.Open('Generating Check-Off Lines:        #1#########\'
                                     + 'Accounts:             #2#########\'
                                     + 'Counter:              #3#########\'
                                     + 'Progress:             @4@@@@@@@@@\'
                                     + 'Press Esc to abort');



            CurrentRecordNo := 0;
            NoOfRecords := CheckoffBuffer.Count;
            dWindow.Update(2, NoOfRecords);

            repeat
                CurrentRecordNo += 1;
                CheckoffBuffer.Processed := false;


                SavAcc.Reset;
                SavAcc.SetRange("Member No.", CheckoffBuffer."Member No.");
                SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"Deposit Contribution");
                if not SavAcc.FindFirst then begin
                    Members.get(CheckoffBuffer."Member No.");
                    ProductSetup.Reset();
                    ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Deposit Contribution");
                    if ProductSetup.FindFirst() then
                        MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, true, ProductSetup."Repay Mode");
                end;
                RunBal := 0;
                CheckoffBuffer.Balance := CheckoffBuffer.Amount;

                if CheckoffBuffer."Loan Amount" > 0 then begin

                    RunBal := CheckoffBuffer."Loan Amount";
                    if not CheckoffBuffer."Loan Not Found" then begin


                        Loans.Reset;
                        Loans.SetRange("Member No.", CheckoffBuffer."Member No.");
                        Loans.SetRange("Loan No.", CheckoffBuffer."Search Code");
                        Loans.SetFilter("Outstanding Principal", '>0');
                        if Loans.FindFirst then begin
                            Loans.CalcFields("Outstanding Interest", "Outstanding Penalty");
                            Loans.CalcFields("Outstanding Principal");

                            if RunBal > 0 then begin

                                if Loans."Outstanding Interest" < 0 then
                                    Loans."Outstanding Interest" := 0;

                                if Loans."Outstanding Interest" > RunBal then
                                    Loans."Outstanding Interest" := RunBal;

                                if Loans."Outstanding Interest" > 0 then begin
                                    EntryNo += 1;
                                    CheckoffLines.Init;
                                    CheckoffLines."Entry No" := EntryNo;
                                    CheckoffLines.Amount := Loans."Outstanding Interest";
                                    CheckoffLines."Account No." := Loans."Member No.";
                                    CheckoffLines."Loan No." := Loans."Loan No.";
                                    CheckoffLines."Payroll No." := CheckoffBuffer.Payroll;
                                    CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
                                    CheckoffLines."Member No." := CheckoffBuffer."Member No.";
                                    CheckoffLines."Savings Account" := false;
                                    CheckoffLines."Credit Account" := true;
                                    CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
                                    CheckoffLines.Name := CheckoffBuffer.Name;
                                    CheckoffLines."Product ID" := Loans."Loan Product Type";
                                    CheckoffLines.Type := CheckoffLines.Type::Interest;
                                    if CheckoffLines.Amount > 0 then
                                        CheckoffLines.Insert;
                                    RunBal -= Loans."Outstanding Interest";
                                    CheckoffBuffer.Balance -= CheckoffLines.Amount;
                                    CheckoffBuffer.Processed := true;
                                end;
                            end;


                            if RunBal > 0 then begin

                                if Loans."Outstanding Penalty" < 0 then
                                    Loans."Outstanding Penalty" := 0;

                                if Loans."Outstanding Penalty" > RunBal then
                                    Loans."Outstanding Penalty" := RunBal;

                                if Loans."Outstanding Penalty" > 0 then begin
                                    EntryNo += 1;
                                    CheckoffLines.Init;
                                    CheckoffLines."Entry No" := EntryNo;
                                    CheckoffLines.Amount := Loans."Outstanding Penalty";
                                    CheckoffLines."Account No." := Loans."Member No.";
                                    CheckoffLines."Loan No." := Loans."Loan No.";
                                    CheckoffLines."Payroll No." := CheckoffBuffer.Payroll;
                                    CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
                                    CheckoffLines."Member No." := CheckoffBuffer."Member No.";
                                    CheckoffLines."Savings Account" := false;
                                    CheckoffLines."Credit Account" := true;
                                    CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
                                    CheckoffLines.Name := CheckoffBuffer.Name;
                                    CheckoffLines."Product ID" := Loans."Loan Product Type";
                                    CheckoffLines.Type := CheckoffLines.Type::Penalty;
                                    if CheckoffLines.Amount > 0 then
                                        CheckoffLines.Insert;
                                    RunBal -= Loans."Outstanding Penalty";
                                    CheckoffBuffer.Balance -= CheckoffLines.Amount;
                                    CheckoffBuffer.Processed := true;
                                end;
                            end;



                            if RunBal > 0 then begin

                                if Loans."Outstanding Principal" > RunBal then
                                    Loans."Outstanding Principal" := RunBal;

                                if Loans."Outstanding Principal" > 0 then begin
                                    EntryNo += 1;
                                    CheckoffLines.Init;
                                    CheckoffLines."Entry No" := EntryNo;
                                    CheckoffLines.Amount := Loans."Outstanding Principal";
                                    CheckoffLines."Account No." := Loans."Member No.";
                                    CheckoffLines."Loan No." := Loans."Loan No.";
                                    CheckoffLines."Payroll No." := CheckoffBuffer.Payroll;
                                    CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
                                    CheckoffLines."Member No." := CheckoffBuffer."Member No.";
                                    CheckoffLines."Savings Account" := false;
                                    CheckoffLines."Credit Account" := true;
                                    CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
                                    CheckoffLines.Name := CheckoffBuffer.Name;
                                    CheckoffLines."Product ID" := Loans."Loan Product Type";
                                    CheckoffLines.Type := CheckoffLines.Type::Principal;
                                    if CheckoffLines.Amount > 0 then
                                        CheckoffLines.Insert;
                                    RunBal -= Loans."Outstanding Principal";
                                    CheckoffBuffer.Balance -= CheckoffLines.Amount;
                                    CheckoffBuffer.Processed := true;
                                end;
                            end;
                        end;
                    end;
                end;


                if CheckoffBuffer."Savings Amount" > 0 then begin

                    ExpAmt := CheckoffBuffer."Savings Amount";

                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", CheckoffBuffer."Member No.");
                    SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"Registration Fee");
                    if not SavAcc.FindFirst then begin
                        Members.get(CheckoffBuffer."Member No.");
                        ProductSetup.Reset();
                        ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Registration Fee");
                        if ProductSetup.FindFirst() then
                            MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, true, ProductSetup."Repay Mode");
                    end;

                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", CheckoffBuffer."Member No.");
                    SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"Registration Fee");
                    SavAcc.SetRange("Balance (LCY)", 0);
                    if SavAcc.FindFirst then begin
                        ProductSetup.Reset();
                        ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Registration Fee");
                        if ProductSetup.FindFirst() then begin
                            RegFee := ProductSetup."Minimum Contribution";
                            if ExpAmt >= RegFee then begin


                                EntryNo += 1;
                                CheckoffLines.Init;
                                CheckoffLines."Entry No" := EntryNo;
                                CheckoffLines.Amount := RegFee;
                                CheckoffLines."Account No." := SavAcc."No.";
                                CheckoffLines."Loan No." := '';
                                CheckoffLines."Payroll No." := CheckoffBuffer.Payroll;
                                CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
                                CheckoffLines."Member No." := CheckoffBuffer."Member No.";
                                CheckoffLines."Savings Account" := true;
                                CheckoffLines."Credit Account" := false;
                                CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
                                CheckoffLines.Name := CheckoffBuffer.Name;
                                CheckoffLines."Product ID" := SavAcc."Product Type";
                                if CheckoffLines.Amount > 0 then
                                    CheckoffLines.Insert;
                                CheckoffBuffer.Processed := true;
                                CheckoffBuffer.Balance -= CheckoffLines.Amount;
                                ExpAmt -= RegFee;

                            end;

                        end;
                    end;


                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", CheckoffBuffer."Member No.");
                    SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"Deposit Contribution");
                    if SavAcc.FindFirst then begin
                        repeat
                            if ExpAmt > 0 then begin



                                EntryNo += 1;
                                CheckoffLines.Init;
                                CheckoffLines."Entry No" := EntryNo;
                                CheckoffLines.Amount := ExpAmt;
                                CheckoffLines."Account No." := SavAcc."No.";
                                CheckoffLines."Loan No." := '';
                                CheckoffLines."Payroll No." := CheckoffBuffer.Payroll;
                                CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
                                CheckoffLines."Member No." := CheckoffBuffer."Member No.";
                                CheckoffLines."Savings Account" := true;
                                CheckoffLines."Credit Account" := false;
                                CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
                                CheckoffLines.Name := CheckoffBuffer.Name;
                                CheckoffLines."Product ID" := SavAcc."Product Type";
                                if CheckoffLines.Amount > 0 then
                                    CheckoffLines.Insert;
                                CheckoffBuffer.Processed := true;
                                CheckoffBuffer.Balance -= CheckoffLines.Amount;

                            end;

                        until SavAcc.Next = 0;
                    end;
                end;


                if RunBal > 0 then begin

                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", CheckoffBuffer."Member No.");
                    SavAcc.SetRange("Product Category", SavAcc."product category"::"Deposit Contribution");
                    if SavAcc.FindFirst then begin

                        EntryNo += 1;
                        CheckoffLines.Init;
                        CheckoffLines."Entry No" := EntryNo;
                        CheckoffLines.Amount := RunBal;
                        CheckoffLines."Account No." := SavAcc."No.";
                        CheckoffLines."Loan No." := '';
                        CheckoffLines."Payroll No." := CheckoffBuffer.Payroll;
                        CheckoffLines."ID Number" := CheckoffBuffer."ID No.";
                        CheckoffLines."Member No." := CheckoffBuffer."Member No.";
                        CheckoffLines."Savings Account" := true;
                        CheckoffLines."Credit Account" := false;
                        CheckoffLines."Excess Amount" := true;
                        CheckoffLines."Checkoff Header" := CheckoffBuffer."Checkoff No";
                        CheckoffLines.Name := CheckoffBuffer.Name;
                        CheckoffLines."Product ID" := SavAcc."Product Type";
                        if CheckoffLines.Amount > 0 then
                            CheckoffLines.Insert;
                        CheckoffBuffer.Processed := true;
                        CheckoffBuffer.Balance -= CheckoffLines.Amount;
                    end;
                end;
                CheckoffBuffer.Modify();

                dWindow.Update(3, CurrentRecordNo);
                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            until CheckoffBuffer.Next = 0;
            dWindow.Close;
        end;
    end;


    procedure GetLoanPrincipal(Loans: Record Loans; RepDate: Date): Decimal
    var
        d: Integer;
        m: Integer;
        y: Integer;
        EndMonth: Date;
        RepDay: Integer;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin

        LoanRepaymentSchedule.Reset;
        LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
        LoanRepaymentSchedule.SetRange("Repayment Date", CalcDate('-CM', RepDate), CalcDate('CM', RepDate));
        LoanRepaymentSchedule.SetFilter("Monthly Principal", '>0');
        if LoanRepaymentSchedule.FindFirst then
            exit(LoanRepaymentSchedule."Monthly Principal")
        else begin

            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
            LoanRepaymentSchedule.SetFilter("Monthly Principal", '>0');
            if LoanRepaymentSchedule.FindFirst then
                exit(LoanRepaymentSchedule."Monthly Principal");
        end;


        if Loans."Loan Principle Repayment" > 0 then
            exit(Loans."Loan Principle Repayment");

        if Loans.Installments > 0 then
            exit(ROUND(Loans."Approved Amount" / Loans.Installments));
    end;


    /*procedure PostOverDraft(Overdraft: Record "Overdraft Header")
    var
        Text0001: label 'Ensure the Overdraft Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Overdraft Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        Text0004: label 'The transaction has already been posted.';
        LineNo: Integer;
        SaccoSetup: Record "Sacco Setup";
        MemberActivities: Codeunit "Member Activities";
    begin

        with Overdraft do begin

            if Posted = true then
                Error(Text0004);

            SaccoSetup.Get;

            JTemplate := '';
            JBatch := '';
            GetPaymentJournalTemplate(JTemplate, JBatch);


            if Status <> Status::Approved then
                Error('You cannot post an application being processed.');

            TestField("Account No.");
            TestField("Effective/Start Date");
            TestField(Duration);
            TestField("Expiry Date");
            TestField("Requested Amount");
            TestField("Approved Amount");


            if not Confirm('Are you sure you want to post this Overdraft?') then
                Error('Aborted');

            JournalInit(JTemplate, JBatch);



            ChargeAmt := 0;
            ChargeDuty := 0;
            ChargeAcct := '';
            MemberActivities.GetGeneralChargeAmount("Transaction Type", "Approved Amount", ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct);

            JournalInsert(JTemplate, JBatch, "No.", Today, Accttype::Savings, "Account No.", 'Overdraft Fee',
                    ChargeAcctType, ChargeAcct, ChargeAmt, "Account No.", '', Transtype::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", true);

            JournalInsert(JTemplate, JBatch, "No.", Today, Accttype::Savings, "Account No.", 'Excise Duty on Overdraft Fee',
                    Chargeaccttype::"G/L Account", SaccoSetup."Excise Duty GL", ChargeDuty, "Account No.", '', Transtype::" ", "Global Dimension 1 Code", "Global Dimension 2 Code", true);


            Posted := true;
            Modify;

            JournalPost(JTemplate, JBatch);

            Message('Overdraft charges posted successfully.');

        end;
    end;

    local procedure ClearOverDraft()
    var
        OverDraft: Record "Overdraft Header";
    begin

        OverDraft.Reset;
        OverDraft.SetRange(Posted, true);
        OverDraft.SetRange(Expired, false);
        OverDraft.SetFilter("Expiry Date", '<>%1', 0D);
        if OverDraft.Find('-') then begin
            repeat
                if OverDraft."Expiry Date" <= Today then begin
                    OverDraft.Expired := true;
                    OverDraft.Modify;
                end;
            until OverDraft.Next = 0;
        end;
    end;
*/

    procedure GetInterestDue(Loans: Record Loans; AsAt: Date): Decimal
    var
        SchDate: Date;
        Due: Decimal;
        RSchedule: Record "Loan Repayment Schedule";
        LRec: Record Loans;
    begin


        Loans.CalcFields("Outstanding Interest", "Interest Paid");

        Due := 0;
        SchDate := 0D;
        Due := Loans."Outstanding Interest";

        if Due < 0 then
            Due := 0;

        exit(Due);
    end;


    procedure ValidEmailAddress(EmailAddress: Text): Boolean
    var
        i: Integer;
        NoOfAtSigns: Integer;
    begin
        EmailAddress := DelChr(EmailAddress, '<>');

        if EmailAddress = '' then
            exit(false);

        if (EmailAddress[1] = '@') or (EmailAddress[StrLen(EmailAddress)] = '@') then
            exit(false);

        for i := 1 to StrLen(EmailAddress) do begin
            if EmailAddress[i] = '@' then
                NoOfAtSigns := NoOfAtSigns + 1
            else
                if EmailAddress[i] = ' ' then
                    exit(false);
        end;

        if NoOfAtSigns <> 1 then
            exit(false);


        exit(true);
    end;


    procedure GenerateManualLoanInterest(LoanNo: Code[20]; PDate: Date; Amt: Decimal; Desc: Text)
    var
        Loans: Record Loans;
        LoanType: Record "Product Setup";
        LineNo: Integer;
        DocNo: Code[20];
        "Document No.": Code[20];
        LoansInterest: Record "Loan Interest Buffer";
        LoanAmount: Decimal;
        CustMember: Record Customer;
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        AlreadyPostedErr: label 'This transaction Is Already posted';
        Memb: Record Customer;
        InterestAmount: Decimal;
        BalDate: Date;
        MemberAccounts: Record Vendor;
    begin


        //BalDate:=CALCDATE('-1M+CM',BDate);


        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.Find('-') then begin
            repeat


                Loans.CalcFields("Loans Category-SASRA");
                begin
                    if LoanType.Get(Loans."Loan Product Type") then begin

                        InterestAmount := Amt;
                        /*
                        LoansInterest.RESET;
                        LoansInterest.SETRANGE("Loan No.",Loans."Loan No.");
                        LoansInterest.SETRANGE("Interest Date",PDate);
                        //LoansInterest.SETRANGE(Reversed,FALSE);
                        IF LoansInterest.FINDFIRST THEN BEGIN
                            IF (LoansInterest.Posted) AND (LoansInterest.Reversed=FALSE) THEN
                              InterestAmount:=0
                            ELSE
                              LoansInterest.DELETE;
                        END;
                        */


                        if InterestAmount > 0 then begin
                            Loans.CalcFields(Loans."Outstanding Principal", Loans."Outstanding Interest");

                            LoansInterest.Init;
                            LoansInterest."Loan No." := Loans."Loan No.";
                            LoansInterest."Account Type" := LoansInterest."account type"::Credit;
                            LoansInterest."Account No" := Loans."Member No.";
                            LoansInterest."Interest Date" := PDate;
                            LoansInterest."Issued Date" := Loans."Disbursement Date";
                            LoansInterest."Interest Amount" := InterestAmount;
                            LoansInterest."Posting Date" := PDate;
                            LoansInterest.Description := Desc;//'Interest Due'+' '+COPYSTR(FORMAT(PDate,0,'<Month Text>'),1,3) +' '+ FORMAT(DATE2DMY(PDate,3));;
                            LoansInterest."Global Dimension 1 Code" := Loans."Global Dimension 1 Code";
                            LoansInterest."Global Dimension 2 Code" := Loans."Booking Branch";
                            LoansInterest."Loan Product type" := Loans."Loan Product Type";

                            LoanType.TestField("Loan Interest Income [G/L]");
                            LoansInterest."Bal. Account No." := LoanType."Loan Interest Income [G/L]";


                            if CustMember.Get(Loans."Member No.") then begin
                                LoansInterest.Status := CustMember.Status;
                                LoansInterest.Blocked := CustMember.Blocked;
                            end;

                            LoansInterest."Outstanding Balance" := Loans."Outstanding Principal";
                            LoansInterest."Outstanding Interest" := Loans."Outstanding Interest";
                            LoansInterest.Insert;
                        end;
                    end;
                end;
            until Loans.Next = 0;
        end;

    end;

    procedure ProgressInit(var dWindow: Dialog; Var CurrentRecordNo: Integer; Var NoOfRecords: Integer)
    var
    begin

        dWindow.Open('Generating Entries:     #1#########\'
            + 'Total:                #2#########\'
            + 'Counter:              #3#########\'
            + 'Progress:             @4@@@@@@@@@\'
            + 'Press Esc to abort');

        CurrentRecordNo := 0;
        dWindow.Update(2, NoOfRecords);

    end;


    procedure ProgressBarProcessing(var dWindow: Dialog; Var CurrentRecordNo: Integer; Var NoOfRecords: Integer; Name: Text)
    var
    begin

        dWindow.Update(1, Name);
        dWindow.Update(3, CurrentRecordNo);
        dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
    end;

    procedure ProgressClose(var dWindow: Dialog)
    var
    begin
        dWindow.Close();
    end;

    procedure CheckMaturedJuniorAccounts()
    var
        Account: Record Vendor;
        Continue: Boolean;
    begin


        Account.Reset();
        Account.SetRange("Product Category", Account."Product Category"::"Junior Savings");
        Account.SetFilter("Child Date Of Birth", '<>%1', 0D);
        Account.SetRange(Status, Account.Status::Active);
        Account.SetRange("Child Account Status", Account."Child Account Status"::Child);
        if Account.FindFirst() then begin
            repeat
                Continue := false;
                if (Date2DMY(today, 3) - Date2DMY(Account."Child Date Of Birth", 3)) > 18 then
                    Continue := true;
                if (Date2DMY(today, 3) - Date2DMY(Account."Child Date Of Birth", 3)) = 18 then begin

                    if (Date2DMY(today, 2) > Date2DMY(Account."Child Date Of Birth", 2)) then begin
                        Continue := true;
                    end;
                end;

                if Continue then begin
                    Account."Child Account Status" := Account."Child Account Status"::"Pending Conversion";
                    Account.Modify();
                end;
            until Account.Next() = 0;
        end;
    end;


    procedure CreateStandingOrder(VAr Loans: Record Loans)
    var
        myInt: Integer;
        STOHeader: Record "Standing Order Header";
        STOLines: Record "Standing Order Lines";
    begin
        Loans."Standing Order Amount" := Loans.Repayment;

        Loans.testfield("Standing Order Amount");

        if Loans."Standing Order Amount" > 0 then begin
            STOHeader.init;

            STOHeader.Code := '';
            STOHeader."Source Account Type" := STOHeader."Source Account Type"::Savings;
            STOHeader.validate("Source Account No.", Loans."Disbursement Account No");
            STOHeader.Description := Loans."Loan Product Type Name";
            STOHeader.Amount := Loans."Standing Order Amount";
            STOHeader."Allow Partial Deduction" := true;
            STOHeader."Income Type" := STOHeader."Income Type"::Business;
            STOHeader."Created By" := UserID;
            STOHeader.Status := STOHeader.Status::Approved;
            STOHeader."Effective/Start Date" := Today;
            Evaluate(STOHeader."Frequency (Months)", '999M');
            Evaluate(STOHeader."Duration (Months)", '1M');
            STOHeader.Validate("Duration (Months)");
            STOHeader."Auto Process" := true;
            STOHeader.Insert(true);

            Loans."STO No." := STOHeader.Code;

            STOLines.Init();
            STOLines."Document No." := STOHeader.Code;
            STOLines."Destination Account Type" := STOLines."Destination Account Type"::Credit;
            STOLines."Destination Account No." := Loans."Member No.";
            STOLines."Loan No." := Loans."Loan No.";
            STOLines.Amount := STOHeader.Amount;
            STOLines.Insert();

        end


    end;




    procedure GetAccountBalance(Account: Text[30]) AccountBal: Decimal
    var
        MemberActivities: Codeunit "Member Activities";
    begin

        AccountBal := MemberActivities.GetAccountBalance(Account);
        exit(AccountBal);
    end;

    procedure CalculateLoanOffset(Header: Record "Defaulter Loan Recovery"; PostEntries: Boolean)
    var
        AppraisalLine: Record "Offset Appraisal";
        myInt: Integer;
        j: Integer;
        PSetup: Record "Product Setup";
        MemberAccounts: Record Vendor;
        AvailDep: Decimal;
        Offset: Record "Loans Offet List";
        LoanRecLines: Record "Loans Offet List";
        RunBal: Decimal;
        DedAmt: Decimal;
        PrAmt: Decimal;
        IntAmt: Decimal;
        DefLoan: Record Loans;
        TotalGuaranteed: Decimal;
        RecoveryLines: Record "Defaulter Recovery Lines";
        Legacy: Codeunit Legacy;
        RecoveryAccount: Code[20];

    begin

        Header.GetAmounts();

        AppraisalLine.Reset();
        AppraisalLine.SetRange("Offset No.", Header."No.");
        if AppraisalLine.FindFirst() then begin
            AppraisalLine.DeleteAll();
        end;

        Header.Waiver := 0;
        Offset.Reset();
        Offset.SetRange("Header No.", Header."No.");
        Offset.SetRange("Member No", Header."Member No.");
        if Offset.FindFirst() then begin
            repeat
                Loans.Get(Offset."Loan No");
                AppraisalLine.Init();
                AppraisalLine."Offset No." := Header."No.";
                AppraisalLine."Member No." := Header."Member No.";
                AppraisalLine."Loan No." := Offset."Loan No";
                AppraisalLine."Member Name" := Header.Name;
                AppraisalLine."Loan Product" := Loans."Loan Product Type";
                AppraisalLine."Approved Amount" := Loans."Approved Amount";
                AppraisalLine.Savings := Header."Total Available";

                AppraisalLine."New Savings Balance" := AppraisalLine.Savings;
                AppraisalLine."Share Capital" := Header."Share Capital";
                AppraisalLine."Share Capital Top Up" := Header."Share Capital Top Up";

                if AppraisalLine."Share Capital Top Up" > 0 then begin
                    if Header."Total Available" > AppraisalLine."Share Capital Top Up" then
                        AppraisalLine."New Share Capital" := AppraisalLine."Share Capital" + AppraisalLine."Share Capital Top Up"
                    else
                        AppraisalLine."New Share Capital" := AppraisalLine."Share Capital Top Up" - Header."Total Available";
                end
                else
                    AppraisalLine."New Share Capital" := AppraisalLine."Share Capital";


                AppraisalLine."Outstanding Interest" := Offset."Outstanding Interest";
                AppraisalLine."Interest Waived" := Offset."interest waiver";
                AppraisalLine."Out. Interest After Waiver" := AppraisalLine."Outstanding Interest" - AppraisalLine."Interest Waived";
                AppraisalLine."New Outstanding Interest" := AppraisalLine."Out. Interest After Waiver";
                AppraisalLine."Outstanding Balance" := Offset."Outstanding Principal";
                AppraisalLine."New Outstanding Balance" := Offset."Outstanding Principal";


                AppraisalLine.Insert();
                Header.Waiver += AppraisalLine."Interest Waived";
            until Offset.Next() = 0;
        end;

        RunBal := Header."Total Available";

        if PostEntries then begin

            GetGeneralJournalTemplate(JTemplate, JBatch);
            JournalInit(JTemplate, JBatch);

            AvailDep := 0;

            RecoveryAccount := '';
            if Header."Recovery Option" = Header."Recovery Option"::"Recover from Multiple Accounts" then begin
                RecoveryAccount := Legacy.GetOrdinaryAccount(Header."Member No.");
                PSetup.Reset();
                PSetup.SetRange(PSetup."Can Offset Loan");
                PSetup.SetFilter("Product Category", '<>%1', PSetup."Product Category"::"Ordinary Savings");
                if PSetup.FindFirst() then begin
                    MemberAccounts.Reset();
                    MemberAccounts.SetRange("Member No.", Header."Member No.");
                    MemberAccounts.SetRange("Product Type", PSetup."Product ID");
                    MemberAccounts.SetFilter("Balance (LCY)", '>0');
                    if MemberAccounts.FindFirst() then begin
                        repeat
                            MemberAccounts.calcfields("Balance (LCY)");
                            AvailDep += MemberAccounts."Balance (LCY)";

                            JournalInsert(
                                JTemplate,
                                JBatch,
                                Header."No.",
                                Today,
                                Accttype::Savings,
                                MemberAccounts."No.",
                                CopyStr('Offset Consolidation: ' + MemberAccounts."Product Name", 1, 50),
                                Balaccttype::"G/L Account",
                                '',
                                MemberAccounts."Balance (LCY)",
                                Header."No.",
                                '',
                                Transtype::" ",
                                Header."Global Dimension 1 Code",
                                Header."Global Dimension 2 Code",
                                true
                                );
                            JournalInsert(
                                JTemplate,
                                JBatch,
                                Header."No.",
                                Today,
                                Accttype::Savings,
                                Legacy.GetOrdinaryAccount(Header."Member No."),
                                CopyStr('Offset Consolidation: ' + MemberAccounts."Product Name", 1, 50),
                                Balaccttype::"G/L Account",
                                '',
                                -MemberAccounts."Balance (LCY)",
                                Header."No.",
                                '',
                                Transtype::" ",
                                Header."Global Dimension 1 Code",
                                Header."Global Dimension 2 Code",
                                true
                                );

                        until MemberAccounts.Next() = 0;
                    end;
                end;


                AvailDep += SaccoActivities.GetAccountBalance(Legacy.GetOrdinaryAccount(Header."Member No."));
            end
            else begin

                AvailDep := MemberActivities.GetAccountBalanceWithoutMinAccBalance(Header."Source Account");
                RecoveryAccount := Header."Source Account";
            end;

            RunBal := AvailDep;
            if Header."Amount to Recover" > 0 then begin
                If RunBal > Header."Amount to Recover" then
                    RunBal := Header."Amount to Recover"
                else
                    Error('Insufficient Balance');
            end;

        end;


        if PostEntries then begin

            if Header."Share Capital Top Up" > 0 then begin

                if PostEntries then begin

                    JournalInsert(
                        JTemplate,
                        JBatch,
                        Header."No.",
                        Today,
                        Accttype::Savings,
                        Legacy.GetShareCapitalAccount(Header."Member No."),
                        CopyStr('Offset: Share Capital Top Up', 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        -Header."Share Capital Top Up",
                        Header."No.",
                        Loans."Loan No.",
                        Transtype::"Interest Paid",
                        Header."Global Dimension 1 Code",
                        Header."Global Dimension 2 Code",
                        true
                        );

                    JournalInsert(
                        JTemplate,
                        JBatch,
                        Header."No.",
                        Today,
                        Accttype::Savings,
                        RecoveryAccount,
                        CopyStr('Offset: Share Capital Top Up', 1, 50),
                        Balaccttype::"G/L Account",
                        '',
                        Header."Share Capital Top Up",
                        Header."No.",
                        '',
                        Transtype::" ",
                        Header."Global Dimension 1 Code",
                        Header."Global Dimension 2 Code",
                        true
                        );


                end;


                //AppraisalLine."New Savings Balance" := AppraisalLine."New Savings Balance" - DedAmt;

            end;

        end;



        //Recover Interests
        Offset.Reset();
        Offset.SetRange("Header No.", Header."No.");
        Offset.SetRange("Member No", Header."Member No.");
        if Offset.FindFirst() then begin
            repeat

                AppraisalLine.Reset();
                AppraisalLine.SetRange("Offset No.", Header."No.");
                AppraisalLine.SetRange("Loan No.", Offset."Loan No");
                AppraisalLine.SetFilter("Out. Interest After Waiver", '>0');
                if AppraisalLine.FindFirst() then begin
                    if RunBal > 0 then begin
                        Loans.Get(Offset."Loan No");

                        AppraisalLine.SAvings := RunBal;
                        AppraisalLine."New Savings Balance" := RunBal;

                        DedAmt := AppraisalLine."Out. Interest After Waiver";
                        PSetup.get(Loans."Loan Product Type");

                        if DedAmt > RunBal then
                            DedAmt := RunBal;

                        if PostEntries then begin

                            if DedAmt > 0 then begin

                                IntAmt := DedAmt;
                                RunBal -= IntAmt;
                                //RecoverInterestLines
                                AppraisalLine."New Outstanding Interest" -= DedAmt;
                                if PostEntries then begin

                                    JournalInsert(
                                        JTemplate,
                                        JBatch,
                                        Header."No.",
                                        Today,
                                        Accttype::Credit,
                                        Header."Member No.",
                                        CopyStr('Interest Offset: ' + Loans."Loan Product Type Name", 1, 50),
                                        Balaccttype::"G/L Account",
                                        '',
                                        -IntAmt,
                                        Header."No.",
                                        Loans."Loan No.",
                                        Transtype::"Interest Paid",
                                        Header."Global Dimension 1 Code",
                                        Header."Global Dimension 2 Code",
                                        true
                                        );



                                    JournalInsert(
                                        JTemplate,
                                        JBatch,
                                        Header."No.",
                                        Today,
                                        Accttype::Credit,
                                        Header."Member No.",
                                        CopyStr('Interest Waiver: ' + Loans."Loan Product Type Name", 1, 50),
                                        Balaccttype::"G/L Account",
                                        PSetup."Loan Interest Income [G/L]",
                                        -AppraisalLine."Interest Waived",
                                        Header."No.",
                                        Loans."Loan No.",
                                        Transtype::"Interest Paid",
                                        Header."Global Dimension 1 Code",
                                        Header."Global Dimension 2 Code",
                                        true
                                        );

                                    JournalInsert(
                                        JTemplate,
                                        JBatch,
                                        Header."No.",
                                        Today,
                                        Accttype::Savings,
                                        RecoveryAccount,
                                        CopyStr('Interest Offset: ' + Loans."Loan Product Type Name", 1, 50),
                                        Balaccttype::"G/L Account",
                                        '',
                                        IntAmt,
                                        Header."No.",
                                        '',
                                        Transtype::" ",
                                        Header."Global Dimension 1 Code",
                                        Header."Global Dimension 2 Code",
                                        true
                                        );


                                end;


                                //AppraisalLine."New Savings Balance" := AppraisalLine."New Savings Balance" - DedAmt;

                            end;

                        end;
                        AppraisalLine."New Savings Balance" := RunBal;
                        AppraisalLine.Modify();
                    end;

                end;
            until Offset.Next() = 0;
        end;

        SaccoSetup.Get();

        ChargeAmt := 0;
        //MemberActivities.GetGeneral_SharingChargeAmount(SaccoSetup."Member Exit Charge", AppraisalLine."New Savings Balance", ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, SharingAmt, SharingDuty, SharingChargeAcctType, SharingChargeAcct);
        Header."Withdrawal Fee" := ChargeAmt;
        if Header."Withdrawal Fee" > 0 then begin

            JournalInsert(
                JTemplate,
                JBatch,
                Header."No.",
                Today,
                Accttype::Savings,
                RecoveryAccount,
                CopyStr('Withdrawal Fee: ' + Loans."Loan Product Type Name", 1, 50),
                Balaccttype::"G/L Account",
                ChargeAcct,
                Header."Withdrawal Fee",
                Header."No.",
                '',
                Transtype::" ",
                Header."Global Dimension 1 Code",
                Header."Global Dimension 2 Code",
                true
                );


        end;



        Header."Total Deduction" := Header."Outstanding Principal" + Header."Outstanding Interest" + Header."Withdrawal Fee";
        Header."Net Refund" := Header."Total Available" + Header.Waiver - Header."Total Deduction";



        if Header."Net Refund" < 0 then
            Header."Net Refund" := 0;
        Header.Modify();


        //Recover Self Guaranteed Loans
        Offset.Reset();
        Offset.SetRange("Header No.", Header."No.");
        Offset.SetRange("Member No", Header."Member No.");
        Offset.SetRange("Self Guaranteed", true);
        if Offset.FindFirst() then begin
            repeat

                AppraisalLine.Reset();
                AppraisalLine.SetRange("Offset No.", Header."No.");
                AppraisalLine.SetRange("Loan No.", Offset."Loan No");
                if AppraisalLine.FindFirst() then begin
                    if RunBal > 0 then begin
                        Loans.Get(Offset."Loan No");

                        if AppraisalLine."Outstanding Interest" = 0 then begin
                            AppraisalLine.SAvings := RunBal;
                            AppraisalLine."New Savings Balance" := RunBal;
                        end;

                        DedAmt := Offset."Amount to Recover";
                        if DedAmt = 0 then
                            DedAmt := Offset."Outstanding Principal";


                        if DedAmt > RunBal then
                            DedAmt := RunBal;

                        if DedAmt > 0 then begin

                            PrAmt := DedAmt;
                            RunBal -= PrAmt;
                            //RecoverPrincipalLines
                            AppraisalLine."New Outstanding Balance" := DedAmt;
                            //AppraisalLine."New Savings Balance" := AppraisalLine."New Savings Balance" - DedAmt;


                            if PostEntries then begin

                                JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    Header."No.",
                                    Today,
                                    Accttype::Credit,
                                    Header."Member No.",
                                    CopyStr('Principal Offset: ' + Loans."Loan Product Type Name", 1, 50),
                                    Balaccttype::"G/L Account",
                                    '',
                                    -PrAmt,
                                    Header."No.",
                                    Loans."Loan No.",
                                    Transtype::"Principal Repayment",
                                    Header."Global Dimension 1 Code",
                                    Header."Global Dimension 2 Code",
                                    true
                                    );

                                JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    Header."No.",
                                    Today,
                                    Accttype::Savings,
                                    RecoveryAccount,
                                    CopyStr('Principal Offset: ' + Loans."Loan Product Type Name", 1, 50),
                                    Balaccttype::"G/L Account",
                                    '',
                                    PrAmt,
                                    Header."No.",
                                    '',
                                    Transtype::" ",
                                    Header."Global Dimension 1 Code",
                                    Header."Global Dimension 2 Code",
                                    true
                                    );


                            end;
                        end;

                    end;

                    AppraisalLine."New Savings Balance" := RunBal;
                    AppraisalLine.Modify();
                end;
            until Offset.Next() = 0;
        end;



        //Recover Other Loans
        Offset.Reset();
        Offset.SetRange("Header No.", Header."No.");
        Offset.SetRange("Member No", Header."Member No.");
        Offset.SetRange("Self Guaranteed", false);
        if Offset.FindFirst() then begin
            repeat

                AppraisalLine.Reset();
                AppraisalLine.SetRange("Offset No.", Header."No.");
                AppraisalLine.SetRange("Loan No.", Offset."Loan No");
                if AppraisalLine.FindFirst() then begin
                    if RunBal > 0 then begin
                        Loans.Get(Offset."Loan No");

                        DedAmt := Offset."Amount to Recover";
                        if DedAmt = 0 then
                            DedAmt := Offset."Outstanding Principal";

                        if DedAmt > RunBal then
                            DedAmt := RunBal;

                        if DedAmt > 0 then begin

                            PrAmt := DedAmt;
                            RunBal -= PrAmt;
                            //RecoverPrincipalLines
                            AppraisalLine."New Outstanding Balance" := DedAmt;
                            //AppraisalLine."New Savings Balance" := AppraisalLine."New Savings Balance" - DedAmt;


                            if PostEntries then begin

                                JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    Header."No.",
                                    Today,
                                    Accttype::Credit,
                                    Header."Member No.",
                                    CopyStr('Principal Offset: ' + Loans."Loan Product Type Name", 1, 50),
                                    Balaccttype::"G/L Account",
                                    '',
                                    -PrAmt,
                                    Header."No.",
                                    Loans."Loan No.",
                                    Transtype::"Principal Repayment",
                                    Header."Global Dimension 1 Code",
                                    Header."Global Dimension 2 Code",
                                    true
                                    );

                                JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    Header."No.",
                                    Today,
                                    Accttype::Savings,
                                    RecoveryAccount,
                                    CopyStr('Principal Offset: ' + Loans."Loan Product Type Name", 1, 50),
                                    Balaccttype::"G/L Account",
                                    '',
                                    PrAmt,
                                    Header."No.",
                                    '',
                                    Transtype::" ",
                                    Header."Global Dimension 1 Code",
                                    Header."Global Dimension 2 Code",
                                    true
                                    );


                            end;

                        end;
                    end;

                    AppraisalLine."Loan Balance Before Guarantors" := AppraisalLine."New Outstanding Balance" + AppraisalLine."New Outstanding Interest";

                    AppraisalLine."New Savings Balance" := RunBal;
                    AppraisalLine.Modify();
                end;
            until Offset.Next() = 0;
        end;




        //Recover Other Guarantors
        Offset.Reset();
        Offset.SetRange("Header No.", Header."No.");
        Offset.SetRange("Member No", Header."Member No.");
        Offset.SetRange("Recover From Guarantors", true);
        if Offset.FindFirst() then begin
            repeat

                AppraisalLine.Reset();
                AppraisalLine.SetRange("Offset No.", Header."No.");
                AppraisalLine.SetRange("Loan No.", Offset."Loan No");
                if AppraisalLine.FindFirst() then begin

                    TotalGuaranteed := 0;
                    RecoveryLines.Reset;
                    RecoveryLines.SetRange("Header No.", Header."No.");
                    RecoveryLines.SetRange("Loan No.", Offset."Loan No");
                    if RecoveryLines.Find('-') then begin
                        RecoveryLines.CalcSums("Amount Guaranteed");
                        TotalGuaranteed := RecoveryLines."Amount Guaranteed";
                    END;


                    RecoveryLines.Reset;
                    RecoveryLines.SetRange("Header No.", Header."No.");
                    RecoveryLines.SetRange("Loan No.", Offset."Loan No");
                    if RecoveryLines.Find('-') then begin
                        repeat


                            RecoveryLines."Loan Balance After Offset" := AppraisalLine."Loan Balance Before Guarantors";

                            RecoveryLines."Loan Allocation" := 0;

                            //if TotalGuaranteed > 0 then
                            RecoveryLines."Loan Allocation" := ROUND(RecoveryLines."Amount Guaranteed" / TotalGuaranteed * RecoveryLines."Loan Balance After Offset", 0.01, '>');

                            RecoveryLines."Amount to Recover" := RecoveryLines."Loan Allocation";
                            RecoveryLines.Modify();

                            Loans.Reset;
                            Loans.SetRange("Loan No.", Offset."Loan No");
                            Loans.SetFilter("Total Outstanding Balance", '>0');
                            if Loans.FindFirst then begin

                                MemberAccounts.Reset();
                                MemberAccounts.SetRange("No.", RecoveryLines."Guarantor Savings Account");
                                MemberAccounts.SetFilter("Balance (LCY)", '>0');
                                if MemberAccounts.FindFirst() then begin
                                    repeat

                                        PSetup.Reset();
                                        PSetup.SetRange("Nature of Loan Type", PSetup."Nature of Loan Type"::Defaulter);
                                        if PSetup.FindFirst() then begin
                                            DefLoan.Reset();
                                            DefLoan.SetRange("Loan Product Type", PSetup."Product ID");
                                            DefLoan.SetRange("Member No.", MemberAccounts."Old Member No.");
                                            DefLoan.SetRange(Posted, false);
                                            if DefLoan.FindFirst() then begin
                                                DefLoan.DeleteAll();
                                            end;


                                            DefLoan.Init;
                                            DefLoan."Loan No." := '';
                                            DefLoan.Source := PSetup."Loan Source";
                                            DefLoan."Application Date" := Today;
                                            DefLoan."Loan Product Type" := PSetup."Product ID";
                                            DefLoan."Loan Product Type Name" := PSetup.Description;
                                            DefLoan."Member No." := MemberAccounts."Member No.";
                                            DefLoan.Validate("Disbursement Account No", '');
                                            DefLoan."Member Name" := MemberAccounts.Name;
                                            DefLoan."Requested Amount" := RecoveryLines."Amount to Recover";
                                            DefLoan."Approved Amount" := RecoveryLines."Amount to Recover";
                                            DefLoan.Status := DefLoan."status"::Approved;
                                            DefLoan.Installments := PSetup."Default Installments";
                                            DefLoan."Repayment Frequency" := PSetup."Repayment Frequency";
                                            DefLoan."Annual Interest %" := PSetup."Interest Rate (Max.)";
                                            DefLoan.Validate("Sub-Sector Level 2 Code", Loans."Sub-Sector Level 2 Code");



                                            DefLoan."Interest Calculation Method" := PSetup."Interest Calculation Method";

                                            DefLoan."Mode of Disbursement" := DefLoan."mode of disbursement"::"Transfer to FOSA";
                                            DefLoan."Global Dimension 1 Code" := PSetup."Global Dimension 1 Code";
                                            DefLoan."Loan Interest Repayment" := ROUND((DefLoan."Requested Amount" * (DefLoan."Annual Interest %" / 1200)), 1);

                                            DefLoan."Loan Principle Repayment" := ROUND((DefLoan."Requested Amount" / DefLoan.Installments), 1);
                                            DefLoan.Repayment := DefLoan."Loan Interest Repayment" + DefLoan."Loan Principle Repayment";



                                            if DefLoan."Interest Calculation Method" = DefLoan."Interest Calculation Method"::Amortised then begin
                                                DefLoan.TestField(DefLoan.Installments);
                                                DefLoan.Repayment := ROUND((DefLoan."Annual Interest %" / 12 / 100) / (1 - Power((1 + (DefLoan."Annual Interest %" / 12 / 100)), -DefLoan.Installments)) * DefLoan."Approved Amount");
                                                DefLoan."Loan Interest Repayment" := DefLoan."Approved Amount" / 100 * DefLoan."Annual Interest %";
                                                DefLoan."Loan Principle Repayment" := DefLoan.Repayment - DefLoan."Loan Interest Repayment";
                                            end;

                                            if (DefLoan."Interest Calculation Method" = DefLoan."Interest Calculation Method"::"Straight Line") then begin
                                                //POLICETESTFIELD(Interest);
                                                DefLoan.TestField(Installments);
                                                DefLoan."Loan Principle Repayment" := ROUND(DefLoan."Approved Amount" / DefLoan.Installments, 0.05, '>');//LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');

                                                DefLoan."Loan Interest Repayment" := (DefLoan."Annual Interest %" / 12 / 100) * DefLoan."Approved Amount";
                                                DefLoan.Repayment := DefLoan."Loan Principle Repayment" + DefLoan."Loan Interest Repayment";
                                            end;


                                            if DefLoan."Interest Calculation Method" = DefLoan."Interest Calculation Method"::"Reducing Balance" then begin
                                                DefLoan.TestField("Annual Interest %");
                                                DefLoan.TestField(Installments);
                                                DefLoan."Loan Principle Repayment" := ROUND(DefLoan."Approved Amount" / DefLoan.Installments, 0.05, '>');//LoanAmount/RepayPeriod;
                                                DefLoan."Loan Interest Repayment" := (DefLoan."Annual Interest %" / 12 / 100) * DefLoan."Approved Amount";
                                                DefLoan.Repayment := DefLoan."Loan Principle Repayment" + DefLoan."Loan Interest Repayment";
                                                DefLoan.Repayment := DefLoan."Loan Principle Repayment" + DefLoan."Loan Interest Repayment";
                                                DefLoan."Adjusted Repayment" := DefLoan."Loan Principle Repayment" + DefLoan."Loan Interest Repayment";
                                            end;

                                            DefLoan."Booking Branch" := MemberAccounts."Global Dimension 2 Code";

                                            DefLoan.Posted := false;
                                            DefLoan."Disbursement Date" := Today;
                                            DefLoan."Repayment Start Date" := CalcDate('1M+CM', DefLoan."Disbursement Date");
                                            DefLoan."Completion Date" := CalcDate(Format(DefLoan.Installments) + 'M', DefLoan."Disbursement Date");
                                            DefLoan."Defaulted Amount Transfered" := DefLoan."Approved Amount";
                                            DefLoan."Defaulter Loan No." := Loans."Loan No.";
                                            DefLoan."Defaulter Member No." := Loans."Member No.";

                                            DefLoan.Insert(true);




                                            JournalInsert(
                                                JTemplate,
                                                JBatch,
                                                Header."No.",
                                                Today,
                                                Accttype::Credit,
                                                Loans."Member No.",
                                                CopyStr('Defaulted Loan Transfer: ' + DefLoan."Member Name", 1, 50),
                                                Balaccttype::"G/L Account",
                                                '',
                                                -DefLoan."Approved Amount",
                                                Header."No.",
                                                Loans."Loan No.",
                                                Transtype::"Principal Repayment",
                                                Header."Global Dimension 1 Code",
                                                Header."Global Dimension 2 Code",
                                                true
                                                );




                                            JournalInsert(
                                                JTemplate,
                                                JBatch,
                                                Header."No.",
                                                Today,
                                                Accttype::Credit,
                                                DefLoan."Member No.",
                                                CopyStr('Defaulted Loan Transfer: ' + Loans."Member Name", 1, 50),
                                                Balaccttype::"G/L Account",
                                                '',
                                                DefLoan."Approved Amount",
                                                Header."No.",
                                                DefLoan."Loan No.",
                                                Transtype::"Principal Repayment",
                                                Header."Global Dimension 1 Code",
                                                Header."Global Dimension 2 Code",
                                                true
                                                );

                                        end;


                                    /*
                                    MemberAccounts.calcfields("Balance (LCY)");
                                    AvailDep := MemberAccounts."Balance (LCY)";
                                    if AvailDep > RecoveryLines."Amount to Recover" then
                                        AvailDep := RecoveryLines."Amount to Recover";

                                    RunBal := AvailDep;


                                    if RunBal > 0 then begin

                                        Loans.CalcFields("Outstanding Interest", "Outstanding Principal");

                                        if Loans."Outstanding Interest" < AppraisalLine."New Outstanding Interest" then
                                            Loans."Outstanding Interest" := AppraisalLine."New Outstanding Interest";


                                        if Loans."Outstanding Principal" < AppraisalLine."New Outstanding Balance" then
                                            Loans."Outstanding Principal" := AppraisalLine."New Outstanding Balance";


                                        if Loans."Outstanding Interest" < 0 then
                                            Loans."Outstanding Interest" := 0;


                                        DedAmt := Loans."Outstanding Interest" + Loans."Outstanding Principal";

                                        if DedAmt > RunBal then
                                            DedAmt := RunBal;

                                        if PostEntries then begin


                                            if Loans."Outstanding Interest" > 0 then begin
                                                IntAmt := Loans."Outstanding Interest";
                                                if IntAmt > DedAmt then
                                                    IntAmt := DedAmt;

                                                RunBal -= IntAmt;
                                                DedAmt -= IntAmt;

                                                JournalInsert(
                                                    JTemplate,
                                                    JBatch,
                                                    Header."No.",
                                                    Today,
                                                    Accttype::Credit,
                                                    Header."Member No.",
                                                    CopyStr('Defaulter Interest Recovered: ' + RecoveryLines."Guarantor Name", 1, 50),
                                                    Balaccttype::"G/L Account",
                                                    '',
                                                    -IntAmt,
                                                    Header."No.",
                                                    Loans."Loan No.",
                                                    Transtype::"Interest Paid",
                                                    Header."Global Dimension 1 Code",
                                                    Header."Global Dimension 2 Code",
                                                    true
                                                    );

                                                JournalInsert(
                                                    JTemplate,
                                                    JBatch,
                                                    Header."No.",
                                                    Today,
                                                    Accttype::Savings,
                                                    MemberAccounts."No.",
                                                    CopyStr('Defaulter Interest Recovered: ' + Header.Name, 1, 50),
                                                    Balaccttype::"G/L Account",
                                                    '',
                                                    IntAmt,
                                                    Header."No.",
                                                    '',
                                                    Transtype::" ",
                                                    Header."Global Dimension 1 Code",
                                                    Header."Global Dimension 2 Code",
                                                    true
                                                    );


                                            end;

                                            if Loans."Outstanding Principal" > 0 then begin
                                                PrAmt := Loans."Outstanding Principal";
                                                if PrAmt > DedAmt then
                                                    PrAmt := DedAmt;

                                                RunBal -= PrAmt;
                                                DedAmt -= PrAmt;

                                                JournalInsert(
                                                    JTemplate,
                                                    JBatch,
                                                    Header."No.",
                                                    Today,
                                                    Accttype::Credit,
                                                    Header."Member No.",
                                                    CopyStr('Defaulter Principal Recovered: ' + RecoveryLines."Guarantor Name", 1, 50),
                                                    Balaccttype::"G/L Account",
                                                    '',
                                                    -PrAmt,
                                                    Header."No.",

                                                    Loans."Loan No.",
                                                    Transtype::"Principal Repayment",
                                                    Header."Global Dimension 1 Code",
                                                    Header."Global Dimension 2 Code",
                                                    true
                                                    );

                                                JournalInsert(
                                                    JTemplate,
                                                    JBatch,
                                                    Header."No.",
                                                    Today,
                                                    Accttype::Savings,
                                                    RecoveryAccount,
                                                    CopyStr('Defaulter Principal Recovered: ' + Header.Name, 1, 50),
                                                    Balaccttype::"G/L Account",
                                                    '',
                                                    PrAmt,
                                                    Header."No.",
                                                    '',
                                                    Transtype::" ",
                                                    Header."Global Dimension 1 Code",
                                                    Header."Global Dimension 2 Code",
                                                    true
                                                    );
                                            end;

                                        end;

                                    end;
                                    */

                                    until MemberAccounts.Next() = 0;
                                end;
                                /*
                                MemberAccounts.Reset();
                                MemberAccounts.SetRange("No.", RecoveryLines."Guarantor Savings Account");
                                MemberAccounts.SetFilter("Balance (LCY)", '>0');
                                if MemberAccounts.FindFirst() then begin
                                    repeat
                                        MemberAccounts.calcfields("Balance (LCY)");
                                        AvailDep := MemberAccounts."Balance (LCY)";
                                        if AvailDep > RecoveryLines."Amount to Recover" then
                                            AvailDep := RecoveryLines."Amount to Recover";

                                        RunBal := AvailDep;

                                        if RunBal > 0 then begin

                                            Loans.CalcFields("Outstanding Interest", "Outstanding Principal");

                                            if Loans."Outstanding Interest" < AppraisalLine."New Outstanding Interest" then
                                                Loans."Outstanding Interest" := AppraisalLine."New Outstanding Interest";


                                            if Loans."Outstanding Principal" < AppraisalLine."New Outstanding Balance" then
                                                Loans."Outstanding Principal" := AppraisalLine."New Outstanding Balance";


                                            if Loans."Outstanding Interest" < 0 then
                                                Loans."Outstanding Interest" := 0;


                                            DedAmt := Loans."Outstanding Interest" + Loans."Outstanding Principal";

                                            if DedAmt > RunBal then
                                                DedAmt := RunBal;

                                            if PostEntries then begin


                                                if Loans."Outstanding Interest" > 0 then begin
                                                    IntAmt := Loans."Outstanding Interest";
                                                    if IntAmt > DedAmt then
                                                        IntAmt := DedAmt;

                                                    RunBal -= IntAmt;
                                                    DedAmt -= IntAmt;

                                                    JournalInsert(
                                                        JTemplate,
                                                        JBatch,
                                                        Header."No.",
                                                        Today,
                                                        Accttype::Credit,
                                                        Header."Member No.",
                                                        CopyStr('Defaulter Interest Recovered: ' + RecoveryLines."Guarantor Name", 1, 50),
                                                        Balaccttype::"G/L Account",
                                                        '',
                                                        -IntAmt,
                                                        Header."No.",
                                                        Loans."Loan No.",
                                                        Transtype::"Interest Paid",
                                                        Header."Global Dimension 1 Code",
                                                        Header."Global Dimension 2 Code",
                                                        true
                                                        );

                                                    JournalInsert(
                                                        JTemplate,
                                                        JBatch,
                                                        Header."No.",
                                                        Today,
                                                        Accttype::Savings,
                                                        MemberAccounts."No.",
                                                        CopyStr('Defaulter Interest Recovered: ' + Header.Name, 1, 50),
                                                        Balaccttype::"G/L Account",
                                                        '',
                                                        IntAmt,
                                                        Header."No.",
                                                        '',
                                                        Transtype::" ",
                                                        Header."Global Dimension 1 Code",
                                                        Header."Global Dimension 2 Code",
                                                        true
                                                        );


                                                end;

                                                if Loans."Outstanding Principal" > 0 then begin
                                                    PrAmt := Loans."Outstanding Principal";
                                                    if PrAmt > DedAmt then
                                                        PrAmt := DedAmt;

                                                    RunBal -= PrAmt;
                                                    DedAmt -= PrAmt;

                                                    JournalInsert(
                                                        JTemplate,
                                                        JBatch,
                                                        Header."No.",
                                                        Today,
                                                        Accttype::Credit,
                                                        Header."Member No.",
                                                        CopyStr('Defaulter Principal Recovered: ' + RecoveryLines."Guarantor Name", 1, 50),
                                                        Balaccttype::"G/L Account",
                                                        '',
                                                        -PrAmt,
                                                        Header."No.",

                                                        Loans."Loan No.",
                                                        Transtype::"Principal Repayment",
                                                        Header."Global Dimension 1 Code",
                                                        Header."Global Dimension 2 Code",
                                                        true
                                                        );

                                                    JournalInsert(
                                                        JTemplate,
                                                        JBatch,
                                                        Header."No.",
                                                        Today,
                                                        Accttype::Savings,
                                                        RecoveryAccount,
                                                        CopyStr('Defaulter Principal Recovered: ' + Header.Name, 1, 50),
                                                        Balaccttype::"G/L Account",
                                                        '',
                                                        PrAmt,
                                                        Header."No.",
                                                        '',
                                                        Transtype::" ",
                                                        Header."Global Dimension 1 Code",
                                                        Header."Global Dimension 2 Code",
                                                        true
                                                        );
                                                end;

                                            end;

                                        end;

                                    until MemberAccounts.Next() = 0;
                                end;
                                */

                            end;
                        until RecoveryLines.Next = 0;
                    end;


                    DedAmt := Offset."Outstanding Principal";

                    if DedAmt > RunBal then
                        DedAmt := RunBal;

                    if DedAmt > 0 then begin

                        IntAmt := DedAmt;
                        RunBal -= IntAmt;
                        DedAmt -= IntAmt;
                        //RecoverPrincipalLines
                        AppraisalLine."New Outstanding Balance" := DedAmt;
                        AppraisalLine."Loan Balance Before Guarantors" := AppraisalLine."New Outstanding Balance" + AppraisalLine."New Outstanding Balance";
                        AppraisalLine.Modify();
                    end;
                end;

            until Offset.Next() = 0;
        end;

        if PostEntries then begin
            if JournalPost(JTemplate, JBatch) then
                Message('Entries Posted Successfully');
        end;

    end;

    procedure SendEmail(RecepientAddress: Text; AddCC: Text; FileName: Text; Subject: Text; Salutation: Text; Body: Text)
    var
        myInt: Integer;
        Vend: Record Vendor;
        SaccoSetup: Record "Sacco Setup";
        RFQLn: Record "RFQ Line";
        //TmpCustomTempBlob: Record CustomTempBlob temporary;
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        BodyMsg: Text;
        Base64: Text;
        SalutationTxt: label 'Dear Sir / Madam,';
        BodyTxt: label 'Please find attached the quotation to be filled in.';
        RegardsTxt: label 'Kind Regards,';
        DesclaimerTxt: label 'This is a system generated email. please do not respond to this email';
        ProcessTxt: label 'Successfully Processed.';
    begin


        if FILE.Exists(FileName) then
            FILE.Erase(FileName);

        if FileName <> '' then begin
            //TmpCustomTempBlob.BLOBImportFromServerFile(TmpCustomTempBlob, FileName);
            //Base64 := Format(TmpCustomTempBlob.ToBase64String);
        end;

        BodyMsg := (Salutation);
        BodyMsg += ('<br><br>');
        BodyMsg += (Body);
        BodyMsg += ('<br><br>');
        BodyMsg += (RegardsTxt);
        BodyMsg += ('<br>');
        BodyMsg += (COMPANYNAME);
        BodyMsg += ('<br><br>');
        BodyMsg += ('<HR>');
        BodyMsg += (DesclaimerTxt);


        EmailMsg.Create(RecepientAddress, Subject, BodyMsg, true);
        if FileName <> '' then
            EmailMsg.AddAttachment(FileName, 'xlsx', Base64);
        Email.Send(EmailMsg);
    end;

    procedure EncryptFile(inputFileName: Text; outputFileName: Text; filePassword: Text)
    var
      //  EncPdf: DotNet EncPdf;
    begin
        //EncPdf := EncPdf.EncryptThisPdf(inputFileName, outputFileName, filePassword);
    end;

    procedure ImportToExcelBuffer(DestinationVariant: Variant)
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
        RecRef: RecordRef;
    begin

        File.Upload(OpenExcelFile, FromFolder, ExcelFileFilter, FileName, ServerFileName);

        if not File.Exists(ServerFileName) then exit;

        SheetName := TempExcelBuffer.SelectSheetsName(ServerFileName);
        TempExcelBuffer.OpenBook(ServerFileName, SheetName);
        TempExcelBuffer.ReadSheet;
        TempExcelBuffer.SetFilter("Row No.", '>%1', 1);
        Total := TempExcelBuffer.Count;
        RecRef.Open(DestinationVariant);
        case RecRef.Number of
            Database::"RFQ Vendors Quotations":
                ReadExcelBufferForRfqVendorQuotations(TempExcelBuffer);

        end;


    end;


    procedure ReadExcelBufferForRfqVendorQuotations(var ExcelBuffer: Record "Excel Buffer" temporary)
    var
        RFQVendorsQuotations: Record "RFQ Vendors Quotations";
        Counter: Integer;
        ReadingFile: label 'Reading File';
        WritingFile: label 'Writing File';
        ReadingLines: label 'Reading Lines';
        NoOfLines: label 'No. of Lines';
        CurrentLine: label 'Current Line No.';
        Window: Dialog;
        WindowLastUpdated: DateTime;
        Total: Integer;
    begin

        Counter := 0;
        Total := ExcelBuffer.Count;
        Window.Open(
          ReadingFile + ' @1@@@@@@@@@@@@@@@@@@@@@@@@\' +
          CurrentLine + ' #2#######\' +
          NoOfLines + '#3#######');
        Window.Update(3, Total);
        WindowLastUpdated := CurrentDatetime;

        if ExcelBuffer.FindSet() then
            repeat
                Counter += 1;


                case ExcelBuffer."Column No." of
                    1:
                        begin
                            RFQVendorsQuotations.Init();
                            Evaluate(RFQVendorsQuotations."Vendor No", ExcelBuffer."Cell Value as Text");
                        end;
                    2:
                        Evaluate(RFQVendorsQuotations."Document No", ExcelBuffer."Cell Value as Text");
                    3:
                        Evaluate(RFQVendorsQuotations.Type, ExcelBuffer."Cell Value as Text");
                    4:
                        Evaluate(RFQVendorsQuotations.Description, ExcelBuffer."Cell Value as Text");
                    5:
                        Evaluate(RFQVendorsQuotations.Quantity, ExcelBuffer."Cell Value as Text");
                    6:
                        Evaluate(RFQVendorsQuotations."Unit Cost", ExcelBuffer."Cell Value as Text");
                    7:
                        begin
                            Evaluate(RFQVendorsQuotations.Amount, ExcelBuffer."Cell Value as Text");
                            RFQVendorsQuotations.Insert();
                        end;


                end;


                if CurrentDatetime - WindowLastUpdated > 100 then begin
                    Window.Update(1, ROUND(Counter / Total * 10000, 1));
                    Window.Update(2, Counter);
                    WindowLastUpdated := CurrentDatetime;
                end;
            until ExcelBuffer.Next = 0;
        Window.Close;



    end;






}

