
PageExtension 52188550 pageextension52188450 extends "Approval Request Entries"
{


    layout
    {

        modify(RecordIDText)
        {
            Visible = false;
        }
        addfirst(Control1)
        {

            field("Document  Type"; "Document Type")
            {
                ApplicationArea = Basic;
            }
            field("Document  No."; "Document No.")
            {
                ApplicationArea = Basic;
            }
            field("Tracker ID"; "Tracker ID")
            {
                ApplicationArea = Basic;
            }
            field(DocumentIDText; DocumentIDText)
            {
                ApplicationArea = Basic;
                Caption = 'Document To Approve';
                Visible = false;
            }
        }
        addafter(RecordIDText)
        {
            field(Name; Name)
            {
                ApplicationArea = Basic;
            }
        }
    }



    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        FilterGroup(2);

        Ascending(false);

        If findfirst then;

        FilterGroup(0);
    end;

    var
        DocumentIDText: Text;

}

