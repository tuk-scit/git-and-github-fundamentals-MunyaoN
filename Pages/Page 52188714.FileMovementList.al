Page 52188714 "File Movement - To Issue"
{
    CardPageID = "File Movement Card - To Issue";
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
        SetRange("Entry Type", "Entry Type"::"File Issue");
        SetRange("Status", Status::" ");
        SetRange("Current User", UserId);
    end;

}

