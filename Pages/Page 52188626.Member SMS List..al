
Page 52188626 "Member SMS List."
{
    PageType = List;
    SourceTable = "Member SMS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MemberNo;"Member No")
                {
                    ApplicationArea = Basic;
                }
                field(Source;Source)
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

