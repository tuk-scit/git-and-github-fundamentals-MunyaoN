
Page 52188530 "Loan Security"
{
    PageType = List;
    SourceTable = "Loan Security";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(GuarantorType; "Guarantor Type")
                {
                    ApplicationArea = Basic;
                }

                field(AccountNo; "Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Customer;
                        Accounts: Record Vendor;
                    begin
                        "Account No." := '';
                        if "Guarantor Type" = "Guarantor Type"::Collateral then begin
                            Members.Reset();
                            Members.setfilter(type, '<>%1', Members.Type::" ");
                            if Page.RunModal(Page::"Member List", Members) = Action::LookupOK then
                                "Account No." := Members."No.";
                        end
                        else
                            if "Guarantor Type" = "Guarantor Type"::Guarantor then begin
                                Accounts.Reset();
                                Accounts.setfilter("Product Category", '%1|%2|%3', Accounts."Product Category"::"Deposit Contribution", Accounts."Product Category"::"Micro Member Deposit", Accounts."Product Category"::"Micro Group Deposit");
                                //if Page.RunModal(Page::"Member Accounts  List", Accounts) = Action::LookupOK then
                                    "Account No." := Accounts."No.";
                            end
                            else
                                if "Guarantor Type" = "Guarantor Type"::Lien then begin
                                    Accounts.Reset();
                                    Accounts.setfilter("Product Category", '<>%1&<>%2&<>%3', Accounts."Product Category"::"Deposit Contribution", Accounts."Product Category"::"Micro Member Deposit", Accounts."Product Category"::"Micro Group Deposit");
                                    //if Page.RunModal(Page::"Member Accounts  List", Accounts) = Action::LookupOK then
                                        "Account No." := Accounts."No.";
                                end;

                        Validate("Account No.");
                    end;
                }
                field(CollateralRegNo; "Collateral Reg. No.")
                {
                    ApplicationArea = Basic;
                }
                field(SecurityDetails; "Security Details")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(AvailableGuarantorship; "Available Guarantorship")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AmountGuaranteed; "Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCommitted; "Total Committed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CurrentCommitted; "Current Committed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Substituted; Substituted)
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; "Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
            group(Control20)
            {
                fixed(Control19)
                {
                    group(DepositsCollateralLimit)
                    {
                        Caption = 'Deposits/Collateral Limit';
                        field("Guarantor Details"; "Guarantor Deposits")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group(GuaranteedinApplication)
                    {
                        Caption = 'Guaranteed in Application';
                        field(ApplicationAmountGuaranteed; "Application Amount Guaranteed")
                        {
                            ApplicationArea = Basic;
                            Editable = false;
                        }
                    }
                    group(GuarantorDetails)
                    {
                        Caption = 'Total Guarantor Commitment';
                        field(TotalGuarantorCommitment; "Total Guarantor Commitment")
                        {
                            ApplicationArea = Basic;
                            Editable = false;
                        }
                    }
                }
            }
            group(Control12)
            {
                fixed(Control11)
                {
                    group(RequestedAmount)
                    {
                        Caption = 'Requested Amount';
                        field("Guarantorship Summary"; RequestedAmount)
                        {
                            ApplicationArea = Basic;
                            Editable = false;
                        }
                    }
                    group(TotalGuaranteed)
                    {
                        Caption = 'Total Guaranteed';
                        field(Control7; TotalGuaranteed)
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Guarantorship Balance")
                    {
                        Caption = 'Guarantorship Balance';
                        field(GuarantorshipBalance; GuarantorshipBalance)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Bal. Account Name';
                            Editable = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Suggest Micro Guarantors")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Loan: Record Loans;
                    Members: Record Customer;
                    Accounts: Record Vendor;
                begin
                    GCount := 0;
                    if Loan.Get("Loan No.") then begin
                        Message(Loan."Group Code");
                        if Loan."Group Code" <> '' then begin
                            Members.Reset;
                            Members.SetFilter("No.", '<>%1', Loan."Member No.");
                            Members.SetFilter("Group No.", Loan."Group Code");
                            if Members.FindFirst then begin

                                repeat
                                    Accounts.Reset;
                                    Accounts.SetRange("Group No.", Members."Group No.");
                                    Accounts.SetRange("Product Category", Accounts."product category"::"Micro Member Deposit");
                                    Accounts.SetFilter("Member No.", Members."No.");
                                    if Accounts.Find('-') then begin
                                        repeat
                                            GAmount := ROUND(Loan."Approved Amount" / Members.Count, 0.01, '>');
                                            LoanGua.Init;
                                            LoanGua."Loan No." := Loan."Loan No.";
                                            LoanGua.Validate("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                                            LoanGua.Validate("Account No.", Accounts."No.");
                                            if GAmount > LoanGua."Available Guarantorship" then
                                                GAmount := LoanGua."Available Guarantorship";
                                            LoanGua.Validate("Amount Guaranteed", GAmount);
                                            LoanGua.Insert(true);
                                            GCount += 1;
                                        until Accounts.Next = 0;
                                    end;
                                until Members.Next = 0;
                            end;
                        end;
                    end;
                    Message('%1 Accounts Added', GCount);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnAfterGetRecord()
    begin

        if Loan.Get("Loan No.") then begin
            if Loan.Posted then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;

        CalculateGuarantorshipSummary;
    end;

    trigger OnClosePage()
    begin

        if Loan.Get("Loan No.") then begin
            with Loan do begin
                MicroDef := '';

                if ProdFac.Get("Loan Product Type") then begin
                    if not "Self Guarantee" then
                        if ProdFac."Minimum Guarantors" > 0 then begin
                            LoanGua.Reset;
                            LoanGua.SetRange(LoanGua."Loan No.", "Loan No.");
                            LoanGua.SetFilter("Guarantor Type", '%1', LoanGua."guarantor type"::Guarantor);
                            if LoanGua.Find('-') then begin
                                repeat
                                    Loan.Reset;
                                    Loan.SetFilter("Outstanding Principal", '>0');
                                    Loan.SetRange("Member No.", LoanGua."Member No");
                                    Loan.SetFilter("Loans Category-SASRA", '<>%1&<>%2', Loan."loans category-sasra"::Perfoming, Loan."loans category-sasra"::Watch);
                                    if Loan.FindFirst then begin
                                        repeat
                                            MicroDef += '\ - ' + Loan."Member No." + ' - ' + Loan."Member Name" + '-' + Loan."Loan Product Type" + '-' + Format(Loan."Loans Category-SASRA");
                                        until Loan.Next = 0;
                                    end;
                                until LoanGua.Next = 0;
                            end;
                        end;
                end;

                if MicroDef <> '' then begin
                    Message('The following Guarantor(s) are Defaulters: \' + MicroDef);
                end;

            end;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnOpenPage()
    begin

        if Loan.Get("Loan No.") then begin
            if Loan.Posted then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;

        CalculateGuarantorshipSummary;
    end;

    var
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        CompInfo: Record "Company Information";
        TotalGuaranteed: Decimal;
        RequestedAmount: Decimal;
        ApprovedAmount: Decimal;
        GuarantorshipBalance: Decimal;
        GCount: Integer;
        GAmount: Decimal;
        MicroDef: Text;
        Loan: Record Loans;
        ProdFac: Record "Product Setup";
        LoanGua: Record "Loan Security";


    procedure CalculateGuarantorshipSummary()
    begin

        RequestedAmount := 0;
        ApprovedAmount := 0;
        TotalGuaranteed := 0;
        GuarantorshipBalance := 0;

        if Loan.Get("Loan No.") then begin
            RequestedAmount := Loan."Requested Amount";
            ApprovedAmount := Loan."Approved Amount";
        end;

        LoanGua.Reset;
        LoanGua.SetRange("Loan No.", "Loan No.");
        LoanGua.SetRange(Substituted, false);
        if LoanGua.Find('-') then begin
            repeat
                TotalGuaranteed += LoanGua."Amount Guaranteed";
            until LoanGua.Next = 0;
        end;

        GuarantorshipBalance := RequestedAmount - TotalGuaranteed;
    end;
}

