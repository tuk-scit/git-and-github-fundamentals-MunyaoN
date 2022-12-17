Page 52188782 "File Movement Card - To Issue"
{
    PageType = Card;
    SourceTable = "File Movement";


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
            }

            part(Control18; "File Management Lines")
            {
                SubPageLink = "Header No." = field("No."), "Current Location" = field("Current Location");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Suggest Files")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    GetLines();

                end;
            }
            action("Issue File")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    FLines: Record "File Management Lines";
                begin
                    if "Current Location" <> 'FM_REGISTRY' then
                        Error('You cannot issue files');

                    UserSetup.Get(UserId);

                    if "Current User" = "Requested By" then
                        Error('Invalid Locations Selected');
                    TestField("Entry Type", "Entry Type"::"File Issue");

                    if Confirm('Are you sure you want to Issue this batch?') then begin
                        TestField(Remarks);

                        FLines.Reset();
                        FLines.setrange("Header No.", "No.");
                        FLines.SetRange(Issued, true);
                        if not FLines.FindFirst() then
                            Error('No File has been issued');


                        FLines.Reset();
                        FLines.setrange("Header No.", "No.");
                        FLines.SetRange(Issued, false);
                        if FLines.FindFirst() then begin
                            FLines.DeleteAll();
                        end;
                        if not UserSetup."File Movement Admin" then
                            TestField("Current User", UserId)
                        else begin
                            if "Current User" <> UserId then
                                if not Confirm('You are not the Assigned User for this Action. Do you want to proceed with the Request?') then
                                    Error('Aborted');
                        end;
                        TestField(Status, Status::" ");

                        Status := Status::"To Be Received";
                        Modify;
                        Message('Issued');
                    end;
                end;
            }
            action("Transfer File")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    FLines: Record "File Management Lines";
                begin
                    //if "Current Location" = 'REGISTRY' then
                    //  Error('You cannot transfer files');

                    UserSetup.Get(UserId);

                    if "Current User" = "Requested By" then
                        Error('Invalid Locations Selected');
                    TestField("Entry Type", "Entry Type"::"File Issue");

                    if Confirm('Are you sure you want to Issue this batch?') then begin
                        TestField(Remarks);

                        FLines.Reset();
                        FLines.setrange("Header No.", "No.");
                        FLines.SetRange(Issued, true);
                        if not FLines.FindFirst() then
                            Error('No File has been issued');


                        FLines.Reset();
                        FLines.setrange("Header No.", "No.");
                        FLines.SetRange(Issued, false);
                        if FLines.FindFirst() then begin
                            FLines.DeleteAll();
                        end;
                        if not UserSetup."File Movement Admin" then
                            TestField("Current User", UserId)
                        else begin
                            if "Current User" <> UserId then
                                if not Confirm('You are not the Assigned User for this Action. Do you want to proceed with the Request?') then
                                    Error('Aborted');
                        end;
                        TestField(Status, Status::" ");

                        Status := Status::"To Be Received";
                        Modify;
                        Message('Issued');
                    end;
                end;
            }
            action("Return")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    FLines: Record "File Management Lines";
                    Logs: Record "File Movement Log";
                begin

                    //if "Current Location" = 'REGISTRY' then
                    //  Error('You cannot transfer files');

                    UserSetup.Get(UserId);

                    TestField("Entry Type", "Entry Type"::"File Issue");

                    if "Current User" = "Requested By" then
                        Error('Invalid Locations Selected');
                    if Confirm('Are you sure you want to Return this batch?') then begin
                        TestField(Remarks);

                        FLines.Reset();
                        FLines.setrange("Header No.", "No.");
                        FLines.SetRange(Issued, true);
                        //FLines.SetRange();
                        if FLines.FindFirst() then begin
                            repeat

                                Logs.Reset();
                                Logs.SetRange("Current Location", "Current Location");
                                Logs.SetFilter("Member No.", FLines."Member No.");
                                if Logs.findlast() then begin
                                    IF Logs."Movement Date" <> 0D THEN
                                        if CalcDate('1M', Logs."Movement Date") < Today then
                                            TestField("Reason For Delay");

                                end;
                            until FLines.Next() = 0;
                        end;


                        FLines.Reset();
                        FLines.setrange("Header No.", "No.");
                        FLines.SetRange(Issued, true);
                        if not FLines.FindFirst() then
                            Error('No File has been issued');


                        FLines.Reset();
                        FLines.setrange("Header No.", "No.");
                        FLines.SetRange(Issued, false);
                        if FLines.FindFirst() then begin
                            FLines.DeleteAll();
                        end;
                        if not UserSetup."File Movement Admin" then
                            TestField("Current User", UserId)
                        else begin
                            if "Current User" <> UserId then
                                if not Confirm('You are not the Assigned User for this Action. Do you want to proceed with the Request?') then
                                    Error('Aborted');
                        end;
                        TestField(Status, Status::" ");

                        Status := Status::"To Be Received";
                        Modify;
                        Message('Issued');

                    end;
                end;
            }
            action(Receive)
            {
                ApplicationArea = Basic;
                Image = Receipt;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Log: Record "File Movement Log";
                    UserSetup: Record "User Setup";
                    FLines: Record "File Management Lines";
                begin

                    if Confirm('Are you sure you want to Receive this batch?') then begin
                        UserSetup.Get(UserId);
                        if "Current User" = "Requested By" then
                            Error('Invalid Locations Selected');

                        if not UserSetup."File Movement Admin" then
                            TestField("Requested By", UserId)
                        else begin
                            if "Requested By" <> UserId then
                                if not Confirm('You are not the Assigned User for this Action. Do you want to proceed with the Issue?') then
                                    Error('Aborted');
                        end;


                        TestField(Status, Status::"To Be Received");

                        Status := Status::"File Received";
                        "Date Received" := Today;
                        Modify;


                        FLines.Reset();
                        FLines.setrange("Header No.", "No.");
                        FLines.SetRange(Issued, true);
                        FLines.SetRange(Received, true);
                        if FLines.FindFirst() then begin
                            repeat

                                Log.Init();
                                Log."Line No." := 0;
                                Log."Member No." := FLines."Member No.";
                                Log."Member Name" := FLines."Member Name";
                                Log."Source Location" := "Current Location";
                                Log."Source Name" := "Current Name";
                                Log."Source User" := "Current User";
                                Log."Current Location" := "Request Location";
                                Log."Current Name" := "Request Location Name";
                                Log."Current User" := "Requested By";
                                Log."Movement Date" := "Movement Date";
                                Log."File Movement Reference" := "No.";
                                Log."Entry Type" := "Entry Type";
                                Log.Insert();


                            until FLines.Next() = 0;
                        end
                        else
                            Error('No File Marked to be Received');


                        Message('Received');
                        CurrPage.Close();
                    end;
                end;
            }
        }
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

