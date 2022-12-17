
Page 52188599 "Staggered Header Card"
{
    PageType = Card;
    SourceTable = "Staggered Header.";

    layout
    {
        area(content)
        {
            group(General)
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
            part(Control5;"Staggered Lines")
            {
                SubPageLink = Code=field(Code);
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

