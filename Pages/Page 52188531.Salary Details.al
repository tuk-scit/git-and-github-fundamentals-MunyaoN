
Page 52188531 "Salary Details"
{
    PageType = List;
    SourceTable = "Appraisal Salary Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AmountCalculationMethod;"Amount Calculation Method")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(RatePerunit;"Rate Per unit")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(NoOfUnits;"No Of Units")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(MultiplierQualification;"Multiplier Qualification")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

