page 52188622 "Loans Subform"
{
    Caption = 'Loans Subform';
    PageType = ListPart;
    SourceTable = Loans;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No. field.';
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
            }
        }
    }
}
