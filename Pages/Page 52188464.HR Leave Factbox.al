
Page 52188464 "HR Leave Factbox"
{
    PageType = CardPart;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            label(Control1102755011)
            {
                ApplicationArea = Basic;
                CaptionClass = Text1;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field(No;"No.")
            {
                ApplicationArea = Basic;
            }
            field(FirstName;"First Name")
            {
                ApplicationArea = Basic;
            }
            field(MiddleName;"Middle Name")
            {
                ApplicationArea = Basic;
            }
            field(LastName;"Last Name")
            {
                ApplicationArea = Basic;
            }
            field(JobTitle;"Job Title")
            {
                ApplicationArea = Basic;
            }
            field(Status;Status)
            {
                ApplicationArea = Basic;
            }
            field(EMail;"E-Mail")
            {
                ApplicationArea = Basic;
            }
            field(Text3;Text3)
            {
                ApplicationArea = Basic;
            }
            field(Text2;Text2)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field(ReimbursedLeaveDays;"Reimbursed Leave Days")
            {
                ApplicationArea = Basic;
                Importance = Promoted;
            }
            field(AllocatedLeaveDays;"Allocated Leave Days")
            {
                ApplicationArea = Basic;
                Importance = Promoted;
            }
            field(TotalLeaveDays;"Total (Leave Days)")
            {
                ApplicationArea = Basic;
                Importance = Promoted;
            }
            field("Leave Earned";LeaveEarned)
            {
                ApplicationArea = Basic;
            }
            field(TotalLeaveTaken;"Total Leave Taken")
            {
                ApplicationArea = Basic;
                Editable = false;
                Importance = Promoted;
            }
            field(LeaveBalance;"Leave Balance")
            {
                ApplicationArea = Basic;
                Enabled = false;
                Importance = Promoted;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CalcFields(CurrYearStart,CurrYearEnd);
        SetRange("Date Filter",CurrYearStart,CurrYearEnd);

        LeaveTypes.Reset;
        LeaveTypes.SetRange("Is Annual Leave",true);
        LeaveTypes.SetRange("Employee Category","Employee Category");
        if LeaveTypes.FindFirst then begin
            SetFilter("Leave Type Filter",LeaveTypes.Code);
            CalcFields("Reimbursed Leave Days","Allocated Leave Days","Total Leave Taken");

            if "Total (Leave Days)"<>"Reimbursed Leave Days"+"Allocated Leave Days" then begin
                "Total (Leave Days)":="Reimbursed Leave Days"+"Allocated Leave Days";
            end;

            Month:=Date2dmy(Today,2);
            LeaveEarned:=ROUND("Allocated Leave Days"*Month/12,1,'<');
            LeaveEarned+="Reimbursed Leave Days";

            if "Leave Balance" <> LeaveEarned-"Total Leave Taken" then begin
              if "Total Leave Taken" < 0 then
                "Leave Balance" := LeaveEarned+"Total Leave Taken"
              else
                "Leave Balance" := LeaveEarned-"Total Leave Taken"
            end;

        end;
    end;

    var
        Text1: label 'Employee Details';
        Text2: label 'Employeee Leave Details';
        Text3: label '==============================';
        LeaveTypes: Record "HR Leave Types.";
        Month: Integer;
        LeaveEarned: Integer;
}

