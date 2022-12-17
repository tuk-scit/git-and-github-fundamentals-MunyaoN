
Page 52188589 "Picture & Signature"
{
    PageType = CardPart;
    SourceTable = "Member Images";

    layout
    {
        area(content)
        {
            group(Picture_)
            {
                field(".";Picture)
                {
                    ApplicationArea = Basic;
                    Caption = '.';
                }
            }
            group(Signature_)
            {
                field("..";Signature)
                {
                    ApplicationArea = Basic;
                    Caption = '..';
                }
            }
        }
    }

    actions
    {
    }
}

