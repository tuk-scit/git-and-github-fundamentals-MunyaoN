
PageExtension 52188435 pageextension52188435 extends "General Journal"
{
    layout
    {

        modify("Incoming Document Entry No.")
        {
            Visible = false;
        }
        modify(AccountName)
        {
            Visible = false;
        }

        modify("Business Unit Code")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        addafter("Transaction Information")
        {
            field("Transaction Type"; "Transaction Type")
            {
                ApplicationArea = Basic;
            }
            field("Loan No."; "Loan No.")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Account Type")
        {
            field("Member No."; "Member No.")
            {
                ApplicationArea = Basic;
                LookupPageId = "Member Listing";
            }
        }

        modify("Account No.")
        {

            trigger OnLookup(var Text: Text): Boolean
            var
                Members: Record Customer;
                Accounts: Record Vendor;
                Customer: Record Customer;
                Vendor: Record Vendor;
                GLAcc: Record "G/L Account";
                Bank: Record "Bank Account";
            begin
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    "Account No." := '';
                    GLAcc.Reset();
                    if Page.RunModal(Page::"Chart of Accounts", GLAcc) = Action::LookupOK then
                        "Account No." := GLAcc."No.";
                end
                else
                    if "Account Type" = "Account Type"::Customer then begin
                        "Account No." := '';
                        Customer.Reset();
                        if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then
                            "Account No." := Customer."No.";
                    end
                    else
                        if "Account Type" = "Account Type"::Vendor then begin
                            "Account No." := '';
                            Vendor.Reset();
                            if Page.RunModal(Page::"Vendor List", Vendor) = Action::LookupOK then
                                "Account No." := Vendor."No.";
                        end
                        else
                            if "Account Type" = "Account Type"::"Bank Account" then begin
                                "Account No." := '';
                                Bank.Reset();
                                if Page.RunModal(Page::"Bank Account List", Bank) = Action::LookupOK then
                                    "Account No." := Bank."No.";
                            end

                            else
                                if "Account Type" = "Account Type"::Savings then begin

                                    "Account No." := '';
                                    Accounts.Reset();
                                    if "Member No." <> '' then
                                        Accounts.SetRange("Member No.", "Member No.");
                                    //if Page.RunModal(Page::"Member Accounts  List", Accounts) = Action::LookupOK then
                                        "Account No." := Accounts."No.";
                                end
                                else
                                    if "Account Type" = "Account Type"::Credit then begin
                                        Members.Reset();
                                        if "Member No." <> '' then
                                            Members.SetRange("Member No.", "Member No.");
                                        if Page.RunModal(Page::"Member Listing", Members) = Action::LookupOK then
                                            "Account No." := Members."No.";
                                    end;

                Validate("Account No.");
            end;
        }
    }


}

