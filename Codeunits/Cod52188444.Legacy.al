codeunit 52188435 Legacy
{



    procedure CreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Enum "Transaction Type Enum"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No." := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."System-Created Entry" := true;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure CreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Enum "Transaction Type Enum"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Enum "Gen. Journal Account Type"; BalancingAccountNo: Code[40])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."System-Created Entry" := true;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetUserBranch() branchCode: Code[20]
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Global Dimension 2 Code";
        end;
        exit(branchCode);
    end;




    procedure CreatePVLine(PVNumber: Code[20]; PostingDate: Date; PVLineCode: Code[40]; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20]; Amount: Decimal; Remarks: Text[60]; ActivityCode: Code[10]; BranchCode: Code[10]; TransactionType: Enum "Transaction Type Enum"; LoanNo: Code[20]; Reference: Code[20])
    var
        //PVLines: Record "Document Line";
    begin
        /*if Amount <> 0 then begin
            PVLines.Init;
            PVLines."Header No." := PVNumber;
            PVLines."Posting Date" := PostingDate;
            PVLines.Type := PVLineCode;//code
            PVLines."Account Type" := AccountType;
            PVLines."Account No." := AccountNo;

            PVLines."Transaction Type" := TransactionType;
            PVLines.Amount := Amount;
            PVLines.Validate(PVLines.Amount);
            PVLines.Description := Remarks;
            PVLines."Shortcut Dimension 1 Code" := ActivityCode;
            PVLines."Shortcut Dimension 2 Code" := BranchCode;
            PVLines."Loan No." := LoanNo;
            //PVLines.Reference := Reference;
            if PVLines.Amount <> 0 then
                PVLines.Insert;
            //PVLines.VALIDATE(PVLines."Account No.");
        end;*/
    end;


    procedure GetDepositAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record Vendor;
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Deposit Contribution");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetShareCapitalAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record Vendor;
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Share Capital");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetOrdinaryAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record Vendor;
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetRegFeeAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record Vendor;
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Registration Fee");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetDividendAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record Vendor;
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Dividend Account");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;


    procedure GetHousingAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record Vendor;
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::Housing);
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetHolidayAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record Vendor;
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Holiday Savings");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetSchFeeAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record Vendor;
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"School Fee");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;

    procedure GetUnallocatedAccount(MNo: Code[200]) AccountNo: Code[20];
    var
        MemberAccounts: Record Vendor;
    begin
        AccountNo := '';
        MemberAccounts.Reset();
        MemberAccounts.SetRange("Member No.", MNo);
        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Unallocated Fund");
        if MemberAccounts.FindFirst() then begin
            AccountNo := MemberAccounts."No.";
        end;
    end;



    procedure GetNonWithdrawableBalance(MNo: Code[200]) Bal: Decimal;
    var
        MemberAccounts: Record Vendor;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;
        PSetup.Reset();
        PSetup.SetRange("Savings Type", PSetup."Savings Type"::"Non-Withdrawable");
        if PSetup.FindFirst() then begin
            repeat

                MemberAccounts.Reset();
                MemberAccounts.SetRange("Member No.", MNo);
                MemberAccounts.SetRange("Product Type", PSetup."Product ID");
                if MemberAccounts.FindFirst() then begin
                    MemberAccounts.CalcFields("Balance (LCY)");
                    Bal += MemberAccounts."Balance (LCY)";
                end;
            until PSetup.Next() = 0;
        end;
    end;

    procedure GetProductsToOffsetAccountBalance(MNo: Code[200]) Bal: Decimal;
    var
        MemberAccounts: Record Vendor;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;
        PSetup.Reset();
        PSetup.SetRange("Can Offset Loan", true);
        if PSetup.FindFirst() then begin
            repeat

                MemberAccounts.Reset();
                MemberAccounts.SetRange("Member No.", MNo);
                MemberAccounts.SetRange("Product Type", PSetup."Product ID");
                if MemberAccounts.FindFirst() then begin
                    MemberAccounts.CalcFields("Balance (LCY)");
                    Bal += MemberAccounts."Balance (LCY)";
                end;
            until PSetup.Next() = 0;
        end;
    end;

    procedure GetTotalLoanPrincipalBalance(MNo: Code[200]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Outstanding Principal");
                Bal += Loans."Outstanding Principal";
            until Loans.Next() = 0;
        end;
    end;


    procedure GetTotalLoanOutstandingBalance(MNo: Code[200]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                Bal += Loans."Outstanding Principal" + Loans."Outstanding Interest";

            until Loans.Next() = 0;
        end;
    end;

    procedure GetTotalLoanInterestBalance(MNo: Code[200]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Outstanding Interest");
                Bal += Loans."Outstanding Interest";
            until Loans.Next() = 0;
        end;
    end;


    procedure GetTotalBOSALoanPrincipalBalance(MNo: Code[200]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        if Loans.FindFirst() then begin
            repeat
                PSetup.Get(Loans."Loan Product Type");
                if PSetup."Loan Source" = PSetup."Loan Source"::BOSA then begin

                    Loans.CalcFields("Outstanding Principal");
                    Bal += Loans."Outstanding Principal";

                end;
            until Loans.Next() = 0;
        end;
    end;

    procedure GetTotalBosaLoanInterestBalance(MNo: Code[200]) Bal: Decimal;
    var
        Loans: Record Loans;
        PSetup: Record "Product Setup";
    begin
        Bal := 0;

        Loans.Reset();
        Loans.SetRange("Member No.", MNo);
        if Loans.FindFirst() then begin
            repeat
                PSetup.Get(Loans."Loan Product Type");
                if PSetup."Loan Source" = PSetup."Loan Source"::BOSA then begin
                    Loans.CalcFields("Outstanding Interest");
                    Bal += Loans."Outstanding Interest";
                end;
            until Loans.Next() = 0;
        end;
    end;



    procedure GetLoansApprovedPerProduct(Product: Code[20]; SDate: date; EDate: date) Bal: Decimal
    var
        Loans: Record Loans;
    begin

        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Disbursement Date", '%1..%2', SDate, EDate);
        if Loans.FindFirst() then begin
            repeat
                Bal += Loans."Approved Amount";
            until Loans.Next() = 0;
        end;
    end;


    procedure GetTotalOutstandingBalancePerProduct(Product: Code[20]; AsAt: date) Bal: Decimal
    var
        Loans: Record Loans;
    begin

        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Date Filter", '..%1', Asat);
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Total Outstanding Balance");
                Bal += Loans."Total Outstanding Balance";
            until Loans.Next() = 0;
        end;
    end;

    procedure GetNoOfApplicationsPerProduct(Product: Code[20]; SDate: date; EDate: date) LCount: Integer
    var
        Loans: Record Loans;
    begin

        LCount := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Disbursement Date", '%1..%2', SDate, EDate);
        if Loans.FindFirst() then begin
            LCount := Loans.Count;
        end;
    end;


    procedure GetTotalPrincipalBalancePerProduct(Product: Code[20]; AsAt: date) Bal: Decimal
    var
        Loans: Record Loans;
    begin

        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Date Filter", '..%1', Asat);
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Outstanding Principal");
                Bal += Loans."Outstanding Principal";
            until Loans.Next() = 0;
        end;
    end;

    procedure GetTotalInterestBalancePerProduct(Product: Code[20]; AsAt: date) Bal: Decimal
    var
        Loans: Record Loans;
    begin

        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Date Filter", '..%1', Asat);
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Outstanding Interest");
                Bal += Loans."Outstanding Interest";
            until Loans.Next() = 0;
        end;
    end;




    procedure GetNonPerformingLoansPerProduct(Product: Code[20]; AsAt: date; Days: Integer; var DefAmt: Decimal; var PerformingBal: Decimal; var NonPerformingBal: Decimal) Bal: Decimal
    var
        Loans: Record Loans;
        SActivities: Codeunit "Sacco Activities";
        AmtDefaulted: Decimal;
        UserSetup: Record "User Setup";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        MDef: Integer;

    begin

        NonPerformingBal := 0;
        PerformingBal := 0;
        DefAmt := 0;
        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Loan Product Type", Product);
        Loans.SetFilter("Date Filter", '..%1', AsAt);
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Outstanding Principal");
                Bal += Loans."Outstanding Principal";

                ExpectedAmt := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;

                SActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false);

                if DaysInArrear >= Days then begin
                    DefAmt += DefAmount;
                    NonPerformingBal += Loans."Outstanding Principal";
                end
                else begin

                    PerformingBal += Loans."Outstanding Principal";
                end;

            until Loans.Next() = 0;
        end;
    end;

}
