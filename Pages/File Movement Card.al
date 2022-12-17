Page 52188783 "File Movement Card"
{
    PageType = Card;
    SourceTable = "File Movement";

    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEdit;
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentLocation; "Current Location")
                {
                    ApplicationArea = Basic;

                }
                field(CurrentName; "Current Name")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentUser; "Current User")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(RequestLocation; "Request Location")
                {
                    ApplicationArea = Basic;
                }
                field(RequestLocationName; "Request Location Name")
                {
                    ApplicationArea = Basic;
                }
                field(RequestedBy; "Requested By")
                {
                    ApplicationArea = Basic;
                }

                field(Purpose; Purpose)
                {
                    ApplicationArea = Basic;
                }
                field(MovementDate; "Movement Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Delay"; "Reason For Delay")
                {
                    ApplicationArea = Basic;
                }
            }

            part(Control18; "File Management Lines")
            {
                SubPageLink = "Header No." = field("No."), "Current Location" = field("Current Location");
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Status = Status::"File Received" then
            pageEdit := false
        else
            PageEdit := true;



        if "Entry Type" = "Entry Type"::"File Request" then
            RequestBool := true
        else
            RequestBool := false;

    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserGroupMember: Record "User Group Member";
    begin
        "Entry Type" := "Entry Type"::"File Issue";

        if "Entry Type" = "entry type"::"File Issue" then begin
            UserGroupMember.Reset;
            UserGroupMember.SetRange(Type, UserGroupMember.Type::"File Movement");
            UserGroupMember.SetRange("User Name", UserId);
            UserGroupMember.SetRange("Company Name", CompanyName);
            if UserGroupMember.FindFirst then begin
                UserGroupMember.calcfields("User Group Name");
                UserGroupMember.calcfields("User Name");
                "Current Location" := UserGroupMember."User Group Code";
                "Current Name" := UserGroupMember."User Group Name";
                "Current User" := UserGroupMember."User Name";
                //GetLines();
            end
            else
                Error('You have not been attached to any department');
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin

        if Status = Status::"File Received" then
            pageEdit := false
        else
            PageEdit := true;


        if "Entry Type" = "Entry Type"::"File Request" then
            RequestBool := true
        else
            RequestBool := false;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        IssueBool := false;
        TransferBool := false;

        if Status = Status::"File Received" then
            pageEdit := false
        else
            PageEdit := true;



        if "Entry Type" = "Entry Type"::"File Request" then
            RequestBool := true
        else
            RequestBool := false;

    end;

    var
        PageEdit: Boolean;
        RequestBool: Boolean;
        IssueBool: Boolean;
        TransferBool: Boolean;


    procedure GetLines()
    var
        Logs: Record "File Movement Log";
        Lines: Record "File Management Lines";
    begin
        Lines.Reset();
        Lines.SetRange("Header No.", "No.");
        if Lines.FindFirst() then begin
            if not Confirm('Are you sure you want to suggest lines? Existing Lines will be deleted') then
                Error('Aborted');
            Lines.DeleteAll();

        end;


        Logs.Reset();
        Logs.SetRange("Current Location", "Current Location");
        Logs.SetFilter("Member No.", '<>%1', '');
        if Logs.FindFirst() then begin
            repeat
                Lines.Init();
                Lines."Header No." := "No.";
                Lines."Current Location" := "Current Location";
                Lines."Member No." := Logs."Member No.";
                Lines."Member Name" := Logs."Member Name";
                Lines.Insert();
            until Logs.Next() = 0;
        end;

    end;

}

