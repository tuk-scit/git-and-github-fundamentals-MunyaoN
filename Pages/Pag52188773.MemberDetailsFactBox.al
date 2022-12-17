page 52188773 "Member Details FactBox"
{
    Caption = 'Member Details FactBox';
    PageType = CardPart;
    SourceTable = "Member Images";

    layout
    {
        area(content)
        {
            group(PictureSignature)
            {
                field("No."; "Member No.")
                {
                    ApplicationArea = All;
                    Caption = 'Member No: ';
                }
                field(Picture; Picture)
                {
                    ApplicationArea = All;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
