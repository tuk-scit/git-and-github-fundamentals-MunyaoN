
Page 52188449 "Staff Payroll List."
{
    ApplicationArea = Basic;
    CardPageID = "Staff Payroll Card.";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Employee;
    SourceTableView = where(Status = const(Active));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(No; "No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(MemberNo; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field(FullName; FullName)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Full Name';
                    ToolTip = 'Specifies the full name of the employee.';
                    Visible = false;
                }
                field(FirstName; "First Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field(MiddleName; "Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                    Visible = false;
                }
                field(LastName; "Last Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(EmploymentDate; "Employment Date")
                {
                    ApplicationArea = Basic;
                }
                field(Initials; Initials)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the employee''s initials.';
                    Visible = false;
                }
                field(JobTitle; "Job Title")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field(PostCode; "Post Code")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the postal code.';
                    Visible = false;
                }
                field(CountryRegionCode; "Country/Region Code")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the country/region of the address.';
                    Visible = false;
                }
                field(CompanyPhoneNo; "Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field(Extension; Extension)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s telephone extension.';
                    Visible = false;
                }
                field(PrivatePhoneNo; "Mobile Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Private Phone No.';
                    ToolTip = 'Specifies the employee''s private telephone number.';
                    Visible = false;
                }
                field(PrivateEmail; "E-Mail")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Private Email';
                    ToolTip = 'Specifies the employee''s private email address.';
                    Visible = false;
                }
                field(StatisticsGroupCode; "Statistics Group Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
                    Visible = false;
                }
                field(ResourceNo; "Resource No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies a resource number for the employee.';
                    Visible = false;
                }
                field(SearchName; "Search Name")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field(Comment; Comment)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies if a comment has been entered for this entry.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = BasicHR;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = BasicHR;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                action(AssignEarningDeductions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Assign Earning/Deductions';
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                }
                action(ViewPayslip)
                {
                    ApplicationArea = Basic;
                    Caption = 'View Payslip';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        PayrollPeriods.Reset;
                        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
                        if PayrollPeriods.Find('-') then begin
                            OpenPeriod := PayrollPeriods."Date Opened";
                        end else begin
                            Error('No Payroll period found');
                        end;



                        //Display payslip report
                        Employee.SetRange("No.", "No.");
                        Employee.SetRange("Period Filter", OpenPeriod);
                        Report.Run(52188540, true, false, Employee);
                    end;
                }
                action
                (ProcessPayroll)
                {
                    ApplicationArea = Basic;
                    Caption = 'Process Payroll';
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: label '@1@@@@@@@@@@@@@@@@@@@@@';
                    begin
                        if not Confirm('Are you sure you want to process payroll. This should not be processed if  the journal has been posted') then
                            Error('Aborted');
                        PayrollPeriods.Reset;
                        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
                        if PayrollPeriods.Find('-') then begin
                            OpenPeriod := PayrollPeriods."Date Opened";
                        end else begin
                            Error('No Payroll period found');
                        end;

                        if StaffPayroll.Get("No.") then begin
                            Employee.Reset;
                            Employee.SetRange(Employee.Status, Employee.Status::Active);
                            if Employee.Find('-') then begin
                                ProgressWindow.Open('Processing Salary #1#################################################################');
                                repeat
                                    ProgressWindow.Update(1, Employee."No." + ':' + Employee."First Name");
                                    if StaffPayroll.Get(Employee."No.") then begin
                                        /*
                                        StaffPayroll."Pays PAYE":=TRUE;
                                        StaffPayroll."Pays NSSF":=TRUE;
                                        StaffPayroll."Pays NHIF":=TRUE;
                                        StaffPayroll.MODIFY;
                                        */
                                        PayrollProcessing.Processpayroll(Employee."No.", Employee."Employment Date"
                                        , StaffPayroll."Basic Pay", StaffPayroll."Pays PAYE", StaffPayroll."Pays NSSF", StaffPayroll."Pays NHIF"
                                        , OpenPeriod, OpenPeriod, '', '', Employee."Termination Date", true,
                                        '', StaffPayroll."Insurance Certificate?", StaffPayroll."Insurance Relief");





                                    end else begin
                                        //ERROR('Employee not found in PR Salary Card table, please capture Basic PY information');
                                    end;
                                until Employee.Next = 0;
                                ProgressWindow.Close;
                            end;

                            Commit;

                            //Display payslip report
                            Employee.SetRange("No.", "No.");
                            Employee.SetRange("Period Filter", OpenPeriod);
                            Report.Run(52188540, true, false, Employee);

                        end;

                    end;
                }
                action(ProcessCurrent)
                {
                    ApplicationArea = Basic;
                    Caption = 'Process Current';
                    Image = Period;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: label '@1@@@@@@@@@@@@@@@@@@@@@';
                    begin
                        if not Confirm('Are you sure you want to process payroll. This should not be processed if the journal has been posted') then
                            Error('Aborted');
                        PayrollPeriods.Reset;
                        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
                        if PayrollPeriods.Find('-') then begin
                            OpenPeriod := PayrollPeriods."Date Opened";
                        end else begin
                            Error('No Payroll period found');
                        end;

                        if StaffPayroll.Get("No.") then begin
                            Employee.Reset;
                            Employee.SetRange(Employee.Status, Employee.Status::Active);
                            Employee.SetRange(Employee."No.", "No.");
                            if Employee.Find('-') then begin
                                ProgressWindow.Open('Processing Salary #1#################################################################');
                                repeat
                                    ProgressWindow.Update(1, Employee."No." + ':' + Employee."First Name");
                                    if StaffPayroll.Get(Employee."No.") then begin
                                        PayrollProcessing.Processpayroll(Employee."No.", Employee."Employment Date"
                                        , StaffPayroll."Basic Pay", StaffPayroll."Pays PAYE", StaffPayroll."Pays NSSF", StaffPayroll."Pays NHIF"
                                        , OpenPeriod, OpenPeriod, '', '', Employee."Termination Date", true,
                                        '', StaffPayroll."Insurance Certificate?", StaffPayroll."Insurance Relief");


                                    end else begin
                                        //ERROR('Employee not found in PR Salary Card table, please capture Basic PY information');
                                    end;
                                until Employee.Next = 0;
                                ProgressWindow.Close;
                            end;

                            Commit;



                            //Display payslip report
                            Employee.SetRange("No.", "No.");
                            Employee.SetRange("Period Filter", OpenPeriod);
                            Report.Run(52188540, true, false, Employee);

                        end;
                    end;
                }
                action(Earnings)
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Payroll Employee Transactions.";
                    RunPageLink = "Employee Code" = field("No.");
                }
                action(Deductions)
                {
                    ApplicationArea = Basic;
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Transactions -D";
                    RunPageLink = "Employee Code" = field("No.");
                }
            }
        }
    }

    trigger OnInit()
    begin
        RestrictAccess
    end;

    var
        PayrollPeriods: Record "Payroll Periods";
        OpenPeriod: Date;
        StaffPayroll: Record "Staff Payroll Details";
        Employee: Record Employee;
        ProgressWindow: Dialog;
        PayrollProcessing: Codeunit "Payroll Processing";


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange(Payroll, true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Payroll"');
    end;
}

