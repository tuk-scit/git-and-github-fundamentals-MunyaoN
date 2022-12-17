
Codeunit 52188438 "Payroll Processing"
{
    // c


    trigger OnRun()
    begin
    end;

    var
        PayrollCodes: Record "Payroll Codes";
        PayrollPeriods: Record "Payroll Periods";
        PeriodTrans: Record "Payroll Period Transactions";
        BankRemit: Record "Payroll Bank Remittance";
        RemitAcc: Record "Payroll Remittance Accounts";
        VarGrouping: Option " ","Basic Salary",Allowances,"Gross Salary","Tax Calculations",Statutories,Deductions,"Net Salary";
        VarSubGroup: Option " ",BasicPay,"BasicPay Arrears","Defined Contribution","Tax Relief","Insurance Relief","Taxable Pay","Tax Charged",NSSF,NHIF,PAYE,"PAYE Arrears","Pension Relief","Owner Occupier","Home Ownership","Non-Taxable";
        EntryType: Option " ",Employer,Employee;
        salariesAcc: Code[20];
        TaxAccount: Code[20];
        LoanNo: Code[20];
        SalaryArrears: Record "Payroll Arrears";
        DaysWorked: Integer;
        CountDaysofMonth: Integer;
        curReliefPersonal: Decimal;
        curReliefInsurance: Decimal;
        curMaxPensionContrib: Decimal;
        curMaxInsuranceRelief: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curReliefMorgage: Decimal;
        BenifitAmount: Decimal;
        curMaximumRelief: Decimal;
        currMinRelief: Decimal;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        intNSSF_BasedOn: Option Gross,Basic;
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        Prsalary: Record "Staff Payroll Details";
        RatesCeilings: Record "Payroll Rates";
        curDisabledLimit: Decimal;
        PostingGroup: Record "Payroll Posting Group";
        PayablesAcc: Code[10];
        NitaAccount: Code[10];


    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record PAYE;
        curTempAmount: Decimal;
        KeepCount: Integer;
    begin
        KeepCount := 0;
        prPAYE.Reset;
        if prPAYE.FindFirst then begin
            if curTaxablePay >= prPAYE."PAYE Tier" then begin

                repeat
                    KeepCount += 1;
                    curTempAmount := curTaxablePay;
                    if curTaxablePay > 0 then begin

                        if KeepCount = prPAYE.Count then   //this is the last record or loop
                            curTaxablePay := curTempAmount
                        else
                            if curTempAmount >= prPAYE."PAYE Tier" then
                                curTempAmount := prPAYE."PAYE Tier"
                            else
                                curTempAmount := curTempAmount;

                        //MESSAGE('curTempAmount %1',curTempAmount);
                        PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                        curTaxablePay := curTaxablePay - curTempAmount;
                    end;

                until prPAYE.Next = 0;
            end;
        end;

        //MESSAGE('curTempAmount %1',PAYE);
    end;


    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
    var
        prNHIF: Record NHIF;
    begin
        prNHIF.Reset;
        prNHIF.SetCurrentkey(prNHIF."Tier Code");
        if prNHIF.FindFirst then begin
            repeat
                if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then begin
                    NHIF := prNHIF.Amount;
                end;
            until prNHIF.Next = 0;
        end;
    end;


    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option "None","Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Fringe Benefit",Mortgage,"Salary Arrears","Staff Loan","Education Insurance"; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        strExtractedFrml: Text[250];
        MortgageInterest: Decimal;
        MortgageRelief: Decimal;
        EmployeeTrans: Record "Payroll Employee Transactions";
        PayrollCodes: Record "Payroll Codes";
    begin


        SpecialTransAmount := 0;
        PayrollCodes.Reset;
        PayrollCodes.SetRange(PayrollCodes."Special Transactions", intSpecTransID);
        if PayrollCodes.Find('-') then begin
            repeat

                EmployeeTrans.Reset;
                EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
                EmployeeTrans.SetRange(EmployeeTrans."Transaction Code", PayrollCodes."Transaction Code");
                EmployeeTrans.SetRange(EmployeeTrans."Period Month", intMonth);
                EmployeeTrans.SetRange(EmployeeTrans."Period Year", intYear);
                EmployeeTrans.SetRange(EmployeeTrans.Stopped, false);
                if EmployeeTrans.Find('-') then begin

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        Intspectransid::"Defined Contribution":
                            begin

                                if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes.Formula);
                                    SpecialTransAmount := SpecialTransAmount + ROUND(fnFormulaResult(strExtractedFrml), 1, '>'); //Get the calculated amount
                                                                                                                                 //error('%1',curTransAmount);

                                end
                                else
                                    if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then
                                        SpecialTransAmount += PayrollCodes."Standard Amount"
                                    else
                                        SpecialTransAmount += EmployeeTrans.Amount;
                            end;
                        Intspectransid::"Life Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * EmployeeTrans.Amount);
                        Intspectransid::"Education Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * EmployeeTrans.Amount);
                        Intspectransid::"Owner Occupier Interest":
                            SpecialTransAmount := SpecialTransAmount + EmployeeTrans.Amount;
                        Intspectransid::"Home Ownership Savings Plan":
                            SpecialTransAmount := SpecialTransAmount + EmployeeTrans.Amount;

                    end;
                end;
            until PayrollCodes.Next = 0;
        end;
    end;


    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        //AZIZResults:=AccSchedMgt.EvaluateExpression(true,strFormula,AccSchedLine,ColumnLayout,CalcAddCurr);
    end;


    procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
    var
        salCard: Record "Staff Payroll Details";
        EmployeeTrans: Record "Payroll Employee Transactions";
    begin


        if strTransCode = 'BPAY' then begin
            salCard.Reset;
            salCard.SetRange(salCard."Employee Code", strEmpCode);
            if salCard.Find('-') then begin
                TransAmount := salCard."Basic Pay";
            end;
        end;


        EmployeeTrans.Reset;
        EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
        EmployeeTrans.SetRange(EmployeeTrans."Transaction Code", strTransCode);
        EmployeeTrans.SetRange(EmployeeTrans."Period Month", intMonth);
        EmployeeTrans.SetRange(EmployeeTrans."Period Year", intYear);
        EmployeeTrans.SetRange(EmployeeTrans.Stopped, false); //Added DW to not process Stopped Transactions
        if EmployeeTrans.FindFirst then
            TransAmount := EmployeeTrans.Amount;
    end;


    procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then
                StartCopy := true;

            if StartCopy then
                TransCode := TransCode + Char;

            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := FinalFormula + Char;

            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);

                //Get TransCodeAmount
                TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;


    procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; VarGrouping: Option " ","Basic Salary",Allowances,"Gross Salary","Tax Calculations",Statutories,Deductions,"Net Salary"; VarSubGroup: Option " ",BasicPay,"BasicPay Arrears","Defined Contribution","Tax Relief","Insurance Relief","Taxable Pay","Tax Charged",NSSF,NHIF,PAYE,"PAYE Arrears","Pension Relief","Owner Occupier","Home Ownership","Non-Taxable"; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; dtOpenPeriod: Date; JournalAC: Code[20]; JournalACType: Enum "Gen. Journal Account Type"; LoanNo: Code[20]; PostAs: Option " ",Debit,Credit; EntryType: Option " ",Employer,Employee; ReferenceNo: Integer)
    var
        NetAmt: Decimal;
        RunBal: Decimal;
        PTrans: Record "Payroll Period Transactions";
        PCodes: Record "Payroll Codes";
    begin

        if curAmount <> 0 then begin


            if VarGrouping = Vargrouping::"Net Salary" then begin
                BankRemit.Reset;
                BankRemit.SetRange("Staff No.", EmpCode);
                BankRemit.SetRange("Payroll Period", dtOpenPeriod);
                if BankRemit.FindFirst then
                    BankRemit.DeleteAll;

                RemitAcc.Reset;
                RemitAcc.SetRange(RemitAcc."Employee Code", EmpCode);
                if RemitAcc.Find('-') then begin
                    RunBal := curAmount;
                    repeat

                        if RemitAcc.Count = 1 then
                            RemitAcc."Percentage to Transfer" := 100;

                        if RemitAcc."Payment to" = RemitAcc."payment to"::Bank then begin
                            RemitAcc.TestField(RemitAcc."Bank  Code");
                            RemitAcc.TestField(RemitAcc."Branch Code");
                            RemitAcc.TestField(RemitAcc."A/C  Number");
                            RemitAcc.TestField(RemitAcc."Percentage to Transfer");
                        end;


                        if RemitAcc."Payment to" = RemitAcc."payment to"::Sacco then begin
                            RemitAcc.TestField(RemitAcc."Sacco Account");
                            RemitAcc.TestField(RemitAcc."Percentage to Transfer");
                        end;

                        RemitAcc.CalcFields("Total % Allocation");
                        if RemitAcc."Total % Allocation" <> 100 then
                            Error('Remittance Allocation for Employee No. %1 Must be 100%', EmpCode);


                        if RunBal > 0 then begin
                            NetAmt := ROUND((curAmount * RemitAcc."Percentage to Transfer" / 100), 0.1, '=');
                            if NetAmt > RunBal then
                                NetAmt := RunBal;
                            RunBal -= NetAmt;

                            BankRemit.Init;
                            BankRemit."Bank Code" := RemitAcc."Bank  Code";
                            BankRemit."Branch Code" := RemitAcc."Branch Code";
                            BankRemit."Payroll Period" := dtOpenPeriod;
                            BankRemit.Amount := NetAmt;
                            BankRemit."Transaction Code" := TCode;
                            BankRemit."Staff No." := EmpCode;
                            BankRemit."Bank Name" := UpperCase(RemitAcc."Bank Name");
                            BankRemit."Branch Name" := UpperCase(RemitAcc."Branch Name");
                            BankRemit."A/C  Number" := RemitAcc."A/C  Number";
                            BankRemit."Sacco Account" := RemitAcc."Sacco Account";
                            BankRemit."Payment to" := RemitAcc."Payment to";
                            BankRemit."% Net PAY" := RemitAcc."Percentage to Transfer";
                            if BankRemit.Amount > 0 then
                                BankRemit.Insert;
                        end;

                    until RemitAcc.Next = 0;
                end
                else begin
                    //     ERROR('No Bank A/C has been specified for [Employee No %1]',EmpCode);
                end;
            end;
            PCodes.Reset;
            if PCodes.Get(TCode) then;

            with PTrans do begin
                Init;
                "Payroll Code Type" := PCodes."Transaction Type";
                "Sacco Transaction Type" := PCodes."Sacco Transaction Type";
                if PCodes."Special Transactions" = PCodes."special transactions"::"Staff Loan" then begin
                    if ReferenceNo = 0 then
                        "Sacco Transaction Type" := "sacco transaction type"::"Principal Repayment";
                    if ReferenceNo = 1 then
                        "Sacco Transaction Type" := "sacco transaction type"::"Interest Paid";
                end;

                "Employee Code" := EmpCode;
                "Entry Type" := EntryType;
                "Transaction Code" := TCode;
                Grouping := VarGrouping;
                "Sub Group" := VarSubGroup;
                "Transaction Name" := Description;
                Amount := curAmount;
                Balance := curBalance;
                "Period Month" := Month;
                "Period Year" := Year;
                "Payroll Period" := dtOpenPeriod;
                "Account Type" := JournalACType;
                "Post As" := PostAs;
                "Account No." := JournalAC;
                "Loan No." := LoanNo;

                if "Sub Group" = "sub group"::BasicPay then
                    "Payroll Code Type" := "payroll code type"::Earning;
                if "Sub Group" = "sub group"::"BasicPay Arrears" then
                    "Payroll Code Type" := "payroll code type"::Earning;
                if "Sub Group" = "sub group"::PAYE then
                    "Payroll Code Type" := "payroll code type"::Deduction;
                if "Sub Group" = "sub group"::"PAYE Arrears" then
                    "Payroll Code Type" := "payroll code type"::Deduction;

                "Reference No" := ReferenceNo;

                "Payslip Sort Order" := 10;
                if PCodes."Sort Order" > 0 then
                    "Payslip Sort Order" := PCodes."Sort Order";

                if "Sub Group" = "sub group"::"Tax Relief" then
                    "Payslip Sort Order" := 100;

                if "Sub Group" = "sub group"::PAYE then
                    "Payslip Sort Order" := 1;
                if TCode = 'TOT-DED' then
                    "Payslip Sort Order" := 200;

                Insert;
            end;
        end;
    end;


    procedure Processpayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; blnInsuranceCertificate: Boolean; ManualInsuranceRelief: Decimal)
    var
        EmployeeTrans: Record "Payroll Employee Transactions";
        strTableName: Text[50];
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        strTransDescription: Text[50];
        TGroup: Text[30];
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        curSalaryArrears: Decimal;
        curPayeArrears: Decimal;
        curGrossPay: Decimal;
        curTotAllowances: Decimal;
        curExcessPension: Decimal;
        curNSSF: Decimal;
        curDefinedContrib: Decimal;
        curPensionStaff: Decimal;
        curNonTaxable: Decimal;
        curGrossTaxable: Decimal;
        curBenefits: Decimal;
        curValueOfQuarters: Decimal;
        curUnusedRelief: Decimal;
        curInsuranceReliefAmount: Decimal;
        curMorgageReliefAmount: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curPAYE: Decimal;
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        SalaryArrears: Record "Payroll Arrears";
        strExtractedFrml: Text[250];
        SpecialTransType: Option "None","Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Fringe Benefit",Mortgage,"Salary Arrears","Staff Loan";
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        curNhif_Base_Amount: Decimal;
        curNHIF: Decimal;
        curTotalDeductions: Decimal;
        curNetRnd_Effect: Decimal;
        curNetPay: Decimal;
        curTotCompanyDed: Decimal;
        curOOI: Decimal;
        curHOSP: Decimal;
        curLoanInt: Decimal;
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;
        salCard: Record "Staff Payroll Details";
        curBPAYBal: Decimal;
        curPensionReliefAmount: Decimal;
        curIncludeinNet: Decimal;
        JournalPostAs: Option " ",Debit,Credit;
        JournalPostingType: Enum "Gen. Journal Account Type";
        JournalAc: Code[20];
        Customer: Record Customer;
        curIncludeGross: Decimal;
        IsCashbenefit: Decimal;
        curNssf_Base_Amount: Decimal;
        Vendor: Record Vendor;
        HREmployes: Record Employee;
        TotalSalaryArrears: Decimal;
        TotalPAYEArrears: Decimal;
        HREmp2: Record Employee;
        Members: Record Customer;
        Loans: Record Loans;
        IntAmt: Decimal;
        MemberAccounts: Record Vendor;
        MNo: Code[20];
        LSchedule: Record "Loan Repayment Schedule";
    begin
        dtOpenPeriod := 0D;
        DaysWorked := 0;
        CountDaysofMonth := 0;

        PayrollPeriods.Reset;
        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
        if PayrollPeriods.Find('-') then begin
            dtOpenPeriod := PayrollPeriods."Date Opened";
            intMonth := Date2dmy(dtOpenPeriod, 2); //GET THE MONTH
            intYear := Date2dmy(dtOpenPeriod, 3);  //GET THE YEAR
        end
        else begin
            Error('There is no open payroll period');
        end;



        //Initialize
        fnInitialize;

        //Get Payroll Posting Accountss
        ConfirmPostingGroupSetup(strEmpCode);


        //check if the period selected=current period. If not, do NOT run this function
        if SelectedPeriod <> dtOpenPeriod then exit;
        intMonth := Date2dmy(SelectedPeriod, 2);
        intYear := Date2dmy(SelectedPeriod, 3);

        //Delete all Records from the prPeriod Transactions for Reprocessing

        PeriodTrans.Reset;
        PeriodTrans.SetRange(PeriodTrans."Employee Code", strEmpCode);
        PeriodTrans.SetRange(PeriodTrans."Payroll Period", dtOpenPeriod);
        if PeriodTrans.Find('-') then
            PeriodTrans.DeleteAll;


        //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
        if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
            CountDaysofMonth := Date2dmy(CalcDate('CM', dtOpenPeriod), 1);
            DaysWorked := CountDaysofMonth - Date2dmy(dtDOE, 1) + 1;
            curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
        end;

        //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
        if dtTermination <> 0D then begin
            if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                CountDaysofMonth := Date2dmy(CalcDate('CM', dtOpenPeriod), 1);
                DaysWorked := Date2dmy(dtTermination, 1);
                curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
            end;
        end;



        PayrollCodes.Reset;
        PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::"Basic Pay");
        if PayrollCodes.Find('-') then begin

            curTransAmount := curBasicPay;
            curTransBalance := 0;
            JournalAc := PayrollCodes."GL Account";
            strTransDescription := 'Basic Pay';
            LoanNo := '';
            fnUpdatePeriodTrans(
                strEmpCode, 'BPAY', Vargrouping::"Basic Salary", Varsubgroup::BasicPay, strTransDescription, curTransAmount, curTransBalance,
                intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Debit, Entrytype::Employee, 0);





            TotalSalaryArrears := 0;
            TotalPAYEArrears := 0;

            //Salary Arrears
            SalaryArrears.Reset;
            SalaryArrears.SetRange(SalaryArrears."Employee Code", strEmpCode);
            SalaryArrears.SetRange(SalaryArrears."Period Month", intMonth);
            SalaryArrears.SetRange(SalaryArrears."Period Year", intYear);
            if SalaryArrears.Find('-') then begin
                repeat

                    curSalaryArrears := SalaryArrears."Salary Arrears";
                    curPayeArrears := SalaryArrears."PAYE Arrears";

                    TotalSalaryArrears += curSalaryArrears;
                    TotalPAYEArrears += curPayeArrears;

                    SalaryArrears.TestField("Transaction Code");


                    curTransAmount := curSalaryArrears;
                    curTransBalance := 0;
                    JournalAc := salariesAcc;
                    strTransDescription := 'Salary Arrears';
                    LoanNo := '';
                    fnUpdatePeriodTrans(
                        strEmpCode, SalaryArrears."Transaction Code", Vargrouping::"Basic Salary", Varsubgroup::"BasicPay Arrears", strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Debit, Entrytype::Employee, 0);


                    curTransAmount := curPayeArrears;
                    curTransBalance := 0;
                    JournalAc := TaxAccount;
                    strTransDescription := 'PAYE Arrears';
                    LoanNo := '';
                    fnUpdatePeriodTrans(
                        strEmpCode, SalaryArrears."Transaction Code", Vargrouping::Statutories, Varsubgroup::"PAYE Arrears", strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Debit, Entrytype::Employee, 0);

                until SalaryArrears.Next = 0;
            end;



            RatesCeilings.Get;
            if RatesCeilings."NITA Amount" > 0 then begin
                curTransAmount := RatesCeilings."NITA Amount";

                strTransDescription := 'Employer: NITA Levy';

                JournalAc := NitaAccount;

                fnUpdatePeriodTrans(
                    strEmpCode, 'NITA', 0, 0, strTransDescription, curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employer, 0);

            end;


        end;


        //Get Earnings

        //Message('%1\%2\%3', strEmpCode, intMonth, intYear);

        EmployeeTrans.Reset;
        EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
        EmployeeTrans.SetRange(EmployeeTrans."Period Month", intMonth);
        EmployeeTrans.SetRange(EmployeeTrans."Period Year", intYear);
        EmployeeTrans.SetRange(EmployeeTrans.Stopped, false); //Added DW to not process Stopped Transactions
        if EmployeeTrans.Find('-') then begin
            curTotAllowances := 0;
            curNonTaxable := 0;
            repeat
                //Message('t1');
                PayrollCodes.Reset;
                PayrollCodes.SetRange(PayrollCodes."Transaction Code", EmployeeTrans."Transaction Code");
                PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::Earning);
                if PayrollCodes.Find('-') then begin
                    //Message('t2');
                    curTransAmount := 0;
                    curTransBalance := 0;
                    strTransDescription := '';
                    strExtractedFrml := '';

                    if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin
                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes.Formula);
                        curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 1, '>'); //Get the calculated amount
                                                                                            //error('%1',curTransAmount);

                    end
                    else
                        if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then
                            curTransAmount := PayrollCodes."Standard Amount"
                        else
                            curTransAmount := EmployeeTrans.Amount;


                    if PayrollCodes."Balance Type" = PayrollCodes."balance type"::None then
                        curTransBalance := 0;
                    if PayrollCodes."Balance Type" = PayrollCodes."balance type"::Increasing then
                        curTransBalance := EmployeeTrans.Balance + curTransAmount;
                    if PayrollCodes."Balance Type" = PayrollCodes."balance type"::Reducing then
                        curTransBalance := EmployeeTrans.Balance - curTransAmount;


                    //Prorate Allowances Here
                    if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                        curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                    end;

                    //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                    if dtTermination <> 0D then begin
                        if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                            curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                        end;
                    end;
                    // Prorate Allowances Here



                    //Add Non Taxable Here
                    if (not PayrollCodes.Taxable) and (PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::None) then
                        curNonTaxable := curNonTaxable + curTransAmount;

                    //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                    if (not PayrollCodes.Taxable) and (PayrollCodes."Special Transactions" <> PayrollCodes."special transactions"::None) then
                        curTransAmount := 0;

                    curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                    strTransDescription := EmployeeTrans."Transaction Name";

                    //Get the posting Details
                    JournalPostingType := Journalpostingtype::"G/L Account";
                    JournalAc := '';

                    if PayrollCodes.Subledger <> PayrollCodes.Subledger::"G/L Account" then begin

                        HREmployes.Reset;
                        HREmployes.SetRange(HREmployes."No.", strEmpCode);
                        if HREmployes.Find('-') then begin
                            EmployeeTrans.TestField("Sub-Ledger Account");
                            JournalAc := EmployeeTrans."Sub-Ledger Account";
                            JournalPostingType := EmployeeTrans."Sub-Ledger";
                        end;

                        //FOR CUSTOMER
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Customer then begin
                            Customer.Reset;
                            Customer.SetRange(Customer."No.", JournalAc);
                            if not Customer.Find('-') then begin
                                Error('Customer Sub-Ledger Account No. %1 does not Exist for Employer %2', JournalAc, strEmpCode);
                            end;
                        end;

                        //FOR VENDOR
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Vendor then begin
                            Vendor.Reset;
                            Vendor.SetRange(Vendor."No.", JournalAc);
                            if not Vendor.Find('-') then begin
                                Error('Vendor Sub-Ledger Account No. %1 does not Exist for Employer %2', JournalAc, strEmpCode);
                            end;
                        end;

                        //Credit
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::"Bank Account" then begin
                            /*
                           CreditAcc.RESET;
                           CreditAcc.SETRANGE(CreditAcc."No.",JournalAc);
                           CreditAcc.SETRANGE(CreditAcc."Payroll/Staff No.",strEmpCode);
                           CreditAcc.SETRANGE("Product Type",PayrollCodes."Product Type");
                           IF NOT CreditAcc.FIND('-') THEN BEGIN
                              ERROR('Credit Sub-Ledger Account No. %1 does not Exist for Employer %2, Loan Product %3',JournalAc,strEmpCode,PayrollCodes."Product Type");
                           END;
                           */
                        end;

                        //Savings
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::"Fixed Asset" then begin
                            /*
                            SavingAcc.RESET;
                            SavingAcc.SETRANGE(SavingAcc."No.",JournalAc);
                            SavingAcc.SETRANGE(SavingAcc."Payroll/Staff No.",strEmpCode);
                            SavingAcc.SETRANGE("Product Type",PayrollCodes."Product Type");
                            IF SavingAcc.FIND('-') THEN BEGIN
                                ERROR('Savings Sub-Ledger Account No. %1 does not Exist for Employer %2, Loan Product %3',JournalAc,strEmpCode,PayrollCodes."Product Type");
                            END;
                            */
                        end;
                    end
                    else begin
                        JournalPostingType := Journalpostingtype::"G/L Account";
                        JournalAc := PayrollCodes."GL Account";
                    end;

                    LoanNo := '';
                    fnUpdatePeriodTrans(
                        strEmpCode, PayrollCodes."Transaction Code", Vargrouping::Allowances, Varsubgroup::" ", strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, LoanNo, Journalpostas::Debit, Entrytype::Employee, 0);

                end;
            until EmployeeTrans.Next = 0;
        end;


        EmployeeTrans.Reset;
        EmployeeTrans.SetRange(EmployeeTrans."Employee Code", strEmpCode);
        EmployeeTrans.SetRange(EmployeeTrans."Payroll Period", SelectedPeriod);
        EmployeeTrans.SetRange(EmployeeTrans.Stopped, false); //Added DW to not process Stopped Transactions
        if EmployeeTrans.Find('-') then begin
            //MESSAGE('%1',EmployeeTrans.COUNT);

            repeat
                //MESSAGE(EmployeeTrans."Transaction Code");

                PayrollCodes.Reset;
                PayrollCodes.SetRange(PayrollCodes."Transaction Code", EmployeeTrans."Transaction Code");
                PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::Deduction);
                if PayrollCodes.Find('-') then begin

                    //MESSAGE(EmployeeTrans."Transaction Name"+' - %1',EmployeeTrans.Amount);
                    curTransAmount := 0;
                    curTransBalance := 0;
                    strExtractedFrml := '';
                    strTransDescription := EmployeeTrans."Transaction Name";
                    JournalAc := PayrollCodes."GL Account";
                    LoanNo := '';
                    JournalPostAs := Journalpostas::Credit;


                    if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin

                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes.Formula);
                        curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 1, '>'); //Get the calculated amount
                                                                                            //error('%1',curTransAmount);

                    end
                    else
                        if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then
                            curTransAmount := PayrollCodes."Standard Amount"
                        else
                            curTransAmount := EmployeeTrans.Amount;


                    VarGrouping := Vargrouping::Deductions;
                    VarSubGroup := Varsubgroup::" ";


                    if (PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::"Life Insurance") then
                        if not (PayrollCodes."Deduct Premium") then
                            curTransAmount := 0;

                    if (PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::"Education Insurance") then
                        if not (PayrollCodes."Deduct Premium") then
                            curTransAmount := 0;


                    if (PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::Mortgage) then
                        if (PayrollCodes."Deduct Mortgage" = false) then
                            curTransAmount := 0;


                    //Get the posting Details
                    JournalPostingType := Journalpostingtype::"G/L Account";
                    JournalAc := '';
                    MNo := '';

                    if PayrollCodes.Subledger <> PayrollCodes.Subledger::"G/L Account" then begin

                        HREmployes.Reset;
                        HREmployes.SetRange(HREmployes."No.", strEmpCode);
                        if HREmployes.Find('-') then begin
                            HREmployes.TestField("Member No");
                            EmployeeTrans.TestField("Sub-Ledger Account");
                            JournalAc := EmployeeTrans."Sub-Ledger Account";
                            JournalPostingType := EmployeeTrans."Sub-Ledger";
                            MNo := HREmployes."Member No";
                        end;


                        //FOR CUSTOMER
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Customer then begin
                            JournalAc := PayrollCodes."Sub-Ledger Account";
                            Customer.Reset;
                            Customer.SetRange(Customer."No.", JournalAc);
                            if not Customer.Find('-') then begin
                                Error('Customer Sub-Ledger Account No. %1 does not Exist for Employer %2', JournalAc, strEmpCode);
                            end;
                        end;

                        //FOR VENDOR
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Vendor then begin
                            JournalAc := PayrollCodes."Sub-Ledger Account";
                            Vendor.Reset;
                            Vendor.SetRange(Vendor."No.", JournalAc);
                            if not Vendor.Find('-') then begin
                                Error('Vendor Sub-Ledger Account No. %1 does not Exist for Employer %2', JournalAc, strEmpCode);
                            end;
                        end;

                        //FOR Loans
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Credit then begin
                            Members.Get(MNo);


                            if PayrollCodes."Special Transactions" = PayrollCodes."special transactions"::"Staff Loan" then begin
                                PayrollCodes.TestField("Sub-Ledger Product Type");

                                EmployeeTrans.TestField("Loan No.");
                                LoanNo := EmployeeTrans."Loan No.";

                                Loans.Reset;
                                Loans.SetRange("Member No.", Members."No.");
                                Loans.SetRange("Loan No.", EmployeeTrans."Loan No.");
                                Loans.SetRange("Loan Product Type", PayrollCodes."Sub-Ledger Product Type");
                                Loans.SetFilter("Total Outstanding Balance", '>0');
                                if Loans.FindFirst then begin
                                    Loans.CalcFields("Outstanding Principal", "Outstanding Interest");
                                    EmployeeTrans.Balance := Loans."Outstanding Principal";
                                    EmployeeTrans.Modify;
                                    /*
                                    LSchedule.RESET;
                                    LSchedule.SETRANGE("Loan No.",Loans."Loan No.");
                                    LSchedule.SETFILTER("Monthly Principal",'>0');
                                    IF LSchedule.FINDFIRST THEN
                                        IF EmployeeTrans."Payroll Period"
                                        */

                                    //EmployeeTrans.Balance := Loans."Outstanding Loan Principal";
                                    IntAmt := 0;
                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::"Flat Rate" then
                                        IntAmt := Loans."Loan Interest Repayment";
                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::Amortised then begin
                                        IntAmt := Loans."Outstanding Interest";
                                        if PayrollCodes."Post Loan Interest Due" then
                                            IntAmt := ROUND(Loans."Outstanding Principal" * Loans."Annual Interest %" / 1200);
                                        EmployeeTrans.TestField("Amortization Total Repayment");
                                    end;
                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::"Reducing Balance" then begin
                                        IntAmt := Loans."Outstanding Interest";

                                        if PayrollCodes."Post Loan Interest Due" then
                                            IntAmt := ROUND(Loans."Outstanding Principal" * Loans."Annual Interest %" / 1200);
                                    end;
                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::"User Defined Amount" then
                                        IntAmt := EmployeeTrans."User Defined Loan Interest";

                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::Amortised then
                                        if IntAmt > EmployeeTrans."Amortization Total Repayment" then
                                            IntAmt := EmployeeTrans."Amortization Total Repayment";


                                    if IntAmt < 0 then
                                        IntAmt := 0;

                                    if PayrollCodes."Loan Interest Method" = PayrollCodes."loan interest method"::Amortised then begin
                                        EmployeeTrans.Amount := EmployeeTrans."Amortization Total Repayment" - IntAmt;
                                        if EmployeeTrans.Amount < 0 then
                                            EmployeeTrans.Amount := 0;
                                        curTransAmount := EmployeeTrans.Amount;
                                    end;

                                    if IntAmt > 0 then begin
                                        fnUpdatePeriodTrans(
                                            strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription + '- Interest', IntAmt, 0,
                                            intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, LoanNo, JournalPostAs, Entrytype::Employee, 1);

                                        curTotalDeductions += IntAmt;
                                    end;
                                end;
                            end;
                        end;

                        //Savings
                        if PayrollCodes.Subledger = PayrollCodes.Subledger::Savings then begin

                            curTransAmount := 0;
                            //EmployeeTrans.Balance := 0;
                            Members.Get(MNo);

                            MemberAccounts.Reset;
                            MemberAccounts.SetRange("Member No.", Members."No.");
                            MemberAccounts.SetRange("Product Type", PayrollCodes."Sub-Ledger Product Type");
                            if MemberAccounts.FindFirst then begin
                                MemberAccounts.CalcFields("Balance (LCY)");
                                EmployeeTrans.Balance := MemberAccounts."Balance (LCY)";
                                EmployeeTrans.Modify;
                                JournalPostingType := Journalpostingtype::Savings;
                                JournalAc := MemberAccounts."No.";
                            end;

                            if PayrollCodes."Sub-Ledger Account" <> '' then begin

                                JournalAc := PayrollCodes."Sub-Ledger Account";
                            end;

                            curTransAmount := EmployeeTrans.Amount;
                            /*
                            IF PayrollCodes."Sacco Transaction Type" = PayrollCodes."Sacco Transaction Type"::"Deposit Contribution" THEN BEGIN
                                Members.CALCFIELDS("Current Savings");
                                //EmployeeTrans.Balance := Members."Current Savings";
                            END;
        
                            IF PayrollCodes."Sacco Transaction Type" = PayrollCodes."Sacco Transaction Type"::"Benevolent Fund" THEN BEGIN
                                Members.CALCFIELDS("Benoverent Fund");
                                //EmployeeTrans.Balance := Members."Benoverent Fund";
                            END;
        
                            IF PayrollCodes."Sacco Transaction Type" = PayrollCodes."Sacco Transaction Type"::"Holiday Savings" THEN BEGIN
                                Members.CALCFIELDS("Account Type");
                                //EmployeeTrans.Balance := Members."Holiday Savings";
                            END;
        
                            IF PayrollCodes."Sacco Transaction Type" = PayrollCodes."Sacco Transaction Type"::"Junior Account" THEN BEGIN
                                Members.CALCFIELDS("CRB Employer Industry Type");
                                //EmployeeTrans.Balance := Members."Junior Account";
        
                            END;
        
                            IF PayrollCodes."Special Transactions" = PayrollCodes."Special Transactions"::"Staff Loan" THEN BEGIN
                                PayrollCodes.TESTFIELD("Loan Product Type");
        
                                EmployeeTrans.TESTFIELD("Loan No.");
                                LoanNo := EmployeeTrans."Loan No.";
        
                                Loans.RESET;
                                Loans.SETRANGE("Date Entered",Members."No.");
                                Loans.SETRANGE("SMS ID",EmployeeTrans."Loan No.");
                                Loans.SETRANGE("Mobile Phone No.",PayrollCodes."Loan Product Type");
                                //Loans.SETFILTER("Outstanding Loan Principal",'>0');
                                IF Loans.FINDFIRST THEN BEGIN
                                    Loans.CALCFIELDS("Outstanding Loan Principal","Outstanding Interest");
                                    //EmployeeTrans.Balance := Loans."Outstanding Loan Principal";
                                    IntAmt := 0;
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::"Flat Rate" THEN
                                        IntAmt := Loans."Loan Interest Repayment";
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::Amortised THEN BEGIN
                                        IntAmt := Loans."Outstanding Interest";
                                        EmployeeTrans.TESTFIELD("Amortization Total Repayment");
                                    END;
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::"Reducing Balance" THEN
                                        IntAmt := Loans."Outstanding Interest";
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::"User Defined Amount" THEN
                                        IntAmt := EmployeeTrans."User Defined Loan Interest";
        
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::Amortised THEN
                                        IF IntAmt > EmployeeTrans."Amortization Total Repayment" THEN
                                            IntAmt := EmployeeTrans."Amortization Total Repayment";
        
                                    IF IntAmt < 0 THEN
                                        IntAmt := 0;
        
                                    IF PayrollCodes."Loan Interest Method" = PayrollCodes."Loan Interest Method"::Amortised THEN BEGIN
                                        EmployeeTrans.Amount := EmployeeTrans."Amortization Total Repayment" - IntAmt;
                                        IF EmployeeTrans.Amount < 0 THEN
                                            EmployeeTrans.Amount := 0;
                                        curTransAmount := EmployeeTrans.Amount;
                                    END;
                                    //MESSAGE('%1',IntAmt);
        
                                    IF IntAmt > 0 THEN BEGIN
                                        fnUpdatePeriodTrans(
                                            strEmpCode,PayrollCodes."Transaction Code",VarGrouping,VarSubGroup,strTransDescription+'- Interest',IntAmt,0,
                                            intMonth,intYear,SelectedPeriod,JournalAc,JournalPostingType,LoanNo,JournalPostAs,EntryType::Employee,1);
        
                                        curTotalDeductions +=IntAmt;
                                    END;
                                END;
                            END;
                            */

                        end;

                    end
                    else begin
                        JournalPostingType := Journalpostingtype::"G/L Account";
                        JournalAc := PayrollCodes."GL Account";
                    end;


                    case PayrollCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                        PayrollCodes."balance type"::None:
                            curTransBalance := 0;
                        PayrollCodes."balance type"::Increasing:
                            begin
                                curTransBalance := EmployeeTrans.Balance + curTransAmount;
                            end;
                        PayrollCodes."balance type"::Reducing:
                            begin
                                if EmployeeTrans.Balance < 0 then
                                    EmployeeTrans.Balance := 0;

                                if EmployeeTrans.Balance < EmployeeTrans.Amount then begin
                                    curTransAmount := EmployeeTrans.Balance;
                                    curTransBalance := 0;
                                end
                                else begin
                                    curTransBalance := EmployeeTrans.Balance - curTransAmount;
                                end;

                                if curTransBalance < 0 then begin
                                    curTransAmount := 0;
                                    curTransBalance := 0;
                                end;
                            end
                    end;

                    curTotalDeductions += curTransAmount;
                    fnUpdatePeriodTrans(
                        strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, LoanNo, JournalPostAs, Entrytype::Employee, 0);

                    //Fringe Benefits and Low interest Benefits
                    if PayrollCodes."Fringe Benefit" = true then begin
                        if EmployeeTrans."Interest Rate" > 0 then
                            if EmployeeTrans."Interest Rate" < curLoanMarketRate then
                                fnCalcFringeBenefit := (((curLoanMarketRate - EmployeeTrans."Interest Rate") * curLoanCorpRate) / 1200)
                                  * EmployeeTrans.Balance;

                    end
                    else begin
                        fnCalcFringeBenefit := 0;
                    end;

                    if fnCalcFringeBenefit > 0 then begin
                        curTransAmount := fnCalcFringeBenefit;
                        strTransDescription := 'Fringe Benefit Tax';
                        curTransBalance := 0;
                        JournalAc := '';
                        LoanNo := '';

                        fnUpdatePeriodTrans(
                            strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
                            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employer, 0);

                    end;
                    //End Fringe Benefits

                    if PayrollCodes."Special Identifier" = PayrollCodes."special identifier"::NSSF then begin

                        curTransAmount := ROUND(PayrollCodes."Standard Amount", 1, '>');


                        curTransBalance := 0;
                        strTransDescription := 'NSSF Relief';
                        JournalAc := '';
                        LoanNo := '';

                        fnUpdatePeriodTrans(
                            strEmpCode, 'NSSFR', Vargrouping::"Tax Calculations", Varsubgroup::"Pension Relief", strTransDescription, curTransAmount, curTransBalance,
                            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);


                    end;

                    //Create Employer Deduction
                    if (PayrollCodes."Employer Deduction") or (PayrollCodes."Include Employer Deduction") then begin

                        if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::Formula then begin
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes."Is Formula for employer");
                            curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 1, '>'); //Get the calculated amount
                                                                                                //error('%1',curTransAmount);

                        end
                        else
                            if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::"Standard Amount" then
                                curTransAmount := PayrollCodes."Standard Amount"
                            else
                                curTransAmount := EmployeeTrans.Amount;

                        if curTransAmount > 0 then begin

                            strTransDescription := 'Employer: ' + EmployeeTrans."Transaction Name";

                            JournalAc := PayrollCodes."GL Account";
                            /*
                            curTransBalance := 0;
                            LoanNo := '';
                            */

                            fnUpdatePeriodTrans(
                                strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
                                intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employer, 0);

                        end;
                    end;

                end;


            until EmployeeTrans.Next = 0;




            curNSSF := 0;
            if blnPaysNssf then begin

                PayrollCodes.Reset;
                PayrollCodes.SetRange(PayrollCodes."Special Identifier", PayrollCodes."special identifier"::NSSF);
                PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::Deduction);
                if PayrollCodes.Find('-') then begin

                    VarGrouping := Vargrouping::Deductions;
                    VarSubGroup := Varsubgroup::" ";
                    VarGrouping := Vargrouping::Statutories;
                    VarSubGroup := Varsubgroup::NSSF;

                    JournalPostingType := Journalpostingtype::"G/L Account";
                    JournalAc := PayrollCodes."GL Account";
                    JournalPostAs := Journalpostas::Credit;

                    if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::Formula then begin
                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes.Formula);
                        curNSSF := ROUND(fnFormulaResult(strExtractedFrml), 1, '>'); //Get the calculated amount
                    end
                    else
                        if PayrollCodes."Calculation Type" = PayrollCodes."calculation type"::"Standard Amount" then
                            curNSSF := PayrollCodes."Standard Amount"
                        else
                            curNSSF := EmployeeTrans.Amount;


                    curTransAmount := curNSSF;
                    curTotalDeductions += curNSSF;
                    curTransBalance := 0;
                    fnUpdatePeriodTrans(
                        strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, PayrollCodes."Transaction Name", curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, '', JournalPostAs, Entrytype::Employee, 0);


                    //Create Employer Deduction
                    if (PayrollCodes."Employer Deduction") or (PayrollCodes."Include Employer Deduction") then begin

                        if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::Formula then begin
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes."Is Formula for employer");
                            curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 1, '>'); //Get the calculated amount
                                                                                                //error('%1',curTransAmount);

                        end
                        else
                            if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::"Standard Amount" then
                                curTransAmount := PayrollCodes."Standard Amount"
                            else
                                curTransAmount := EmployeeTrans.Amount;

                        if curTransAmount > 0 then begin

                            strTransDescription := 'Employer: NSSF';

                            JournalAc := PayrollCodes."GL Account";
                            /*
                            curTransBalance := 0;
                            LoanNo := '';
                            */

                            fnUpdatePeriodTrans(
                                strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
                                intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employer, 0);

                        end;
                    end;

                end;

            end;


        end;





        curGrossPay := (curBasicPay + curTotAllowances + TotalSalaryArrears);
        curTransAmount := ROUND(curGrossPay, 0.01, '>');
        curTransBalance := 0;
        strTransDescription := 'Gross Pay';
        JournalAc := '';
        JournalPostingType := Journalpostingtype::"G/L Account";

        LoanNo := '';
        fnUpdatePeriodTrans(
            strEmpCode, 'GPAY', Vargrouping::"Gross Salary", Varsubgroup::" ", strTransDescription, curTransAmount, curTransBalance,
            intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

        curGrossTaxable := curGrossPay;
        curDefinedContrib := 0;

        /*
        //Added for auto relief calculation
        IF  (curGrossPay-curNSSF)  <= currMinRelief THEN
        BEGIN
            blnGetsPAYERelief:=FALSE;
        END ELSE
        BEGIN
            blnGetsPAYERelief:=TRUE;
            //If employee is marked on salary card as not entitle to personal relief
            PRSalCard_2.RESET;
            IF PRSalCard_2.GET(strEmpCode) THEN
            BEGIN
                IF PRSalCard_2."Disable Personal Relief?" THEN blnGetsPAYERelief:=FALSE;
            END;
        
        END;
        */



        curNHIF := 0;
        if blnPaysNhif then begin

            PayrollCodes.Reset;
            PayrollCodes.SetRange(PayrollCodes."Special Identifier", PayrollCodes."special identifier"::NHIF);
            PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::Deduction);
            if PayrollCodes.Find('-') then begin

                VarGrouping := Vargrouping::Deductions;
                VarSubGroup := Varsubgroup::" ";
                VarGrouping := Vargrouping::Statutories;
                VarSubGroup := Varsubgroup::NHIF;

                JournalPostingType := Journalpostingtype::"G/L Account";
                JournalAc := PayrollCodes."GL Account";
                JournalPostAs := Journalpostas::Credit;



                curNhif_Base_Amount := 0;

                if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
                    curNhif_Base_Amount := curGrossPay;
                if intNHIF_BasedOn = Intnhif_basedon::Basic then
                    curNhif_Base_Amount := curBasicPay;
                if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
                    curNhif_Base_Amount := curTaxablePay;

                curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
                curTransAmount := curNHIF;
                curTotalDeductions += curNHIF;
                curTransBalance := 0;


                fnUpdatePeriodTrans(
                    strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, PayrollCodes."Transaction Name", curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, JournalPostingType, '', JournalPostAs, Entrytype::Employee, 0);


                //Create Employer Deduction
                if (PayrollCodes."Employer Deduction") or (PayrollCodes."Include Employer Deduction") then begin

                    if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::Formula then begin
                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PayrollCodes."Is Formula for employer");
                        curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 1, '>'); //Get the calculated amount
                                                                                            //error('%1',curTransAmount);

                    end
                    else
                        if PayrollCodes."Employer Calculation Type" = PayrollCodes."employer calculation type"::"Standard Amount" then
                            curTransAmount := PayrollCodes."Standard Amount"
                        else
                            curTransAmount := EmployeeTrans.Amount;

                    if curTransAmount > 0 then begin

                        strTransDescription := 'Employer: ' + EmployeeTrans."Transaction Name";

                        JournalAc := PayrollCodes."GL Account";
                        /*
                        curTransBalance := 0;
                        LoanNo := '';
                        */

                        fnUpdatePeriodTrans(
                            strEmpCode, PayrollCodes."Transaction Code", VarGrouping, VarSubGroup, strTransDescription, curTransAmount, curTransBalance,
                            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employer, 0);

                    end;
                end;

            end;

        end;


        if blnGetsPAYERelief then begin
            curTransAmount := curReliefPersonal;
            curTransBalance := 0;
            strTransDescription := 'Personal Relief';
            JournalAc := '';
            LoanNo := '';

            fnUpdatePeriodTrans(
                strEmpCode, 'PSNR', Vargrouping::"Tax Calculations", Varsubgroup::"Tax Relief", strTransDescription, curTransAmount, curTransBalance,
                intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

        end
        else
            curReliefPersonal := 0;


        //>Pension Contribution [self] relief
        curDefinedContrib := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
        Specialtranstype::"Defined Contribution", false);//Self contrib Pension is 1 on [Special Transaction]
        if curDefinedContrib > 0 then begin

            if curDefinedContrib > curMaxPensionContrib then
                curTransAmount := ROUND(curMaxPensionContrib, 1, '>')
            else
                curTransAmount := ROUND(curDefinedContrib, 1, '>');


            curTransBalance := 0;
            strTransDescription := 'Pension Relief';
            JournalAc := '';
            LoanNo := '';

            fnUpdatePeriodTrans(
                strEmpCode, 'PENR', Vargrouping::"Tax Calculations", Varsubgroup::"Pension Relief", strTransDescription, curTransAmount, curTransBalance,
                intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

        end;

        //if he PAYS paye only*******************I
        if blnPaysPaye and blnGetsPAYERelief then begin
            //Get Insurance Relief
            curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::"Life Insurance", false); //Insurance is 3 on [Special Transaction]


            if curInsuranceReliefAmount > 0 then begin
                if ManualInsuranceRelief > 0 then
                    curInsuranceReliefAmount := ManualInsuranceRelief;


                curTransAmount := ROUND(curInsuranceReliefAmount, 1, '<');
                if ManualInsuranceRelief > 0 then
                    curTransAmount := curInsuranceReliefAmount;

                if curTransAmount > curMaxInsuranceRelief then
                    curTransAmount := curMaxInsuranceRelief;


                curTransBalance := 0;
                strTransDescription := 'Insurance Relief';
                JournalAc := '';
                LoanNo := '';

                fnUpdatePeriodTrans(
                    strEmpCode, 'INSR', Vargrouping::"Tax Calculations", Varsubgroup::"Insurance Relief", strTransDescription, curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

            end;
            //>OOI
            curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                      Specialtranstype::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]

            if curOOI > 0 then begin
                if curOOI <= curOOIMaxMonthlyContrb then
                    curTransAmount := curOOI
                else
                    curTransAmount := curOOIMaxMonthlyContrb;


                curTransBalance := 0;
                strTransDescription := 'Insurance Relief';
                JournalAc := '';
                LoanNo := '';

                fnUpdatePeriodTrans(
                    strEmpCode, 'OOI', Vargrouping::"Tax Calculations", Varsubgroup::"Owner Occupier", strTransDescription, curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

            end;

            //HOSP
            curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
            if curHOSP > 0 then begin


                if curHOSP > curReliefMorgage then
                    curHOSP := curReliefMorgage;

                curTransAmount := curHOSP;

                curTransBalance := 0;
                strTransDescription := 'Home Ownership Savings Plan';
                JournalAc := '';
                LoanNo := '';

                fnUpdatePeriodTrans(
                    strEmpCode, 'HOSP', Vargrouping::"Tax Calculations", Varsubgroup::"Home Ownership", strTransDescription, curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

            end;


            //Enter NonTaxable Amount
            if curNonTaxable > 0 then begin

                curTransAmount := curNonTaxable;
                curTransBalance := 0;
                strTransDescription := 'Other Non-Taxable Benefits';
                JournalAc := '';
                LoanNo := '';

                fnUpdatePeriodTrans(
                    strEmpCode, 'NONTAX', Vargrouping::"Tax Calculations", Varsubgroup::"Non-Taxable", strTransDescription, curTransAmount, curTransBalance,
                    intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

            end;

        end;




        BenifitAmount := 0;

        //Initialize
        curTransAmount := 0;
        curTransBalance := 0;
        strTransDescription := '';

        curTaxablePay := (curGrossTaxable + BenifitAmount) -
                        (curSalaryArrears + curDefinedContrib + curOOI + curHOSP + curNonTaxable + curPensionReliefAmount + curNSSF);


        //MESSAGE('curSalaryArrears %1 \curDefinedContrib %2\curMaxPensionContrib %3\curOOI %4\curHOSP %5\curNonTaxable %6\curPensionReliefAmount %7',
        //curSalaryArrears,curDefinedContrib,curMaxPensionContrib,curOOI,curHOSP,curNonTaxable,curPensionReliefAmount) ;

        curTaxablePay := ROUND(curTaxablePay, 1, '<');
        curTransAmount := curTaxablePay;
        curTransBalance := 0;
        strTransDescription := 'Taxable Pay';
        JournalAc := '';
        LoanNo := '';

        fnUpdatePeriodTrans(
            strEmpCode, 'TXBP', Vargrouping::"Tax Calculations", Varsubgroup::"Taxable Pay", strTransDescription, curTransAmount, curTransBalance,
            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);



        if blnPaysPaye then begin
            //Special tax for disabled employee
            HREmp2.Reset;
            if HREmp2.Get(strEmpCode) then begin
                if HREmp2."Physically Challenged" = HREmp2."physically challenged"::Yes then
                    blnPaysPaye := false
                else begin

                    curTaxCharged := ROUND(fnGetEmployeePaye(curTaxablePay), 1, '>');
                    curTaxCharged := ROUND(curTaxCharged, 1, '>');
                    curTransAmount := ROUND(curTaxCharged, 1, '>');
                    curTransBalance := 0;
                    strTransDescription := 'Tax Charged';
                    JournalAc := '';
                    LoanNo := '';

                    fnUpdatePeriodTrans(
                        strEmpCode, 'TXCHRG', Vargrouping::"Tax Calculations", Varsubgroup::"Tax Charged", strTransDescription, curTransAmount, curTransBalance,
                        intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);


                end;
            end;
        end;

        /*
        //Get the Net PAYE amount to post for the month
        IF (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief THEN BEGIN
            curPAYE := curTaxCharged - curMaximumRelief;
        END
        ELSE BEGIN
        
            //******************************************************************************************************************************************
            //Added DW: Only for Employees who have brought their insurance Certificate are entitled to Insurance Relief Otherwise NO
            //Place a check mark on the Salary Card to YES
            IF (blnInsuranceCertificate) THEN BEGIN
                curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount + curHOSP);
            END
            ELSE BEGIN
                curPAYE := curTaxCharged - (curReliefPersonal + curHOSP);
            END;
            //******************************************************************************************************************************************
        END;
        */
        if (blnInsuranceCertificate) then begin
            curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount + curHOSP);
        end
        else begin
            curPAYE := curTaxCharged - (curReliefPersonal + curHOSP);
        end;
        //MESSAGE('curPAYE %1\curReliefPersonal %2',curPAYE,curReliefPersonal);


        //Added for auto PAYE calculation
        if (curGrossPay - curNSSF) <= currMinRelief then begin
            blnPaysPaye := false;
        end
        else begin
            blnPaysPaye := true;
        end;

        curPAYE := ROUND(curPAYE, 1, '>');

        if not blnPaysPaye then
            curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0

        if curPAYE < 0 then
            curPAYE := 0;


        curTransAmount := curPAYE;
        strTransDescription := 'P.A.Y.E';
        curTransBalance := 0;
        JournalAc := TaxAccount;
        LoanNo := '';

        fnUpdatePeriodTrans(
            strEmpCode, 'PAYE', Vargrouping::Statutories, Varsubgroup::PAYE, strTransDescription, curTransAmount, curTransBalance,
            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employee, 0);
        curTotalDeductions += curPAYE;





        //GET TOTAL DEDUCTIONS
        strTransDescription := 'Total Deductions';
        curTransAmount := curTotalDeductions;
        curTransBalance := 0;
        JournalAc := '';
        LoanNo := '';

        fnUpdatePeriodTrans(
            strEmpCode, 'TOT-DED', Vargrouping::Deductions, Varsubgroup::" ", strTransDescription, curTransAmount, curTransBalance,
            intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::" ", Entrytype::Employee, 0);

        //END GET TOTAL DEDUCTIONS





        PayrollCodes.Reset;
        PayrollCodes.SetRange(PayrollCodes."Transaction Type", PayrollCodes."transaction type"::"Net Pay");
        if PayrollCodes.Find('-') then begin

            curNetPay := curGrossPay - (curTotalDeductions);//-curIncludeinNet;
            strTransDescription := 'Net Pay';
            curTransAmount := curNetPay;
            curTransBalance := 0;
            JournalAc := PayrollCodes."GL Account";
            LoanNo := '';

            fnUpdatePeriodTrans(
                strEmpCode, 'NPAY', Vargrouping::"Net Salary", Varsubgroup::" ", strTransDescription, curTransAmount, curTransBalance,
                intMonth, intYear, SelectedPeriod, JournalAc, Journalpostingtype::"G/L Account", LoanNo, Journalpostas::Credit, Entrytype::Employee, 0);

        end;

    end;


    procedure fnInitialize()
    begin
        //Initialize Global Setup Items
        RatesCeilings.Get;
        with RatesCeilings do begin
            curReliefPersonal := "Tax Relief";
            curReliefInsurance := "Insurance Relief";
            curReliefMorgage := "Mortgage Relief"; //Same as HOSP
            curMaximumRelief := "Max Relief";
            intNHIF_BasedOn := "NHIF Based on";
            curMaxPensionContrib := "Max Pension Contribution";
            curOOIMaxMonthlyContrb := "OOI Deduction";
            curLoanMarketRate := "Loan Market Rate";
            curLoanCorpRate := "Loan Corporate Rate";
            currMinRelief := "Minimum Relief Amount";
            curDisabledLimit := "Disbled Tax Limit";
        end;
    end;


    procedure ConfirmPostingGroupSetup(strEmpCode: Code[20])
    var
        SalaryCard: Record "Staff Payroll Details";
        HREmp: Record Employee;
    begin

        if HREmp.Get(strEmpCode) then begin
            if PostingGroup.Get('PAYROLL') then begin
                PostingGroup.TestField("Salary Account");
                PostingGroup.TestField("Income Tax Account");
                //PostingGroup.TESTFIELD("Net Salary Payable");

                TaxAccount := PostingGroup."Income Tax Account";
                salariesAcc := PostingGroup."Salary Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                NitaAccount := PostingGroup."NITA Payable Account"
            end;
        end;
    end;


    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
    begin
        ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary, 1, '<');
    end;


    procedure ClosePayrollPeriod(OpenPeriod: Date) Closed: Boolean
    var
        dtNewPeriod: Date;
        intNewMonth: Integer;
        intNewYear: Integer;
        intMonth: Integer;
        intYear: Integer;
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        CreateTrans: Boolean;
        NewEmployeeTrans: Record "Payroll Employee Transactions";
        EmployeeTrans: Record "Payroll Employee Transactions";
        Lno: Integer;
    begin

        dtNewPeriod := CalcDate('1M', OpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        intMonth := Date2dmy(OpenPeriod, 2);
        intYear := Date2dmy(OpenPeriod, 3);

        EmployeeTrans.Reset;
        EmployeeTrans.SetRange(EmployeeTrans."Period Month", intMonth);
        EmployeeTrans.SetRange(EmployeeTrans."Period Year", intYear);
        EmployeeTrans.SetRange(EmployeeTrans.Stopped, false); //Added DW to not process Stopped Transactions
        if EmployeeTrans.Find('-') then begin
            repeat
                PayrollCodes.Reset;
                PayrollCodes.SetRange(PayrollCodes."Transaction Code", EmployeeTrans."Transaction Code");
                if PayrollCodes.Find('-') then begin
                    with PayrollCodes do begin


                        curTransAmount := 0;
                        curTransBalance := 0;
                        case PayrollCodes."Balance Type" of
                            PayrollCodes."balance type"::None:
                                begin
                                    curTransAmount := EmployeeTrans.Amount;
                                    curTransBalance := 0;
                                end;

                            PayrollCodes."balance type"::Increasing:
                                begin
                                    curTransAmount := EmployeeTrans.Amount;
                                    curTransBalance := EmployeeTrans.Balance + EmployeeTrans.Amount;
                                end;

                            PayrollCodes."balance type"::Reducing:
                                begin
                                    curTransAmount := EmployeeTrans.Amount;
                                    if EmployeeTrans.Balance < EmployeeTrans.Amount then begin
                                        curTransAmount := EmployeeTrans.Balance;
                                        curTransBalance := 0;
                                    end
                                    else begin
                                        curTransBalance := EmployeeTrans.Balance - EmployeeTrans.Amount;
                                    end;
                                    if curTransBalance < 0 then begin
                                        curTransAmount := 0;
                                        curTransBalance := 0;
                                    end;
                                end;
                        end;
                    end;


                    //For those transactions with Start and End Date Specified
                    if (EmployeeTrans."Start Date" <> 0D) then begin
                        if EmployeeTrans."Start Date" >= dtNewPeriod then begin
                            curTransAmount := 0;
                            curTransBalance := 0;
                        end;
                    end;
                    if (EmployeeTrans."End Date" <> 0D) then begin
                        if EmployeeTrans."End Date" < dtNewPeriod then begin
                            curTransAmount := 0;
                            curTransBalance := 0;
                        end;
                    end;
                    //End Transactions with Start and End Date
                    Lno += 1;
                    if (PayrollCodes.Frequency = PayrollCodes.Frequency::Fixed) then begin
                        if (curTransAmount > 0) then begin
                            //Insert record for the next period
                            with NewEmployeeTrans do begin
                                Init;
                                EntryNo := Lno;
                                "Employee Code" := EmployeeTrans."Employee Code";
                                Validate("Transaction Code", EmployeeTrans."Transaction Code");
                                "Transaction Name" := EmployeeTrans."Transaction Name";
                                Amount := curTransAmount;
                                Balance := curTransBalance;
                                "Period Month" := intNewMonth;
                                "Period Year" := intNewYear;
                                "Payroll Period" := dtNewPeriod;
                                "Start Date" := EmployeeTrans."Start Date";
                                "End Date" := EmployeeTrans."End Date";
                                "Loan No." := EmployeeTrans."Loan No.";
                                Insert;
                            end;
                        end;
                    end;
                end;
            until EmployeeTrans.Next = 0;
        end;

        //Update the Period as Closed
        PayrollPeriods.Reset;
        PayrollPeriods.SetRange(PayrollPeriods."Period Month", intMonth);
        PayrollPeriods.SetRange(PayrollPeriods."Period Year", intYear);
        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
        if PayrollPeriods.Find('-') then begin
            PayrollPeriods.Closed := true;
            PayrollPeriods."Date Closed" := Today;
            PayrollPeriods."Closed By" := UserId;
            PayrollPeriods.Modify;
        end;

        //Enter a New Period
        with PayrollPeriods do begin
            Init;
            "Period Month" := intNewMonth;
            "Period Year" := intNewYear;
            "Period Name" := CopyStr(Format(dtNewPeriod, 0, '<Month Text>'), 1, 3) + ' ' + Format(intNewYear);
            "Date Opened" := dtNewPeriod;
            "Opened By" := UserId;
            Closed := false;
            Insert;
        end;

        //Effect the transactions for the P9
        UpdatePeriodP9(intMonth, intYear, OpenPeriod);

        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        AddNegativePay(intMonth, intYear, OpenPeriod);


        /*
        //Reset no. of days worked for casuals
        PRSalCard.RESET;
        PRSalCard.SETRANGE(PRSalCard."Employee Contract Type",'CASUALS');
        IF PRSalCard.FIND('-') THEN BEGIN
            REPEAT
                PRSalCard."No. of Days Worked":=0;
                PRSalCard.MODIFY;
            UNTIL PRSalCard.NEXT = 0;
        END;
        */

    end;


    procedure UpdatePeriodP9(intMonth: Integer; intYear: Integer; dtCurPeriod: Date)
    var
        P9EmployeeCode: Code[20];
        P9BasicPay: Decimal;
        P9Allowances: Decimal;
        P9Benefits: Decimal;
        P9ValueOfQuarters: Decimal;
        P9DefinedContribution: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9GrossPay: Decimal;
        P9TaxablePay: Decimal;
        P9TaxCharged: Decimal;
        P9InsuranceRelief: Decimal;
        P9TaxRelief: Decimal;
        P9Paye: Decimal;
        P9NSSF: Decimal;
        P9NHIF: Decimal;
        P9Deductions: Decimal;
        P9NetPay: Decimal;
        Employee: Record Employee;
    begin
        Employee.Reset;
        if Employee.Find('-') then begin
            repeat
                P9BasicPay := 0;
                P9Allowances := 0;
                P9Benefits := 0;
                P9ValueOfQuarters := 0;
                P9DefinedContribution := 0;
                P9OwnerOccupierInterest := 0;
                P9GrossPay := 0;
                P9TaxablePay := 0;
                P9TaxCharged := 0;
                P9InsuranceRelief := 0;
                P9TaxRelief := 0;
                P9Paye := 0;
                P9NSSF := 0;
                P9NHIF := 0;
                P9Deductions := 0;
                P9NetPay := 0;


                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", Employee."No.");
                PeriodTrans.SetRange(PeriodTrans."Period Month", intMonth);
                PeriodTrans.SetRange(PeriodTrans."Period Year", intYear);
                if PeriodTrans.Find('-') then begin
                    repeat
                        with PeriodTrans do begin
                            case PeriodTrans.Grouping of
                                PeriodTrans.Grouping::"Basic Salary": //Basic pay & Arrears
                                    begin
                                        if "Sub Group" = "sub group"::BasicPay then
                                            P9BasicPay := Amount; //Basic Pay
                                        if "Sub Group" = "sub group"::"BasicPay Arrears" then
                                            P9BasicPay := P9BasicPay + Amount; //Basic Pay Arrears
                                    end;
                                PeriodTrans.Grouping::Allowances:  //Allowances
                                    begin
                                        P9Allowances := P9Allowances + Amount
                                    end;
                                PeriodTrans.Grouping::"Gross Salary": //Gross Pay
                                    begin
                                        P9GrossPay := Amount
                                    end;
                                PeriodTrans.Grouping::"Tax Calculations": //Taxation
                                    begin
                                        if "Sub Group" = "sub group"::"Defined Contribution" then P9DefinedContribution := Amount; //Defined Contribution
                                        if "Sub Group" = "sub group"::"Tax Relief" then P9TaxRelief := Amount; //Tax Relief
                                        if "Sub Group" = "sub group"::"Insurance Relief" then P9InsuranceRelief := Amount; //Insurance Relief
                                        if "Sub Group" = "sub group"::"Taxable Pay" then P9TaxablePay := Amount; //Taxable Pay
                                        if "Sub Group" = "sub group"::"Tax Charged" then P9TaxCharged := Amount; //Tax Charged
                                    end;
                                PeriodTrans.Grouping::Statutories: //Statutories
                                    begin
                                        if "Sub Group" = "sub group"::NSSF then P9NSSF := Amount; //Nssf
                                        if "Sub Group" = "sub group"::NHIF then P9NHIF := Amount; //Nhif
                                        if "Sub Group" = "sub group"::PAYE then P9Paye := Amount; //paye
                                        if "Sub Group" = "sub group"::"PAYE Arrears" then P9Paye := P9Paye + Amount; //Paye Arrears
                                    end;
                                PeriodTrans.Grouping::Deductions://Deductions
                                    begin
                                        P9Deductions := P9Deductions + Amount;
                                    end;
                                PeriodTrans.Grouping::"Net Salary": //NetPay
                                    begin
                                        P9NetPay := Amount;
                                    end;

                            end;
                        end;
                    until PeriodTrans.Next = 0;
                end;


                //Update the P9 Details
                if P9NetPay <> 0 then
                    InsertP9Record(Employee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                    P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                    P9NHIF, P9Deductions, P9NetPay, dtCurPeriod);

            until Employee.Next = 0;
        end;
    end;


    procedure AddNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
    var
        intNewMonth: Integer;
        intNewYear: Integer;
        dtNewPeriod: Date;
        EmployeeTrans: Record "Payroll Employee Transactions";
    begin
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        PeriodTrans.Reset;
        PeriodTrans.SetRange(PeriodTrans."Period Month", intMonth);
        PeriodTrans.SetRange(PeriodTrans."Period Year", intYear);
        PeriodTrans.SetRange(PeriodTrans.Grouping, PeriodTrans.Grouping::"Net Salary");
        PeriodTrans.SetFilter(PeriodTrans.Amount, '<0');
        if PeriodTrans.Find('-') then begin
            if not PayrollCodes.Get('NEGP') then begin
                PayrollCodes.Init;
                PayrollCodes."Transaction Code" := 'NEGPAY';
                PayrollCodes."Transaction Name" := 'Negative Pay';
                PayrollCodes."Balance Type" := PayrollCodes."balance type"::None;
                PayrollCodes."Transaction Type" := PayrollCodes."transaction type"::Deduction;
                PayrollCodes.Frequency := PayrollCodes.Frequency::Varied;
                PayrollCodes."Calculation Type" := PayrollCodes."calculation type"::"Varied Amount";
                PayrollCodes.Insert;
            end;

            repeat
                with EmployeeTrans do begin
                    Init;
                    "Employee Code" := PeriodTrans."Employee Code";
                    "Transaction Code" := 'NEGP';
                    "Transaction Name" := 'Negative Pay';
                    Amount := PeriodTrans.Amount * -1;
                    Balance := 0;
                    "Period Month" := intNewMonth;
                    "Period Year" := intNewYear;
                    "Payroll Period" := dtNewPeriod;
                    Insert;
                end;
            until PeriodTrans.Next = 0;
        end;
    end;


    procedure InsertP9Record(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date)
    var
        PayrollP9Buffer: Record "Payroll P9 Buffer";
        intYear: Integer;
        intMonth: Integer;
    begin
        intMonth := Date2dmy(dtCurrPeriod, 2);
        intYear := Date2dmy(dtCurrPeriod, 3);


        PayrollP9Buffer.Reset;
        with PayrollP9Buffer do begin
            Init;
            "Employee Code" := P9EmployeeCode;
            "Basic Pay" := P9BasicPay;
            Allowances := P9Allowances;
            Benefits := P9Benefits;
            "Value Of Quarters" := P9ValueOfQuarters;
            "Defined Contribution" := P9DefinedContribution;
            "Owner Occupier Interest" := P9OwnerOccupierInterest;
            "Gross Pay" := P9GrossPay;
            "Taxable Pay" := P9TaxablePay;
            "Tax Charged" := P9TaxCharged;
            "Insurance Relief" := P9InsuranceRelief;
            "Tax Relief" := P9TaxRelief;
            PAYE := P9Paye;
            NSSF := P9NSSF;
            NHIF := P9NHIF;
            Deductions := P9Deductions;
            "Net Pay" := P9NetPay;
            "Period Month" := intMonth;
            "Period Year" := intYear;
            "Payroll Period" := dtCurrPeriod;
            Insert;
        end;
    end;


    procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
    var
        pureformula: Text[50];
    begin
        pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
        curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
    end;
}

