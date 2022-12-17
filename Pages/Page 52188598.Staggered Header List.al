
Page 52188598 "Staggered Header List"
{
    CardPageID = "Staggered Header Card";
    PageType = List;
    SourceTable = "Staggered Header.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::Staggered;
    end;
}

