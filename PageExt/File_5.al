
PageExtension 52188549 pageextension52188449 extends "Approval Entries"
{
    layout
    {
        modify(RecordIDText)
        {
            Visible = false;
        }
        addafter(Details)
        {
            field(DocumentIDText; DocumentIDText)
            {
                ApplicationArea = Basic;
                Caption = 'Document To Approve';
            }
            field("Tracker ID"; "Tracker ID")
            {
                ApplicationArea = Basic;
            }
            field("Document Table ID"; "Document Table ID")
            {
                ApplicationArea = Basic;
            }
        }
    }

    var
        DocumentIDText: Text;


}

