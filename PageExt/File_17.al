
PageExtension 52188457 pageextension52188457 extends "FA Depreciation Books"
{
    layout
    {
        addafter("Straight-Line %")
        {
            field("Customized Depr. Amount"; "Customized Depr. Amount")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

