
PageExtension 52188543 pageextension52188443 extends "Bank Account Card"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Bank Account Card"(Page 370)".

    layout
    {
        addafter("Search Name")
        {
            field("Responsibility Center"; "Responsibility Center")
            {
                ApplicationArea = Basic;
            }
            field("Cheque Clearing Acc."; "Cheque Clearing Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Bank Type"; "Bank Type")
            {
                ApplicationArea = Basic;
            }
            field("Pending Voucher Amount"; "Pending Voucher Amount")
            {
                ApplicationArea = Basic;
            }
            field("Bank Branch Name"; "Bank Branch Name")
            {
                ApplicationArea = Basic;
            }
            field("Previous Statement No."; "Previous Statement No.")
            {
                ApplicationArea = Basic;
            }
            field("Cashier ID"; "Cashier ID")
            {
                ApplicationArea = Basic;
            }
            field("Max Amount"; "Max Amount")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Bank Clearing Code")
        {
            field("Responsible User"; "Responsible User")
            {
                ApplicationArea = Basic;
            }
            field("PV User"; "PV User")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

