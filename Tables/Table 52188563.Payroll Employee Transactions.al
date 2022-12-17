
Table 52188563 "Payroll Employee Transactions"
{

    fields
    {
        field(1; "Employee Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = '"HR Employees".No.';
        }
        field(2; "Transaction Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = '"Payroll Codes"."Transaction Code" WHERE (Transaction Type=FILTER(Earning|Deduction))';

            trigger OnValidate()
            begin
                Transcode.Reset;
                Transcode.SetRange(Transcode."Transaction Code", "Transaction Code");
                if Transcode.Find('-') then
                    "Transaction Name" := Transcode."Transaction Name";



                if Transcode."Special Identifier" = Transcode."special identifier"::NHIF then
                    Error('Invalid Code');

                if Transcode."Special Identifier" = Transcode."special identifier"::NSSF then
                    Error('Invalid Code');


                if Employee.Get("Employee Code") then begin
                    if Employee."Member No" = '' then
                        Error('Member No. not captured under HR List');
                    Members.Get(Employee."Member No");

                    "Sub-Ledger" := "sub-ledger"::"G/L Account";
                    Balance := 0;
                    Amount := 0;
                    "Loan No." := '';
                    "Member No." := Members."No.";


                    Transcode.Reset;
                    Transcode.SetRange(Transcode."Transaction Code", "Transaction Code");
                    Transcode.SetRange(Transcode.Subledger, Transcode.Subledger::Savings);
                    if Transcode.Find('-') then begin

                        "Sub-Ledger" := "sub-ledger"::Savings;
                        MemberAccounts.Reset;
                        MemberAccounts.SetRange("Member No.", Members."No.");
                        MemberAccounts.SetRange("Product Type", Transcode."Sub-Ledger Product Type");
                        if MemberAccounts.FindFirst then begin
                            "Sub-Ledger Account" := MemberAccounts."No.";
                            MemberAccounts.CalcFields("Balance (LCY)");
                            Balance := MemberAccounts."Balance (LCY)";
                        end;

                    end;

                    Transcode.Reset;
                    Transcode.SetRange(Transcode."Transaction Code", "Transaction Code");
                    Transcode.SetRange(Transcode.Subledger, Transcode.Subledger::Credit);
                    if Transcode.Find('-') then begin

                        "Sub-Ledger" := "sub-ledger"::Credit;
                        "Sub-Ledger Account" := Members."No.";
                        if Transcode."Special Transactions" = Transcode."special transactions"::"Staff Loan" then begin
                            Transcode.TestField("Sub-Ledger Product Type");

                            Balance := 0;
                            Amount := 0;
                            Loans.Reset;
                            Loans.SetRange("Member No.", Members."No.");
                            Loans.SetRange("Loan Product Type", Transcode."Sub-Ledger Product Type");
                            Loans.SetFilter("Outstanding Principal", '>0');
                            if Loans.FindFirst then begin
                                Loans.CalcFields("Outstanding Principal");
                                Balance := Loans."Outstanding Principal";
                                Amount := Loans."Loan Principle Repayment";
                                "Loan No." := Loans."Loan No.";

                                //MESSAGE('Loan Balance: %1\Loan Principal Repayment: %2',Loans."Outstanding Loan Principal",Loans."Loan Principal Repayment");
                            end;
                        end;

                    end;
                end;
            end;
        }
        field(3; "Transaction Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Balance; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Employer Balance" := 0;
                //IF (Balance > 0) AND ("#of Repayments" > 0) THEN
                //Amount:=Balance/"#of Repayments"
            end;
        }
        field(6; "Period Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Period Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Periods"."Date Opened";
        }
        field(9; "Employer Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Employer Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Payroll Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Stopped; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."),
                                         "Total Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            begin
                if "Loan No." <> '' then begin
                    Loans.Get("Loan No.");
                    Loans.CalcFields("Outstanding Principal");
                    Balance := Loans."Outstanding Principal";
                    Amount := Loans."Loan Principle Repayment";
                    Message('Loan Balance: %1\Loan Principal Repayment: %2', Loans."Outstanding Principal", Loans."Loan Principle Repayment");

                end;
            end;
        }
        field(16; "Sub-Ledger"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Sub-Ledger Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Sub-Ledger" = const(Vendor)) Vendor
            else
            if ("Sub-Ledger" = const(Customer)) Customer;
        }
        field(18; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Member No."; Code[20])
        {
        }
        field(20; "User Defined Loan Interest"; Decimal)
        {
        }
        field(21; "Amortization Total Repayment"; Decimal)
        {
        }
        field(22; EntryNo; Integer)
        {
            AutoIncrement = true;
        }
        field(32; "Loan Product Type"; Code[20])
        {
            TableRelation = "Approval Tracker";
        }
        field(33; "Transaction Type"; Option)
        {
            CalcFormula = lookup("Payroll Codes"."Transaction Type" where("Transaction Code" = field("Transaction Code")));
            FieldClass = FlowField;
            OptionMembers = Earning,Deduction,"Basic Pay","Gross Pay","Net Pay",PAYE;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Payroll Period", EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeTrans: Record "Payroll Employee Transactions";
        Transcode: Record "Payroll Codes";
        Employee: Record Employee;
        Members: Record Customer;
        Loans: Record Loans;
        MemberAccounts: Record Vendor;
}

