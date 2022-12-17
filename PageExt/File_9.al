
PageExtension 52188444 pageextension52188444 extends "Bank Account List" 
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Bank Account List"(Page 371)".

    layout
    {
        addafter("Post Code")
        {
            field("GL Account";"GL Account")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

