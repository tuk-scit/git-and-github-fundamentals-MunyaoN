page 52188720 "Nominee Application"
{
    Caption = 'Nominee Application';

    PageType = List;
    SourceTable = Nominee;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IDNo; "ID No.")
                {
                    Caption = 'ID No./Birth Cert. No.';
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; "Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Email; Email)
                {
                    ApplicationArea = Basic;
                }
                field(MobilePhoneNo; "Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Relationship)
                {
                    ApplicationArea = Basic;
                }
                field(Spouse; Spouse)
                {
                    ApplicationArea = Basic;
                }
                field(Beneficiary; Beneficiary)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field(Allocation; "%Allocation")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

