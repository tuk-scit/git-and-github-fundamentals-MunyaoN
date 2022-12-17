
Page 52188666 "Ordinary Cheque Register Setup"
{
    PageType = Card;
    SourceTable = "Ordinary Cheque Register";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(OrdinaryChequeNo;"Ordinary Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Issued;Issued)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Cancelled;Cancelled)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(BranchCode;"Branch Code")
                {
                    ApplicationArea = Basic;
                }
            }
            field(BankerCh;BankerCh)
            {
                ApplicationArea = Basic;
                Caption = 'Starting No.';
            }
            field(NoOfLeaves;NoOfLeaves)
            {
                ApplicationArea = Basic;
                Caption = 'No. of Leaves';
            }
            field(Control8;BranchCode)
            {
                ApplicationArea = Basic;
                Caption = 'Branch Code';
                TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
            }
            field(Source;Source)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Generate)
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm ('Are you sure you want to generate ordinary cheque No. ?',false)=false then
                      exit;

                    i:=0;

                    repeat
                    i:=i+1;

                    BankerR.Init;
                    BankerR."Ordinary Cheque No.":=BankerCh;
                    BankerR."Branch Code":=BranchCode;
                    BankerR.Source:=Source;
                    BankerR.Insert;

                    BankerCh:=IncStr(BankerCh);
                    until i = NoOfLeaves;
                end;
            }
        }
    }

    var
        BankerCh: Code[20];
        NoOfLeaves: Integer;
        i: Integer;
        BankerR: Record "Ordinary Cheque Register";
        BranchCode: Code[20];
}

