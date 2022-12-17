Page 52188625 "Loan Disbursement Header"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Loan Disbursement Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                Editable = ApprovedEdit;
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension1Code; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(SubsequentDisbursements; "Subsequent Disbursements")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if "Subsequent Disbursements" = "subsequent disbursements"::Yes then
                            SubseqDisb := true
                        else
                            SubseqDisb := false;
                    end;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(DisbursementDestination; "Disbursement Destination")
                {
                    ApplicationArea = Basic;
                }
                field(DisburseAccounts; "Disburse Accounts")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(ChequeNo; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(DatePosted; "Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TimePosted; "Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TotalAmount; "Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                group("Partial Disbursements")
                {
                    Visible = SubseqDisb;
                    field(LoanProductType; "Loan Product Type")
                    {
                        ApplicationArea = Basic;
                        Editable = SubseqDisb;
                        Visible = SubseqDisb;
                    }
                    field(IssuedDateFrom; "Issued Date From")
                    {
                        ApplicationArea = Basic;
                    }
                    field(IssuedDateTo; "Issued Date To")
                    {
                        ApplicationArea = Basic;
                        Editable = SubseqDisb;
                        Visible = SubseqDisb;
                    }
                }
            }
            part(PVLines; "Loan Disbursement Lines")
            {
                SubPageLink = No = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    Jtemplate: Code[20];
                    JBatch: Code[20];
                    dWindow: Dialog;
                    BatchAmt: Decimal;
                    AcctType: Enum "Gen. Journal Account Type";
                    BalAcctType: Enum "Gen. Journal Account Type";
                    TransType: Enum "Transaction Type Enum";

                begin
                    TestField("Posting Date");
                    TestField(Posted, false);
                    TestField(Status, Status::Approved);
                    if "Disbursement Destination" <> "disbursement destination"::Normal then
                        TestField("Disburse Accounts");
                    if "Subsequent Disbursements" = "subsequent disbursements"::No then begin

                        Loans.Reset;
                        //Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                        //Loans.SetRange(Loans.Posted, false);
                        Loans.SetRange(Loans."Batch No.", "No.");
                        if Loans.Find('-') then begin
                            Loans.Posted := false;
                            Loans.Modify();
                            Commit();

                            UserSetup.Get(UserId);
                            UserSetup.TestField("Payment Journal Template");
                            UserSetup.TestField("Payment Journal Batch");
                            JTemplate := UserSetup."Payment Journal Template";
                            JBatch := UserSetup."Payment Journal Batch";
                            Posting.JournalInit(JTemplate, JBatch);
                            BatchAmt := 0;

                            repeat
                                Posting.PostLoan(Loans."Loan No.", "No.", "Disburse Accounts", true, BatchAmt, "Posting Date");
                            until Loans.Next() = 0;

                            if "Disbursement Destination" = "Disbursement Destination"::"Bank Account" then begin

                                if "Posting Date" = 0D then
                                    "Posting Date" := today;
                                Posting.JournalInsert(
                                    JTemplate,
                                    JBatch,
                                    "No.",
                                    "Posting Date",
                                    Accttype::"Bank Account",
                                    Rec."Disburse Accounts",
                                    'Loan Disbursement Batch No: ' + "No.",
                                    Balaccttype::"G/L Account",
                                    '',
                                    -BatchAmt,
                                    '',
                                    '',
                                    Transtype::" ",
                                    "Global Dimension 1 Code",
                                    "Global Dimension 2 Code",
                                    true
                                    );
                            end;

                            if Posting.JournalPost(Jtemplate, JBatch) then begin
                                Rec.Posted := true;
                                Rec."Date Posted" := Today;
                                Rec."Posted By" := UserId;
                                Rec.Modify();

                                Loans.Reset;
                                Loans.SetRange(Loans.Posted, true);
                                Loans.SetRange(Loans."Batch No.", "No.");
                                if Loans.Find('-') then begin
                                    dWindow.Open('#1#################');
                                    dWindow.Update(1, 'Generating Schedule');
                                    repeat

                                        Posting.GenerateRepaymentSchedule(Loans);
                                        Commit;
                                        dWindow.Update(1, 'Sending Email/SMS Notification: ' + Loans."Loan No.");
                                        Posting.SendLoanDisbursementNotifications(Loans);
                                    until Loans.Next() = 0;

                                    dWindow.Close;
                                end;

                                Message('Batch Posted Successfuly');
                            end;

                        end
                    end
                    //else
                    //  Posting."PostLoan Subsequent Disbursements"("No.");
                end;
            }
            separator(Action12)
            {
            }
            action("Suggest Disbursements")
            {
                ApplicationArea = Basic;
                Image = SuggestCustomerBill;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Status <> Status::Open then
                        Error('Batch MUST be Open');
                    //Validations
                    DisbLines.Reset;
                    DisbLines.SetRange(DisbLines.No, "No.");
                    if DisbLines.Find('-') then begin
                        if Confirm('The lines will be deleted and recreated. Are you sure you want to proceed?', false) = true then
                            DisbLines.DeleteAll
                        else begin
                            Message('Proceed and process. The lines will not be regenerated');
                            exit;
                        end;
                    end;
                    Loans.Reset;
                    //Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SetRange(Loans.Posted, false);
                    Loans.SetRange(Loans."Batch No.", "No.");
                    if Loans.Find('-') then begin
                        repeat
                            if Loans.Status <> Loans.Status::Approved then
                                Error(LoanNotApproved, Loans."Loan No.");
                            EntryNo := EntryNo + 1000;
                            DisbLines.Init;
                            DisbLines."Line No." := EntryNo;
                            DisbLines."Loan No." := Loans."Loan No.";
                            DisbLines.Validate(DisbLines."Loan No.");
                            DisbLines."Global Dimension 1 Code" := Loans."Global Dimension 1 Code";
                            DisbLines."Global Dimension 2 Code" := Loans."Booking Branch";
                            DisbLines.No := "No.";
                            DisbLines.Insert;
                        //Tag that it has been suggested
                        //Loans."Already Suggested":=TRUE;
                        //Loans.MODIFY;
                        until Loans.Next = 0;
                    end else
                        Error("MissingLoans:");




                    /*
                    IF "Subsequent Disbursements"="Subsequent Disbursements"::Yes THEN
                      ERROR(Text003);
                    
                    GetIfNothingSelected;
                    
                    IF ("Issued Date From"<>0D ) AND ("Issued Date To"=0D) THEN
                      ERROR("LoanDateErr:");
                    
                    IF ("Issued Date From"=0D ) AND ("Issued Date To"<>0D) THEN
                      ERROR("LoanDateErr:");
                    
                    IF "Issued Date From">"Issued Date To" THEN
                      ERROR("LoanDateErr:");
                    
                    
                    //Date only placed--1
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    //"Loan Product Type" only placed--2
                    
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim one only--3
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim 2 only--4
                    
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dates and Loan type placed--5
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //"Loan Product Type" and Dim1 placed--6
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //"Loan Product Type" AND dim2--7
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim 1 and dates-8
                    
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim1 and dim 2--9
                    
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim 2 and datess--10
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //All present--11
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Ltype Dim1 and dim2--12
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    //Ltype Dim1 and dates--13
                    
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"<>'') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    //Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Ltype Dim2 and dates--14
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Loan Product Type","Loan Product Type");
                    //Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    
                    //Dim1 Dim2 and dates--15
                    IF ("Loan Product Type"<>'') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"<>'') AND ("Issued Date From"<>0D) AND ("Issued Date To"<>0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                    
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                    IF ("Loan Product Type"='') AND ("Global Dimension 1 Code"='') AND ("Global Dimension 2 Code"='') AND ("Issued Date From"=0D) AND ("Issued Date To"=0D) THEN BEGIN
                    EntryNo:=0;
                    Loans.RESET;
                    //Loans.SETRANGE(Loans."Loan Product Type","Loan product Type");
                    //Loans.SETRANGE(Loans."Global Dimension 1 Code","Global Dimension 1 Code");
                    //Loans.SETRANGE(Loans."Global Dimension 2 Code","Global Dimension 2 Code");
                    //Loans.SETRANGE(Loans."Disbursement Date","Issued Date From","Issued Date To");
                    Loans.SETRANGE(Loans.Status,Loans.Status::Approved);
                    Loans.SETRANGE(Loans.Posted,FALSE);
                    Loans.SETRANGE(Loans."Already Suggested",FALSE);
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        EntryNo:=EntryNo+1000;
                        DisbLines.INIT;
                        DisbLines."Line No.":= EntryNo;
                        DisbLines."Loan No.":=Loans."Loan No.";
                        DisbLines.VALIDATE(DisbLines."Loan No.");
                        DisbLines."Global Dimension 1 Code":=Loans."Global Dimension 1 Code";
                        DisbLines."Global Dimension 2 Code":=Loans."Global Dimension 2 Code";
                        DisbLines.No:="No.";
                        DisbLines.INSERT;
                        //Tag that it has been suggested
                        Loans."Already Suggested":=TRUE;
                        Loans.MODIFY;
                      UNTIL Loans.NEXT=0;
                    END ELSE
                    ERROR("MissingLoans:");
                    END;
                    
                     */

                end;
            }
            separator(Action13)
            {
            }
            action("Suggest Partial Disbursements Due")
            {
                ApplicationArea = Basic;
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //ERROR('Invalid action....');

                    if "Subsequent Disbursements" = "subsequent disbursements"::No then
                        Error(Text003);
                    GetIfNothingSelected;


                    if ("Issued Date From" = 0D) or ("Issued Date To" = 0D) then
                        Error(Text005);

                    if "Issued Date To" < "Issued Date From" then
                        Error("LoanDateErr:");


                    EntryNo := 0;
                    Loans.Reset;
                    Loans.SetRange(Loans.Status, Loans.Status::Approved);
                    Loans.SetRange(Loans.Posted, true);
                    Loans.SetRange(Loans."Type of Disbursement", Loans."Type of Disbursement"::"Partial Disbursement");

                    if ("Loan Product Type" <> '') then
                        Loans.SetRange(Loans."Loan Product Type", "Loan Product Type");
                    if ("Global Dimension 2 Code" <> '') then
                        Loans.SetRange(Loans."Booking Branch", "Global Dimension 2 Code");
                    if ("Global Dimension 1 Code" <> '') then
                        Loans.SetRange(Loans."Global Dimension 1 Code", "Global Dimension 1 Code");

                    if Loans.Find('-') then begin
                        DisbLines.Reset;
                        DisbLines.SetRange(No, "No.");
                        if DisbLines.FindFirst then
                            DisbLines.DeleteAll;
                        /*repeat
                            PartDisb.Reset;
                            PartDisb.SetRange(PartDisb."Loan No.", Loans."Loan No.");
                            PartDisb.SetRange(PartDisb.Posted, false);
                            PartDisb.SetRange(PartDisb."Scheduled Disbursement Date", "Issued Date From", "Issued Date To");
                            if PartDisb.Find('-') then begin
                                repeat
                                    EntryNo := EntryNo + 1000;
                                    DisbLines.Init;
                                    DisbLines."Line No." := EntryNo;
                                    DisbLines."Loan No." := PartDisb."Loan No.";
                                    DisbLines."Disbursement Amount" := PartDisb.Amount;
                                    DisbLines.Date := Today;
                                    DisbLines."Account No." := Loans."Member No.";
                                    DisbLines."Account Name" := Loans."Member Name";
                                    DisbLines."Global Dimension 1 Code" := Loans."Global Dimension 1 Code";
                                    DisbLines."Global Dimension 2 Code" := Loans."Booking Branch";
                                    DisbLines.No := "No.";
                                    DisbLines."Disbursement Serial - PD" := PartDisb."Entry No";
                                    DisbLines.Insert;
                                    //Tag that it has been suggested
                                    PartDisb."Suggested for Disbursement" := true;
                                    PartDisb.Modify;
                                until PartDisb.Next = 0;
                            end;
                        until Loans.Next = 0;*/
                    end
                    else
                        Error("MissingLoans:");
                end;
            }
            separator(Action21)
            {
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Approval Document Type";
                        //CalwideApprovals: Codeunit "Calwide Approvals";
                        Source: Option BOSA,FOSA,MICRO;
                    begin

                        //TestField("Posting Date");
                        //TestField("Posting Remarks");
                        TestField(Status, Status::Open);

                        CalcFields("Total Amount");
                        VarVariant := Rec;
                        //CalwideApprovals.CreateTracker(VarVariant, "No.", "Total Amount", Documenttype::"Loan Batch", "Global Dimension 1 Code", "Global Dimension 2 Code", Source);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        //CalwideApprovals: Codeunit "Calwide Approvals";
                        DocumentType: Enum "Approval Document Type";
                    begin
                        TestField(Status, Status::Pending);

                        VarVariant := Rec;
                        //CalwideApprovals.CancelTracker(VarVariant, "No.");
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Enum "Approval Document Type";
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::"Loan Batch";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", "No.");
                        ApprovalTracker.SetRange("Document Type", DocType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }

                action(ApproveBatch)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve Batch';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Enum "Approval Document Type";
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        if Confirm('Are you sure you want to Approve this Batch?') then begin
                            Status := Status::Approved;
                            Modify();
                            Message('Approve');
                        end;
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if (Status <> Status::Open) and (Status <> Status::Pending) then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;
                            Status := Status::Open;
                            Modify;
                        end;
                    end;
                }
            }

            separator(Action5)
            {
            }
            action("Loan Disbursement Schedule")
            {
                ApplicationArea = Basic;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Batches.Reset;
                    Batches.SetRange(Batches."No.", "No.");
                    if Batches.Find('-') then begin
                        Report.Run(52188511, true, false, Batches);
                    end;
                end;
            }
            action("EFT Schedule")
            {
                ApplicationArea = Basic;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Batches.Reset;
                    Batches.SetRange(Batches."No.", "No.");
                    if Batches.Find('-') then begin
                        Report.Run(52188512, true, false, Batches);
                    end;
                end;
            }
            action(REOPEN)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    Status := Status::Open;
                    Modify;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        StatusControl;
    end;

    trigger OnOpenPage()
    begin
        if "Subsequent Disbursements" = "subsequent disbursements"::Yes then
            SubseqDisb := true
        else
            SubseqDisb := false;
        StatusControl;
    end;

    var
        Text001: label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: label 'Do you want to Void Check No %1';
        Text002: label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        Posting: Codeunit "Sacco Activities";
        Batches: Record "Loan Disbursement Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        "LoanDateErr:": label 'Dates are inconsistent';
        EntryNo: Integer;
        Loans: Record Loans;
        DisbLines: Record "Loan Disbursement Lines";
        "MissingLoans:": label 'There are missing loans within the filter';
        //PartDisb: Record "Partial Disbursement Schedule";
        Text003: label 'This option is meant for subsequent disbursements - Partial';
        Text004: label 'This option is first time disbursements';
        Text005: label 'Dates cannot be blank';
        LoanApp: Record Loans;
        LoanNotApproved: label 'Loan No. %1 in the current batch is not approved. Remove from batch or approve first';
        SubseqDisb: Boolean;
        ApprovedEdit: Boolean;

    local procedure GetIfNothingSelected()
    begin
    end;


    procedure StatusControl()
    begin
        ApprovedEdit := true;
        case Status of
            Status::Pending, Status::Approved, Status::Rejected:
                begin
                    ApprovedEdit := false;
                end;
            Status::Open:
                begin
                    ApprovedEdit := true;
                end;
        end;
    end;
}

