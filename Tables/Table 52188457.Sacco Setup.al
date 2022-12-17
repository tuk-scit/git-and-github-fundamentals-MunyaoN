
Table 52188457 "Sacco Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(50050; "Membership Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Member Picture Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Picture,Signature,"Picture & Signature";
        }
        field(50052; "Guarantors Multiplier"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Staff Can Guarantee Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Self Guarantee %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Excise Duty (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Excise Duty GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50057; "Loan Interest Automation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = No,Yes;
        }
        field(50058; "Loan Interest Date"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Loan Anniversary","End of Month","Begining of Month","Mid Month","Specific Date","User Defined At Run Time";
        }
        field(50059; "Specific Loan Interest Day"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Calc. Loan Interest On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Principal Only","Principal plus Outstanding Interest","User Defined Interest Amount";
        }
        field(50061; "Dividend Year Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Dividend Processing Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = const(Savings));
        }
        field(50063; "Dividend Charge"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Use General Charge","Use Product Based Charge";
        }
        field(50064; "Dividend Processing Charge"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Dividend Processing"));
        }
        field(50065; "Dividend Activity Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50066; "Member Exit Notice Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Member Exit Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Member Withdrawal"));
        }
        field(50068; "Member Exit Transfer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = const(Savings));
        }
        field(50069; "Next of Kin Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
        }
        field(50070; "Group Picture Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Picture,Signature,"Picture & Signature";
        }
        field(50071; "Signatory Picture Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Picture,Signature,"Picture & Signature";
        }
        field(50072; "Cheque Reject Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "External STO Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50074; "Income Control Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50075; "Send Receipt Email"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Send Receipt SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Maximum Valuation Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "Kin % Allocation Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
        }
        field(50079; "Penalty Days From Exp. Pay Day"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Minimum Amt to Penalize"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "Collateral % of Limit To Use"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50082; "Posting Date Limit"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50083; "Teller Can Self-Transact"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "MBanking Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50085; "By Pass Cheque Clearing Days"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "FD Interest Accrual"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Calculate and Post On Maturity","Calculate Every End Month and Post on Maturity","Calculate & Post Every End Month","Calculate On Anniversary and Post on Maturity","Calculate and Post On Anniversary";
        }
        field(50087; "Loan Rescheduling Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Loan Changes"));
        }
        field(50088; "Loan Restructure Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Loan Changes"));
        }
        field(50089; "Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "Dormancy Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50091; "Chq Book Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50092; "Early Member Exit Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Member Withdrawal"));
        }
        field(50093; "Activate Early Exit Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50094; "Sacco Contacts"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50095; "Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50096; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "Bank Account No,"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50098; "Email File Path"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(50099; "Allow Loan-Specific Charges"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(50100; "Nominee Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
        }
        field(50101; "Checkoff Control"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "g/l account";
        }
        field(50102; "Teller Shortage Email"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(50103; "Registration Comm. Expense"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "g/l account";
        }




        field(50104; "Statement Path B64"; Text[2000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }

        field(50105; "SMS Time"; Time)
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50106; "Withdrawal Fee"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Withdrawal Fee(Quick)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Duplum Interest Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Maximum ATM Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50110; "ATM Card No Characters"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "File Keeping Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
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
        Text000: label '%1 %2 %3 have %4 to %5.';
        Text001: label '%1 %2 have %3 to %4.';
        Text002: label '%1 %2 %3 use %4.';
        Text003: label '%1 %2 use %3.';
        Text004: label '%1 must be rounded to the nearest %2.';
        Text016: label 'Enter one number or two numbers separated by a colon. ';
        Text017: label 'The online Help for this field describes how you can fill in the field.';
        Text018: label 'You cannot change the contents of the %1 field because there are posted ledger entries.';
        Text021: label 'You must close the program and start again in order to activate the amount-rounding feature.';
        Text022: label 'You must close the program and start again in order to activate the unit-amount rounding feature.';
        Text023: label '%1\You cannot use the same dimension twice in the same setup.';
        Dim: Record Dimension;
        GLEntry: Record "G/L Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        JobLedgEntry: Record "Job Ledger Entry";
        ResLedgEntry: Record "Res. Ledger Entry";
        FALedgerEntry: Record "FA Ledger Entry";
        MaintenanceLedgerEntry: Record "Maintenance Ledger Entry";
        InsCoverageLedgerEntry: Record "Ins. Coverage Ledger Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        TaxJurisdiction: Record "Tax Jurisdiction";
        AnalysisView: Record "Analysis View";
        AnalysisViewEntry: Record "Analysis View Entry";
        AnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
        AdjAddReportingCurr: Report "Adjust Add. Reporting Currency";
        ErrorMessage: Boolean;
        DependentFieldActivatedErr: label 'You cannot change %1 because %2 is selected.';
        Text025: label 'The field %1 should not be set to %2 if field %3 in %4 table is set to %5 because deadlocks can occur.';
        ObsoleteErr: label 'This field is obsolete, it has been replaced by Table 248 VAT Reg. No. Srv Config.';
}

