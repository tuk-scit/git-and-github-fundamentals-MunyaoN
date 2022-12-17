
Table 52188598 "Sacco Cues"
{

    fields
    {
        field(1; "Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Loans - Application"; Integer)
        {
            CalcFormula = count(Loans where(Status = const(Open),
                                             Posted = const(false),
                                             "Captured By" = field("User Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50051; "Loans - Pending"; Integer)
        {
            CalcFormula = count(Loans where(Status = const(Pending),
                                             Posted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50052; "Loans - Approved"; Integer)
        {
            CalcFormula = count(Loans where(Status = const(Approved),
                                             Posted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50053; "Loans - Rejected"; Integer)
        {
            CalcFormula = count(Loans where(Status = const(Rejected),
                                             Posted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50054; "Approval Entry"; Integer)
        {
            CalcFormula = count("Approval Entry" where(Status = const(Open),
                                                        "Approver ID" = field("User Filter")));
            FieldClass = FlowField;
        }
        field(50055; "User Filter"; Code[50])
        {
            FieldClass = FlowFilter;
        }
        field(50056; "Loans - Posted"; Integer)
        {
            CalcFormula = count(Loans where(Posted = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50057; "Leave - Application"; Integer)
        {
            CalcFormula = count("HR Leave Application." where(Status = const(New),
                                                               "Applicant User ID" = field("User Filter")));
            FieldClass = FlowField;
        }
        field(50058; "Leave - Pending"; Integer)
        {
            CalcFormula = count("HR Leave Application." where(Status = const("Pending Approval"),
                                                               "Applicant User ID" = field("User Filter")));
            FieldClass = FlowField;
        }
        field(50059; "Leave - Approved"; Integer)
        {
            CalcFormula = count("HR Leave Application." where(Status = const(Approved),
                                                               "Applicant User ID" = field("User Filter")));
            FieldClass = FlowField;
        }
        field(50060; "Leave - Rejected"; Integer)
        {
            CalcFormula = count("HR Leave Application." where(Status = const(Rejected),
                                                               "Applicant User ID" = field("User Filter")));
            FieldClass = FlowField;
        }
        field(50061; "Member Application - Open"; Integer)
        {
            CalcFormula = count("Member Registration" where(Status = const(Open),
                                                             "Group Account" = const(false)));
            FieldClass = FlowField;
        }
        field(50062; "Member Application - Pending"; Integer)
        {
            CalcFormula = count("Member Registration" where(Status = const(Pending),
                                                             "Group Account" = const(false)));
            FieldClass = FlowField;
        }
        field(50063; "Group Application - Open"; Integer)
        {
            CalcFormula = count("Member Registration" where(Status = const(Open),
                                                             "Group Account" = const(false)));
            FieldClass = FlowField;
        }
        field(50064; "Group Application - Pending"; Integer)
        {
            CalcFormula = count("Member Registration" where(Status = const(Pending),
                                                             "Group Account" = const(false)));
            FieldClass = FlowField;
        }
        /*field(50065; "Account Application - Open"; Integer)
        {
            CalcFormula = count("Member Accounts Application" where(Status = const(Open)));
            FieldClass = FlowField;
        }
        field(50066; "Account Application - Pending"; Integer)
        {
            CalcFormula = count("Member Accounts Application" where(Status = const(Pending)));
            FieldClass = FlowField;
        }*/
        field(50067; "Cashier Trans. - Open"; Integer)
        {
            CalcFormula = count("Teller Transaction" where(Posted = const(false),
                                                            Cashier = field("User Filter"),
                                                            Status = const(Open),
                                                            Mpesa = const(false)));
            FieldClass = FlowField;
        }
        field(50068; "Cashier Trans. - Pending"; Integer)
        {
            CalcFormula = count("Teller Transaction" where(Posted = const(false),
                                                            Cashier = field("User Filter"),
                                                            Status = const("Pending Approval"),
                                                            Mpesa = const(false)));
            FieldClass = FlowField;
        }
        field(50069; "Cashier Trans. - Approved"; Integer)
        {
            CalcFormula = count("Teller Transaction" where(Posted = const(false),
                                                            Cashier = field("User Filter"),
                                                            Status = const(Approved),
                                                            Mpesa = const(false)));
            FieldClass = FlowField;
        }
        field(50070; "Cashier Trans. - Posted"; Integer)
        {
            CalcFormula = count("Teller Transaction" where(Posted = const(true),
                                                            Cashier = field("User Filter"),
                                                            Mpesa = const(false)));
            FieldClass = FlowField;
        }
        field(50071; "Treasury/Teller - Open"; Integer)
        {
            CalcFormula = count("Treasury/Teller Transactions" where(Posted = const(false),
                                                                   Status = const(Open)));
            FieldClass = FlowField;
        }
        field(50072; "Treasury/Teller - Pending"; Integer)
        {
            CalcFormula = count("Treasury/Teller Transactions" where(Posted = const(false),
                                                                   Status = const(Pending)));
            FieldClass = FlowField;
        }
        field(50073; "Treasury/Teller - Approved"; Integer)
        {
            CalcFormula = count("Treasury/Teller Transactions" where(Posted = const(false),
                                                                   Status = const(Approved)));
            FieldClass = FlowField;
        }
        field(50074; "Treasury/Teller - Posted"; Integer)
        {
            CalcFormula = count("Treasury/Teller Transactions" where(Posted = const(true)));
            FieldClass = FlowField;
        }
        field(50075; "Transfer List"; Integer)
        {
            CalcFormula = count("Transfer Header" where("Assigned User ID" = field("User Filter")));
            FieldClass = FlowField;
        }
        field(50076; "Members - Active"; Integer)
        {
            CalcFormula = count(Customer where("Member Status" = const(Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50077; "Members - Dormant"; Integer)
        {
            CalcFormula = count(Customer where("Member Status" = const(Dormant)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50078; "Members - Deceased"; Integer)
        {
            CalcFormula = count(Customer where("Member Status" = const(Deceased)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50079; "Members - Closed"; Integer)
        {
            CalcFormula = count(Customer where("Member Status" = const(Closed)));
            Editable = false;
            FieldClass = FlowField;

        }
        field(50080; "Dep - Active"; Integer)
        {
            CalcFormula = count(Vendor where(Status = const(Active),
                                                         "Product Category" = const("Deposit Contribution")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50081; "Dep - Dormant"; Integer)
        {
            CalcFormula = count(Vendor where(Status = const(Dormant),
                                                         "Product Category" = const("Deposit Contribution")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50082; "Dep - Deceased"; Integer)
        {
            CalcFormula = count(Vendor where(Status = const(Deceased),
                                                         "Product Category" = const("Deposit Contribution")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50083; "Dep - Closed"; Integer)
        {
            CalcFormula = count(Vendor where(Status = const(Closed),
                                                         "Product Category" = const("Deposit Contribution")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

