
Page 52188683 "Loans Statistics FactBox"
{
    Caption = 'Loans Statistics';
    PageType = CardPart;
    SourceTable = Loans;

    layout
    {
        area(content)
        {
            group("Loan Details")
            {
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(MemberName; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount; "Approved Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            group(CurrentLoan)
            {
                Caption = 'Current Loan';
                field(OutstandingPenalty; "Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";
                }
                field(OutstandingInterest; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";
                }
                field(PrincipalArrears; "Principal Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(TotalArrears; "Total Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; "Outstanding Principal")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";
                }
                field("Current Total Repayment"; "Outstanding Penalty" + "Outstanding Interest" + "Principal Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(TotalOutstandingBalance; "Total Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";

                    trigger OnDrillDown()
                    begin
                        ShowDetails;
                    end;
                }
            }
            group("All Member Loans")
            {
                Caption = 'All Member Loans';
                field("Total Penalty"; AllPenalty)
                {
                    ApplicationArea = Basic;
                }
                field("Total Out. Interest"; AllInterest)
                {
                    ApplicationArea = Basic;
                }
                field(TotalPrincipalArrears; TotalPrincipalArrears)
                {
                    ApplicationArea = Basic;
                }
                field("Total  Arrears"; AllBills)
                {
                    ApplicationArea = Basic;
                }
                field("Total Loan Balance"; AllLoanBalance)
                {
                    ApplicationArea = Basic;
                }
                field("Total Current Repayment"; AllPenalty + TotalPrincipalArrears + AllInterest)
                {
                    ApplicationArea = Basic;
                }
                field("Total Outstanding - All"; TLoans)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcValues;
    end;

    var
        Text000: label 'Overdue Amounts (LCY) as of %1';
        ProdType: Record "Product Setup";
        MinBalance: Decimal;
        PeriodicActivities: Codeunit "Member Activities";
        AvailBalance: Decimal;
        AllPenalty: Decimal;
        AllAppraisal: Decimal;
        AllInterest: Decimal;
        AllBills: Decimal;
        AllLoanBalance: Decimal;
        Loans: Record Loans;
        AppFee: Decimal;
        TAppFee: Decimal;
        AppAmt: Decimal;
        InterestPaid: Decimal;
        IntAmount: Decimal;
        TIntAmount: Decimal;
        Int: Decimal;
        AppraisalToDate: Decimal;
        InterestToDate: Decimal;
        BillToDate: Decimal;
        TAppraisalToDate: Decimal;
        TInterestToDate: Decimal;
        TBillToDate: Decimal;
        TLoans: Decimal;
        BillAmt: Decimal;
        SaccoActivities: Codeunit "Sacco Activities";
        TotalPrincipalArrears: Decimal;

    local procedure ShowDetails()
    begin
        //Page.Run(Page::"Member Account Card", Rec);
    end;

    local procedure CalcValues()
    begin
        AllAppraisal := 0;
        AllBills := 0;
        AllInterest := 0;
        AllLoanBalance := 0;
        AllPenalty := 0;


        AppraisalToDate := 0;
        InterestToDate := 0;
        BillToDate := 0;

        TAppraisalToDate := 0;
        TInterestToDate := 0;
        TBillToDate := 0;
        TLoans := 0;

        //SETFILTER("Date Filter",'..%1',TODAY);
        CalcFields("Total Arrears", "Outstanding Appraisal", "Outstanding Interest", "Schedule Interest", "Interest Paid");


        Loans.Reset;
        Loans.SetRange("Member No.", "Member No.");
        //Loans.SETFILTER("Date Filter",'..%1',TODAY);
        if Loans.FindFirst then begin
            repeat
                Loans.CalcFields("Outstanding Appraisal", "Outstanding Penalty", "Outstanding Interest", "Total Arrears", "Outstanding Principal");
                Loans.CalcFields("Total Outstanding Balance", "Principal Arrears");

                /*
                        AppAmt:=PeriodicActivities.GetAppraisalDue(Loans);
                        IF AppAmt > Loans."Outstanding Appraisal" THEN
                          AppAmt := Loans."Outstanding Appraisal";

                        IF AppAmt < 0 THEN
                          AppAmt:=0;
                          */

                /*
                        IntAmount:=PeriodicActivities.GetInterestDue(Loans);
                        IF IntAmount > Loans."Outstanding Interest" THEN
                          IntAmount := Loans."Outstanding Interest";

                        IF IntAmount < 0 THEN
                          IntAmount:=0;
                          */
                BillAmt := Loans."Total Arrears";

                if BillAmt < 0 then
                    BillAmt := 0;


                AllAppraisal += Loans."Outstanding Appraisal";
                AllBills += Loans."Total Arrears";
                AllInterest += Loans."Outstanding Interest";
                AllLoanBalance += Loans."Outstanding Principal";
                AllPenalty += Loans."Outstanding Penalty";
                TLoans += Loans."Total Outstanding Balance";
                TotalPrincipalArrears += Loans."Principal Arrears";

                TAppraisalToDate += AppAmt;
                TInterestToDate += IntAmount;
                TBillToDate += BillAmt;


            until Loans.Next = 0;
        end;

    end;
}

