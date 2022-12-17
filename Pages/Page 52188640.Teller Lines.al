
Page 52188640 "Teller Lines"
{
    PageType = ListPart;
    SourceTable = "Teller Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        Members: Record Customer;
                        Accounts: Record Vendor;
                    begin
                        "Account No." := '';
                        if Type = Type::Credit then begin
                            Members.Reset();
                            Members.SetRange("No.", "Member No.");
                            Members.setfilter(type, '<>%1', Members.Type::" ");
                            if Members.FindFirst() then
                                "Account No." := Members."No.";
                        end;
                        Validate("Account No.");

                    end;
                }
                field(GlobalDimension1Code; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; "Account No.")
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Customer;
                        Accounts: Record Vendor;
                    begin
                        "Account No." := '';
                        if Type = Type::Credit then begin
                            Members.Reset();
                            Members.SetRange("No.", "Member No.");
                            Members.setfilter(type, '<>%1', Members.Type::" ");
                            if Page.RunModal(Page::"Member List", Members) = Action::LookupOK then
                                "Account No." := Members."No.";
                        end
                        else
                            if Type = Type::Savings then begin
                                Accounts.Reset();
                                Accounts.SetRange("Member No.", "Member No.");
                                Accounts.setfilter("Creditor Type", '%1', Accounts."Creditor Type"::FOSA);
                                //if Page.RunModal(Page::"Member Accounts  List", Accounts) = Action::LookupOK then
                                    "Account No." := Accounts."No.";
                            end;

                        Validate("Account No.");
                    end;
                }
                field(LoanNo; "Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionNo; "Transaction No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ProductType; "Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(OutstandingPenalty; "Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; "Outstanding Principal")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(PrincipalDue; "Principal Due")
                {
                    ApplicationArea = Basic;
                }
                field(TotalBalance; "Total Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

