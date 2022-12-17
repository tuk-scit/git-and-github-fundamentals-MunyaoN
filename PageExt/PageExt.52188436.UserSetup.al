
PageExtension 52188436 UserSetup extends "User Setup"
{
    layout
    {

        addafter("User ID")
        {
            field("Member No."; "Member No.")
            {
                ApplicationArea = Basic;
                LookupPageId = "Member Listing";
            }
            field("Staff No"; "Staff No")
            {
                ApplicationArea = Basic;
            }
            field("Max. Open Documents"; "Max. Open Documents")
            {
                ApplicationArea = Basic;
            }
            field("File Management Admin"; "File Movement Admin")
            {
                ApplicationArea = Basic;
            }
            field("Global Dimension 1 Code"; "Global Dimension 1 Code")
            {
                ApplicationArea = Basic;
            }
            field("Global Dimension 2 Code"; "Global Dimension 2 Code")
            {
                ApplicationArea = Basic;
            }
            field("CashRec Journal Template"; "CashRec Journal Template")
            {
                ApplicationArea = Basic;
            }
            field("CashRec Journal Batch"; "CashRec Journal Batch")
            {
                ApplicationArea = Basic;
            }
            field("Payment Journal Template"; "Payment Journal Template")
            {
                ApplicationArea = Basic;
            }
            field("Payment Journal Batch"; "Payment Journal Batch")
            {
                ApplicationArea = Basic;
            }

            field("General Journal Template"; "General Journal Template")
            {
                ApplicationArea = Basic;
            }
            field("General Journal Batch"; "General Journal Batch")
            {
                ApplicationArea = Basic;
            }

            field("Imprest Account"; "Imprest Account")
            {
                ApplicationArea = Basic;
            }
            field(Payroll; Payroll)
            {
                ApplicationArea = basic;
            }
            field("View Staff Accounts"; "View Staff Accounts")
            {
                ApplicationArea = Basic;
            }
            field("Branch Manager"; "Branch Manager")
            {
                ApplicationArea = Basic;
            }
            field("Default Petty Cash Bank"; "Default Petty Cash Bank")
            {
                ApplicationArea = Basic;
            }
            field("Default Payment Bank"; "Default Payment Bank")
            {
                ApplicationArea = Basic;
            }
            field("Disable SMS"; "Disable SMS")
            {
                ApplicationArea = Basic;
            }
            field("View Board Accounts"; "View Board Accounts")
            {
                ApplicationArea = Basic;
            }
        }

    }
    actions
    {

        addfirst(processing)
        {
            action("Status Change Permissions")
            {
                ApplicationArea = Basic;
            }
            action("Set Posting Date As Current")
            {
                ApplicationArea = Basic;
                Image = New;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Update Posting Date";
            }
            action("Get Users")
            {
                ApplicationArea = Basic;
                Image = New;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                trigger OnAction()
                var
                    User: Record User;
                    UserSetup: Record "User Setup";
                    USetup: Record "User Setup";
                    j: Integer;
                    GenBatch: Record "Gen. Journal Batch";
                    GenTemplate: Record "Gen. Journal Template";
                    Pos: Integer;
                    JTemplate: Code[10];
                    JBatch: Code[20];
                    AccName: Text;
                begin

                    if Confirm('Are you sure you want to Get All Users?') then begin
                        j := 0;

                        JTemplate := 'GENERAL';
                        if not GenTemplate.Get(JTemplate) then begin
                            GenTemplate.Init();
                            GenTemplate.Name := JTemplate;
                            GenTemplate.Type := GenTemplate.Type::General;
                            GenTemplate.Insert();
                        end;

                        JTemplate := 'PAYMENTS';
                        if not GenTemplate.Get(JTemplate) then begin
                            GenTemplate.Init();
                            GenTemplate.Name := JTemplate;
                            GenTemplate.Type := GenTemplate.Type::Payments;
                            GenTemplate.Insert();
                        end;

                        JTemplate := 'RECEIPTS';
                        if not GenTemplate.Get(JTemplate) then begin
                            GenTemplate.Init();
                            GenTemplate.Name := JTemplate;
                            GenTemplate.Type := GenTemplate.Type::"Cash Receipts";
                            GenTemplate.Insert();
                        end;

                        User.Reset();
                        if User.FindFirst() then begin
                            repeat
                                if not UserSetup.Get(User."User Name") then begin
                                    UserSetup.Init();
                                    UserSetup.Validate("User ID", User."User Name");


                                    Pos := StrPos(UserSetup."User ID", '\');

                                    if Pos > 1 then begin
                                        AccName := CopyStr(UserSetup."User ID", Pos + 1, StrLen(UserSetup."User ID"));
                                        Pos := StrPos(AccName, '.');
                                        if Pos > 1 then begin
                                            AccName := CopyStr(AccName, Pos + 1, StrLen(AccName));
                                            GenBatch.Reset();
                                            GenBatch.SetRange(Name, AccName);
                                            IF GenBatch.FindFirst() THEN begin
                                                AccName := CopyStr(AccName, 1, Pos - 1);
                                                JBatch := AccName;
                                            end;
                                        end
                                        else begin

                                            JBatch := AccName;
                                        end;
                                    end
                                    ELSE begin
                                        JBatch := UserSetup."User ID";
                                    end;

                                    USetup.Reset();
                                    USetup.SetRange("General Journal Batch", JBatch);
                                    if not USetup.FindFirst() then begin

                                        JTemplate := 'GENERAL';

                                        if not GenBatch.Get(JTemplate, JBatch) then begin
                                            GenBatch.Init();
                                            GenBatch."Journal Template Name" := JTemplate;
                                            GenBatch.Name := JBatch;
                                            GenBatch.Insert();
                                        end;

                                        UserSetup."General Journal Template" := JTemplate;
                                        UserSetup."General Journal Batch" := JBatch;
                                        JTemplate := 'PAYMENTS';

                                        if not GenBatch.Get(JTemplate, JBatch) then begin
                                            GenBatch.Init();
                                            GenBatch."Journal Template Name" := JTemplate;
                                            GenBatch.Name := JBatch;
                                            GenBatch.Insert();
                                        end;
                                        UserSetup."General Journal Template" := JTemplate;
                                        UserSetup."General Journal Batch" := JBatch;
                                        JTemplate := 'RECEIPTS';

                                        if not GenBatch.Get(JTemplate, JBatch) then begin
                                            GenBatch.Init();
                                            GenBatch."Journal Template Name" := JTemplate;
                                            GenBatch.Name := JBatch;
                                            GenBatch.Insert();
                                        end;
                                        UserSetup."General Journal Template" := JTemplate;
                                        UserSetup."General Journal Batch" := JBatch;

                                    end;

                                    UserSetup.Insert(true);
                                    j += 1;


                                end;
                            until User.Next() = 0;
                        end;
                        Message('%1 Account(s) Created', j);
                    end;

                end;
            }

        }
    }

    var
        UserSetup: Record "User Setup";
}

