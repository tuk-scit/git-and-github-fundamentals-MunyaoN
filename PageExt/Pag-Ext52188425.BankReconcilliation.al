pageextension 52188425 "Bank Reconcilliation " extends "Bank Acc. Reconciliation"
{


    layout
    {

        addafter(BankAccountNo)
        {

            field(Type; Type)
            {
                ApplicationArea = Basic;
            }
        }
        addafter(StatementEndingBalance)
        {
            field("Notes Line 1"; "Notes Line 1")
            {
                ApplicationArea = Basic;
            }
            field("Notes Line 2"; "Notes Line 2")
            {
                ApplicationArea = Basic;
            }
            field("Notes Line 3"; "Notes Line 3")
            {
                ApplicationArea = Basic;
            }
            field("Notes Line 4"; "Notes Line 4")
            {
                ApplicationArea = Basic;
            }
            field("Notes Line 5"; "Notes Line 5")
            {
                ApplicationArea = Basic;
            }
            field("Notes Line 6"; "Notes Line 6")
            {
                ApplicationArea = Basic;
            }



        }



    }



    actions
    {
        // Adding a new action group 'MyNewActionGroup' in the 'Creation' area
        addbefore(ImportBankStatement)
        {



            action(ImportStatementLinesFromExcel)
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Import electronic bank statements from your bank to populate with data about actual bank transactions.';

                trigger OnAction()
                begin
                    CurrPage.Update;
                    ImportBankStatementLinesFromExcel;
                end;
            }

            action(ReconReport)
            {
                ApplicationArea = Basic, Suite;
                Image = Report2;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Recon: Record "Bank Acc. Reconciliation";
                begin
                    CurrPage.Update;
                    Recon.Reset();
                    Recon.SetRange("Bank Account No.", "Bank Account No.");
                    Recon.SetRange("Statement No.", "Statement No.");
                    if Recon.FindFirst() then begin
                        Report.Run(52188519, true, false, recon);
                    end;
                end;
            }

        }
    }
}
