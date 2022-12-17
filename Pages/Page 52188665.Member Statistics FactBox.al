
Page 52188665 "Member Statistics FactBox"
{
    Caption = 'Member Statistics';
    PageType = CardPart;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(BalanceDetails)
            {
                Caption = 'Balance Details';
            }
            field(MemberNo; "No.")
            {
                ApplicationArea = Basic;
                Caption = 'Member No.';
            }
            field(Name; Name)
            {
                ApplicationArea = Basic;
            }
            group(ShareAnalysis)
            {
                Caption = 'Share Analysis';
                field("Share Capital"; ShareCap)
                {
                    ApplicationArea = Basic;
                }
                field(Deposits; Deposits)
                {
                    ApplicationArea = Basic;
                }
                field("Dividends/Interest on Deposits"; Dividend)
                {
                    ApplicationArea = Basic;
                }
                field("Current Guarantorship"; FreeShares)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ValidatePage;
    end;

    trigger OnOpenPage()
    begin

        ValidatePage;
    end;

    var
        Text000: label 'Overdue Amounts (LCY) as of %1';
        ProdType: Record "Product Setup";
        MinBalance: Decimal;
        Reg: Record "Member Images";
        MemberActivities: Codeunit "Member Activities";
        AvailBalance: Decimal;
        Deposits: Decimal;
        ShareCap: Decimal;
        FreeShares: Decimal;
        LoanSecurity: Record "Loan Security";
        MemberAccounts: Record Vendor;
        SaccoActivities: Codeunit "Sacco Activities";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Dividend: Decimal;
        Committed: Decimal;
        Available: Decimal;


    procedure ValidatePage()
    begin

        MemberAccounts.Reset;
        MemberAccounts.SetRange("Member No.", "No.");
        if MemberAccounts.FindFirst then begin
            repeat
                if MemberAccounts."Product Category" = MemberAccounts."product category"::"Deposit Contribution" then begin
                    Deposits := MemberActivities.GetAccountBalance(MemberAccounts."No.");

                    LoanSecurity.CalculateAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, Available);
                    FreeShares := Available;
                end;
                if MemberAccounts."Product Category" = MemberAccounts."product category"::"Share Capital" then
                    ShareCap := MemberActivities.GetAccountBalance(MemberAccounts."No.");

                if MemberAccounts."Product Category" = MemberAccounts."product category"::"Dividend Account" then
                    Dividend := MemberActivities.GetAccountBalance(MemberAccounts."No.");

            until MemberAccounts.Next = 0;
        end;
    end;
}

