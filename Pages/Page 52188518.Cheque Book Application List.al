
Page 52188518 "Cheque Book Application List"
{
    //CardPageID = "Cheque Application";
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "Cheque Book Application_";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;"No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountNo;"Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo;"Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IDNo;"ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationDate;"Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChequeAccountNo;"Cheque Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(StaffNo;"Staff No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationExported;"Application Exported")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Select;Select)
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
            action("Export Applications")
            {
                ApplicationArea = Basic;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ChqAppl.Reset;
                    ChqAppl.SetRange(ChqAppl."Application Exported",false);
                    ChqAppl.SetRange(Select,true);
                    Xmlport.Run(39004249,true,false,ChqAppl);
                end;
            }
        }
    }

    var
        ChqAppl: Record "Cheque Book Application_";
}

