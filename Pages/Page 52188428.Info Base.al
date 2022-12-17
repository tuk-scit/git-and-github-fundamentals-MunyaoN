
Page 52188428 "Info Base"
{
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Information Base.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Info;Info)
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field(CapturedBy;"Captured By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

