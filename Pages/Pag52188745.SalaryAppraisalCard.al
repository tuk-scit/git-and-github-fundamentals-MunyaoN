page 52188752 "Salary Appraisal Card"
{
    Caption = 'Salary Appraisal Card';
    PageType = Card;
    SourceTable = "Member Salary Appraisal";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Appraisal Type"; "Appraisal Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                        if "Appraisal Type" = "Appraisal Type"::Business then begin
                            BusinessAppraisal := true;
                            SalaryDetails := false;
                        end
                        else begin
                            BusinessAppraisal := false;
                            SalaryDetails := true;
                        end;

                    end;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                    LookupPageId = "Member Listing";
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Type"; "Member Type")
                {
                    ApplicationArea = All;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Amount field.';
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period field.';
                }
            }

            group("Loan Details")
            {
            }
            group("Salary Details")
            {
                Visible = SalaryDetails;

                field("Net Salary Multiplier %"; "Net Salary Multiplier %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Amount field.';
                }

                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Basic Pay field.';
                }
                field("House Allowance"; Rec."House Allowance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the House Allowance field.';
                }
                field("Commuter Allowance"; Rec."Commuter Allowance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commuter Allowance field.';
                }
                field("Other Allowances"; Rec."Other Allowances")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other Allowances field.';
                }
                field("Gross Pay"; Rec."Gross Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gross Pay field.';
                }
                field(Pension; Rec.Pension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pension field.';
                }
                field(NHIF; Rec.NHIF)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NHIF field.';
                }
                field(NSSF; Rec.NSSF)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NSSF field.';
                }
                field(Tax; Rec.Tax)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax field.';
                }
                field("BOSA Loans"; Rec."BOSA Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BOSA Loans field.';
                }
                field("BOSA Savings"; Rec."BOSA Savings")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BOSA Savings field.';
                }
                field("Other Deductions"; Rec."Other Deductions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other Deductions field.';
                }
                field("1/3 of Gross Pay"; Rec."1/3 of Gross Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 1/3 of Gross Pay field.';
                }
                field("FOSA Loans"; Rec."FOSA Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FOSA Loans field.';
                }
                field(STO; Rec.STO)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the STO field.';
                }
                field("Net Salary"; Rec."Net Salary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field("Percentage of Net Salary"; Rec."Percentage of Net Salary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percentage of Net Salary field.';
                }
                field("To Deduct"; Rec."To Deduct")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Deduct field.';
                }
                field("Net Salary After Fosa Ded"; Rec."Net Salary After Fosa Ded")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Salary After Fosa Ded field.';
                }

                field("BOSA Loan To Run At"; Rec."BOSA Loan To Run At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan To Run At field.';
                }


                field("FOSA Loan To Run At"; "FOSA Loan To Run At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan To Run At field.';
                }
            }
            group(Qualifications)
            {

                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qualification field.';
                }

                field("Share Deposits"; "Share Deposits")
                {
                    ApplicationArea = All;
                }
                field(Multiplier; Multiplier)
                {
                    ApplicationArea = All;
                }
                field("Deposit Multiplier"; "Deposit Multiplier")
                {
                    ApplicationArea = All;
                }
                field("BOSA Loan balance"; "BOSA Loan balance")
                {
                    ApplicationArea = All;
                }

                field("Maximum Credit"; "Maximum Credit")
                {
                    ApplicationArea = All;
                }

                field("Recommended Amount"; "Recommended Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Max. Monthly Deduction"; Rec."Max. Monthly Deduction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Max. Monthly Deduction field.';
                }

                field("External Clearance"; Rec."External Clearance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Clearance field.';
                }
                field("External Clearance Charges"; Rec."External Clearance Charges")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Clearance Charges field.';
                }
                field("Top Up Loan"; Rec."Top Up Loan")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Top Up Loan field.';
                }
                field("Top Up Commission"; Rec."Top Up Commission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Top Up Commission field.';
                }
                field("Upfront Interest"; Rec."Upfront Interest")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Upfront Interest field.';
                }
                field(Insurance; Rec.Insurance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance field.';
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Monthly Repayment field.';
                }
                field("Principal Repayment"; Rec."Principal Repayment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Principal Repayment field.';
                }
                field("Interest Repayment"; Rec."Interest Repayment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Repayment field.';
                }
                field("Total Charges"; Rec."Total Charges")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Charges field.';
                }
                field("Net Loan Take Home"; "Net Loan Take Home")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }

                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                }
                field("Annual Interest %"; Rec."Annual Interest %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Annual Interest % field.';
                }
            }

            part(Control1102755015; "Business Monthly Income")
            {
                Editable = true;
                ApplicationArea = Basic, Suite;
                Visible = BusinessAppraisal;
                SubPageLink = "Appraisal No." = FIELD("Appraisal No.");

            }
        }
    }

    actions
    {
        area(navigation)
        {

            action("Loan Top Up")
            {
                ApplicationArea = Basic;
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Appraisal Loan Top Up";
                RunPageLink = "Loan No." = field("Appraisal No."),
                              "Member No." = field("Member No.");
            }

            action("Other Clearances")
            {
                ApplicationArea = Basic;
                Image = ClearFilter;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Other Commitments Clearance";
                RunPageLink = "Loan Application No." = field("Appraisal No.");
            }

        }
        area(reporting)
        {
            action("Loan Appraisal Report")
            {
                ApplicationArea = Basic;
                Image = AnalysisView;

                trigger OnAction()
                var
                    Appraisal: Record "Member Salary Appraisal";
                begin

                    Appraisal.Reset;
                    Appraisal.SetRange("Appraisal No.", "Appraisal No.");
                    if Appraisal.FindFirst then
                        Report.Run(Report::"Loan Salary Appraisal", true, false, Appraisal);
                end;
            }
            action("Loan Schedule Report")
            {
                ApplicationArea = Basic;
                Image = Link;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                    Appraisal: Record "Member Salary Appraisal";
                begin

                    SaccoActivities.GenerateAppraisalRepaymentSchedule(Rec);
                    Commit;

                    Appraisal.Reset;
                    Appraisal.SetRange("Appraisal No.", "Appraisal No.");
                    if Appraisal.FindFirst then
                        Report.Run(Report::"Appraisal Repayment Schedule", true, false, Appraisal);
                end;
            }
        }

    }


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        if "Appraisal Type" = "Appraisal Type"::Business then begin
            BusinessAppraisal := true;
            SalaryDetails := false;
        end
        else begin
            BusinessAppraisal := false;
            SalaryDetails := true;
        end;

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin

        if "Appraisal Type" = "Appraisal Type"::Business then begin
            BusinessAppraisal := true;
            SalaryDetails := false;
        end
        else begin
            BusinessAppraisal := false;
            SalaryDetails := true;
        end;


    end;

    var
        BusinessAppraisal: Boolean;
        SalaryDetails: Boolean;



}
