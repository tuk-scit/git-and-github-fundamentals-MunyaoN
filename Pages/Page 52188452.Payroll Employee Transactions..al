
Page 52188452 "Payroll Employee Transactions."
{
    PageType = List;
    SourceTable = "Payroll Employee Transactions";
    SourceTableView = where("Transaction Type"=const(Earning));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EmployeeCode;"Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionCode;"Transaction Code")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Codes" where ("Transaction Type"=const(Earning));

                    trigger OnValidate()
                    begin
                        blnIsLoan:=false;

                        PayrollCodes.Reset;
                        PayrollCodes.SetRange(PayrollCodes."Transaction Code","Transaction Code");
                        if PayrollCodes.Find('-') then begin
                            "Transaction Name":=PayrollCodes."Transaction Name";
                            "Payroll Period":=SelectedPeriod;
                            "Period Month":=PeriodMonth;
                            "Period Year":=PeriodYear;
                            "Loan Product Type" := PayrollCodes."Sub-Ledger Product Type";

                            if PayrollCodes."Calculation Type"=PayrollCodes."calculation type"::Formula then begin
                                empCode:="Employee Code";
                                curTransAmount:=objOCX.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,PayrollCodes.Formula);
                                Amount:=curTransAmount;
                            end;

                            if PayrollCodes."Calculation Type"=PayrollCodes."calculation type"::"Standard Amount" then begin
                                Amount:=PayrollCodes."Standard Amount";
                            end;


                            if PayrollCodes."Include Employer Deduction" then  begin
                              curTransAmount:=objOCX.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,PayrollCodes."Is Formula for employer");
                              "Employer Amount":=curTransAmount;
                            end;

                            if PayrollCodes."Special Identifier" = PayrollCodes."special identifier"::NHIF then begin
                                if StaffPayrollDetails.Get("Employee Code") then
                                    Amount := objOCX.fnGetEmployeeNHIF(StaffPayrollDetails."Basic Pay");
                            end;


                        end;
                    end;
                }
                field(TransactionName;"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Balance)
                {
                    ApplicationArea = Basic;
                }
                field(UserDefinedLoanInterest;"User Defined Loan Interest")
                {
                    ApplicationArea = Basic;
                }
                field(AmortizationTotalRepayment;"Amortization Total Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodMonth;"Period Month")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodYear;"Period Year")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollPeriod;"Payroll Period")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerAmount;"Employer Amount")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerBalance;"Employer Balance")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollCode;"Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo;"Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo;"Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        RestrictAccess;

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed,false);
        if objPeriod.Find('-') then
        begin
            SelectedPeriod:=objPeriod."Date Opened";
            PeriodName:=objPeriod."Period Name";
            PeriodMonth:=objPeriod."Period Month";
            PeriodYear:=objPeriod."Period Year";
            //objEmpTrans.RESET;
            //objEmpTrans.SETRANGE("Payroll Period",SelectedPeriod);
        end;

        //Filter per period  - Dennis
        SetFilter("Payroll Period",Format(objPeriod."Date Opened"));
        //objPeriod.SETFILTER(objPeriod.Closed,'FALSE');
    end;

    trigger OnOpenPage()
    begin
        SetFilter("Payroll Period",Format(objPeriod."Date Opened"));
    end;

    var
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Periods";
        PeriodName: Text[30];
        PeriodTrans: Record "Payroll Period Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        transType: Text[30];
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
        PREmployeeTrans: Record "Payroll Employee Transactions";
        i: Integer;
        HREmp: Record Employee;
        PayrollCodes: Record "Payroll Codes";
        objOCX: Codeunit "Payroll Processing";
        StaffPayrollDetails: Record "Staff Payroll Details";


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID",UserId);
        SaccoPermissions.SetRange(Payroll,true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Payroll"');
    end;
}

