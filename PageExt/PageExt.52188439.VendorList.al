// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 52188439 VendorListExt extends "Vendor List"
{



    trigger OnOpenPage();
    begin
        Rec.SetFilter("Creditor Type", '<>%1', "Creditor Type"::FOSA);
    end;




}