
Page 52188528 "Loan Application List"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Loans;
    SourceTableView = where(Posted = const(false),
                            "Loan Calculator" = const(false), Status = filter(<> Approved));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; "Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; "Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(RequestedAmount; "Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount; "Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field(CapturedBy; "Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SetRange("Captured By", UserId);
    end;
}

