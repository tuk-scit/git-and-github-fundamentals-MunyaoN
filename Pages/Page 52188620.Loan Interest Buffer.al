
Page 52188620 "Loan Interest Buffer"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Interest Buffer";
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;

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
                field(LoanProducttype; "Loan Product type")
                {
                    ApplicationArea = Basic;
                }
                field(IssuedDate; "Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field(AnnualInterest; "Annual Interest %")
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerCode; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDate; "Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(InterestAmount; "Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; "User ID")
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
                field(GlobalDimension1Code; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingBalance; "Outstanding Balance")
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
                field(Reversed; Reversed)
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
            action("Generate Loan Interest")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Generate Loan Interest";
            }
            action("Post Interest")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Post Generated Interest') then begin
                        UserSetup.Get(UserId);
                        UserSetup.TestField("General Journal Template");
                        UserSetup.TestField("General Journal Batch");

                        JTemplate := UserSetup."General Journal Template";
                        JBatch := UserSetup."General Journal Batch";

                        SaccoActivities.JournalInit(JTemplate, JBatch);
                        IntBuffer.Reset;
                        IntBuffer.SetRange(Posted, false);
                        if IntBuffer.FindFirst then begin
                            if Confirm(Format(IntBuffer.Count) + ' line(s) will be posted. Continue?') then
                                repeat

                                    SaccoActivities.JournalInsert(
                                        JTemplate,
                                        JBatch,
                                        IntBuffer."Loan No.",
                                        IntBuffer."Posting Date",
                                        Accttype::Credit,
                                        IntBuffer."Account No",
                                        IntBuffer.Description,
                                        IntBuffer."Bal. Account Type",
                                        IntBuffer."Bal. Account No.",
                                        IntBuffer."Interest Amount",
                                        ExtDocNo,
                                        IntBuffer."Loan No.",
                                        Transtype::"Interest Due",
                                        IntBuffer."Global Dimension 1 Code",
                                        IntBuffer."Global Dimension 2 Code",
                                        true
                                        );

                                    IntBuffer.Posted := true;
                                    IntBuffer.Modify;

                                    SaccoActivities.JournalPost(JTemplate, JBatch);
                                until IntBuffer.Next = 0;
                        end;

                    end;
                end;
            }
            action("Clear Unposted Interest")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Clear Unposted Interest') then begin
                        UserSetup.Get(UserId);
                        UserSetup.TestField("General Journal Template");
                        UserSetup.TestField("General Journal Batch");

                        JTemplate := UserSetup."General Journal Template";
                        JBatch := UserSetup."General Journal Batch";


                        IntBuffer.Reset;
                        IntBuffer.SetRange(Posted, false);
                        if IntBuffer.FindFirst then begin
                            IntBuffer.DeleteAll;
                        end;

                    end;
                end;
            }
            action("Generate Manual Interest")
            {
                ApplicationArea = Basic;
                RunObject = Report "Generate Manual Interest";
            }
        }
    }

    var
        IntBuffer: Record "Loan Interest Buffer";
        SaccoActivities: Codeunit "Sacco Activities";
        UserSetup: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        ExtDocNo: Code[20];
        TransType: Enum "Transaction Type Enum";
}

