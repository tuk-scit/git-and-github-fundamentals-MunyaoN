
Table 52188465 "Defaulter Loan Recovery"
{
    LookupPageID = "Defaulter Loan Recovery List";

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Recovery Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }

        field(10; Stage; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Booking,Verification,Approval,Recovery;
        }
        field(50001; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = Customer where("Account Type" = const(Members));

            trigger OnValidate()
            begin

                if Members.Get("Member No.") then
                    Name := Members.Name
                else
                    Name := '';

                RecoveryLines.Reset;
                RecoveryLines.SetRange("Header No.", "No.");
                if RecoveryLines.FindFirst then
                    if Confirm('This will clear the lines below. Do you want to continue?') then
                        RecoveryLines.DeleteAll
                    else
                        Error('Cancelled');

                "Recovery Type" := "recovery type"::" ";
                "Recovery Source" := "recovery source"::" ";
                "Loan No." := '';
            end;
        }
        field(50002; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."),
                                         "Total Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            begin

                TestField("Recovery Type", "recovery type"::"Single Loan");

                RecoveryLines.Reset;
                RecoveryLines.SetRange("Header No.", "No.");
                if RecoveryLines.FindFirst then begin
                    if Confirm('This will clear the lines below. Do you want to continue?') then
                        RecoveryLines.DeleteAll
                    else
                        Error('Cancelled');
                end;



                GetAmounts;
            end;
        }
        field(50004; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Status = Status::Pending then begin
                    Stage := Stage::Approval;
                    Modify();
                end;
                if Status = Status::Approved then begin
                    Stage := Stage::Recovery;
                    Modify();
                end;

            end;
        }
        field(50007; "Outstanding Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; "Member Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50010; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Recovered; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50012; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Recovery Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single Loan,All Loans';
            OptionMembers = " ","Single Loan","All Loans";

            trigger OnValidate()
            begin
                "Loan No." := '';
                RecoveryLines.Reset;
                RecoveryLines.SetRange("Header No.", "No.");
                if RecoveryLines.FindFirst then
                    if Confirm('This will clear the lines below. Do you want to continue?') then
                        RecoveryLines.DeleteAll
                    else
                        Error('Cancelled');

                if "Recovery Type" <> "Recovery Type"::"All Loans" then begin

                    OffsetLines.Reset;
                    OffsetLines.SetRange("Header No.", "No.");
                    OffsetLines.SetFilter("Loan No", '<>%1', '');
                    if OffsetLines.FindFirst then
                        OffsetLines.DeleteAll();

                end;

                GetAmounts;
            end;
        }
        field(50014; "Recovery Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Defaulter Withdrawable Savings","Defaulter Non-Withdrawable Deposits","Guarantor Withdrawable Savings","Guarantor Non-Withdrawable Deposits","Issue Guarantor Defaulter Loan","Recovery From All";

            trigger OnValidate()
            begin
                GetAmounts;
            end;
        }
        field(50015; "Member Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50016; "Source Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." where("Product Category" = filter(<> "Registration Fee" & <> "Share Capital"),
                                            "Member No." = field("Member No."));

            trigger OnValidate()
            begin


                if "Source Account" <> '' then begin
                    TestField("Recovery Option", "recovery option"::"Recover from Single Account");
                end;
                GetAmounts();
            end;
        }
        field(50017; "Amount to Recover"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if "Amount to Recover" > 0 then begin
                    TestField("Source Account");
                    TestField("Recovery Option", "recovery option"::"Recover from Single Account");
                    if "Amount to Recover" > MemberActivities.GetAccountBalance("Source Account") then
                        Error('Amount cannot be More than the Account Balance of KES %1', MemberActivities.GetAccountBalance("Source Account"));
                end;
            end;
        }
        field(50018; "Outstanding Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50019; "Outstanding Appraisal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50020; "Recovery Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Recover from Single Account","Recover from Multiple Accounts";

            trigger OnValidate()
            begin
                "Source Account" := '';
                "Amount to Recover" := 0;
                "Recovery Source" := "recovery source"::" ";
                GetAmounts;
            end;
        }
        field(50021; "Total Available"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50022; "Committed Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50024; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50025; "Share Capital Top Up"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "Deposit Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; "Waiver"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50028; "Self Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50029; "Total Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50030; "Withdrawal Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50031; "Dividend Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50032; "Net Refund"; Decimal)
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
            SalesSetup.Get;
            SalesSetup.TestField("Loan Recovery Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Loan Recovery Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;


        "Date Entered" := Today;
        "Entered By" := UserId;

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Members: Record Customer;
        RecoveryLines: Record "Defaulter Recovery Lines";
        MemberAccounts: Record Vendor;
        MemberActivities: Codeunit "Member Activities";
        Loans: Record Loans;
        UserSetup: Record "User Setup";
        OffsetLines: Record "Loans Offet List";


    local procedure GetFreeShares(MemberAccounts: Record Vendor; var FreeShares: Decimal)
    var
        LoanSecurity: Record "Loan Security";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: Decimal;
    begin
        FreeShares := 0;

        LoanSecurity.CalculateAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, Available);
        FreeShares := Available;
    end;

    procedure GetAmounts()
    var
        Security: Record "Loan Security";
        Vend: Record Vendor;
        OffsetLines: Record "Loans Offet List";
        Loans: Record Loans;
        Legacy: Codeunit Legacy;
        MActivities: Codeunit "Member Activities";
        PSetup: Record "Product Setup";

    begin

        "Member Deposits" := 0;
        "Member Savings" := 0;
        "Outstanding Principal" := 0;
        "Outstanding Appraisal" := 0;
        "Outstanding Interest" := 0;
        "Outstanding Penalty" := 0;
        "Total Available" := 0;
        "Committed Deposits" := 0;
        "Total Available" := Legacy.GetProductsToOffsetAccountBalance("Member No.");

        if "Recovery Option" = "Recovery Option"::"Recover from Single Account" then
            "Total Available" := MActivities.GetAccountBalanceWithoutMinAccBalance("Source Account");

        "Share Capital" := MActivities.GetAccountBalance(Legacy.GetShareCapitalAccount("Member No."));
        "Dividend Balance" := MActivities.GetAccountBalance(Legacy.GetDividendAccount("Member No."));

        "Share Capital Top Up" := 0;

        /*
        PSetup.Reset();
        PSetup.SetRange("Product Category", PSetup."Product Category"::"Share Capital");
        if PSetup.FindFirst() then begin
            if "Share Capital" < PSetup."Mandatory Contribution" then
                "Share Capital Top Up" := PSetup."Mandatory Contribution" - "Share Capital"
            else
                "Share Capital Top Up" := 0;
        end;
        */


        RecoveryLines.reset;
        RecoveryLines.setrange("Header No.", "No.");
        if RecoveryLines.FindFirst() then
            RecoveryLines.DeleteAll();


        if "Recovery Type" = "Recovery Type"::"All Loans" then begin
            OffsetLines.Reset;
            OffsetLines.SetRange("Header No.", "No.");
            OffsetLines.SetFilter("Loan No", '<>%1', '');
            if not OffsetLines.FindFirst then begin
                Loans.Reset();
                Loans.SetRange("Member No.", "Member No.");
                Loans.SetFilter("Outstanding Principal", '>0');
                if Loans.FindFirst() then begin
                    repeat
                        OffsetLines.Init();
                        OffsetLines."Header No." := "No.";
                        OffsetLines."Member No" := "Member No.";
                        OffsetLines.Validate("Loan No", Loans."Loan No.");
                        OffsetLines.Insert(true);
                    until Loans.Next() = 0;
                end;
            end;
        end;

        OffsetLines.Reset;
        OffsetLines.SetRange("Header No.", "No.");
        if OffsetLines.FindFirst then begin
            repeat
                OffsetLines.Validate("Loan No");
                OffsetLines.Modify();
                Loans.Get(OffsetLines."Loan No");
                Loans.CalcFields("Outstanding Interest", "Outstanding Principal");
                "Outstanding Principal" += Loans."Outstanding Principal";
                "Outstanding Interest" += Loans."Outstanding Interest";


                Security.Reset;
                Security.SetRange("Loan No.", Loans."Loan No.");
                Security.SetRange("Guarantor Type", Security."guarantor type"::Guarantor);
                Security.SETRANGE("Self Guarantee", true);
                if Security.FindFirst then begin
                    OffsetLines."Self Guaranteed" := true;
                    OffsetLines.Modify();
                end;

                if OffsetLines."Recover From Guarantors" then begin

                    Security.Reset;
                    Security.SetRange("Loan No.", Loans."Loan No.");
                    Security.SetRange("Guarantor Type", Security."guarantor type"::Guarantor);
                    Security.SETRANGE("Self Guarantee", FALSE);
                    if Security.FindFirst then begin
                        repeat

                            Security.CalcFields("Total Loan Guarantorship");
                            Loans.CalcFields("Outstanding Interest", "Outstanding Principal");
                            Loans."Total Outstanding Balance" := Loans."Outstanding Interest" + Loans."Outstanding Principal";

                            //Message('t');
                            RecoveryLines.Init;
                            RecoveryLines."Loan No." := Loans."Loan No.";
                            RecoveryLines."Header No." := "No.";
                            RecoveryLines."Guarantor Member No." := Security."Member No";
                            RecoveryLines."Guarantor Name" := Security.Name;
                            Members.Get(Security."Member No");

                            MemberAccounts.Reset;
                            MemberAccounts.SetRange("Product Category", MemberAccounts."product category"::"Deposit Contribution");
                            MemberAccounts.SetRange("Member No.", Members."No.");
                            if MemberAccounts.FindFirst then
                                RecoveryLines."Guarantor Savings Account" := MemberAccounts."No.";

                            RecoveryLines."Amount Guaranteed" := Security."Amount Guaranteed";

                            GetSavingsBalances(Members."No.", RecoveryLines."Withdrawable Savings", RecoveryLines."Non-Withdrable Savings", RecoveryLines."Committed Deposits");
                            if Security."Total Loan Guarantorship" > 0 then
                                RecoveryLines."Loan Allocation" := ROUND(Security."Amount Guaranteed" / Security."Total Loan Guarantorship" * Loans."Total Outstanding Balance", 0.01, '>');

                            RecoveryLines."Amount to Recover" := RecoveryLines."Loan Allocation";
                            RecoveryLines.Insert;
                        until Security.Next = 0;
                    end;

                end;

            until OffsetLines.Next() = 0;
        end;


        "Self Guaranteed" := 0;
        Security.Reset;
        Security.SetRange("Loan No.", Loans."Loan No.");
        Security.SetRange("Guarantor Type", Security."guarantor type"::Guarantor);
        Security.SETRANGE("Member No", "Member No.");
        if Security.FindFirst then begin
            repeat
                Security.CalcSums("Current Committed");
                "Self Guaranteed" += Security."Current Committed";

            until Security.Next = 0;
        end;

        "Deposit Balance" := "Total Available" + "Dividend Balance" - "Outstanding Principal" - "Outstanding Interest" - "Share Capital Top Up";

    end;

    local procedure GetSavingsBalances(MNo: Code[20]; var Withdrawable: Decimal; var NonWithdrawable: Decimal; var "Committed Deposits": Decimal)
    var
        ProductSetup: Record "Product Setup";
    begin

        Withdrawable := 0;
        NonWithdrawable := 0;

        MemberAccounts.Reset;
        MemberAccounts.SetRange("Member No.", MNo);
        if MemberAccounts.FindFirst then begin
            repeat
                if ProductSetup.Get(MemberAccounts."Product Type") then begin
                    if ProductSetup."Can Offset Loan" then begin
                        if ProductSetup."Savings Type" = ProductSetup."savings type"::"Non-Withdrawable" then
                            NonWithdrawable += MemberActivities.GetAccountBalance(MemberAccounts."No.");
                        if ProductSetup."Savings Type" = ProductSetup."savings type"::Withdrawable then
                            Withdrawable += MemberActivities.GetAccountBalance(MemberAccounts."No.");
                    end;

                    "Committed Deposits" += MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", true);
                    "Committed Deposits" += MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", false);
                end;
            until MemberAccounts.Next = 0;
        end;
    end;


    procedure RecoverCombined(Post: Boolean)
    var
        sAcctivities: Codeunit "Sacco Activities";
        TotalRecovered: Decimal;
        AvailableDeposits: Decimal;
        DedAmt: Decimal;
        ProductSetup: Record "Product Setup";
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        LBal: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loan Security";
        RunBal: Decimal;
        LRec: Record Loans;
        JTemplate: Code[20];
        JBatch: Code[20];
    begin

        UserSetup.Get(UserId);

        JTemplate := UserSetup."General Journal Template";
        JBatch := UserSetup."General Journal Batch";

        sAcctivities.JournalInit(JTemplate, JBatch);


        //-----------------------------------Withdrawable
        TotalRecovered := 0;
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Savings);
        ProductSetup.SetRange("Savings Type", ProductSetup."Savings Type"::"Withdrawable");
        ProductSetup.SetRange("Can Offset Loan", true);
        if ProductSetup.FindFirst() then begin
            repeat
                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", "Member No.");
                MemberAccounts.SetRange("Product Type", ProductSetup."Product ID");
                if MemberAccounts.FindFirst then begin
                    repeat
                        TotalRecovered := 0;
                        AvailableDeposits := MemberActivities.GetAccountBalance(MemberAccounts."No.");
                        AvailableDeposits -= MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", true);
                        AvailableDeposits -= MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", false);
                        AvailableDeposits -= sAcctivities.GetJournalDebits(JTemplate, JBatch, AcctType::Savings, MemberAccounts."No.");


                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            Loans.SetFilter(loans."Outstanding Interest", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Interest");
                                        Loans."Outstanding Interest" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Interest Paid");

                                        IF Loans."OuTstanding Interest" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Interest";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Interest Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Interest Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                end;
                            END;
                        end;

                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            Loans.SetFilter(loans."Outstanding Penalty", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Penalty");
                                        Loans."Outstanding Penalty" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Penalty Paid");

                                        IF Loans."OuTstanding Penalty" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Penalty";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Penalty Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Penalty Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                end;
                            END;
                        end;



                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Principal");
                                        Loans."Outstanding Principal" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Principal Repayment");

                                        IF Loans."OuTstanding Penalty" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Penalty";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Penalty Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Principal Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                end;
                            END;
                        end;
                    until MemberAccounts.Next = 0;
                end;
            until ProductSetup.Next() = 0;
        end;


        //-----------------------------------Non-Withdrawable
        TotalRecovered := 0;
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Savings);
        ProductSetup.SetRange("Savings Type", ProductSetup."Savings Type"::"NOn-Withdrawable");
        ProductSetup.SetRange("Can Offset Loan", true);
        if ProductSetup.FindFirst() then begin
            repeat
                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", "Member No.");
                MemberAccounts.SetRange("Product Type", ProductSetup."Product ID");
                if MemberAccounts.FindFirst then begin
                    repeat
                        TotalRecovered := 0;
                        AvailableDeposits := MemberActivities.GetAccountBalance(MemberAccounts."No.");
                        AvailableDeposits -= MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", true);
                        AvailableDeposits -= MemberActivities.GetMemberCommittedDeposits(MemberAccounts."No.", false);
                        AvailableDeposits -= sAcctivities.GetJournalDebits(JTemplate, JBatch, AcctType::Savings, MemberAccounts."No.");


                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            Loans.SetFilter(loans."Outstanding Interest", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Interest");
                                        Loans."Outstanding Interest" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Interest Paid");

                                        IF Loans."OuTstanding Interest" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Interest";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Interest Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Interest Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                end;
                            END;
                        end;

                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            Loans.SetFilter(loans."Outstanding Penalty", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Penalty");
                                        Loans."Outstanding Penalty" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Penalty Paid");

                                        IF Loans."OuTstanding Penalty" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Penalty";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Penalty Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Penalty Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                end;
                            END;
                        end;



                        if AvailableDeposits > 0 then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", "Member No.");
                            Loans.SetFilter(loans."Outstanding Principal", '>0');
                            IF Loans.FIND('-') THEN BEGIN
                                TotalRecovered := 0;
                                REPEAT
                                    if AvailableDeposits > 0 then begin

                                        Loans.CALCFIELDS(Loans."OuTstanding Principal");
                                        Loans."Outstanding Principal" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Principal Repayment");

                                        IF Loans."OuTstanding Penalty" > 0 THEN BEGIN

                                            DedAmt := Loans."Outstanding Penalty";
                                            if DedAmt > AvailableDeposits then
                                                DedAmt := AvailableDeposits;

                                            IF DedAmt > 0 THEN BEGIN
                                                sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Defaulter Penalty Recovery From ' + ProductSetup.Description, 1, 50),
                                                BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                TotalRecovered := TotalRecovered + DedAmt;
                                                AvailableDeposits := AvailableDeposits - DedAmt;
                                            END;
                                        END;
                                    end;
                                UNTIL Loans.NEXT = 0;
                                if TotalRecovered > 0 then begin
                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Defaulter Principal Recovery', 1, 50),
                                    BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                end;
                            END;
                        end;
                    until MemberAccounts.Next = 0;
                end;
            until ProductSetup.Next() = 0;
        end;



        Loans.RESET;
        Loans.SETRANGE(Loans."Member No.", "Member No.");
        Loans.SetFilter("Outstanding Principal", '>0');
        Loans.SetFilter("Total Guarantor Count", '>0');
        IF Loans.FIND('-') THEN BEGIN
            REPEAT

                Loans.CALCFIELDS(Loans."Outstanding Principal", Loans."Outstanding Interest", Loans."Outstanding Penalty");
                Loans."Outstanding Interest" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Interest Paid");
                Loans."Outstanding Penalty" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Penalty Paid");
                Loans."Outstanding Principal" -= sAcctivities.GetJournalLoanCredits(JTemplate, JBatch, AcctType::Credit, Loans."Member No.", Loans."Loan No.", TransType::"Principal Repayment");
                LBal := Loans."Outstanding Interest" + Loans."Outstanding Penalty" + Loans."Outstanding Principal";


                if LBal > 0 then begin
                    //No Shares recovery
                    //Loans."Recovered Balance" := LBal;
                    //Loans."Guarantor Amount" := LBal;
                    Loans.MODIFY;

                    LGurantors.RESET;
                    LGurantors.SETRANGE(LGurantors."Loan No.", Loans."Loan No.");
                    LGurantors.SETRANGE(LGurantors.Substituted, FALSE);
                    LGurantors.SetRange("Guarantor Type", LGurantors."Guarantor Type"::Guarantor);
                    IF LGurantors.FIND('-') THEN BEGIN
                        REPEAT
                            DedAmt := 0;
                            LGurantors.calcfields("Total Loan Guarantorship");
                            if LGurantors."Total Loan Guarantorship" > 0 then
                                DedAmt := ROund(LGurantors."Amount Guaranteed" / LGurantors."Total Loan Guarantorship" * LBal);

                            MemberAccounts.Reset();
                            MemberAccounts.SetRange("No.", LGurantors."Account No.");
                            MemberAccounts.SetFilter("Balance (LCY)", '>0');
                            if DedAmt > 0 then
                                if MemberAccounts.FindFirst() then begin

                                    AvailableDeposits := MemberActivities.GetAccountBalance(MemberAccounts."No.");
                                    AvailableDeposits -= sAcctivities.GetJournalDebits(JTemplate, JBatch, AcctType::Savings, MemberAccounts."No.");
                                    if AvailableDeposits > 0 then begin
                                        if DedAmt > AvailableDeposits then
                                            DedAmt := AvailableDeposits;


                                        RunBal := DedAmt;
                                        TotalRecovered := 0;
                                        If RunBal > 0 then begin
                                            IF Loans."OuTstanding Interest" > 0 THEN BEGIN
                                                DedAmt := Loans."Outstanding Interest";
                                                if DedAmt > RunBal then
                                                    DedAmt := RunBal;

                                                IF DedAmt > 0 THEN BEGIN
                                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Guarantor Interest Recovery From ' + MemberAccounts.Name, 1, 50),
                                                    BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                    TotalRecovered := TotalRecovered + DedAmt;
                                                    RunBal := RunBal - DedAmt;
                                                END;
                                            END;
                                        end;

                                        If RunBal > 0 then begin
                                            IF Loans."OuTstanding Penalty" > 0 THEN BEGIN
                                                DedAmt := Loans."Outstanding Penalty";
                                                if DedAmt > RunBal then
                                                    DedAmt := RunBal;

                                                IF DedAmt > 0 THEN BEGIN
                                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Guarantor Penalty Recovery From ' + MemberAccounts.Name, 1, 50),
                                                    BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Penalty Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                    TotalRecovered := TotalRecovered + DedAmt;
                                                    RunBal := RunBal - DedAmt;
                                                END;
                                            END;
                                        end;

                                        If RunBal > 0 then begin
                                            IF Loans."Outstanding Principal" > 0 THEN BEGIN
                                                DedAmt := Loans."Outstanding Principal";
                                                if DedAmt > RunBal then
                                                    DedAmt := RunBal;

                                                IF DedAmt > 0 THEN BEGIN
                                                    sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Credit, Loans."Member No.", CopyStr('Guarantor Principal Recovery From ' + MemberAccounts.Name, 1, 50),
                                                    BalAcctType::"G/L Account", '', -DedAmt, Loans."Loan No.", Loans."Loan No.", TransType::"Principal Repayment", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);

                                                    TotalRecovered := TotalRecovered + DedAmt;
                                                    RunBal := RunBal - DedAmt;
                                                END;
                                            END;
                                        end;

                                        if TotalRecovered > 0 then begin
                                            sAcctivities.JournalInsert(JTemplate, JBatch, "No.", "Posting Date", AcctType::Savings, MemberAccounts."No.", CopyStr('Guarantor Loan Recovery for ' + Loans."Member Name", 1, 50),
                                            BalAcctType::"G/L Account", '', TotalRecovered, Loans."Loan No.", Loans."Loan No.", TransType::"Interest Paid", Loans."Global Dimension 1 Code", Loans."Booking Branch", true);
                                        end;

                                    END;

                                end;

                        until LGurantors.Next() = 0;
                    end;
                END;
            UNTIL Loans.NEXT = 0;
        END;

        if Post then begin
            sAcctivities.JournalPost(JTemplate, JBatch);

            MESSAGE('Loan recovery posted successfully.');
        end;
    end;
}

