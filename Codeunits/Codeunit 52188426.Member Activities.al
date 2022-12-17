
Codeunit 52188426 "Member Activities"
{

    trigger OnRun()
    begin
        //Base64Header;
    end;

    var
        GenSetup: Record "Sacco Setup";
        Source: Enum "SMS Source Enum";
        SaccoActivities: Codeunit "Sacco Activities";
        Emp: Record Employee;
        MinBal: Decimal;
        //SkyMbanking: Codeunit "Sky Mbanking";


    procedure CreateMember(MemberApplication: Record "Member Registration")
    var
        Member: Record Customer;
        ImageData: Record "Member Images";
        NextOfKin: Record "Next of Kin.";
        NextOfKinApp: Record "Next of Kin.";
        Nominee: Record Nominee;
        NomineeApp: Record Nominee;
        DefaultSavingsProducts: Record "Default Savings Products.";
        ProductSetup: Record "Product Setup";
        Msg: Text;
        SenderName: Text;
        SenderAddress: Text;
        Signatory: Record "Account Signatories.";
        SignatoryApp: Record "Account Signatories.";
        MemberAccounts: Record Vendor;
        MNo: Code[20];

        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin



        MNo := '';
        Member.Init;
        SalesSetup.Get;
        SalesSetup.TestField("Member Nos.");
        NoSeriesMgt.InitSeries(SalesSetup."Member Nos.", Member."No. Series", 0D, Member."No.", Member."No. Series");

        Member.TestField("No.");
        Member.Type := MemberApplication.Type;
        Member."Industry Type" := MemberApplication."Industry Type";
        Member."Account Category" := MemberApplication."Account Category";
        Member."First Name" := UpperCase(MemberApplication."First Name");
        Member.Surname := UpperCase(MemberApplication.Surname);
        Member."Middle Name" := UpperCase(MemberApplication."Middle Name");
        Member.Name := UpperCase(MemberApplication.Name);
        Member."Registration Date" := Today;
        Member."How Did You Know About Us" := MemberApplication."How Did You Know About Us";
        Member."Member Class" := MemberApplication."Member Class";
        Member."Account Type" := Member."Account Type"::Members;
        Member."ID No." := MemberApplication."ID No.";
        Member."Date of Birth" := MemberApplication."Date of Birth";
        Member."KRA PIN" := MemberApplication."KRA PIN";
        Member.Gender := MemberApplication.Gender;
        Member."Marital Status" := MemberApplication."Marital Status";
        Member."Employer Code" := MemberApplication."Employer Code";
        Member."Employer Name" := MemberApplication."Employer Name";
        Member."Terms of Employment" := MemberApplication."Terms of Employment";
        Member."Payroll/Staff No." := MemberApplication."Payroll/Staff No.";
        Member."Member Category" := MemberApplication."Member Category";
        Member."Captured By" := MemberApplication."Captured By";
        Member."Post Code" := MemberApplication."Post Code";
        Member.Address := MemberApplication.Address;
        Member."Address 2" := MemberApplication."Address 2";
        Member.City := MemberApplication.City;
        Member."Country/Region Code" := MemberApplication."Country/Region Code";
        Member."Phone No." := MemberApplication."Alternative Phone No.";
        Member."Mobile Phone No." := MemberApplication."Mobile Phone No.";
        Member."E-Mail" := MemberApplication."E-Mail";
        Member."Global Dimension 2 Code" := MemberApplication."Global Dimension 2 Code";
        Member."Recruited by Type" := MemberApplication."Recruited by Type";
        Member."Recruited By" := MemberApplication."Recruited By";
        Member."Recruited By Name" := MemberApplication."Recruited By Name";
        Member."Member Status" := Member."Member Status"::Active;
        Member."Bank Code" := MemberApplication."Bank Code";
        Member."Bank Name" := MemberApplication."Bank Name";
        Member."Branch Code" := MemberApplication."Branch Code";
        Member."Swift Code" := MemberApplication."Swift Code";
        Member."Branch Name" := MemberApplication."Branch Name";
        Member."Bank Account No." := MemberApplication."Bank Account No.";
        Member."Salutation Code" := MemberApplication."Salutation Code";
        Member."Group No." := MemberApplication."Group No.";

        Member."Relationship Officer" := MemberApplication."Relationship Officer";
        Member."Relationship Officer Name" := MemberApplication."Relationship Officer Name";
        Member."Branch Manager" := MemberApplication."Branch Manager";
        Member."Branch Manager Name" := MemberApplication."Branch Manager Name";
        Member."From Another Sacco" := MemberApplication."From Another Sacco";

        //Group

        Member."Group Account" := MemberApplication."Group Account";
        Member."Other Type Of Business" := MemberApplication."Other Type Of Business";
        Member."Business Reg. No." := MemberApplication."Business Reg. No.";
        Member."Incorporation No." := MemberApplication."Incorporation No.";
        Member."Date of Bus. Incorporation" := MemberApplication."Date of Bus. Incorporation";
        Member."Business/Group Location" := MemberApplication."Business/Group Location";
        Member."Group Type" := MemberApplication."Group Type";
        Member."Other Group Type" := MemberApplication."Other Group Type";
        Member."Date of Bus. Reg." := MemberApplication."Date of Bus. Reg.";
        Member."Group Category" := MemberApplication."Group Category";
        Member."Type of Business" := MemberApplication."Type of Business";
        Member."Account Category" := MemberApplication."Account Category";
        Member."Meeting Day" := MemberApplication."Meeting Day";
        Member."Meeting Location" := MemberApplication."Meeting Location";
        Member."Signing Instructions" := MemberApplication."Signing Instructions";
        Member."Signing Instruction Narration" := MemberApplication."Signing Instruction narration";
        Member."Previous Sacco No." := MemberApplication."Previous Sacco No.";
        Member."Group Section" := MemberApplication."Group Section";
        Member."Account Category" := MemberApplication."Account Category";



        Member.Insert();

        MemberApplication.CalcFields(Signature, Picture);
        ImageData.Init;
        ImageData."Member No." := Member."No.";
        ImageData.Picture := MemberApplication.Picture;
        ImageData.Signature := MemberApplication.Signature;
        ImageData.Insert(true);


        /*
        IF MemberApplication.Picture.HASVALUE THEN BEGIN
            CLEAR(MemberApplication.Picture);
            MemberApplication.MODIFY;
        END;
        
        IF MemberApplication.Signature.HASVALUE THEN BEGIN
            CLEAR(MemberApplication.Signature);
            MemberApplication.MODIFY;
        END;
        */


        NextOfKinApp.Reset;
        NextOfKinApp.SetRange(NextOfKinApp."No.", MemberApplication."No.");
        if NextOfKinApp.Find('-') then begin
            repeat
                NextOfKin.Init;
                NextOfKin."No." := Member."No.";
                NextOfKin."ID No." := NextOfKinApp."ID No.";
                NextOfKin.Name := UpperCase(NextOfKinApp.Name);
                NextOfKin.Relationship := NextOfKinApp.Relationship;
                NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                NextOfKin."Mobile Phone No." := NextOfKinApp."Mobile Phone No.";
                NextOfKin.Email := NextOfKinApp.Email;
                NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                NextOfKin.Spouse := NextOfKinApp.Spouse;
                NextOfKin.Insert;
            until NextOfKinApp.Next = 0;
        end;



        NomineeApp.Reset;
        NomineeApp.SetRange(NomineeApp."No.", MemberApplication."No.");
        if NomineeApp.Find('-') then begin
            repeat
                Nominee.Init;
                Nominee."No." := Member."No.";
                Nominee."ID No." := NomineeApp."ID No.";
                Nominee.Name := UpperCase(NomineeApp.Name);
                Nominee.Relationship := NomineeApp.Relationship;
                Nominee.Beneficiary := NomineeApp.Beneficiary;
                Nominee."Date of Birth" := NomineeApp."Date of Birth";
                Nominee."Mobile Phone No." := NomineeApp."Mobile Phone No.";
                Nominee.Email := NomineeApp.Email;
                Nominee."%Allocation" := NomineeApp."%Allocation";
                Nominee.Spouse := NomineeApp.Spouse;
                Nominee.Insert;
            until NomineeApp.Next = 0;
        end;


        SignatoryApp.Reset;
        SignatoryApp.SetRange(SignatoryApp.Code, MemberApplication."No.");
        if SignatoryApp.Find('-') then begin
            repeat
                Signatory.Init;
                Signatory.Code := Member."No.";
                Signatory."Member No." := SignatoryApp."Member No.";
                Signatory."ID No." := SignatoryApp."ID No.";
                Signatory.Name := UpperCase(SignatoryApp.Name);
                Signatory."Date Of Birth" := SignatoryApp."Date Of Birth";
                Signatory."Staff/Payroll" := SignatoryApp."Staff/Payroll";
                //Signatory."Salesperson Code":=SignatoryApp."Salesperson Code";
                Signatory."Phone No." := SignatoryApp."Phone No.";
                Signatory.Signatory := SignatoryApp.Signatory;
                Signatory."Must Sign" := SignatoryApp."Must Sign";
                Signatory."Must be Present" := SignatoryApp."Must be Present";
                SignatoryApp.CalcFields(SignatoryApp.Signature, SignatoryApp.Picture);
                Signatory.Picture := SignatoryApp.Picture;
                Signatory.Signature := SignatoryApp.Signature;
                Signatory."Expiry Date" := SignatoryApp."Expiry Date";
                //Signatory."Mobile No.":=SignatoryApp."Mobile No.";
                Signatory.Type := Signatory.Type;
                Signatory.Insert;

                if SignatoryApp.Picture.Hasvalue then begin
                    Clear(SignatoryApp.Picture);
                    SignatoryApp.Modify;
                end;

                if SignatoryApp.Signature.Hasvalue then begin
                    Clear(SignatoryApp.Signature);
                    SignatoryApp.Modify;
                end;

            until SignatoryApp.Next = 0;
        end;


        DefaultSavingsProducts.Reset;
        DefaultSavingsProducts.SetRange(Code, MemberApplication."No.");
        if DefaultSavingsProducts.Find('-') then begin
            repeat
                if ProductSetup.Get(DefaultSavingsProducts.Product) then begin
                    ProductSetup.TestField("Product Posting Group");
                    CreateSavingsAccount(ProductSetup, Member, DefaultSavingsProducts."Monthly Contribution", false, DefaultSavingsProducts."Repay Mode");

                    //if MemberApplication."Signing Instruction narration" <> '' then begin

                    if ProductSetup."Product Category" = ProductSetup."Product Category"::"Ordinary Savings" then begin
                        MemberAccounts.Reset();
                        MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
                        MemberAccounts.SetRange("Member No.", Member."No.");
                        if MemberAccounts.FindFirst() then begin
                            MemberAccounts."Signing Instructions narration" := MemberApplication."Signing Instruction narration";
                            MemberAccounts."Signing Instructions" := MemberApplication."Signing Instructions";
                            MemberAccounts.Modify();
                        end;
                    end;

                    //end;
                end;
            until DefaultSavingsProducts.Next = 0;
        end;



        MemberApplication.Status := MemberApplication.Status::Created;
        MemberApplication.Modify;
        Commit;
        Msg := 'Dear ' + Member."First Name" + ', Welcome to ' + COMPANYNAME + '. Your Membership No. is ' + Member."No.";
        SendSms(Source::"New Member", Member."Mobile Phone No.", Msg, Member."No.", '', false, false);
        Commit;

        /* 
                if (SMTPSetup.Get) and (SenderAddress <> '') then begin
                    SenderAddress := SMTPSetup."User ID";
                    SenderName := COMPANYNAME;
                    SMTP.CreateMessage(SenderName, SenderAddress, Member."E-Mail", 'MEMBERSHIP: ' + COMPANYNAME, '', true);
                    SMTP.AppendBody('Dear ' + Member."First Name");
                    SMTP.AppendBody('<br><br>');
                    SMTP.AppendBody('A warm welcome and lots of good wishes on becoming part of our growing society.');
                    SMTP.AppendBody('<p>');
                    SMTP.AppendBody('Your SACCO Membership No. is <b>' + Member."No." + '</b>');
                    SMTP.AppendBody('<br><br>');
                    SMTP.AppendBody('Kind Regards,');
                    SMTP.AppendBody('<br>');
                    SMTP.AppendBody(COMPANYNAME);
                    SMTP.AppendBody('<br><br>');
                    SMTP.AppendBody('<hr>');
                    if SMTP.TrySend then;
                end;

         */
        Message('Member Created Successfuly: Member No - %1', Member."No.");

    end;


    procedure CreateSavingsAccount(ProductSetup: Record "Product Setup"; Cust: Record Customer; MonthlyCont: Decimal; SkipExisting: Boolean; RepayMode: Enum "Repay Mode Enum") AccountNo: Code[20]
    var
        Savings: Record Vendor;
        AccNo: Code[20];
        AccCount: Integer;
        AccCode: Code[10];

    begin
        if (ProductSetup."Account No. Prefix" = '') and (ProductSetup."Account No. Suffix" = '') then
            Error('Prefix or Suffix MUST be setup in the %1 "Product Setup".', ProductSetup.Description);


        AccountNo := '';

        AccNo := ProductSetup."Account No. Prefix" + Cust."No." + ProductSetup."Account No. Suffix";

        if Savings.Get(AccNo) then begin

            if ProductSetup."Allow Multiple Accounts" then begin
                AccCount := 0;
                Savings.Reset;
                Savings.SetRange("Member No.", Cust."No.");
                Savings.SetRange("Product Type", ProductSetup."Product ID");
                if Savings.FindFirst then
                    AccCount := Savings.Count;
                AccCount += 1;
                AccCode := Format(AccCount);
                if StrLen(AccCode) = 1 then
                    AccCode := '0' + AccCode;

                AccNo := AccNo + '-' + AccCode;
            end
            else
                if not SkipExisting then
                    Error('Account already Exists');
        end;


        if not Savings.Get(AccNo) then begin
            Savings.Init;
            Savings."No." := AccNo;
            Savings."Member No." := Cust."No.";
            Savings.Name := Cust.Name;
            Savings."Mobile Phone No." := Cust."Mobile Phone No.";
            Savings."Product Type" := ProductSetup."Product ID";
            Savings."Product Name" := ProductSetup.Description;
            Savings."Product Category" := ProductSetup."Product Category";
            Savings."Vendor Posting Group" := ProductSetup."Product Posting Group";
            Savings."Monthly Contribution" := MonthlyCont;
            Savings."Repay Mode" := RepayMode;

            Savings."Creditor Type" := Savings."Creditor type"::FOSA;
            Savings."Group No." := Cust."Group No.";
            Savings.Insert;
        end;

        AccountNo := Savings."No.";
    end;


    procedure SendSms(Source: Enum "SMS Source Enum"; Telephone: Text[200]; Textsms: Text[250]; Reference: Text[30]; AccNo: Text[30]; Chargeable: Boolean; LoanPenalty: Boolean)
    var
        Sms: Record "SMS Messages";
        Member: Record Customer;
        MemberSMS: Record "Member SMS";
        SkipSMS: Boolean;
    begin

        //Subs.RESET;

        SkipSMS := false;
        if (Source <> Source::"Loan Rejected") and (Source <> Source::"Loan Bill Due") then begin
            Member.Reset;
            Member.SetRange("Mobile Phone No.", Telephone);
            if Member.Find('-') then begin
                MemberSMS.Reset;
                MemberSMS.SetRange("Member No", Member."No.");
                MemberSMS.SetRange(Source, Source);
                if MemberSMS.FindFirst then begin
                    SkipSMS := true;
                end;
            end;
        end;

        if not SkipSMS then begin

            Sms.Init;
            //Sms."SMS ID" := CREATEGUID;
            Sms.Source := Source;
            Sms."Mobile Phone No." := Replacestring(Telephone, '-', '+');
            Sms."Date Entered" := Today;
            Sms."Time Entered" := Time;
            Sms."Entered By" := UserId;
            Sms."SMS Message" := Textsms;

            if ((StrLen(Telephone) >= 9) and (StrLen(Telephone) <= 13)) then begin
                Sms."Sent To Server" := Sms."sent to server"::No;
            end else begin
                Sms."Sent To Server" := Sms."sent to server"::Failed;
            end;

            Sms."Document No" := Reference;
            Sms."Account No" := AccNo;
            Sms.IsChargeable := Chargeable;
            Sms."Post to Loan Penalty" := LoanPenalty;
            Sms.Posted := false;
            Sms.Insert;



            //SkyMbanking.SendSms(Source, Telephone, Textsms, Reference, AccNo, Chargeable, 230, Chargeable);
        end;
    end;


    procedure Replacestring(string: Text[200]; findwhat: Text[30]; replacewith: Text[200]) Newstring: Text[200]
    begin
        while StrPos(string, findwhat) > 0 do
            string := DelStr(string, StrPos(string, findwhat)) + replacewith + CopyStr(string, StrPos(string, findwhat) + StrLen(findwhat));
        Newstring := string;
    end;


    procedure GetMemberCommittedDeposits(DepositAccount: Code[20]; ActiveLoan: Boolean): Decimal
    var
        Cust: Record Customer;
        PFact: Record "Product Setup";
        Savings: Record Vendor;
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        CommittedAmount: Decimal;
    begin

        CommittedAmount := 0;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Guarantor);
        LoanSecurity.SetRange("Account No.", DepositAccount);

        LoanSecurity.SetRange(Substituted, false);
        //LoanSecurity.SETRANGE("Defaulter Release",FALSE);
        //LoanSecurity.SETFILTER("Amount Guaranteed",'>0');

        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        if LoanSecurity.Find('-') then begin
            repeat
                LoanSecurity.CalcFields("Outstanding Principal");
                //MESSAGE('T - %1\%2',LoanSecurity."Outstanding Principal",LoanSecurity."Loan No.");
                if ActiveLoan then
                    CommittedAmount += LoanSecurity."Current Committed"
                else begin
                    LRec.Reset;
                    LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                    LRec.SetFilter(Status, '<>%1&<>%2', LRec.Status::Deffered, LRec.Status::Rejected);
                    LRec.SetRange(Posted, false);
                    if LRec.FindFirst then
                        CommittedAmount += LoanSecurity."Current Committed";
                end;
            until LoanSecurity.Next = 0;
        end;

        //MESSAGE(DepositAccount);
        //IF DepositAccount = '0030006779' THEN
        //MESSAGE('%1',CommittedAmount);


        exit(CommittedAmount);
    end;


    procedure GetCommittedCollateral(CollateralRegNo: Code[20]; ActiveLoan: Boolean): Decimal
    var
        Cust: Record Customer;
        PFact: Record "Product Setup";
        Savings: Record Vendor;
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        CommittedAmount: Decimal;
    begin

        CommittedAmount := 0;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Collateral);
        LoanSecurity.SetRange("Collateral Reg. No.", CollateralRegNo);
        LoanSecurity.SetRange(Substituted, false);
        //LoanSecurity.SETRANGE("Defaulter Release",FALSE);
        LoanSecurity.SetFilter("Amount Guaranteed", '>0');

        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        if LoanSecurity.Find('-') then begin
            repeat
                if ActiveLoan then
                    CommittedAmount += LoanSecurity."Current Committed"
                else begin
                    LRec.Reset;
                    LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                    LRec.SetFilter(Status, '<>%1&<>%2', LRec.Status::Deffered, LRec.Status::Rejected);
                    LRec.SetRange(Posted, false);
                    if LRec.FindFirst then
                        CommittedAmount += LoanSecurity."Current Committed";
                end;
            until LoanSecurity.Next = 0;
        end;

        exit(CommittedAmount);
    end;


    procedure GetMemberCommittedLien(LienAccount: Code[20]; ActiveLoan: Boolean): Decimal
    var
        Cust: Record Customer;
        PFact: Record "Product Setup";
        Savings: Record Vendor;
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        CommittedAmount: Decimal;
    begin

        CommittedAmount := 0;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Lien);
        LoanSecurity.SetRange("Account No.", LienAccount);
        LoanSecurity.SetRange(Substituted, false);
        //LoanSecurity.SETRANGE("Defaulter Release",FALSE);
        //LoanSecurity.SETRANGE("Loan Top Up",FALSE);
        LoanSecurity.SetFilter("Amount Guaranteed", '>0');

        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        if LoanSecurity.Find('-') then begin
            repeat
                if ActiveLoan then
                    CommittedAmount += LoanSecurity."Current Committed"
                else begin
                    LRec.Reset;
                    LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                    LRec.SetFilter(Status, '<>%1&<>%2', LRec.Status::Deffered, LRec.Status::Rejected);
                    LRec.SetRange(Posted, false);
                    if LRec.FindFirst then
                        CommittedAmount += LoanSecurity."Current Committed";
                end;
            until LoanSecurity.Next = 0;
        end;

        exit(CommittedAmount);
    end;


    procedure SetLoanAppraisal(LoanNo: Code[20])
    var
        ProdFact: Record "Product Setup";
        Loans: Record Loans;
        Appraisal: Record "Loan Appraisal";
        Savings: Record Vendor;
        LRec: Record Loans;
        LBal: Decimal;
        LSecurity: Record "Loan Security";
        LGuarAmount: Decimal;
        TopUp: Record "Loan Top Up";
        ChargeExtraComms: Boolean;
        PCharges: Record "Loan Product Charges.";
        TopUpComms: Decimal;
        Amt: Decimal;
        GenSetup: Record "General Ledger Setup";
        AppraisalSal: Record "Appraisal Salary Details";
        TBasic: Decimal;
        TEarning: Decimal;
        TAllowance: Decimal;
        TClearedEffects: Decimal;
        TDeductions: Decimal;
        ExternalEff: Record "General Ledger Setup";
        ExternalCharges: Decimal;
        OCharges: Record "General Ledger Setup";
        OtherCharges: Decimal;
        DepDiff: Decimal;
        PVA: Decimal;
        Duty: Decimal;
        TBoost: Decimal;
        BoostComm: Decimal;
        LCharges: Record "General Ledger Setup";
        TCurrBonus: Decimal;
        TPrevBonus: Decimal;
        LoanType: Record "Product Setup";
        LProduct: Record "Product Setup";
        TJunior: Decimal;
        TopUpApproved: Decimal;
        Micro: Boolean;
        ShareCapBoost: Decimal;
        NoCharge: Boolean;
        ChgAmt: Decimal;
        Reverse: Decimal;
        ProductCharge: Decimal;
        PrincIntQual: Decimal;
        RecomAppraisal: Decimal;
        Loantypes: Record "Product Setup";
        LoanRecord: Record Loans;
        MainLoan: Record Loans;
        MainProduct: Record "Product Setup";
        StaggeredLines: Record "Staggered Lines.";
        SLedger: Record "Vendor Ledger Entry";
        LCheck: Record "Loan Appraisal Check";
        PChAmt: Decimal;
        GL: Code[20];
        EDuty: Decimal;
        OtherClearance: Record "Other Committments Clearance";
        STOHeader: Record "Standing Order Header";
    begin

        GenSetup.Get;
        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNo);
        Loans.SetRange(Posted, false);
        if Loans.FindFirst then begin

            Appraisal.Reset;
            Appraisal.SetRange("Loan No.", Loans."Loan No.");
            if Appraisal.FindFirst then
                Appraisal.Delete;

            with Loans do begin
                LoanType.Get("Loan Product Type");

                TBoost := 0;

                IF "Loan Calculator" then begin

                    LCheck.Init();
                    LCheck."Member No." := "Member No.";
                    LCheck."Member Name" := "Member Name";
                    LCheck.Date := Today;
                    LCheck."Requested Amount" := "Requested Amount";

                end;




                Appraisal.Init;
                Appraisal."Loan No." := "Loan No.";
                Appraisal."Member No." := "Member No.";
                Appraisal."Loan Disbursement Account" := "Disbursement Account No";
                Appraisal.Name := "Member Name";
                Appraisal."Product Code" := "Loan Product Type";
                Appraisal."Requested Amount" := "Requested Amount";
                Appraisal."Approved Amount" := "Approved Amount";
                Appraisal."Registration Fee" := "Registration Fee";

                ProdFact.Reset;
                ProdFact.SetRange("Product Category", ProdFact."product category"::"Deposit Contribution");
                if ProdFact.FindFirst then begin
                    Savings.Reset;
                    Savings.SetRange("Member No.", "Member No.");
                    Savings.SetRange("Product Type", ProdFact."Product ID");
                    if Savings.FindFirst then begin
                        Savings.CalcFields("Balance (LCY)");
                        Appraisal."Bosa Deposits" := Savings."Balance (LCY)";

                        SLedger.Reset();
                        SLedger.SetRange("Vendor No.", Savings."No.");
                        SLedger.SetFilter("Amount (LCY)", '<0');
                        SLedger.SetRange(Reversed, false);
                        if SLedger.FindLast() then begin
                            SLedger.CalcFields("Amount (LCY)");
                            Appraisal."Last Deposit Amount" := SLedger."Amount (LCY)" * -1;
                            Appraisal."Last Deposit Date" := SLedger."Posting Date";
                        end;

                    end;
                end;

                Appraisal."STO Deduction" := 0;

                if LoanType."Appraisal Include STO Ded." then begin
                    STOHeader.Reset();
                    STOHeader.SetRange("Member No.", Loans."Member No.");
                    STOHeader.setfilter("Income Type", '%1|%2', STOHeader."Income Type"::Salary, STOHeader."Income Type"::Pension);
                    STOHeader.SetRange(Status, STOHeader.Status::Approved);
                    STOHeader.SetRange("Source Account No.", Loans."Disbursement Account No");
                    if STOHeader.FindFirst() then begin
                        repeat
                        //Appraisal."STO Deduction" += STOHeader.Amount;
                        until STOHeader.Next() = 0;
                    end;
                end;

                ProdFact.Reset;
                ProdFact.SetRange("Product Category", ProdFact."product category"::"Micro Member Deposit");
                if ProdFact.FindFirst then begin
                    Savings.Reset;
                    Savings.SetRange("Member No.", "Member No.");
                    Savings.SetRange("Product Type", ProdFact."Product ID");
                    if Savings.FindFirst then begin
                        Savings.CalcFields("Balance (LCY)");
                        Appraisal."Micro Deposits" := Savings."Balance (LCY)";
                    end;
                end;

                Appraisal."Total Deposits" := Appraisal."Bosa Deposits" + Appraisal."Class B Deposits" + Appraisal."Micro Deposits";

                LBal := 0;
                LRec.Reset;
                LRec.SetRange("Member No.", "Member No.");
                LRec.SetFilter("Outstanding Principal", '>0');
                if LRec.Find('-') then begin
                    repeat
                        LRec.CalcFields("Outstanding Principal", "Outstanding Interest");
                        LBal += LRec."Outstanding Principal" + LRec."Outstanding Interest";
                    until LRec.Next = 0;
                end;
                Appraisal."Current Loan Balance" := LBal;

                Appraisal.Installments := Installments;

                Appraisal."No. of Guarantors" := 0;
                LGuarAmount := 0;
                LSecurity.Reset;
                LSecurity.SetRange("Loan No.", "Loan No.");
                if LSecurity.Find('-') then begin
                    repeat
                        LGuarAmount += LSecurity."Amount Guaranteed";
                        Appraisal."No. of Guarantors" += 1;
                    until LSecurity.Next = 0;
                end;
                Appraisal."Amount Guaranteed" := LGuarAmount;

                //xxx
                Appraisal."Salary Through Fosa" := false;


                ProdFact.Reset;
                ProdFact.SetRange("Product Category", ProdFact."product category"::"Share Capital");
                if ProdFact.FindFirst then begin
                    Savings.Reset;
                    Savings.SetRange("Member No.", "Member No.");
                    Savings.SetRange("Product Type", ProdFact."Product ID");
                    if Savings.FindFirst then begin
                        Savings.CalcFields("Balance (LCY)");
                        Appraisal."Share Capital" := Savings."Balance (LCY)";
                    end;
                    Appraisal."Minimum Share Capital" := ProdFact."Minimum Contribution";
                end;

                Appraisal."Activity Code" := "Global Dimension 1 Code";
                Appraisal."Branch Code" := "Booking Branch";


                Appraisal."Previous Contribution" := 0;
                ProdFact.Reset;
                ProdFact.SetRange("Product Category", ProdFact."product category"::"Deposit Contribution");
                if ProdFact.FindFirst then begin
                    Savings.Reset;
                    Savings.SetRange("Member No.", "Member No.");
                    Savings.SetRange("Product Type", ProdFact."Product ID");
                    Savings.SetFilter("Date Filter", '%1..%2', CalcDate('-1M-CM', "Application Date"), CalcDate('-1M+CM', "Application Date"));
                    if Savings.FindFirst then begin
                        //MESSAGE(Savings.GETFILTER("Date Filter"));
                        Savings.CalcFields("Balance (LCY)");
                        Appraisal."Previous Contribution" := Savings."Balance (LCY)";
                    end;
                end;



                if LoanType."Loan Source" = LoanType."loan source"::MICRO then
                    Appraisal.Deposits := Appraisal."Micro Deposits"
                else
                    Appraisal.Deposits := Appraisal."Bosa Deposits";



                LBal := 0;
                LRec.Reset;
                LRec.SetRange("Member No.", "Member No.");
                LRec.SetFilter("Outstanding Principal", '>0');
                if LRec.Find('-') then begin
                    repeat
                        LRec.CalcFields("Outstanding Principal", "Outstanding Interest");
                        LBal += LRec."Outstanding Principal";

                    until LRec.Next = 0;
                end;
                Appraisal."Loan Outstanding" := LBal;



                Appraisal."Exisiting Loan Repayment" := 0;
                // IF LoanType."Appraisal-Check Repayments" THEN BEGIN
                LRec.Reset;
                LRec.SetRange("Member No.", "Member No.");
                LRec.SetFilter("Outstanding Principal", '>0');
                if LRec.Find('-') then begin
                    repeat
                        LRec.CalcFields("Outstanding Principal");
                        TopUp.Reset;
                        TopUp.SetRange("Loan Top Up", LRec."Loan No.");
                        TopUp.SetFilter("Principle Top Up", '>0');
                        if TopUp.Find('-') then begin
                            repeat
                                Appraisal."Exisiting Loan Repayment" += LRec."Loan Principle Repayment";
                            until TopUp.Next = 0;
                        end;
                    until LRec.Next = 0;
                end;
                //END;


                Appraisal."Committed Deposits" := 0;
                LRec.Reset;
                LRec.SetRange("Member No.", "Member No.");
                LRec.SetFilter("Outstanding Principal", '>0');
                LRec.SetRange(Source, Loans.Source);
                if LRec.Find('-') then begin
                    repeat

                        LRec.CalcFields("Outstanding Principal");
                        TopUp.Reset;
                        TopUp.SetRange("Loan Top Up", LRec."Loan No.");
                        TopUp.SetFilter("Principle Top Up", '>0');
                        if not TopUp.Find('-') then begin
                            repeat
                                LProduct.Get(LRec."Loan Product Type");

                                if LProduct."Deposit Multiplier" > 0 then
                                    Appraisal."Committed Deposits" += ROUND(LRec."Approved Amount" / Appraisal.Multiplier, 0.01, '>')

                            until TopUp.Next = 0;
                        end;
                    until LRec.Next = 0;
                end;
                Appraisal."Available Deposits" := Appraisal.Deposits - Appraisal."Committed Deposits";

                if Appraisal."Available Deposits" < 0 then
                    Appraisal."Available Deposits" := 0;

                Appraisal."Deposit Multiplier" := (Appraisal."Available Deposits") * LoanType."Deposit Multiplier";
                Appraisal.Multiplier := LoanType."Deposit Multiplier";
                if "Deposit Multiplier" > 0 then
                    Appraisal."Deposit Multiplier" := "Deposit Multiplier";



                Duty := 0;
                TopUpApproved := 0;

                //Toatl top ups
                TopUp.Reset;
                TopUp.SetRange("Loan No.", "Loan No.");
                TopUp.SetRange("Member No.", "Member No.");
                if TopUp.Find('-') then begin
                    TopUpComms := 0;
                    repeat
                        Appraisal."Principle Top Up" += TopUp."Principle Top Up";
                        Appraisal."Top Up Penalty" += TopUp."Penalty Top Up";
                        Appraisal."Top Up Appraisal" += TopUp."Appraisal Top Up";
                        Appraisal."Interest Top Up" += TopUp."Interest Top Up";
                        Appraisal."Top Up Commission" += TopUp.Commision;

                    until TopUp.Next = 0;
                end;



                Appraisal."Maximum Credit" := Appraisal."Deposit Multiplier";

                Appraisal."Current Share Capital" := Appraisal."Share Capital";
                Appraisal."Deficit Share Capital" := Appraisal."Minimum Share Capital" - Appraisal."Current Share Capital";

                if Appraisal."Deficit Share Capital" < 0 then
                    Appraisal."Deficit Share Capital" := 0;


                ShareCapBoost := 0;
                Appraisal."Share Financing" := 0;



                //Income Analysis
                //Qualification on salary
                TBasic := 0;
                TEarning := 0;
                TAllowance := 0;
                TClearedEffects := 0;
                TDeductions := 0;
                TCurrBonus := 0;
                TPrevBonus := 0;
                TJunior := 0;
                AppraisalSal.Reset;
                AppraisalSal.SetRange("Loan No", "Loan No.");
                if AppraisalSal.Find('-') then begin
                    repeat
                        if AppraisalSal.Type = AppraisalSal.Type::Basic then
                            TBasic := TBasic + AppraisalSal.Amount
                        else
                            if AppraisalSal.Type = AppraisalSal.Type::Earnings then
                                TEarning := TEarning + AppraisalSal.Amount
                            else
                                if AppraisalSal.Type = AppraisalSal.Type::"Other Allowances" then
                                    TAllowance := TAllowance + AppraisalSal.Amount
                                else
                                    if AppraisalSal.Type = AppraisalSal.Type::"House Allowance" then
                                        TAllowance := TAllowance + AppraisalSal.Amount
                                    else
                                        if AppraisalSal.Type = AppraisalSal.Type::"Commuter Allowance" then
                                            TAllowance := TAllowance + AppraisalSal.Amount
                                        else
                                            if AppraisalSal.Type = AppraisalSal.Type::"Bosa Deductions" then
                                                TDeductions := TDeductions + AppraisalSal.Amount
                                            else
                                                if AppraisalSal.Type = AppraisalSal.Type::"Cleared Effects" then
                                                    TClearedEffects := TClearedEffects + AppraisalSal.Amount
                                                else
                                                    if AppraisalSal.Type = AppraisalSal.Type::Deductions then
                                                        TDeductions := TDeductions + AppraisalSal.Amount
                                                    else
                                                        if AppraisalSal.Type = AppraisalSal.Type::Junior then
                                                            TJunior := TJunior + AppraisalSal.Amount
                                                        else
                                                            if AppraisalSal.Type = AppraisalSal.Type::"Current Bonus" then
                                                                TCurrBonus := TCurrBonus + AppraisalSal.Amount
                                                            else
                                                                if AppraisalSal.Type = AppraisalSal.Type::"Previous Bonus" then
                                                                    TPrevBonus := TPrevBonus + AppraisalSal.Amount;





                        if AppraisalSal.Type = AppraisalSal.Type::Basic then
                            LCheck.Basic := LCheck.Basic + AppraisalSal.Amount
                        else
                            if AppraisalSal.Type = AppraisalSal.Type::"Other Allowances" then
                                LCheck."Other Allowances" := LCheck."Other Allowances" + AppraisalSal.Amount
                            else
                                if AppraisalSal.Type = AppraisalSal.Type::"House Allowance" then
                                    LCheck."House Allowance" := LCheck."House Allowance" + AppraisalSal.Amount
                                else
                                    if AppraisalSal.Type = AppraisalSal.Type::"Commuter Allowance" then
                                        LCheck."Commuter Allowance" := LCheck."Commuter Allowance" + AppraisalSal.Amount
                                    else
                                        if AppraisalSal.Type = AppraisalSal.Type::"Bosa Deductions" then
                                            LCheck."Sacco Bosa Deductions" := LCheck."Sacco Bosa Deductions" + AppraisalSal.Amount


                    until AppraisalSal.Next = 0;
                end;
                TCurrBonus -= TDeductions;

                //MESSAGE('%1',TBasic);

                Appraisal."Average Income" := TBasic;

                if LoanType."Appraisal Parameter Type" = LoanType."appraisal parameter type"::Bonus then begin
                    if LoanType."Appraised on Expected Bonus" then begin
                        Appraisal."Average Income" := TCurrBonus;
                        Appraisal."Outstanding Tea Bills" := 0;
                        LRec.Reset;
                        LRec.SetRange("Member No.", "Member No.");
                        LRec.SetFilter("Outstanding Principal", '>0');
                        //LRec.SETFILTER("Outstanding Bills",'>0');
                        if LRec.Find('-') then begin
                            repeat
                                LProduct.Get(LRec."Loan Product Type");
                                if LProduct."Repay Mode" = LProduct."repay mode"::Tea then begin
                                    //LRec.CALCFIELDS("Outstanding Bills","Outstanding Interest");
                                    //Appraisal."Outstanding Tea Bills"+=("Outstanding Bills"+"Outstanding Interest");
                                end;
                                if LRec."Loan Product Type" = 'MSINGI' then begin
                                    if LRec."Loan Principle Repayment" = 0 then
                                        LRec."Loan Principle Repayment" := ROUND(LRec."Approved Amount" / LRec.Installments, 0.01, '>');
                                    Appraisal."Outstanding Tea Bills" += LRec."Loan Principle Repayment";
                                end;
                            until LRec.Next = 0;
                        end;
                        Appraisal."Outstanding Tea Bills" += Loans."Loan Principle Repayment";
                    end
                    else
                        Appraisal."Average Income" := TPrevBonus;
                end;


                if LoanType."Appraisal Parameter Type" = LoanType."appraisal parameter type"::Junior then begin
                    Appraisal."Average Income" := TJunior;
                end;

                Appraisal.Earnings := TEarning;
                Appraisal.Allowances := TAllowance;
                Appraisal.Deductions := TDeductions;
                Appraisal."Net Salary" := Appraisal."Average Income" + Appraisal.Earnings + Appraisal.Allowances - Appraisal.Deductions - Appraisal."STO Deduction";
                Appraisal."2/3 of Average Income" := ROUND(2 / 3 * Appraisal."Net Salary");
                Appraisal."1/3 of Average Income" := ROUND(1 / 3 * Appraisal."Net Salary");
                //MESSAGE('Appraisal."2/3 of Average Income" %1 (Appraisal."Net Salary" %2);',Appraisal."2/3 of Average Income",Appraisal."Net Salary");


                Appraisal."Adjusted Net" := Appraisal."Net Salary" + Appraisal."External Effects";

                Appraisal."Current Loan Repayment" := Repayment;

                Appraisal."Total Charges" := Appraisal."Top Up Commission" + Appraisal."External Commitment Commission";

                //MESSAGE('%1',Appraisal."Total Charges");



                Appraisal."Qualification as Per Guarantor" := Appraisal."Amount Guaranteed";

                PVA := Installments;


                if "Annual Interest %" = 0 then begin
                    PVA := (Installments * 100) / ((Installments * 12 / 12) + 100);
                end
                else begin
                    if "Interest Calculation Method" = "interest calculation method"::Amortised then
                        PVA := ((1 - Power((1 + ("Annual Interest %" / 1200)), -Installments)) / (Loans."Annual Interest %" / 1200))
                    else
                        PVA := (Installments * 100) / ((Installments * ("Annual Interest %" / 12)) + 100);
                end;


                RecomAppraisal := 0;
                PrincIntQual := ROUND((Appraisal."2/3 of Average Income" - Appraisal."Exisiting Loan Repayment") * PVA, 1, '<');
                //RecomAppraisal :=GetAppraisalFee(PrincIntQual);

                Appraisal."Qualification as Per Income" := ROUND((Appraisal."2/3 of Average Income" - Appraisal."Exisiting Loan Repayment" - RecomAppraisal) * PVA, 1, '<');

                if LoanType."Appraisal Parameter Type" = LoanType."appraisal parameter type"::KGs then
                    Appraisal."Qualification as Per Income" := ROUND(Appraisal."Net Salary", 1, '<');


                if LoanType."Appraisal Parameter Type" = LoanType."appraisal parameter type"::"Staff Salary" then
                    Appraisal."Qualification as Per Income" := ROUND(Appraisal."2/3 of Average Income" * 200 * (Installments / (200 + Installments + 1)), 1, '<');





                if LoanType."Appraisal Parameter Type" = LoanType."appraisal parameter type"::Bonus then begin
                    if LoanType."Appraised on Expected Bonus" then begin
                        Appraisal."Rate on Expected Bonus" := LoanType."Appraisal % on Amount";
                        Appraisal."Qualification as Per Income" := (Appraisal."Average Income" - Appraisal."Outstanding Tea Bills") * LoanType."Appraisal % on Amount" / 100;
                    end;
                end;
                if LoanType."Appraisal Parameter Type" = LoanType."appraisal parameter type"::Junior then begin
                    Appraisal."Rate on Expected Bonus" := LoanType."Appraisal % on Amount";
                    Appraisal."Qualification as Per Income" := (Appraisal."Average Income") * LoanType."Appraisal % on Amount";
                end;


                Appraisal."Qualification As Per Deposits" := Appraisal."Maximum Credit";

                ProductCharge := 0;
                Duty := 0;

                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
                PCharges.SetRange("Posting Type", PCharges."Posting Type"::"Deduct From Net Payable");
                if PCharges.Find('-') then begin
                    repeat
                        PChAmt := 0;
                        GL := '';
                        EDuty := 0;
                        GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", "Approved Amount", PChAmt, EDuty, GL);
                        ProductCharge += PChAmt;
                        Duty += EDuty;
                    until PCharges.Next = 0;

                end;



                //Appraisal."Total Charges"+=OtherCharges;
                Appraisal."Total Charges" += ProductCharge;

                Appraisal."New Total Repayment" := 0;
                LRec.Reset;
                LRec.SetRange("Member No.", "Member No.");
                LRec.SetFilter("Outstanding Principal", '>0');
                if LRec.FindFirst then begin
                    repeat
                        TopUp.Reset;
                        TopUp.SetRange("Loan No.", "Loan No.");
                        TopUp.SetRange("Member No.", "Member No.");
                        TopUp.SetRange("Loan Top Up", LRec."Loan No.");
                        if not TopUp.Find('-') then begin
                            LRec.CalcFields("Outstanding Appraisal", "Outstanding Penalty", "Outstanding Interest", "Outstanding Principal");
                            if LRec."Outstanding Principal" < 0 then
                                LRec."Outstanding Principal" := 0;
                            if LRec."Outstanding Appraisal" < 0 then
                                LRec."Outstanding Appraisal" := 0;

                            if LRec."Outstanding Appraisal" > 0 then
                                if LRec."Outstanding Appraisal" > LRec."Appraisal Fee" then
                                    LRec."Outstanding Appraisal" := LRec."Appraisal Fee";

                            Appraisal."New Total Repayment" += (LRec."Outstanding Appraisal" +
                                      LRec."Outstanding Principal" +
                                      LRec."Outstanding Interest" +
                                      LRec."Outstanding Penalty");

                        end;
                    until LRec.Next = 0;
                end;
                Appraisal."New Total Repayment" += Repayment;




                Appraisal."Recommended Amount" := Appraisal."Requested Amount";


                if LoanType."Appraise Salary" then begin
                    if Appraisal."Recommended Amount" > Appraisal."Qualification as Per Income" then
                        Appraisal."Recommended Amount" := Appraisal."Qualification as Per Income";
                end;


                if LoanType."Appraise Deposits" then begin
                    if Appraisal."Qualification As Per Deposits" < 0 then
                        Appraisal."Qualification As Per Deposits" := 0;

                    if LoanType."Deposit Multiplier" > 0 then begin
                        if Appraisal."Recommended Amount" > Appraisal."Qualification As Per Deposits" then
                            Appraisal."Recommended Amount" := Appraisal."Qualification As Per Deposits";
                    end;
                end;

                if LoanType."Appraise Security" then begin
                    if (LoanType."Minimum Guarantors" > 0) and (LoanType."Guarantorship Type" = LoanType."guarantorship type"::Amount) then begin
                        if Appraisal."Recommended Amount" > Appraisal."Qualification as Per Guarantor" then
                            Appraisal."Recommended Amount" := Appraisal."Qualification as Per Guarantor";
                    end;
                end;


                Appraisal."External Commitment" := 0;
                OtherClearance.Reset();
                OtherClearance.SetRange("Loan Application No.", Loans."Loan No.");
                if OtherClearance.FindFirst() then begin
                    repeat
                        Appraisal."External Commitment" += OtherClearance.Amount;
                    until OtherClearance.Next() = 0;
                end;



                Appraisal."Excise Duty" := Duty;
                Appraisal."Net Take Home" := Appraisal."Approved Amount" -
                (Appraisal."Registration Fee" + Appraisal."Total Financing" + Appraisal."Principle Top Up" + Appraisal."Interest Top Up" + Appraisal."Top Up Appraisal" + Appraisal."Top Up Penalty"
                + Appraisal."External Commitment" + Appraisal."Total Charges" + Duty);

                //MESSAGE('Appraisal."Approved Amount": %1 \Appraisal."Total Financing": %2 \Appraisal."Principle Top Up": %3 \Appraisal."Interest Top Up"  %4\ Appraisal."Total Charges": %5 \Duty: %6);',
                //      Appraisal."Approved Amount",Appraisal."Total Financing",Appraisal."Principle Top Up",Appraisal."Interest Top Up",Appraisal."Total Charges",Duty);

                "Recommended Amount" := Appraisal."Recommended Amount";
                Validate("Approved Amount", "Recommended Amount");
                Modify;
                Appraisal.Insert;
            end;

        end;
    end;


    procedure GetAccountBalance(AcctNo: Code[20]): Decimal
    var
        SavingsAccounts: Record Vendor;
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Customer;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        if SavingsAccounts.Find('-') then begin


            if ProductFactory.Get(SavingsAccounts."Product Type") then
                MinBal := ProductFactory."Minimum Account Balance";
            ;



            Members.Get(SavingsAccounts."Member No.");
            if Emp.Get(Members."Employer Code") then
                if Emp."Dont Charge Transactions" then
                    MinBal := 0;


            SavingsAccounts.CalcFields("Balance (LCY)", "Uncleared Cheques", "Authorised Over Draft", "Lien Placed" /*"Mobile Withdrawals","ATM Transactions","Lien Guaranteed"*/);

            Bal := SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft"
                  //- SavingsAccounts."Mobile Withdrawals"
                  - SavingsAccounts."Uncleared Cheques"
                  - SavingsAccounts."Lien Placed"
                  - MinBal;


            /*
            Bal:=(SavingsAccounts."Balance (LCY)"{+SavingsAccounts."Authorised Over Draft"})-
                  SavingsAccounts."Yetu ATM Transactions"-ProductFactory."Minimum Balance"-SavingsAccounts."Uncleared Cheques"-
                  SavingsAccounts."Lien Placed"-SavingsAccounts."ATM Transactions"-SavingsAccounts."Lien Guaranteed";
                  */

        end;
        exit(Bal);

    end;

    procedure GetAccountBalanceWithoutMinAccBalance(AcctNo: Code[20]): Decimal
    var
        SavingsAccounts: Record Vendor;
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Customer;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        if SavingsAccounts.Find('-') then begin


            if ProductFactory.Get(SavingsAccounts."Product Type") then;


            MinBal := 0;
            ;



            Members.Get(SavingsAccounts."Member No.");
            if Emp.Get(Members."Employer Code") then
                if Emp."Dont Charge Transactions" then
                    MinBal := 0;


            SavingsAccounts.CalcFields("Balance (LCY)", "Uncleared Cheques", "Authorised Over Draft", "Lien Placed" /*"Mobile Withdrawals","ATM Transactions","Lien Guaranteed"*/);

            Bal := SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft"
                  //- SavingsAccounts."Mobile Withdrawals"
                  - SavingsAccounts."Uncleared Cheques"
                  - SavingsAccounts."Lien Placed"
                  - MinBal;


            /*
            Bal:=(SavingsAccounts."Balance (LCY)"{+SavingsAccounts."Authorised Over Draft"})-
                  SavingsAccounts."Yetu ATM Transactions"-ProductFactory."Minimum Balance"-SavingsAccounts."Uncleared Cheques"-
                  SavingsAccounts."Lien Placed"-SavingsAccounts."ATM Transactions"-SavingsAccounts."Lien Guaranteed";
                  */

        end;
        exit(Bal);

    end;

    procedure GetAccountBookBalance(AcctNo: Code[20]): Decimal
    var
        SavingsAccounts: Record Vendor;
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Customer;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        if SavingsAccounts.Find('-') then begin


            SavingsAccounts.CalcFields("Balance (LCY)");

            Bal := SavingsAccounts."Balance (LCY)";


        end;
        exit(Bal);

    end;


    procedure GetLoanChargeAmount(LoanCode: Code[20]; ChargeCode: Code[20]; ChargeType: Option General,"Top up","External Loan","Deposit Financing","Share Capital","Share Financing","Deposit Financing on Maximum","External Payment to Vendor",Rescheduling; Value: Decimal; var ChargeAmt: Decimal; var Duty: Decimal; var ChargeGL: Code[20])
    var
        PCharges: Record "Loan Product Charges.";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
    begin

        GenSetup.Get;
        Duty := 0;
        ChargeAmt := 0;
        ChargeGL := '';

        PCharges.Reset;
        PCharges.SetRange("Product Code", LoanCode);
        PCharges.SetRange("Charge Code", ChargeCode);
        //PCharges.SETRANGE("Charge Type",ChargeType);
        if PCharges.Find('-') then begin

            PCharges.TestField("Account No.");

            ChargeGL := PCharges."Account No.";

            if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                Amt := (Value * (PCharges.Percentage / 100))
            else
                if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                    Amt := PCharges."Charge Amount"
                else
                    if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                        PCharges.TestField(PCharges."Staggered Charge Code");

                        StaggeredLines.Reset;
                        StaggeredLines.SetRange(StaggeredLines.Code, PCharges."Staggered Charge Code");
                        if StaggeredLines.Find('-') then begin
                            repeat
                                if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                                    if StaggeredLines."Use Percentage" = true then
                                        Amt := Value * StaggeredLines.Percentage * 0.01
                                    else
                                        Amt := StaggeredLines."Charge Amount";
                                end;
                            until StaggeredLines.Next = 0;
                        end;

                    end;

            if PCharges.Minimum > 0 then
                if Amt < PCharges.Minimum then
                    Amt := PCharges.Minimum;
            if PCharges.Maximum > 0 then
                if Amt > PCharges.Maximum then
                    Amt := PCharges.Maximum;

            ChargeAmt := Amt;
            if ChargeAmt < 0 then
                ChargeAmt := 0;

            if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                Duty := ChargeAmt * GenSetup."Excise Duty (%)" * 0.01;
            end;

        end
        else
            Error('Charge not Found under this product');
    end;


    procedure Base64Logo() Base64: Text
    var
        CompanyInfo: Record "Company Information";
    begin
        Base64 := '';
        CompanyInfo.Get;

        CompanyInfo.CalcFields(Picture);
    end;


    procedure Base64Header() Base64: Text
    var
        CompanyInfo: Record "Company Information";
    begin
    end;


    procedure Base64Footer() Base64: Text
    var
        CompanyInfo: Record "Company Information";
    begin
        Base64 := '';
    end;


    /*procedure CreateMemberAccount(AccountApp: Record "Member Accounts Application")
    var
        Member: Record Customer;
        ImageData: Record "Member Images";
        NextOfKin: Record "Next of Kin.";
        NextOfKinApp: Record "Next of Kin.";
        Savings: Record Vendor;
        ProductSetup: Record "Product Setup";
        Msg: Text;
        SenderName: Text;
        SenderAddress: Text;
        Signatory: Record "Account Signatories.";
        SignatoryApp: Record "Account Signatories.";
        AccountNo: Code[20];
    begin


        Member.Get(AccountApp."Member No.");

        ProductSetup.Get(AccountApp."Product Type");
        AccountNo := CreateSavingsAccount(ProductSetup, Member, AccountApp."Monthly Contribution", false, AccountApp."Repay Mode");




        if AccountNo = '' then
            Error('Account Could not be created. Contact System Admin');

        if ProductSetup."Product Category" = ProductSetup."product category"::"Junior Savings" then begin
            Savings.Get(AccountNo);
            Savings."Child Birth Cet. No." := AccountApp."Child Birth Cet. No.";
            Savings."Child Date Of Birth" := AccountApp."Child Date Of Birth";
            Savings."Child Name" := AccountApp."Child Name";
            Savings.Name := UpperCase(Savings."Child Name");
            Savings.Modify;
        end;

        Savings.Get(AccountNo);
        Savings."Signing Instructions" := AccountApp."Signing Instructions";
        Savings."Signing Instructions Narration" := AccountApp."Signing Instruction Narration";
        Savings.Modify();



        SignatoryApp.Reset;
        SignatoryApp.SetRange(SignatoryApp.Code, AccountApp."No.");
        if SignatoryApp.Find('-') then begin
            repeat
                Signatory.Init;
                Signatory.Code := AccountNo;
                Signatory.Name := UpperCase(SignatoryApp.Name);
                Signatory."Date Of Birth" := SignatoryApp."Date Of Birth";
                Signatory."Staff/Payroll" := SignatoryApp."Staff/Payroll";
                //Signatory."Salesperson Code":=SignatoryApp."Salesperson Code";
                Signatory."Phone No." := SignatoryApp."Phone No.";
                Signatory.Signatory := SignatoryApp.Signatory;
                Signatory."Must Sign" := SignatoryApp."Must Sign";
                Signatory."Must be Present" := SignatoryApp."Must be Present";
                SignatoryApp.CalcFields(SignatoryApp.Signature, SignatoryApp.Picture);
                Signatory.Picture := SignatoryApp.Picture;
                Signatory.Signature := SignatoryApp.Signature;
                Signatory."Expiry Date" := SignatoryApp."Expiry Date";
                Signatory.Type := SignatoryApp.Type;
                Signatory.Insert;

                if SignatoryApp.Picture.Hasvalue then begin
                    Clear(SignatoryApp.Signature);
                    SignatoryApp.Modify;
                end;

                if SignatoryApp.Signature.Hasvalue then begin
                    Clear(SignatoryApp.Signature);
                    SignatoryApp.Modify;
                end;
            until SignatoryApp.Next = 0;
        end;






        AccountApp.Status := AccountApp.Status::Created;
        AccountApp.Modify;
        Commit;

        Msg := 'Dear ' + Member."First Name" + ', Your ' + ProductSetup.Description + ' has been created successfully. Your Account No. is ' + AccountNo;
        SendSms(Source::"New Member", Member."Mobile Phone No.", Msg, Member."No.", '', false, false);
        Commit;

        /* 
        if SMTPSetup.Get then begin
            SenderAddress := SMTPSetup."User ID";
            SenderName := COMPANYNAME;

            if SaccoActivities.ValidEmailAddress(SenderAddress) then begin

                SMTP.CreateMessage(SenderName, SenderAddress, Member."E-Mail", 'ACCOUNT OPENING: ' + COMPANYNAME, '', true);
                SMTP.AppendBody('Dear ' + Member."First Name");
                SMTP.AppendBody('<br><br>');
                SMTP.AppendBody('A warm welcome and lots of good wishes on opening a new savings product.');
                SMTP.AppendBody('<p>');
                SMTP.AppendBody('Your ' + ProductSetup.Description + ' Account No. is <b>' + AccountNo + '</b>');
                SMTP.AppendBody('<br><br>');
                SMTP.AppendBody('Kind Regards,');
                SMTP.AppendBody('<br>');
                SMTP.AppendBody(COMPANYNAME);
                SMTP.AppendBody('<br><br>');
                SMTP.AppendBody('<hr>');
                if SMTP.TrySend then;
            end;
        end;
 
        Message('Account Created Successfuly: Account No - %1', AccountNo);
    end;*/


    procedure GetGeneral_SharingChargeAmount(ChargeCode: Code[20]; Value: Decimal; var ChargeAmt: Decimal; var ChargeDuty: Decimal; var ChargeAcctType: Enum "Gen. Journal Account Type"; var ChargeAcct: Code[20]; var SharingAmt: Decimal; var SharingDuty: Decimal; var SharingChargeAcctType: Enum "Gen. Journal Account Type"; var SharingChargeAcct: Code[20])
    var
        ChargesLines: Record "Transaction Charges Lines";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
    begin

        GenSetup.Get;
        ChargeAmt := 0;
        ChargeAcct := '';
        ChargeDuty := 0;


        SharingAmt := 0;
        SharingChargeAcct := '';
        SharingDuty := 0;

        ChargesLines.Reset;
        ChargesLines.SetRange("Transaction Type", ChargeCode);
        if ChargesLines.Find('-') then begin


            ChargeAmount := 0;
            if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" = true then
                ChargeAmount := (Value * ChargesLines."Percentage of Amount") * 0.01
            else
                ChargeAmount := ChargesLines."Charge Amount";

            if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                ChargesLines.TestField("Staggered Charge Code");

                StaggeredLines.Reset;
                StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                if StaggeredLines.Find('-') then begin
                    repeat
                        if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                            if StaggeredLines."Use Percentage" = true then begin
                                ChargeAmount := Value * StaggeredLines.Percentage * 0.01;
                            end
                            else begin
                                ChargeAmount := StaggeredLines."Charge Amount";
                            end;
                        end;
                    until StaggeredLines.Next = 0;
                end;
            end;

            ChargeAmt := ChargeAmount;
            ChargeAcct := ChargesLines."Charge Account";
            ChargeAcctType := ChargesLines."Charge Account Type";

            //MESSAGE('%1\%2',ChargeAmt,Value);

            if ChargesLines."Minimum Amount" > 0 then
                if ChargeAmt < ChargesLines."Minimum Amount" then
                    ChargeAmt := ChargesLines."Minimum Amount";

            if ChargesLines."Maximum Amount" > 0 then
                if ChargeAmt > ChargesLines."Maximum Amount" then
                    ChargeAmt := ChargesLines."Maximum Amount";


            if ChargeAmt > 0 then
                ChargesLines.TestField("Charge Account");

            if ChargesLines."Sharing Value" > 0 then begin

                SharingChargeAcctType := ChargesLines."Sharing Account Type";
                SharingChargeAcct := ChargesLines."Sharing Account No.";

                if ChargesLines."Sharing Use Percentage" then
                    SharingAmt := ChargesLines."Sharing Value" / 100 * ChargeAmount
                else
                    SharingAmt := ChargesLines."Sharing Value";

                if ChargeAmt < SharingAmt then
                    Error('Sharing Charge Cannot be Greater than Charge Amount in Transaction Charge: %1', ChargesLines."Transaction Type")
                else begin
                    ChargeAmt -= SharingAmt;

                end;

                if ChargesLines."Sharing Excise Duty" then
                    SharingDuty := (SharingAmt * GenSetup."Excise Duty (%)" * 0.01);

            end;


            if ChargesLines."Charge Excise Duty" then
                ChargeDuty := ChargeAmt * GenSetup."Excise Duty (%)" * 0.01;



        end;
    end;


    procedure FirstName(FullName: Text[100]) FName: Text[100]
    var
        Pos: Integer;
        Separator: Text[1];
    begin
        FName := FullName;

        Pos := StrPos(FullName, ' ');

        if Pos > 0 then begin
            FName := CopyStr(FullName, 1, Pos - 1);
        end;
    end;


    procedure GetGeneralChargeAmount(ChargeCode: Code[20]; Value: Decimal; var ChargeAmt: Decimal; var ChargeDuty: Decimal; var ChargeAcctType: Enum "Gen. Journal Account Type"; var ChargeAcct: Code[20])
    var
        ChargesLines: Record "Transaction Charges Lines";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
    begin

        GenSetup.Get;
        ChargeAmt := 0;
        ChargeAcct := '';
        ChargeDuty := 0;


        ChargesLines.Reset;
        ChargesLines.SetRange("Transaction Type", ChargeCode);
        if ChargesLines.Find('-') then begin



            ChargeAmount := 0;
            if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" = true then
                ChargeAmount := (Value * ChargesLines."Percentage of Amount") * 0.01
            else
                ChargeAmount := ChargesLines."Charge Amount";

            if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                ChargesLines.TestField("Staggered Charge Code");

                StaggeredLines.Reset;
                StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                if StaggeredLines.Find('-') then begin
                    repeat
                        if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                            if StaggeredLines."Use Percentage" = true then begin
                                ChargeAmount := Value * StaggeredLines.Percentage * 0.01;
                            end
                            else begin
                                ChargeAmount := StaggeredLines."Charge Amount";
                            end;
                        end;
                    until StaggeredLines.Next = 0;
                end;
            end;

            ChargeAmt := ChargeAmount;
            ChargeAcct := ChargesLines."Charge Account";
            ChargeAcctType := ChargesLines."Charge Account Type";


            if ChargesLines."Minimum Amount" > 0 then
                if ChargeAmt < ChargesLines."Minimum Amount" then
                    ChargeAmt := ChargesLines."Minimum Amount";

            if ChargesLines."Maximum Amount" > 0 then
                if ChargeAmt > ChargesLines."Maximum Amount" then
                    ChargeAmt := ChargesLines."Maximum Amount";


            if ChargeAmt > 0 then
                ChargesLines.TestField("Charge Account");

            if ChargesLines."Charge Excise Duty" then
                ChargeDuty := ChargeAmt * GenSetup."Excise Duty (%)" * 0.01;


        end;
    end;


    procedure IsDefaulter(MemberNo: Code[20]): Boolean
    var
        Loans: Record Loans;
    begin


        Loans.Reset;
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetFilter("Outstanding Principal", '>0');
        Loans.SetFilter("Loans Category-SASRA", '<>%1&<>%2', Loans."loans category-sasra"::Perfoming, Loans."loans category-sasra"::Watch);
        if Loans.FindFirst then
            exit(true);

        exit(false);
    end;



    procedure getDividendRate(DividendsSimulationHeader: Record "Dividend Simulation Header"): Boolean
    var
        DividendCalculationBuffer: Record "Dividend Simulation Lines";
        ProductFactory: Record "Product Setup";
        CustomerPostingGroup: Record "Vendor Posting Group";
        DividendAccount: Code[20];
    begin

        DividendCalculationBuffer.RESET;
        DividendCalculationBuffer.SETRANGE(DividendCalculationBuffer."Document No.", DividendsSimulationHeader."No.");
        IF DividendCalculationBuffer.FINDSET THEN
            DividendCalculationBuffer.DELETEALL;

        IF DividendsSimulationHeader."All Products" THEN BEGIN
            ProductFactory.RESET;
            ProductFactory.SETFILTER("Dividend Calc. Method", '<>%1', ProductFactory."Dividend Calc. Method"::" ");
            IF ProductFactory.FIND('-') THEN BEGIN
                REPEAT
                    ProductFactory.TESTFIELD("Interest Rate (Min.)");
                    IF CustomerPostingGroup.GET(ProductFactory."Product Posting Group") THEN
                        getSavingsContribution(DividendsSimulationHeader."Start Date", DividendsSimulationHeader."End Date", CustomerPostingGroup."Payables Account", 12, '1',
                                            ProductFactory."Product ID", DividendsSimulationHeader."No.", ProductFactory."Interest Rate (Min.)");
                UNTIL ProductFactory.NEXT = 0;
            END;

        END
        ELSE BEGIN
            DividendsSimulationHeader.TESTFIELD(Rate);
            getSavingsContribution(DividendsSimulationHeader."Start Date", DividendsSimulationHeader."End Date", DividendsSimulationHeader."G/L Account", 12, '1',
                                DividendsSimulationHeader."Product Type", DividendsSimulationHeader."No.", DividendsSimulationHeader.Rate);
        END;
    end;



    procedure getSavingsContribution(StartDate: Date; EndDate: Date; DividendAccount: Code[20]; CalculationPeriod: Integer; SimulationNo: Code[20]; ProductType: Code[10]; DocumentNo: Code[10]; DivRate: Decimal)
    var
        DividendCalculationBuffer: Record "Dividend Simulation Lines";
        ProductFactory: Record "Product Setup";
        CustomerPostingGroup: Record "Vendor Posting Group";
        GLAccount: Record "G/L Account";
        i: Integer;
        LineNo: Integer;
        x: Integer;
    begin

        ProductFactory.GET(ProductType);

        DividendCalculationBuffer.RESET;
        LineNo := DividendCalculationBuffer.COUNT;

        IF ProductFactory."Dividend Calc. Method" = ProductFactory."Dividend Calc. Method"::Prorated THEN BEGIN

            x := CalculationPeriod;
            FOR i := CalculationPeriod DOWNTO 1 DO BEGIN
                GLAccount.RESET;
                LineNo += 1;
                IF i = 12 THEN BEGIN
                    EndDate := CALCDATE('-1D', StartDate);
                    GLAccount.SETRANGE(GLAccount."Date Filter", 0D, EndDate);
                END
                ELSE
                    GLAccount.SETRANGE(GLAccount."Date Filter", StartDate, EndDate);

                GLAccount.SETRANGE(GLAccount."No.", DividendAccount);
                IF GLAccount.FINDFIRST THEN
                    GLAccount.CALCFIELDS(GLAccount."Net Change");

                WITH DividendCalculationBuffer DO BEGIN
                    INIT;
                    "No." := SimulationNo;
                    "Entry No" := LineNo;
                    "G/L Account" := DividendAccount;
                    IF i <> 12 THEN
                        "Start Date" := StartDate;
                    "End Date" := EndDate;
                    Amount := ABS(GLAccount."Net Change");
                    "Weighted Amount" := Amount * (i / CalculationPeriod);
                    Rate := DivRate;
                    "Pay Out" := ROUND(Rate / 100 * "Weighted Amount", 0.01, '=');
                    "W/Tax" := ROUND(ProductFactory."WithHolding Tax" / 100 * "Pay Out", 0.01, '=');
                    "Net Pay" := "Pay Out" - "W/Tax";
                    "Product Type" := ProductType;
                    "Document No." := DocumentNo;
                    INSERT;
                END;

                StartDate := CALCDATE('1M-CM', StartDate);
                EndDate := CALCDATE('CM', StartDate);
            END;
        END;


        IF ProductFactory."Dividend Calc. Method" = ProductFactory."Dividend Calc. Method"::"Flat Rate" THEN BEGIN

            LineNo += 1;

            GLAccount.RESET;
            GLAccount.SETRANGE(GLAccount."Date Filter", 0D, EndDate);
            GLAccount.SETRANGE(GLAccount."No.", DividendAccount);
            IF GLAccount.FINDFIRST THEN
                GLAccount.CALCFIELDS(GLAccount."Net Change");

            WITH DividendCalculationBuffer DO BEGIN
                INIT;

                "No." := SimulationNo;
                "Entry No" := LineNo;
                "G/L Account" := DividendAccount;
                "Start Date" := StartDate;
                "End Date" := EndDate;
                Amount := ABS(GLAccount."Net Change");
                "Weighted Amount" := Amount;
                Rate := DivRate;
                "Pay Out" := ROUND(Rate / 100 * "Weighted Amount", 0.01, '=');
                "W/Tax" := ROUND(ProductFactory."WithHolding Tax" / 100 * "Pay Out", 0.01, '=');
                "Net Pay" := "Pay Out" - "W/Tax";
                "Product Type" := ProductType;
                "Document No." := DocumentNo;
                INSERT;
            END;
        END;

    end;


    procedure GetMemberCommittedDeposits_NRS(DepositAccount: Code[20]; ActiveLoan: Boolean; Loanee: Code[20]): Decimal
    var
        Cust: Record Customer;
        PFact: Record "Product Setup";
        Savings: Record Vendor;
        LRec: Record Loans;
        LoanSecurity: Record "Loan Security";
        CommittedAmount: Decimal;
        CommittedOnAppliedLoans: Decimal;
    begin

        CommittedOnAppliedLoans := 0;

        LRec.Reset;
        LRec.SetRange("Member No.", Loanee);
        LRec.SetFilter("Outstanding Principal", '>0');
        LRec.SetRange(Source, LRec.Source::BOSA);
        if LRec.FindFirst then begin
            repeat
                PFact.Get(LRec."Loan Product Type");
                PFact.TestField("Deposit Multiplier");
                LRec.CalcFields("Outstanding Principal");
                CommittedOnAppliedLoans += ROUND(LRec."Outstanding Principal" / PFact."Deposit Multiplier");
            until LRec.Next = 0;
        end;

        CommittedAmount := 0;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."guarantor type"::Guarantor);
        LoanSecurity.SetRange("Account No.", DepositAccount);
        LoanSecurity.SetRange(Substituted, false);
        //LoanSecurity.SETRANGE("Defaulter Release",FALSE);
        LoanSecurity.SetFilter("Amount Guaranteed", '>0');
        if ActiveLoan then
            LoanSecurity.SetFilter("Outstanding Principal", '>0')
        else
            LoanSecurity.SetFilter("Outstanding Principal", '<=0');

        if LoanSecurity.Find('-') then begin
            repeat
                if ActiveLoan then
                    CommittedAmount += LoanSecurity."Current Committed"
                else begin
                    LRec.Reset;
                    LRec.SetRange("Loan No.", LoanSecurity."Loan No.");
                    LRec.SetFilter(Status, '<>%1&<>%2', LRec.Status::Deffered, LRec.Status::Rejected);
                    LRec.SetRange(Posted, false);
                    if LRec.FindFirst then
                        CommittedAmount += LoanSecurity."Current Committed";
                end;
            until LoanSecurity.Next = 0;
        end;

        exit(CommittedAmount + CommittedOnAppliedLoans);
    end;



    procedure UpdateDormantMembers(PeriodFilter: Date; AccNo: Code[20])
    var
        ProductFactory: Record "Product Setup";
        DormancyPeriod: DateFormula;
        Members: Record Customer;
        SavingsAccounts: Record Vendor;
        SA: Record Vendor;
        LastTransDate: Date;
        k: Integer;
        Msg: Text;
        MemberActicities: Codeunit "Member Activities";
        Source: Enum "SMS Source Enum";
        SMS: Record "SMS Messages";
    begin

        if PeriodFilter = 0D then
            PeriodFilter := Today;


        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AccNo);
        SavingsAccounts.SetFilter(Status, '%1|%2', SavingsAccounts.Status::Active, SavingsAccounts.Status::Dormant);
        if SavingsAccounts.FindFirst then
            with SavingsAccounts do begin


                Members.Get(SavingsAccounts."Member No.");

                CalcFields("Last Transaction Date");



                if "Product Category" = "product category"::"Deposit Contribution" then
                    if "Last Transaction Date" = Dmy2date(10, 4, 2021) then
                        "Last Transaction Date" := Members."Last Deposit Date BF";


                if "Last Transaction Date" = 0D then
                    "Last Transaction Date" := Members."Registration Date";



                if "Last Transaction Date" <> 0D then begin
                    ProductFactory.Reset;
                    ProductFactory.SetFilter("Product ID", "Product Type");
                    ProductFactory.SetFilter(ProductFactory."Dormancy Period", '<>%1', DormancyPeriod);
                    if ProductFactory.Find('-') then begin

                        if CalcDate(ProductFactory."Dormancy Period", "Last Transaction Date") < PeriodFilter then begin
                            if Status = Status::Active then begin
                                Status := Status::Dormant;
                                Blocked := Blocked::Payment;
                                Modify;
                            end;
                            if "Product Category" = "Product Category"::"Deposit Contribution" then begin
                                if Members."Member Status" = Members."Member Status"::Active then begin
                                    Members."Member Status" := Members."Member Status"::Dormant;
                                    Members.Modify;
                                end;
                            end;
                        end else begin
                            if Status = Status::Dormant then begin
                                Status := Status::Active;
                                Blocked := Blocked::" ";
                                Modify;
                            end;

                            if "Product Category" = "Product Category"::"Deposit Contribution" then begin
                                if Members."Member Status" = Members."Member Status"::Dormant then begin
                                    Members."Member Status" := Members."Member Status"::Active;
                                    Members.Modify;
                                end;
                            end;
                        end;
                    end;

                    ProductFactory.Reset;
                    ProductFactory.SetFilter("Product ID", "Product Type");
                    ProductFactory.SetFilter(ProductFactory."Dormancy Period Notification", '<>%1', DormancyPeriod);
                    if ProductFactory.Find('-') then begin

                        if (CalcDate(ProductFactory."Dormancy Period", "Last Transaction Date") > PeriodFilter) and (CalcDate(ProductFactory."Dormancy Period Notification", "Last Transaction Date") < PeriodFilter) then begin
                            if Status = Status::Active then begin
                                //Msg := 'Dear ' + SkyMbanking.FirstName(Members.Name) + ' Please note that your ' + ProductFactory.Description + ' account will become dormant on ' + format(CalcDate(ProductFactory."Dormancy Period", "Last Transaction Date")) + '. ';
                                sms.Reset();
                                sms.SetRange("SMS Message", Msg);
                                sms.SetRange("Mobile Phone No.", Members."Mobile Phone No.");
                                if not sms.FindFirst() then begin
                                    MemberActicities.SendSms(Source::"Account Dormancy", Members."Mobile Phone No.", Msg, Members."No.", '', false, false);
                                end;


                            end;
                        end;
                    end;
                end;

            end;

    end;


    procedure GetAccountBalanceByDate(AcctNo: Code[20]; AsAt: Date): Decimal
    var
        SavingsAccounts: Record Vendor;
        ProductFactory: Record "Product Setup";
        Bal: Decimal;
        Members: Record Customer;
        Emp: Record Customer;
    begin

        Bal := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("No.", AcctNo);
        SavingsAccounts.SetFilter("Date Filter", '..%1', AsAt);
        if SavingsAccounts.Find('-') then begin


            if ProductFactory.Get(SavingsAccounts."Product Type") then
                MinBal := ProductFactory."Minimum Account Balance";
            ;



            Members.Get(SavingsAccounts."Member No.");
            if Emp.Get(Members."Employer Code") then
                if Emp."Dont Charge Transactions" then
                    MinBal := 0;


            SavingsAccounts.CalcFields("Balance (LCY)", "Uncleared Cheques", "Authorised Over Draft"/*,"ATM Transactions","Lien Placed","Lien Guaranteed"*/);

            Bal := SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft"
                  - SavingsAccounts."Uncleared Cheques"
                  - MinBal;


            /*
            Bal:=(SavingsAccounts."Balance (LCY)"{+SavingsAccounts."Authorised Over Draft"})-
                  SavingsAccounts."Yetu ATM Transactions"-ProductFactory."Minimum Balance"-SavingsAccounts."Uncleared Cheques"-
                  SavingsAccounts."Lien Placed"-SavingsAccounts."ATM Transactions"-SavingsAccounts."Lien Guaranteed";
                  */

        end;
        exit(Bal);

    end;


    procedure GetGeneralChargeAmountWithCounter(ChargeCode: Code[20]; Value: Decimal; var ChargeAmt: Decimal; var ChargeDuty: Decimal; var ChargeAcctType: Enum "Gen. Journal Account Type"; var ChargeAcct: Code[20]; var Counter: Integer; var Lines: Integer; var Desc: Text)
    var
        ChargesLines: Record "Transaction Charges Lines";
        Amt: Decimal;
        StaggeredLines: Record "Staggered Lines.";
        ChargeAmount: Decimal;
        k: Integer;
    begin

        GenSetup.Get;
        ChargeAmt := 0;
        ChargeAcct := '';
        ChargeDuty := 0;
        Lines := 0;
        Desc := '';

        ChargesLines.Reset;
        ChargesLines.SetRange("Transaction Type", ChargeCode);
        if ChargesLines.Find('-') then begin
            k := 0;
            Lines := ChargesLines.Count;
            repeat
                k += 1;
                if Counter = k then begin

                    Desc := ChargesLines.Description;
                    ChargeAmount := 0;
                    if ChargesLines."Charge Type" = ChargesLines."charge type"::"% of Amount" = true then
                        ChargeAmount := (Value * ChargesLines."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := ChargesLines."Charge Amount";

                    if ChargesLines."Charge Type" = ChargesLines."charge type"::Staggered then begin

                        ChargesLines.TestField("Staggered Charge Code");

                        StaggeredLines.Reset;
                        StaggeredLines.SetRange(Code, ChargesLines."Staggered Charge Code");
                        if StaggeredLines.Find('-') then begin
                            repeat

                                if (Value >= StaggeredLines."Lower Limit") and (Value <= StaggeredLines."Upper Limit") then begin
                                    if StaggeredLines."Use Percentage" = true then begin
                                        ChargeAmount := Value * StaggeredLines.Percentage * 0.01;
                                    end
                                    else begin
                                        ChargeAmount := StaggeredLines."Charge Amount";
                                    end;
                                end;
                            until StaggeredLines.Next = 0;
                        end;
                    end;

                    ChargeAmt := ChargeAmount;
                    ChargeAcct := ChargesLines."Charge Account";
                    ChargeAcctType := ChargesLines."Charge Account Type";


                    if ChargesLines."Minimum Amount" > 0 then
                        if ChargeAmt < ChargesLines."Minimum Amount" then
                            ChargeAmt := ChargesLines."Minimum Amount";

                    if ChargesLines."Maximum Amount" > 0 then
                        if ChargeAmt > ChargesLines."Maximum Amount" then
                            ChargeAmt := ChargesLines."Maximum Amount";

                    ChargeAmt := ROUND(ChargeAmt, 0.01, '=');
                    if ChargeAmt > 0 then
                        ChargesLines.TestField("Charge Account");

                    if ChargesLines."Charge Excise Duty" then
                        ChargeDuty := ROUND(ChargeAmt * GenSetup."Excise Duty (%)" * 0.01, 0.01, '=');
                end;
            until ChargesLines.Next = 0;

        end;

        Counter += 1;
    end;


    procedure GenerateLoanStatementBuffer(LoanNo: Code[20]; MemberNo: Code[20]; ClearAll: Boolean)
    var
        CLedger: Record "Cust. Ledger Entry";
        Statement: Record "Loan Statement Buffer";
    begin
        CLedger.Reset();
        CLedger.SetRange("Loan No.", LoanNo);
        CLedger.SetRange("Member No.", MemberNo);
        if not ClearAll then
            CLedger.SetRange(Transfered, false);
        if CLedger.FindFirst() then begin
            repeat
                CLedger.calcfields(Amount);

                if ClearAll then begin



                    Statement.Reset();
                    Statement.SetRange("Entry No.", CLedger."Entry No.");
                    Statement.SetRange("Member No.", MemberNo);
                    Statement.SetRange("Loan No.", LoanNo);
                    if Statement.FindFirst() then begin
                        Statement.DeleteAll();
                    end;

                    CLedger.CalcFields(Amount);


                    Statement.Init();
                    Statement."Entry No." := CLedger."Entry No.";
                    Statement.Date := CLedger."Posting Date";
                    Statement."Loan No." := CLedger."Loan No.";
                    Statement."Member No." := CLedger."Customer No.";

                    if CLedger."Transaction Type" = CLedger."Transaction Type"::"Interest Due" then
                        Statement."Accrued Interest" := CLedger.Amount;
                    if CLedger."Transaction Type" = CLedger."Transaction Type"::"Interest Paid" then
                        Statement."Interest Paid" := CLedger.Amount * -1;
                    if CLedger."Transaction Type" = CLedger."Transaction Type"::"Principal Repayment" then
                        Statement."Principal Paid" := CLedger.Amount * -1;
                    if CLedger."Transaction Type" = CLedger."Transaction Type"::"Loan Disbursement" then
                        Statement."New Loan" := CLedger.Amount;

                    Statement."Total Paid" := Statement."Interest Paid" + Statement."Principal Paid";
                    Statement.Insert();
                    CLedger.Transfered := true;
                    CLedger.Modify();

                end
                else begin
                    Statement.Reset();
                    Statement.SetRange("Entry No.", CLedger."Entry No.");
                    Statement.SetRange("Member No.", MemberNo);
                    Statement.SetRange("Loan No.", LoanNo);
                    if not Statement.FindFirst() then begin
                        Statement.Init();
                        Statement."Entry No." := CLedger."Entry No.";
                        Statement.Date := CLedger."Posting Date";
                        Statement."Loan No." := CLedger."Loan No.";
                        Statement."Member No." := CLedger."Customer No.";

                        if CLedger."Transaction Type" = CLedger."Transaction Type"::"Interest Due" then
                            Statement."Accrued Interest" := CLedger.Amount;
                        if CLedger."Transaction Type" = CLedger."Transaction Type"::"Interest Paid" then
                            Statement."Interest Paid" := CLedger.Amount;
                        if CLedger."Transaction Type" = CLedger."Transaction Type"::"Principal Repayment" then
                            Statement."Principal Paid" := CLedger.Amount;
                        if CLedger."Transaction Type" = CLedger."Transaction Type"::"Loan Disbursement" then
                            Statement."New Loan" := CLedger.Amount;

                        Statement."Total Paid" := Statement."Interest Paid" + Statement."Principal Paid";
                        Statement.Insert();
                        CLedger.Transfered := true;
                        CLedger.Modify();
                    end;
                end;

            until CLedger.Next() = 0;
        end;
    end;

    procedure populateStatement(LoanNumber: Code[20]; MemberNo: Code[20])
    var
        myInt: Integer;
        MLedger: Record "Cust. Ledger Entry";
        StatementTable: Record "Statement Buffer";
        LineNo: Integer;
        LRec: Record Loans;
        IntDue: Decimal;
        IntPaid: Decimal;
    begin
        LineNo := 0;

        StatementTable.RESET;
        IF StatementTable.FINDLAST THEN
            LineNo := StatementTable.entryNo;


        StatementTable.RESET;
        StatementTable.SETRANGE("Loan No.", LoanNumber);
        IF StatementTable.FINDFIRST THEN
            StatementTable.DELETEALL;



        MLedger.RESET;
        MLedger.SETRANGE("Loan No.", LoanNumber);
        MLedger.SETRANGE("Customer No.", MemberNo);
        //MLedger.SETRANGE(Transferred,FALSE);
        MLedger.SETRANGE(Reversed, FALSE);
        //MLedger.SETFILTER("Document No.",'%1','<>@*R-*');
        IF MLedger.FINDFIRST THEN BEGIN
            REPEAT
                MLedger.CalcFields(Amount);
                LineNo += 1;
                StatementTable.INIT;
                StatementTable.entryNo := LineNo;
                StatementTable."Loan No." := LoanNumber;
                StatementTable."Posting Date" := MLedger."Posting Date";

                LRec.RESET;
                LRec.SETRANGE("Loan No.", MLedger."Loan No.");
                LRec.SETFILTER("Date filter", '..%1', CALCDATE('-1D', MLedger."Posting Date"));
                IF LRec.FINDFIRST THEN BEGIN
                    LRec.CALCFIELDS("Outstanding Principal");
                    StatementTable."Opening Balance" := LRec."Outstanding Principal";
                END;

                IF MLedger."Transaction Type" = MLedger."Transaction Type"::"Principal Repayment" THEN
                    StatementTable."Principal Paid" := MLedger.Amount * -1;

                IF MLedger."Transaction Type" = MLedger."Transaction Type"::"Interest Paid" THEN
                    StatementTable."Interest Paid" := MLedger.Amount * -1;

                StatementTable."Amount Paid" := StatementTable."Principal Paid" + StatementTable."Interest Paid";

                IntPaid := 0;

                IntDue := 0;
                LRec.RESET;
                LRec.SETRANGE("Loan No.", MLedger."Loan No.");
                LRec.SETFILTER("Date filter", '..%1', MLedger."Posting Date");
                IF LRec.FINDFIRST THEN BEGIN
                    LRec.CALCFIELDS("Outstanding Principal", "Interest Paid", "Interest Due");
                    StatementTable."Loan Balance" := LRec."Outstanding Principal";
                    IntPaid := LRec."Interest Paid";
                END;

                IF MLedger."Posting Date" >= DMY2DATE(1, 1, 2022) THEN BEGIN

                    LRec.RESET;
                    LRec.SETRANGE("Loan No.", MLedger."Loan No.");
                    LRec.SETFILTER("Date filter", '..%1', MLedger."Posting Date");
                    IF LRec.FINDFIRST THEN BEGIN
                        LRec.CALCFIELDS("Outstanding Principal", "Interest Paid", "Interest Due");
                        IntDue := LRec."Interest Due";
                    END;
                END
                ELSE BEGIN

                    LRec.RESET;
                    LRec.SETRANGE("Loan No.", MLedger."Loan No.");
                    LRec.SETFILTER("Date filter", '..%1', MLedger."Posting Date");
                    IF LRec.FINDFIRST THEN BEGIN
                        LRec.CALCFIELDS("Outstanding Principal", "Interest Paid", "Interest Due");
                        IntDue := LRec."Interest Due";
                    END;
                END;

                StatementTable."Interest Balance" := IntDue + IntPaid;

                IF MLedger."Posting Date" >= DMY2DATE(1, 1, 2022) THEN
                    IF MLedger."Transaction Type" = MLedger."Transaction Type"::"Interest Due" THEN
                        StatementTable."Interest Due" := MLedger.Amount;

                StatementTable."Receipt No" := MLedger."Document No.";
                StatementTable.ledgerEntry := MLedger."Entry No.";



                IF (MLedger."Transaction Type" <> MLedger."Transaction Type"::"Interest Due") THEN
                    StatementTable.INSERT
                ELSE
                    IF (MLedger."Posting Date" >= DMY2DATE(1, 1, 2022)) AND (MLedger."Transaction Type" = MLedger."Transaction Type"::"Interest Due") THEN
                        StatementTable.INSERT;

            UNTIL MLedger.NEXT = 0;

        END;
    end;



    procedure SendEmailNotification(Heading: text; SalutationTxt: Text; BodyTxt: text; RegardsTxt: Text; Receiver: Text; FilePath_Name: Text) Sent: Boolean;
    var
        myInt: Integer;


        CompanyInformation: Record "Company Information";
        Cust: Record Customer;
        FileManagement: Codeunit "File Management";
        SMTPSetup: Record "Email Account";
        SMTPMail: Codeunit "Email Message";

        SaccoSetup: Record "Sacco Setup";
        BodyMsg: Text;
        Base64: Text;
        EmailSend: Codeunit Email;
        //TempBlob: Record CustomTempBlob;
        MActivities: Codeunit "Member Activities";
        j: Integer;
    begin
        Sent := false;

        if FilePath_Name <> '' then begin
            if FILE.Exists(FilePath_Name) then
                FILE.Erase(FilePath_Name);


            //TempBlob.BLOBImportFromServerFile(TempBlob, FilePath_Name);
            //Base64 := Format(TempBlob.ToBase64String);

        end;

        BodyMsg := (SalutationTxt);
        BodyMsg += ('<br><br>');
        BodyMsg += (BodyTxt);
        BodyMsg += ('<br><br>');
        BodyMsg += (RegardsTxt);
        BodyMsg += ('<br>');
        BodyMsg += (COMPANYNAME);
        BodyMsg += ('<br><br>');
        BodyMsg += ('<HR>');

        SMTPMail.Create(Receiver, Heading, BodyMsg, true);

        if FilePath_Name <> '' then begin
            SMTPMail.AddAttachment(FilePath_Name, 'pdf', Base64);
            Sleep(2000);
        end;

        if EmailSend.Send(SMTPMail) then
            Sent := true;

        //Message('test');

        if FilePath_Name <> '' then
            if FILE.Exists(FilePath_Name) then
                FILE.Erase(FilePath_Name);
    end;

}