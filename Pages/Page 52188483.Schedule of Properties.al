
Page 52188483 "Schedule of Properties"
{
    PageType = List;
    SourceTable = "Schedule of Properties";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category;Category)
                {
                    ApplicationArea = Basic;
                }
                field(Item;Item)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Year;Year)
                {
                    ApplicationArea = Basic;
                }
                field(SerialNo;"Serial No.")
                {
                    ApplicationArea = Basic;
                }
                field(EstimatedValue;"Estimated Value")
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

