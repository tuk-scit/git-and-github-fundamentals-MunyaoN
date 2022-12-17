pageextension 52188427 "Detailed Customer Ledger" extends "Detailed Cust. Ledg. Entries"
{

    layout
    {
        addafter("Customer No.")
        {
            field("Member No."; "Member No.")
            {
            }
            field("Description - FLF"; "Description - FLF")
            {
            }

            field(Duplicates; Duplicates)
            {
            }

            field("Posted By"; "User ID")
            {
            }


        }
        addafter("Amount (LCY)")
        {
            field("Transaction Type"; "Transaction Type")
            {
            }
            field("Loan No."; "Loan No.")
            {
            }
            field("Group Code"; "Group Code")
            {
            }
            field("Staff No."; "Staff No.")
            {
            }
            field("Reversed - FLF"; "Reversed - FLF")
            {
            }
        }
    }
    actions
    {

        addafter("Unapply Entries")
        {

            action(ReverseTransaction)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reverse Transaction';
                Ellipsis = true;
                Image = ReverseRegister;
                Promoted = true;
                ToolTip = 'Undo an erroneous journal posting.';

                trigger OnAction()
                var
                    ReversalEntry: Record "Reversal Entry";
                begin
                    Clear(ReversalEntry);
                    CalcFields("Reversed - FLF");

                    if "Reversed - FLF" then
                        ReversalEntry.AlreadyReversedEntry(TableCaption, "Entry No.");

                    //if "Journal Batch Name" = '' then
                    //  ReversalEntry.TestFieldError;
                    TestField("Transaction No.");
                    ReversalEntry.ReverseTransaction("Transaction No.");
                end;
            }


            action(UpdateDecember)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'UpdateDecember 2021';
                Ellipsis = true;
                Image = ReverseRegister;
                Promoted = true;
                ToolTip = 'Undo an erroneous journal posting.';

                trigger OnAction()
                var
                    ReversalEntry: Record "Reversal Entry";
                begin
                    if Confirm('Are you sure you want to Update December Entry?') then begin
                        TestField("Transaction Type", "Transaction Type"::"Interest Due");
                        TestField("Posting Date", DMY2Date(31, 12, 2021));
                        "Amount Back Up" := Amount;
                        Amount := 0;
                        "Amount (LCY)" := 0;
                        "Debit Amount" := 0;
                        "Debit Amount (LCY)" := 0;
                        Modify();
                        Message('Updated');


                    end;
                end;
            }
        }
    }
}

