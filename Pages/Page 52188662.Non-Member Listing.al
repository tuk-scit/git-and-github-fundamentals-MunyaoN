
Page 52188662 "Non-Member Listing"
{
    PageType = List;
    SourceTable = "Non-Member Listing";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IDNo;"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(MobilePhoneNo;"Mobile Phone No.")
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

