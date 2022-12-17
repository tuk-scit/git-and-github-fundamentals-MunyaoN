
Page 52188481 "HR Deparments"
{
    PageType = List;
    SourceTable = "HR Departments";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Department;Department)
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

