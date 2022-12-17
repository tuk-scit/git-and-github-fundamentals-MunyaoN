
Page 52188555 "Dividend Posting Buffer"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Dividend Posting";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PostingDate; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; "Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field(DebitAmount; "Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field(CreditAmount; "Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(ProductTypeName; "Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ExternalDocumentNo; "External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; "Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(BalAccountType; "Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(BalAccountNo; "Bal. Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field(LoanProduct; "Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field(Transaction; Transaction)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Posting Buffer")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Dividend Posting Buffer";
            }
            action("Post Entries")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to post these entries') then begin
                        SaccoSetup.Get;
                        Members.Reset;
                        Members.SetFilter("Gross Dividends", '>0');
                        if Members.FindFirst then begin



                            dWindow.Open('Dividend Generation:            #1#########\'
                                                + 'Total Members:          #2#########\'
                                                + 'Counter:                #3#########\'
                                                + 'Progress:               @4@@@@@@@@@\'
                                                + 'Press Esc to abort');




                            TotalRecords := Members.Count;
                            dWindow.Update(2, TotalRecords);
                            RecordCounter := 0;



                            repeat
                                RecordCounter += 1;
                                dWindow.Update(1, Members.Name);
                                dWindow.Update(3, RecordCounter);
                                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));


                                DivPosting.Reset;
                                DivPosting.SetRange("Member No.", Members."No.");
                                DivPosting.SetRange(Posted, false);
                                if DivPosting.Find('-') then
                                    SaccoActivities.PostDividendLines(Members."No.", false, SaccoSetup."Dividend Processing Account", Members."Gross Dividends", Members."Mobile Phone No.");

                            until Members.Next = 0;
                            dWindow.Close;
                        end;
                    end;
                end;
            }
            action("Journal Transfer")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to send these entries to journal?') then begin
                        SaccoSetup.Get;
                        Members.Reset;
                        Members.SetFilter("Gross Dividends", '>0');
                        if Members.FindFirst then begin



                            dWindow.Open('Dividend Generation:            #1#########\'
                                                + 'Total Members:          #2#########\'
                                                + 'Counter:                #3#########\'
                                                + 'Progress:               @4@@@@@@@@@\'
                                                + 'Press Esc to abort');




                            TotalRecords := Members.Count;
                            dWindow.Update(2, TotalRecords);
                            RecordCounter := 0;



                            repeat
                                RecordCounter += 1;
                                dWindow.Update(1, Members.Name);
                                dWindow.Update(3, RecordCounter);
                                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));


                                DivPosting.Reset;
                                DivPosting.SetRange("Member No.", Members."No.");
                                DivPosting.SetRange(Posted, false);
                                if DivPosting.Find('-') then
                                    SaccoActivities.PostDividendLines(Members."No.", true, SaccoSetup."Dividend Processing Account", Members."Gross Dividends", Members."Mobile Phone No.");

                            until Members.Next = 0;
                            dWindow.Close;
                        end;
                    end;
                end;
            }
        }
    }

    var
        Members: Record Customer;
        SaccoActivities: Codeunit "Sacco Activities";
        SaccoSetup: Record "Sacco Setup";
        DivPosting: Record "Dividend Posting";
        dWindow: Dialog;
        RecordCounter: Integer;
        TotalRecords: Integer;
}

