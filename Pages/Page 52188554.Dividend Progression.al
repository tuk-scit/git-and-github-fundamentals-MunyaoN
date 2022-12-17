
Page 52188554 "Dividend Progression"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Dividends Progression";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; "Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(ProcessingDate; "Processing Date")
                {
                    ApplicationArea = Basic;
                }
                field(DividendCalcMethod; "Dividend Calc. Method")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; "Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; "Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field(QualifyingShares; "Qualifying Shares")
                {
                    ApplicationArea = Basic;
                }
                field(Shares; Shares)
                {
                    ApplicationArea = Basic;
                }
                field(GrossDividends; "Gross Dividends")
                {
                    ApplicationArea = Basic;
                }
                field(WitholdingTax; "Witholding Tax")
                {
                    ApplicationArea = Basic;
                }
                field(NetDividends; "Net Dividends")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; "Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; "End Date")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentMode; "Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field(DividendAccount; "Dividend Account")
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
            action("Member Batching")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Member Batching";
            }
            action("Generate Dividends")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Dividend Generation";
            }

        }
    }

    var
        SaccoSetup: Record "Sacco Setup";
}

