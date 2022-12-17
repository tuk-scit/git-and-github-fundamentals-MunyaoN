
Table 52188433 "Product Setup"
{

    fields
    {
        field(1; "Product ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Product Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Credit,Savings';
            OptionMembers = " ",Credit,Savings;
        }
        field(4; "Interest Rate (Min.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Interest Rate (Max.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Withdrawal Interval"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Maximum No. of Withdrawal"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Min. Customer Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Max.Customer Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Credit Limit(Overdraft)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Minimum Account Balance"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Minimum Account Balance" < 0 then
                    Error('Minimum balance cannot be less than zero');
            end;
        }
        field(17; "Allow Overdraft"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Current & Savings account';
        }
        field(19; "Minimum Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Loan Account [G/L]"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(21; "Loan Interest Income [G/L]"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(22; "Loan Interest Receivable [G/L]"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(23; "Grace Period - Principal"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Grace Period - Interest"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Product Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";
        }
        field(26; "Dormancy Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Description = 'Account no transactions';
        }
        field(27; "Account No. Prefix"; Code[4])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Maximum Guarantors"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Minimum Guarantors"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Loan Application Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Minimum Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Maximum Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Registration Fee,Share Capital,Deposit Contribution,Benevolent Fund,Unallocated Fund,Dividend Account,Micro Member Deposit,Micro Group Deposit,Ordinary Savings,Holiday Savings,School Fee,Fixed Deposit,Junior Savings,Welfare,Housing,Asset Finance,FOSA Shares,Business,Jipange';
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Asset Finance","FOSA Shares",Business,Jipange;

            trigger OnValidate()
            begin
                if "Product Category" = "Product Category"::"Deposit Contribution" then
                    "Savings Type" := "Savings Type"::"Non-Withdrawable"
                else
                    if "Product Category" = "Product Category"::"Fixed Deposit" then
                        "Savings Type" := "Savings Type"::Term
                    else
                        if "Product Category" = "Product Category"::"Ordinary Savings" then
                            "Savings Type" := "Savings Type"::Withdrawable
                        else
                            if "Product Category" = "Product Category"::"Share Capital" then
                                "Savings Type" := "Savings Type"::"Non-Withdrawable"
                            else
                                if "Product Category" <> "Product Category"::"Registration Fee" then
                                    "Savings Type" := "Savings Type"::"Non-Withdrawable";
            end;
        }
        field(34; "Interest Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Reducing Flat';
            OptionMembers = Amortised,"Reducing Balance","Straight Line","Reducing Flat";
        }
        field(35; "Default Installments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Earns Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Interest Expense Account"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(38; "Interest Payable Account"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(39; "External EFT Charges"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Interest Calc Min Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Penalty Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Loan Penalty Income [G/L]"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(43; "Loan Penalty Receivable [G/L]"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(44; "Interest Accounting Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Interest Accrual","Cash Basis";
        }
        field(45; "Penalty Accounting Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Interest Accrual","Cash Basis";
        }
        field(46; "Deposit Multiplier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Allow Multiple Running Loans"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Loan Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(49; "Recovery Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Repay Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Withholding Tax Account"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(52; "WithHolding Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Auto Open Member Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Dividend Calc. Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Flat Rate,Prorated';
            OptionMembers = " ","Flat Rate",Prorated;
        }
        field(55; "Over Draft Interest %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Over Draft Interest Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(57; "Allow Multiple Over Draft"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Search Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Allow Multiple Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Suspend Interest Account [G/L]"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = filter(true));
        }
        field(61; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly,Bi-Annual,Tri-Annual,Annually,Bonus';
            OptionMembers = Daily,Weekly,Monthly,Quarterly,"Bi-Annual","Tri-Annual",Annually,Bonus;
        }
        field(62; "Nature of Loan Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,Defaulter,"Cheque Discounting","Loan Discounting";
        }
        field(63; "Account No. Suffix"; Code[4])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Statement Charge"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Mobile Transaction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Deposits Only","Withdrawals Only","Deposits & Withdrawals";
        }
        field(66; "USSD Product Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Interest Recovered Upfront"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Email Loan Schedule"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Requires Batching"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(71; "Disbursement Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup"."Product ID" where("Product Category" = const("Ordinary Savings"));
        }
        field(72; "Income Type"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Cutoff Day"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Can Offset Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Interest Due on Disbursement"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Full Interest","Prorated Interest","Full Interest Before Cutoff","Prorated Interest After CutOff","Full/Prorated Interest Based on CutOff","Total Loan Interest - Straight Line";

            trigger OnValidate()
            begin
                if "Interest Due on Disbursement" = "interest due on disbursement"::"Total Loan Interest - Straight Line" then
                    TestField("Interest Calculation Method", "interest calculation method"::"Straight Line");
            end;
        }
        field(77; "Bonus Appraisal Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "CRB Product Code"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Guarantorship Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Amount,Count';
            OptionMembers = Amount,"Count";
        }
        field(80; "Loan Clients"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Members,Staff,Board;
        }
        field(81; "Appraisal Parameter Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Bonus,Credits,Junior,Milk,Tea,KGs,Salary,Staff Salary';
            OptionMembers = " ",Bonus,Credits,Junior,Milk,Tea,KGs,Salary,"Staff Salary";
        }
        field(82; "Appraised on Expected Bonus"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Appraisal % on Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Auto Open Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "AutoRecovery From Savings"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Savings Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Withdrawable,"Non-Withdrawable","Retained Shares",Term;
        }
        field(87; "Dividend Processing Charge"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Dividend Processing"));
        }
        field(88; "Dont Show on Statement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(89; "Interest Due Cutoff Day"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Appraise Deposits"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Appraise Salary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(92; "Appraise Security"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(93; "Pre-Earned Receivable [G/L]"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(94; "Pre-Earned Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Recover Registration Fee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(96; "Dont Show on Member Register"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(97; "Mbanking Key Word"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(98; "Appraisal Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup"."Product ID" where("Product Category" = filter("Deposit Contribution" | "Asset Finance" | Housing | "Micro Member Deposit" | "Micro Group Deposit"));
        }
        field(99; "Available on Mobile"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(100; "Mandatory Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(101; "Restrict to Emp. Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));
        }
        field(102; "Mobile Loan Req. Guar."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Skip Int Due On Top Up"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(104; "Schedule of Property Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(105; "No Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(106; "Max Teller Wiithdrawable"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Auto Send SMS Alerts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(108; "Monthly Maintenance Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(109; "Maintenance Fee [G/L]"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(110; "Allow Agency Transactions"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Deposits Only","Withdrawals Only","Deposits & Withdrawals";
        }
        field(111; "Recovery Ratio"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Available on Portal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Dividend Capitalization %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Special Multiplier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(115; "Appraisal Include STO Ded."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Withdrawal Frequency"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }

        field(117; "Withdrawal Frequency Charge"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges";
        }

        field(118; "Dormancy Period Notification"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Description = 'Account no transactions';
        }

        field(119; "Recover Int. Due on Disb."; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Full Interest","Interest After CutOff";

            trigger OnValidate()
            begin
            end;
        }

        field(120; "Skip Defaulter Recovery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Sorting Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(122; "Exempt Mbanking C/W Fee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(127; "Mbanking Expense GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }

        field(128; "Member To Capture Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(129; "Charge Upfront Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(130; "Available To Member"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = customer;
        }

        field(131; "Requires Recoery Mode"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(132; "Requires Purpose"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(133; "Mobile Installments Type"; Option)
        {
            OptionMembers = None,Input,Preset;
        }


        field(134; "Mobile Min. Guarantors"; Integer)
        {
        }


        field(135; "Mobile Max. Guarantors"; Integer)
        {
        }


        field(136; "Requires TnC"; Boolean)
        {
        }


        field(137; "Shows Mobile Qualification"; Boolean)
        {
        }
        field(138; "Requires Payslip PIN"; Boolean)
        {
        }
        field(139; "MLoan Salary Formula"; Option)
        {
            OptionMembers = Average,Minimum,Maximum;
        }



    }

    keys
    {
        key(Key1; "Product ID")
        {
            Clustered = true;
        }
        key(Key2; "Product Class")
        {
        }
        key(Key3; "Recovery Priority")
        {
        }
    }

    fieldgroups
    {
    }


    procedure GetReceivablesAccount(ProductCode: Code[20]; TransactionType: Enum "Transaction Type Enum"): Code[20]
    var
        GenJournalLine: Record "Gen. Journal Line";
        ProductSetup: Record "Product Setup";
    begin

        ProductSetup.Get(ProductCode);
        if (TransactionType = Transactiontype::"Loan Disbursement") or (TransactionType = Transactiontype::"Principal Repayment") then begin
            Testfield("Loan Account [G/L]");
            exit("Loan Account [G/L]");
        end
        else
            if (TransactionType = Transactiontype::"Interest Due") or (TransactionType = Transactiontype::"Interest Paid") then begin
                Testfield("Loan Interest Receivable [G/L]");
                exit("Loan Interest Receivable [G/L]");
            end
            else
                if (TransactionType = Transactiontype::"Penalty Due") or (TransactionType = Transactiontype::"Penalty Paid") then begin
                    Testfield("Loan Penalty Receivable [G/L]");
                    exit("Loan Penalty Receivable [G/L]");
                end;
    end;
}

