
Page 52188459 "HR Leave Types Card"
{
    PageType = Card;
    SourceTable = "HR Leave Types.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Days;Days)
                {
                    ApplicationArea = Basic;
                }
                field(Gender;Gender)
                {
                    ApplicationArea = Basic;
                }
                field(InclusiveofNonWorkingDays;"Inclusive of Non Working Days")
                {
                    ApplicationArea = Basic;
                }
                field(IsAnnualLeave;"Is Annual Leave")
                {
                    ApplicationArea = Basic;
                }
                field(CarryForwardAllowed;"Carry Forward Allowed")
                {
                    ApplicationArea = Basic;
                }
                field(MaxCarryForwardDays;"Max Carry Forward Days")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        fn_SetVisible;
    end;

    var
        [InDataSet]
        CarryForwardVisible: Boolean;

    local procedure fn_SetVisible()
    begin
        //Dann - To hide fields to prevent setup errors and hide uneccessary fields
        CarryForwardVisible:=false;
        case Balance of
          Balance::"Carry Forward":
          begin
              CarryForwardVisible:=true;
          end;
        end;
    end;
}

