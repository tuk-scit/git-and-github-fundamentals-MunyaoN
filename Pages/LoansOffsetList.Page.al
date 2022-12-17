Page 52210 "Loans Offset List"
{
    PageType = ListPart;
    SourceTable = "Loans Offet List";
    SourceTableView = where(status = filter("Book Loan to Offset" | "TopUp Shares" | Open | Pending | Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MemberNo; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanNo; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNames; "Member Names")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanProduct; "Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount; "Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingBalance; "Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("interest waiver"; "interest waiver")
                {
                    ApplicationArea = Basic;
                }
                field("Recover From Guarantors"; "Recover From Guarantors")
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

