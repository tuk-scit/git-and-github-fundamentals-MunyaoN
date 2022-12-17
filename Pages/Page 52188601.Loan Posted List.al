
Page 52188601 "Loan Posted List"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Posted Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Loans;
    SourceTableView = where(Posted = const(true));
    UsageCategory = History;

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
                field(DisbursementDate; "Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductTypeName; "Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field(AnnualInterest; "Annual Interest %")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Installments)
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
                field(OutstandingPrincipal; "Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(OpenAt; "Booking Branch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Open At';
                }
                field(OutstandingInterest; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(StopInterestDue; "Stop Interest Due")
                {
                    ApplicationArea = Basic;
                }
                field(RelationshipOfficer; "Relationship Officer")
                {
                    ApplicationArea = Basic;
                }
                field(LoanRestructured; "Loan Restructured")
                {
                    ApplicationArea = Basic;
                }
                field(LoanRescheduled; "Loan Rescheduled")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Suspended"; "Loan Suspended")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Suspension Start Date"; "Loan Suspension Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Suspension End Date"; "Loan Suspension End Date")
                {
                    ApplicationArea = Basic;
                }

                field("Debt Collector Type"; "Debt Collector Type")
                {
                    ApplicationArea = Basic;
                }
                field("Debt Collector"; "Debt Collector")
                {
                    ApplicationArea = Basic;
                }
                field("Debt Collector Name"; "Debt Collector Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Debt Coll. Date"; "Debt Coll. Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control10; "Loans Statistics FactBox")
            {
                SubPageLink = "Loan No." = field("Loan No.");
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin

        UserSetup.Get(UserId);
        if not UserSetup."View Staff Accounts" then begin
            FilterGroup(2);
            SetFilter("Member Category", '<>%1', "member category"::"Staff Members");
        end;
    end;

    var
        UserSetup: Record "User Setup";
}

