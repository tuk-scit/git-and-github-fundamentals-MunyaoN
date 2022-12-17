
Page 52188430 "Information Base"
{
    PageType = List;
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

