pageextension 52188426 "Detailed Vendor Ledger" extends "Detailed Vendor Ledg. Entries"
{

    layout
    {
        addafter("Vendor No.")
        {
            field("Member No."; "Member No.")
            {
            }
            field(Narration; Narration)
            {
            }
        }
        addafter("Amount (LCY)")
        {
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
        }
    }
}
