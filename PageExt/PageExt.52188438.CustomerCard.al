// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 52188438 CustomerCardExt extends "Customer Card"
{

    layout
    {

        addafter(Name)
        {
            field("Account Type"; "Account Type")
            {
                ApplicationArea = Basic;
            }
            field("Advice Method"; "Advice Method")
            {
                ApplicationArea = Basic;
            }

        }

    }
}