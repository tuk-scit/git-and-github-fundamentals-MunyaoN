
Page 52188520 "Cheque Register List"
{
    PageType = List;
    SourceTable = "Cheques Register_";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChequeNo;"Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo;"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalDate;"Approval Date")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationNo;"Application No.")
                {
                    ApplicationArea = Basic;
                }
                field(CancelledStoppedBy;"Cancelled/Stopped By")
                {
                    ApplicationArea = Basic;
                }
                field(Used;Used)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UsedByDocumentNo;"Used By Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cancel Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to cancel cheque ?',false)=true then begin
                    if Status<>Status::Pending then
                    Error('Status must be pending');
                    Status:=Status::Cancelled;
                    "Approval Date":=Today;
                    "Cancelled/Stopped By":=UserId;
                    Modify;
                    end;
                end;
            }
            action("Stop Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to stop cheque ?',false)=true then begin
                    if Status<>Status::Pending then
                    Error('Status must be pending');
                    Status:=Status::stopped;
                    "Approval Date":=Today;
                    "Cancelled/Stopped By":=UserId;
                    Modify;
                    end;
                end;
            }
            action("Cancel Cheque Book")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                         //reset;
                end;
            }
            action("Update Cheque Nos")
            {
                ApplicationArea = Basic;
                Visible = false;

                trigger OnAction()
                begin

                    ChequesRegister.Reset;
                    ChequesRegister.SetRange("Application No.","Application No.");
                    if ChequesRegister.Find('-') then
                    repeat
                      if StrLen(ChequesRegister."Cheque No.")=6 then begin
                          //ChequesRegister."Cheque No.":='0000'+ChequesRegister."Cheque No.";

                          Reg.Get(ChequesRegister."Cheque No.",ChequesRegister."Account No.",ChequesRegister."Application No.");
                          Reg.Rename('0000'+ChequesRegister."Cheque No.",ChequesRegister."Account No.",ChequesRegister."Application No.");

                      end;
                    until ChequesRegister.Next=0;
                end;
            }
        }
    }

    var
        ChequesRegister: Record "Cheques Register_";
        Reg: Record "Cheques Register_";
}

