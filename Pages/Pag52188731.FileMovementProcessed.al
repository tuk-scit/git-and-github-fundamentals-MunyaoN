page 52188731 "File Movement - Processed"
{
    Caption = 'File Movement - Processed';
    CardPageID = "File Movement Card";
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "File Movement";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MovementDate; "Movement Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CurrentLocation; "Current Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CurrentName; "Current Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CurrentUser; "Current User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Select; Select)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(EntryType; "Entry Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestLocation; "Request Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestLocationName; "Request Location Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestedBy; "Requested By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }


    actions
    {

    }






    trigger OnOpenPage()
    begin
        SetRange("Status", Status::"File Received");
    end;

}


