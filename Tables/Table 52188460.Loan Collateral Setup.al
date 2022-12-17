
Table 52188460 "Loan Collateral Setup"
{
    DrillDownPageID = "Collateral Setup";
    LookupPageID = "Collateral Setup";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                /*IF LoanApplications.GET(Code) THEN
                Category:=LoanApplications."Loan Product Type";    */

            end;
        }
        field(2; Type; Option)
        {
            NotBlank = true;
            OptionCaption = ' ,Title Deed,Pension,Shares,Marketable Securities,Inventory,Motor Vehicle';
            OptionMembers = " ","Title Deed",Pension,Shares,"Marketable Securities",Inventory,"Motor Vehicle";
        }
        field(3; Description; Text[50])
        {
        }
        field(5; Category; Option)
        {
            OptionCaption = ' ,Cash,Government Securities,Corporate Bonds,Equity,Mortgage Securities,Lien,Motor Vehicle,Others';
            OptionMembers = " ",Cash,"Government Securities","Corporate Bonds",Equity,"Mortgage Securities",Lien,"Motor Vehicle",Others;
        }
        field(6; "Collateral Multiplier"; Integer)
        {

            trigger OnValidate()
            begin
                //"Guarantee Value":="Collateral Multiplier"*0.7;
            end;
        }
        field(7; Examples; Text[250])
        {
        }
        field(8; Blocked; Boolean)
        {
        }
        field(9; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(10; "Revaluation Frequency"; DateFormula)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Type, Description)
        {
        }
    }
}

