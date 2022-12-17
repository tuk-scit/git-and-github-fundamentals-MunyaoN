
PageExtension 52188448 pageextension52188448 extends "Requests to Approve"
{
    layout
    {
        modify(Details)
        {
            Visible = false;
        }
        modify(ToApprove)
        {
            Visible = false;
        }
        addfirst(Control1)
        {

            field("Document Type"; "Document Type")
            {
                ApplicationArea = Basic;
            }
            field("Document No."; "Document No.")
            {
                ApplicationArea = Basic;
            }
            field("Tracker ID"; "Tracker ID")
            {
                ApplicationArea = Basic;
            }
            field(Name; Name)
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Due Date")
        {
        }
    }


    /*
    actions
    {
        // Adding a new action group 'MyNewActionGroup' in the 'Creation' area

        addlast(Creation)
        {
            group(MyNewActionGroup)
            {
                action(OpenDocument)
                {
                    Caption = 'Open Document';

                    trigger OnAction();
                    var
                        PageMan: Codeunit "Page Management";
                        PageID: Integer;

                    begin
                        PageID := 0;

                       //// IF PageID = 0 THEN
                           // PageID := PageMan.GetDefaultCardPageID(ApprovalTracker."Table ID");


                        ////IF PageID = 0 THEN
                            //PageID := PageMan.GetDefaultLookupPageID(ApprovalTracker."Table ID");

                    end;
                }
            }
        }
    }
    */


    var
        UserGroup: Record "User Group";
        UserSetup: Record "User Setup";
        UserGroupMember: Record "User Group Member";
        Approver: Code[200];


    //Unsupported feature: Code Modification on "OnOpenPage".

    trigger OnOpenPage()
    begin

        FILTERGROUP(2);


        Approver := USERID;


        UserGroupMember.RESET;
        UserGroupMember.SETRANGE("User Name", USERID);
        IF UserGroupMember.FINDFIRST THEN BEGIN
            Approver := Approver + '|';
            REPEAT
                Approver += UserGroupMember."User Group Code" + '|';
            UNTIL UserGroupMember.NEXT = 0;
            Approver += 'X';
        END;

        //MESSAGE(Approver);

        SETFILTER("Approver ID", Approver);


        FILTERGROUP(0);
        SETRANGE(Status, Status::Open);
    end;
}

