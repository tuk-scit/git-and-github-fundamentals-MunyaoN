
Page 52188684 "Loans Statistics"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Loans;
    SourceTableView = where("Total Outstanding Balance" = filter(<> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; "Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Product Name"; "Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount; "Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                }
                field(AnnualInterest; "Annual Interest %")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementDate; "Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(CompletionDate; "Completion Date")
                {
                    ApplicationArea = Basic;
                }
                field(RecoveryMode; "Repay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(RequestedAmount; "Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(LoanPrincipleRepayment; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInterestRepayment; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                }
                field(LoansCategorySASRA; "Loans Category-SASRA")
                {
                    ApplicationArea = Basic;
                }
                field(LoansCategorySACCO; "Loans Category-SACCO")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPenalty; "Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingAppraisal; "Outstanding Appraisal")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDue; "Interest Due")
                {
                    ApplicationArea = Basic;
                }
                field(InterestPaid; "Interest Paid")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";
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
                field(LastPrincipalPayDate; "Last Principal Pay Date")
                {
                    ApplicationArea = Basic;
                }
                field(LastPayDate; "Last Pay Date")
                {
                    ApplicationArea = Basic;
                }
                field(TotalOutstandingBalance; "Total Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    //DrillDownPageId = "Loan Ledger Entries";
                }
            }
        }
        area(factboxes)
        {
            part(Control37; "Loans Statistics FactBox")
            {
                SubPageLink = "Loan No." = field("Loan No.");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        TotaBill := ("Total Arrears" + "Outstanding Interest") - Repayment;
        if TotaBill < 0 then
            TotaBill := 0;
        /*
        IF "Outstanding Balance" = 0 THEN
            IF "Outstanding Appraisal" = 0 THEN
                IF "Outstanding Penalty" = 0 THEN
                    IF "Outstanding Interest" = 0 THEN
        
        */

    end;

    var
        TotaBill: Decimal;
}

