page 52188687 "Super Admin Role Center"

{
    Caption = 'Super Admin', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control60; "Headline RC Relationship Mgt.")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control1; "Loan Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control12; "Member Activites")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control13; "Common Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control56; "User Tasks Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control16; "Team Member Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control6; "Sales Pipeline Chart")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control4; "Opportunity Chart")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control11; "Relationship Performance")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control2; "Power BI Report Spinner Part")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part("My Job Queue"; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(reporting)
        {

        }

        area(sections)
        {

            group(Action157)
            {
                Caption = 'Finance';

                group(GeneralLedger)
                {
                    Caption = 'General Ledger';

                    action(Action267)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Chart of Accounts';
                        Image = CustomerContact;


                        RunObject = Page "Chart of Accounts";
                    }
                    action(Action268)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Blocked Chart of Accounts';
                        Image = CustomerContact;


                        RunObject = Page "Blocked Chart of Accounts";
                    }
                    action(Action166)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'G/L Budgets';


                        RunObject = Page "G/L Budget Names";
                    }
                    action(Action165)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'General Journal';
                        Image = Quote;
                        Visible = false;


                        RunObject = Page "General Journal";
                    }
                    action(Action14)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'General Journal';
                        Image = Quote;


                        RunObject = Page "Sacco General Journal";
                    }
                    /*action(Action164)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Revised General Journal';
                        Image = Quote;


                        RunObject = Page "Sacco Journals List";
                    }
                    action(Action168)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Sacco Journals Report';
                        Image = Quote;
                        RunObject = Report "Sacco Journal Report";
                    }*/

                    action(Action2367)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Account Schedules';
                        Image = Quote;


                        RunObject = Page "Account Schedule Names";
                    }

                    action(Action2168)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Revised Trial Balance';
                        Image = Quote;
                        RunObject = Report "Revised Trial Balance";
                    }

                    action(Action2169)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Sacco Trial Balance';
                        Image = Quote;


                        RunObject = Report "Sacco Trial Balance";
                    }

                }

                group(CashManagement)
                {
                    Caption = 'Cash Management';

                    action(Action634)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Bank Account List';
                        Image = "Order";


                        RunObject = Page "Bank Account List";
                    }
                    action("Cash Receipt Journal")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Cash Receipt Journal';
                        Image = Reminder;


                        RunObject = Page "Cash Receipt Journal";
                    }
                    action("Payment Journal")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Payment Journal';
                        Image = Reminder;


                        RunObject = Page "Payment Journal";
                    }
                    action("Bank Acc. Reconciliation List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Bank Acc. Reconciliation';
                        Image = Reminder;


                        RunObject = Page "Bank Reconcilliation List";
                    }
                    action("Cash Book")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Cash Book Report';
                        Image = Reminder;


                        RunObject = Report "Cash Book";
                    }


                }
                //RECEIVABLES
                group(Receivables)
                {
                    Caption = 'Receivables';

                    action(Action639)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Customers';
                        Image = "Order";


                        RunObject = Page "Customer List";
                    }
                    action("Sales Invoice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Sales Invoice';
                        Image = Reminder;


                        RunObject = Page "Sales Invoice List";
                    }
                    action("Posted Sales Invoice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Sales Invoice';
                        Image = Reminder;


                        RunObject = Page "Posted Sales Invoices";
                    }

                    action("Sales Credit Memo")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Sales Credit Memo';
                        Image = Reminder;


                        RunObject = Page "Sales Credit Memos";
                    }

                    action("Posted Sales Credit Memo")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Sales Credit Memo';
                        Image = Reminder;


                        RunObject = Page "Posted Sales Credit Memos";
                    }

                }




                group(Payables)
                {
                    Caption = 'Payables';

                    action(Action239)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Vendors';
                        Image = "Order";


                        RunObject = Page "Vendor List";
                    }
                    action("Purchase Invoice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Purchase Invoice';
                        Image = Reminder;


                        RunObject = Page "Purchase Invoices";
                    }
                    action("Posted Purchase Invoice")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Purchase Invoice';
                        Image = Reminder;


                        RunObject = Page "Posted Purchase Invoice";
                    }

                    action("Purchase Credit Memo")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Purchase Credit Memo';
                        Image = Reminder;


                        RunObject = Page "Purchase Credit Memos";
                    }

                    action("Posted Purchase Credit Memo")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Posted Purchase Credit Memo';
                        Image = Reminder;


                        RunObject = Page "Posted Purchase Credit Memos";
                    }

                }


                group(FixedAssets)
                {
                    Caption = 'Fixed Assets';

                    action(Action229)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fixed Assets';
                        Image = "Order";


                        RunObject = Page "Fixed Asset List";
                    }
                    action("Fixed Asset G/L Journal")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'FA G/L Journal';
                        Image = Reminder;


                        RunObject = Page "Fixed Asset G/L Journal";
                    }
                    action("Fixed Asset Journal")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'FA Journal';
                        Image = Reminder;


                        RunObject = Page "Fixed Asset Journal";
                    }

                    action("FA Reclass. Journals")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'FA Reclass. Journals';
                        Image = Reminder;


                        RunObject = Page "FA Reclass. Journal";
                    }
                    action("Calculate Depreciation")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Calculate Depreciation';
                        Image = Reminder;


                        RunObject = Report "Calculate Depreciation";
                    }
                    action("Fixed Asset List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        RunObject = Report "FA List";
                        Caption = 'Fixed Asset List';
                    }

                }
                group(PeriodicActivities)
                {
                    Caption = 'Periodic Activities';

                    action(Action29)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Accounting Periods';
                        Image = "Order";
                        RunObject = Page "Accounting Periods";
                    }

                    action("Close Income Statement")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Close Income Statement';
                        Image = Reminder;
                        RunObject = Report "Close Income Statement";
                    }

                    action("Product Listing Comparison")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Product Listing Comparison';
                        Image = Reminder;
                        RunObject = Report "Product Listing Comparison";
                    }

                    action("Credit Ledger Missing in TB")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Credit Ledger Missing in GL';
                        Image = Reminder;
                        RunObject = Report "Credit Ledger Missing in TB";
                    }

                    action("Savings Ledger Missing in TB")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Savings Ledger Missing in TB';
                        Image = Reminder;
                        RunObject = Report "Savings Ledger Missing in TB";
                    }

                    action("TB Missing in Credit Ledger")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'TB Missing in Sub-Ledger';
                        Image = Reminder;
                        RunObject = Report "TB Missing in Credit Ledger";
                    }

                }


            }



            group(Action257)
            {
                Caption = 'Registry';

                group(Registration)
                {
                    Caption = 'Registration';


                    action(Action167)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Individual Member Registration';
                        Image = CustomerContact;


                        RunObject = Page "Member Registration List";
                        ToolTip = 'Create Individual Member Account';
                    }

                }

                group(Membership)
                {
                    Caption = 'Membership';

                    action(Action64)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member List';
                        Image = "Order";


                        RunObject = Page "Member List";
                        ToolTip = 'List of all SACCO Members';
                    }



                }

                group("File Management")
                {

                    action(Action699)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'File Movement List - To Issue/Transfer';
                        Image = Quote;
                        RunObject = Page "File Movement - To Issue";
                    }

                    action(Action799)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'File Movement List - To Receive';
                        Image = Quote;
                        RunObject = Page "File Movement - To Receive";
                    }
                    action(Action899)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'File Movement List - Processed';
                        Image = Quote;
                        RunObject = Page "File Movement - Processed";
                    }
                    action(Action399)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'File Movement Report';
                        Image = Quote;
                        RunObject = Report "File Movement Report";
                    }

                }

                group(Periodic)
                {
                    Caption = 'Periodic Activities';

                    action(Action69)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Changes';
                        Image = "Order";


                        RunObject = Page "Member Changes List";
                        ToolTip = 'Edit Member Details';
                    }

                }

                group(Reports)
                {
                    Caption = 'Reports';

                    action("Member Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Register';
                        Image = "Order";


                        RunObject = Report "Member Register";
                    }
                    action("New Members Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'New Members Report';
                        Image = "Order";


                        RunObject = Report "New Members Report";
                    }
                    action("Member Balances Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Balances Report';
                        Image = "Order";


                        RunObject = Report "Savings List Register";
                    }
                    action("Member Deposit Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Deposit Report';
                        Image = "Order";


                        RunObject = Report "Member Deposit Report";
                    }
                    action("Members Without Shares")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Members Without Shares';
                        Image = "Order";


                        RunObject = Report "Members Without Shares";
                    }
                    action("Deceased Acc. With Balances")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Deceased Members With Balances';
                        Image = "Order";


                        RunObject = Report "Deceased Acc. With Balances";
                    }
                    action("Member Withdrawals Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Withdrawals Report';
                        Image = "Order";


                        RunObject = Report "Member Withdrawals";
                    }
                    action("Member Recruitement Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member Recruitement Report';
                        Image = "Order";


                        RunObject = Report "Member Recruitement Report";
                    }
                    action("Dormant Members")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Dormant Members Report';
                        Image = "Order";

                        RunObject = report "Dormant Members Report";
                    }

                }
            }



            group(Action357)
            {
                Caption = 'Credit';

                group(CollateralGroup)
                {
                    Caption = 'Collateral Management';

                    action(Collateral)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Collateral Register';
                        Image = CustomerContact;


                        RunObject = Page "Collateral List";
                    }
                    action(CollateralRetun)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Collateral Return';


                        RunObject = Page "Collateral Return List";
                    }
                }



                group(LoanManagement)
                {
                    Caption = 'Loan Management';

                    action("Salary Appraisal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Salary Appraisal List';
                        Image = "Order";


                        RunObject = Page "Salary Appraisal";
                    }

                    action(LoanApplication)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Registration';
                        Image = "Order";


                        RunObject = Page "Loan Application List";
                    }
                    action(LoanApproved)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loans Approved';
                        Image = "Order";


                        RunObject = Page "Loans Approved List";
                    }


                    action("Loan Batch List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Loan Batch List';
                        Image = Reminder;


                        RunObject = Page "Loan Disbursement List";
                    }


                    action(PostedLoans)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Loans';
                        Image = "Order";


                        RunObject = Page "Loan Posted List";
                    }

                    action("Loan Changes")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Loan Changes List';
                        Image = Change;
                        RunObject = page "Loan Changes List";
                    }


                }

                group(LoanReports)
                {
                    Caption = 'Reports';

                    action("Loan Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Register';
                        Image = "Order";


                        RunObject = Report "Loan Register";
                    }
                    action("Defaulter Aging")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Defaulter Aging';
                        Image = "Order";


                        RunObject = Report "Loans Defaulter Aging -report";
                    }
                    action("Loan Product Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Product Summary';
                        Image = "Order";


                        RunObject = Report "Loan Product Summary";
                    }
                    action("Loan Product Summ. Comparison")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Product Summ. Comparison';
                        Image = "Order";


                        RunObject = Report "Loan Product Summ. Comparison";
                    }
                    action("Loan Portfolio Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Portfolio Summary';
                        Image = "Order";


                        RunObject = Report "Loan Portfolio Summary";
                    }
                    action("Gross Loans Disbursed")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report "Gross Loans Disbursed";
                    }
                    action("Graphical Gross Loans Disbursed")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report "Gross Loans Disbursed - G";
                    }
                    action("Net Loans Disbursed")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";


                        RunObject = Report "Net Loans Disbursed";
                    }
                    action("Product Variance Analysis-Annual")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Gross Loan Portfolio";
                    }
                    action("Summary Loan Ageing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Summary Loan Ageing";
                    }
                    action("Debt Collection")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Debt Collection";
                    }
                    action("Prod Defaulter Aging")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Prod Defaulter Aging';
                        Image = "Order";
                        Visible = false;
                        RunObject = Report "Prod Defaulter Aging -report";
                    }
                    action("Emp Defaulter Aging")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Emp Defaulter Aging';
                        Image = "Order";
                        Visible = false;


                        RunObject = Report "Emp Defaulter Aging -report";
                    }

                }

                group(CheckOff)
                {
                    Caption = 'CheckOff';

                    action("Monthly Advice")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Monthly Advice';
                        Image = "Order";


                        RunObject = Page "Monthly Advice List";
                    }


                }

                group(Sasra)
                {
                    Caption = 'SASRA';

                    group("Loan Aging")
                    {
                        action("LoanAging")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Update Loan Aging';
                            Image = "Order";


                            RunObject = report "SASRA Loan Categorization";
                        }
                        action("Loan-Aging")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loan Aging - SASRA';
                            Image = "Order";


                            RunObject = report "Loans Defaulter Aging - SASRA";
                        }
                        action("Loans Provisioning")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Loans Provisioning';
                            Image = "Order";


                            RunObject = report "Loans Provisioning Summary";
                        }
                    }

                    group("DepositReturn")
                    {
                        Caption = 'Deposit Return';

                        action("DepositReturn1")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Update Deposit Return';
                            Image = "Order";


                            RunObject = report "Update Deposit Return";
                        }
                        action("DepositReturn2")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Deposit Return Report';
                            Image = "Order";


                            RunObject = report "Sasra Deposit Return";
                        }
                    }
                    action("Sectorial")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Sectorial Lending';
                        Image = "Order";


                        RunObject = page "Sasra - Annex 1 Table 1";
                    }

                    group("Sectorial Setups")
                    {

                        action("MainSector")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Sasra Main Sector';
                            Image = "Order";


                            RunObject = page "Sasra Main Sector";
                        }
                        action("SubSector1")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Sasra Sub-Sector Level 1';
                            Image = "Order";


                            RunObject = page "Sasra Sub-Sector Level 1";
                        }
                        action("SubSector2")
                        {
                            ApplicationArea = RelationshipMgmt;
                            Caption = 'Sasra Sub-Sector Level 2';
                            Image = "Order";


                            RunObject = page "Sasra Sub-Sector Level 2";
                        }

                    }


                }



                group(DefaulterManagement)
                {
                    Caption = 'Defaulter Management';

                    action("Loan Recovery")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Loan Recovery';
                        Image = "Order";


                        RunObject = Page "Defaulter Loan Recovery List";
                    }

                    action("CRB")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'CRB Reporting';
                        Image = "Order";


                        RunObject = Page "CRB Main";
                    }
                    action("Recover Loans From Savings")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Recover Loans From Savings";
                    }

                }
            }
            ///REACH HERE


            group(Action457)
            {
                Caption = 'Savings';

                group(SavingsReports)
                {
                    Caption = 'Reports';

                    action("Savings List Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Savings List Register';
                        Image = "Order";


                        RunObject = Report "Savings List Register";
                    }

                    action("Fosa Register")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Fosa Register';
                        Image = "Order";


                        RunObject = Report "Fosa Register";
                    }
                }


                group(DividendProcessing)
                {
                    Caption = 'Dividend Processing';


                    action("Dividend Simulation")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Dividend Simulation ';
                        Image = "Order";


                        RunObject = Page "Dividend Simulation Header";
                    }
                    action("Dividend Progression")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Dividend Progression';
                        Image = "Order";


                        RunObject = Page "Dividend Progression";
                    }

                    action("Dividend Posting Buffer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Dividend Posting Buffer';
                        Image = "Order";


                        RunObject = Page "Dividend Posting Buffer";
                    }

                }



            }

            group(Action57)
            {
                Caption = 'Funds Management';

                group(Receipts)
                {
                    Caption = 'Receipts';

                    action(Receipt)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Receipts List';
                        Image = CustomerContact;


                        RunObject = Page "Receipts List";
                    }
                    action("Posted Receipts")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Posted Receipts';


                        RunObject = Page "Posted Receipts List";
                    }
                    action("Receipts - report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Receipts Report';
                        Image = Receipt;


                        RunObject = Report Receipt;
                    }

                }
            }

            group(Action13)
            {
                Caption = 'HR & Payroll';

                group(EmployeeManagement)
                {
                    Caption = 'Employee Management';

                    action("Employee List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List';
                        Image = CustomerContact;


                        RunObject = Page "Employee List";
                    }
                    action("Employee List - Contract")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List - Contract';


                        RunObject = Page "Employee List - Contract";
                    }
                    action("Employee List - Interns")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List - Interns';


                        RunObject = Page "Employee List - Interns";
                    }

                }

                group(LeaveManagement)
                {
                    Caption = 'Leave Management';

                    action("HR Leave Applications List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Applications List';
                        Image = CustomerContact;


                        RunObject = Page "HR Leave Applications List";
                    }
                    action("HR Leave App. - Pending")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave App. - Pending';


                        RunObject = Page "HR Leave App. - Pending";
                    }
                    action("HR Leave App. - Approved")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave App. - Approved';


                        RunObject = Page "HR Leave App. - Approved";
                    }
                    action("HR Leave Statement")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Statement';


                        RunObject = Report "HR Leave Statement";
                    }

                }

                group(HReports)
                {
                    Caption = 'HR Reports';

                    action("Employee Listing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List';
                        Image = "Order";


                        RunObject = Report "Employee - List";
                    }
                    action("HRLeave Applications List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Leave Applications List';
                        Image = "Order";


                        RunObject = Report "HR Leave Applications List";
                    }
                    action("HR Leave Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Leave Summary';
                        Image = "Order";


                        RunObject = Report "HR Leave Summary";
                    }
                    action("HR Leave Balances")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Balances';
                        Image = "Order";


                        RunObject = Report "HR Leave Balances";
                    }

                    action("HR Leave Report")
                    {
                        ApplicationArea = RelationshipMgmt;

                        RunObject = report "HR Leave Report";
                    }

                }

                group(Payroll)
                {
                    Caption = 'Payroll';

                    action("Staff Payroll List.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Staff Payroll List.';
                        Image = "Order";


                        RunObject = Page "Staff Payroll List.";
                    }
                    action("Payroll Periods.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Periods.';
                        Image = "Order";


                        RunObject = Page "Payroll Periods.";
                    }
                    action("Payroll Journal Trasnfer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Journal Trasnfer';
                        Image = "Order";


                        RunObject = Report "Payroll Journal Trasnfer";
                    }



                }

                group(PayrollReports)
                {
                    Caption = 'Payroll Reports';

                    action("Payroll Codes Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Codes Report';
                        Image = "Order";


                        RunObject = Report "Payroll Codes Report";
                    }
                    action("P9 Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'P9 Report';
                        Image = "Order";


                        RunObject = Report "P9 Report";
                    }
                    action("Payroll Summary Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Summary Report';
                        Image = "Order";


                        RunObject = Report "Payroll Summary Report";
                    }
                    action("P9 Report - Board")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'P9 Report - Board';
                        Image = "Order";


                        RunObject = Report "P9 Report - Board";
                    }
                    action("Payroll Net Pay Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Net Pay Report';
                        Image = "Order";


                        RunObject = Report "Payroll Net Pay Report";
                    }
                    action("NITA Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'NITA Report';
                        Image = "Order";


                        RunObject = Report "NITA Report";
                    }

                }


            }


            group(Action3)
            {
                Caption = 'Setups';

                group(Finance)
                {
                    Caption = 'Setups';

                    action("General Ledger Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'General Ledger Setup';
                        Image = CustomerContact;


                        RunObject = Page "General Ledger Setup";
                    }
                    action("Accounting Periods")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Accounting Periods';


                        RunObject = Page "Accounting Periods";
                    }
                    action("No. Series")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'No. Series';


                        RunObject = Page "No. Series";
                    }
                    group("Posting Groups")
                    {
                        action("Gen. Business Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Gen. Business Posting Groups";
                        }
                        action("Gen. Product Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Gen. Product Posting Groups";
                        }
                        action("General Posting Setup")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "General Posting Setup";
                        }
                        action("Customer Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Customer Posting Groups";
                        }
                        action("Vendor Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Vendor Posting Groups";
                        }
                        action("FA Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "FA Posting Groups";
                        }
                        action("Bank Account Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Bank Account Posting Groups";
                        }
                        action("Inventory Posting Groups")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Inventory Posting Groups";
                        }
                        action("Inventory Posting Setup")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = Page "Inventory Posting Setup";
                        }

                    }
                    action("Dimensions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Dimensions';


                        RunObject = Page "Dimensions";
                    }
                    action("General Journal Templates")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'General Journal Templates';


                        RunObject = Page "General Journal Templates";
                    }

                }

                group(HRPayrollSetups)
                {
                    Caption = 'HR & PayrollSetups';

                    action(HRSetups)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** HR Setups *****';
                        Image = CustomerContact;


                    }
                    action("Human Resources Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Human Resources Setup';


                        RunObject = Page "Human Resources Setup";
                    }
                    action("HR Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR General Setup';


                        RunObject = Page "HR Setup";
                    }
                    action("HR Leave Types")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Types';


                        RunObject = Page "HR Leave Types";
                    }
                    action("HR Leave Jnl. Template List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Jnl. Template List';


                        RunObject = Page "HR Leave Jnl. Template List";
                    }
                    action("HR Leave Batches")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Batches';


                        RunObject = Page "HR Leave Batches";
                    }
                    action("HR Leave Journal Lines")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Journal Lines';


                        RunObject = Page "HR Leave Journal Lines";
                    }
                    action("HR Leave Calendsr.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Calendar.';


                        RunObject = Page "HR Leave Calendsr.";
                    }


                    action(PayrollSetups)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** Payroll Setups *****';
                        Image = CustomerContact;


                    }
                    action("Payroll Posting Group.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Posting Group';


                        RunObject = Page "Payroll Posting Group.";
                    }
                    action("Payroll Codes List.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Codes List';


                        RunObject = Page "Payroll Codes List.";
                    }
                    action("Payroll Rates.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Rates.';


                        RunObject = Page "Payroll Rates.";
                    }
                    action("PAYE Setup.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'PAYE Setup.';


                        RunObject = Page "PAYE Setup.";
                    }
                    action("SetNHIF Setupup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'NHIF Setup';


                        RunObject = Page "NHIF Setup";
                    }

                }

                group(SaccoSetups)
                {
                    Caption = 'Sacco Setups';

                    action(Credit)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** Credit Setups *****';
                        Image = CustomerContact;


                    }
                    action("Sacco Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Sacco Setup';


                        RunObject = Page "Sacco Setup";
                    }
                    action("Product Setup List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Product Setup';


                        RunObject = Page "Product Setup List";
                    }
                    action("Collateral Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Collateral Setup';


                        RunObject = Page "Collateral Setup";
                    }
                    action("Charges")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Charges';


                        RunObject = Page Charges;
                    }

                    action(Savings)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** Savings Setups *****';
                        Image = CustomerContact;


                    }
                    action("Transaction Charges List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Transaction Charges List';


                        RunObject = Page "Transaction Charges List";
                    }
                    action("Banking User Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Banking User Setup';


                        RunObject = Page "Banking User Setup";
                    }
                    action("CharCheque Typesges")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Cheque Types';


                        RunObject = Page "Cheque Types";
                    }

                    action(General)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** General Setups *****';
                        Image = CustomerContact;


                    }
                    action("SMS Charges")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'SMS Charges';


                        RunObject = Page "SMS Charges";
                    }
                    action("Bank COde")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Bank Code';


                        RunObject = Page "Bank COde";
                    }
                    action("Branch COde")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Branch Code';


                        RunObject = Page "Bank Branches";
                    }
                    action("Sacco Nos.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Sacco Nos.';


                        RunObject = Page "Sacco Nos.";
                    }
                }

                group(Administration)
                {
                    Caption = 'Administration';

                    action("Users")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Users';
                        Image = "Order";


                        RunObject = Page Users;
                    }
                    action("User Setup")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'User Setup';
                        Image = Reminder;


                        RunObject = Page "User Setup";
                    }
                    action("Job Queue Category List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Job Queue Category';
                        Image = Reminder;


                        RunObject = Page "Job Queue Category List";
                    }

                    action("Job Queue Entries")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Job Queue Entries';
                        Image = Reminder;


                        RunObject = Page "Job Queue Entries";
                    }



                    action("Workflow - Table Relations")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Workflow - Table Relations';
                        Image = Reminder;


                        RunObject = Page "Workflow - Table Relations";
                    }

                    action("Workflow")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Workflow';
                        Image = Reminder;


                        RunObject = Page Workflow;
                    }

                    action("Workflow User Group")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Workflow User Group';
                        Image = Reminder;


                        RunObject = Page "Workflow User Group";
                    }

                    action("Approval User Setup")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Approval User Setup';
                        Image = Reminder;


                        RunObject = Page "Approval User Setup";
                    }

                    action("Profiles")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'Profiles';
                        Image = Reminder;


                        RunObject = Page "Profile List";
                    }

                    action("User Personalization List")
                    {
                        ApplicationArea = Suite, RelationshipMgmt;
                        Caption = 'User Personalization List';
                        Image = Reminder;


                        RunObject = Page "User Settings List";
                    }


                }
            }

            group(Action4)
            {
                Caption = 'Management';

                group(ManReports)
                {
                    Caption = 'Management Reports';

                    action("Account Application Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Account Application Summary";
                    }

                    action("Bank Branch Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Bank Branch Transactions";
                    }

                    action("Cashier Branch Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Cashier Branch Summary";
                    }

                    action("Credit PAR Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Credit PAR Report";
                    }

                    action("Exposure Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Exposure Report";
                    }

                    action("Interest Accrual Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Interest Accrual Report";
                    }

                    action("Loan Daily Report - Detailed")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Loan Daily Report - Detailed";
                    }

                    action("Loan Daily Transactions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Loan Daily Transactions";
                    }

                    action("Loan Topup Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Loan Topup Report";
                    }

                    action("Loans Repaid Via Payout")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Loans Repaid Via Income";
                    }

                    action("Product Activity Variance")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Product Activity Variance";
                    }

                    action("Top Performers Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Top Performers Report";
                    }

                    action("Treasury Daily Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "Treasury Daily Report";
                    }

                    action("User profiling Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = Report;


                        RunObject = Report "User profiling Report";
                    }

                    action("Dashboard")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = PayrollStatistics;


                        RunObject = Page "Dashboard.";
                    }


                }
            }




#if not CLEAN18
            group(SetupAndExtensions)
            {
                Caption = 'Setup & Extensions';
                Image = Setup;
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                ObsoleteTag = '18.0';
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action("Manual Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Manual Setup';
                    RunObject = Page "Manual Setup";
                    ToolTip = 'Define your company policies for business departments and for general activities by filling setup windows manually.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action("Service Connections")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service Connections';
                    Image = ServiceTasks;
                    RunObject = Page "Service Connections";
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action(Extensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Extensions';
                    Image = NonStockItemSetup;
                    RunObject = Page "Extension Management";
                    ToolTip = 'Install Extensions for greater functionality of the system.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action(Workflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Workflows';


                    RunObject = Page Workflows;
                    ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
            }
#endif
        }

        area(processing)
        {







        }
    }
}
