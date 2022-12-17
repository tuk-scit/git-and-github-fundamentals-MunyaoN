Page 52188690 "Dividend Simulation Header"
{
    PageType = Document;
    SourceTable = "Dividend Simulation Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(AllProducts; "All Products")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; "Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; "Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(GLAccount; "G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; "Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; "End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Deposits; Deposits)
                {
                    ApplicationArea = Basic;
                }
                field(WeightedAmount; "Weighted Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalPay; "Total Pay")
                {
                    ApplicationArea = Basic;
                }
                field(TotalWTax; "Total W/Tax")
                {
                    ApplicationArea = Basic;
                }
                field(TotalNet; "Total Net")
                {
                    ApplicationArea = Basic;
                }
                field(TotalPayout; "Total Payout")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Rate; Rate)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        CurrPage.Update(true);
                    end;
                }
            }
            part(Control1; "Dividend Simulation Lines")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Simulation)
            {
                Caption = 'S&imulation';
                Image = "Order";
                action(Dividends)
                {
                    ApplicationArea = Basic;
                    Caption = 'Simulate Dividends';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    var
                        DividendPeriod: Integer;
                        DividendAccount: Code[20];
                        ErrDivPeriod: label 'Dividend Period cannot be Zero';
                        ErrDivAccount: label 'A Dividend Account is Expected';
                        MsgComplete: label 'Simulation Complete Enter the Total Amount available to calculate the Dividend Rate ';
                    begin
                        TestField("Start Date");
                        TestField("End Date");
                        GetSavingsContribution.getDividendRate(Rec);
                        Message(MsgComplete);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action("Calculate Overall Dividends")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Dividends';
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                Visible = false;
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group(Posting)
            {
                Caption = 'P&osting';
                Image = Post;
                action("Remove From Job Queue")
                {
                    ApplicationArea = Basic;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        //CancelBackgroundPosting;
                    end;
                }
                action("Preview Dividends")
                {
                    ApplicationArea = Basic;
                    Caption = 'Preview Dividends';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    var
        JobQueueVisible: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        GetSavingsContribution: Codeunit "Member Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;


    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
    end;


    procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
    end;
}

