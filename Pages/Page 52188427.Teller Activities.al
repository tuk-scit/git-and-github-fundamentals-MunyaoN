
Page 52188427 "Teller Activities"
{
    PageType = CardPart;
    SourceTable = "Sacco Cues";

    layout
    {
        area(content)
        {
            cuegroup(Teller)
            {
                Caption = 'Teller';
                field(CashierTransOpen; "Cashier Trans. - Open")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Style = Subordinate;
                    StyleExpr = true;
                }
                field(CashierTransPending; "Cashier Trans. - Pending")
                {
                    ApplicationArea = Basic;
                    Style = Ambiguous;
                    StyleExpr = true;
                }
                field(CashierTransApproved; "Cashier Trans. - Approved")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(CashierTransPosted; "Cashier Trans. - Posted")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
            }
            cuegroup(TreasuryTeller)
            {
                Caption = 'Treasury-Teller';
                field(TreasuryTellerOpen; "Treasury/Teller - Open")
                {
                    ApplicationArea = Basic;
                }
                field(TreasuryTellerPending; "Treasury/Teller - Pending")
                {
                    ApplicationArea = Basic;
                }
                field(TreasuryTellerApproved; "Treasury/Teller - Approved")
                {
                    ApplicationArea = Basic;
                }
                field(TreasuryTellerPosted; "Treasury/Teller - Posted")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;
}

