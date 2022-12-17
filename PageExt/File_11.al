
PageExtension 52188430 pageextension52188430 extends "Company Information" 
{
    layout
    {
        addafter(Picture)
        {
            field("Letter Head";"Letter Head")
            {
                ApplicationArea = Basic,Suite;
                ToolTip = 'Specifies the picture that has been set up for the company, such as a company logo.';

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord;
                end;
            }
            group("Current Year")
            {
                field("Year Start";"Year Start")
                {
                    ApplicationArea = Basic;
                }
                field("Year End";"Year End")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}

