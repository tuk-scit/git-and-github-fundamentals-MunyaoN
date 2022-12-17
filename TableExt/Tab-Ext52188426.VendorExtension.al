tableextension 52188427 "Vendor Extension" extends Vendor
{
    fields
    {
        field(50050; "Creditor Type"; Enum "Creditor Type Enum")
        {
            Caption = 'Creditor Type';
            DataClassification = ToBeClassified;
        }


        field(50051; "Authorised Over Draft"; Decimal)
        {
            //CalcFormula = sum("Overdraft Header"."Approved Amount" where("Account No." = field("No."),
                                                                          //Posted = const(true),
                                                                         // Expired = const(false)));
            Description = 'Sum("Overdraft Header"."Approved Amount" WHERE (Account No.=FIELD(No.),Posted=CONST(Yes),Expired=CONST(No)))';
            //FieldClass = FlowField;
        }
        field(50052; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = sum("Teller Transaction".Amount where("Account No." = field("No."),
                                                                 Posted = const(true),
                                                                 Type = filter("Cheque Deposit" | "Credit Cheque"),
                                                                 "Cheque Status" = filter(Pending | Matured)));
            FieldClass = FlowField;
        }
        field(50053; "Lien Placed"; Decimal)
        {
            CalcFormula = sum("Teller Transaction".Amount where("Account No." = field("No."),
                                                                 Posted = const(true),
                                                                 Type = filter(Lien),
                                                                 "Cheque Status" = filter(Pending)));
            FieldClass = FlowField;
        }

        field(50001; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Registration Fee,Share Capital,Deposit Contribution,Benevolent Fund,Unallocated Fund,Dividend Account,Micro Member Deposit,Micro Group Deposit,Ordinary Savings,Holiday Savings,School Fee,Fixed Deposit,Junior Savings,Welfare,Housing,Asset Finance,FOSA Shares,Business,Jipange';
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Asset Finance","FOSA Shares",Business,Jipange;
        }
        field(50002; "Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup";
        }
        field(50003; "Product Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Members));
        }
        field(50005; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Monthly Contribution Date" := Today;
                "Contribution Updated By" := UserId;
            end;
        }
        field(50007; "ID No."; Code[50])
        {
            CalcFormula = lookup(Customer."ID No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(50009; "Payroll/Staff No."; Code[50])
        {
            CalcFormula = lookup(Customer."Payroll/Staff No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; Status; Enum "Account Status Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Group No."; Code[20])
        {
            CalcFormula = lookup(Customer."Group No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(50013; "Child Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Child Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Child Birth Cet. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Test Blocked"; Enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Signing Instructions Narration"; Text[200])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Mandate;
        }
        field(50018; "Transactional Mobile No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Monthly Contribution Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Contribution Updated By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Cheque Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Old Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Old Member No."; Code[20])
        {
            CalcFormula = lookup(Customer."Old Member No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(50024; "Next MLoan Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Member Category"; Option)
        {
            CalcFormula = lookup(Customer."Member Category" where("No." = field("Member No.")));
            FieldClass = FlowField;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member";
        }
        field(50058; "Last Transaction Date"; Date)
        {
            CalcFormula = max("Vendor Ledger Entry"."Posting Date" where("Amount (LCY)" = filter(< 0),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Vendor No." = field("No.")));
            FieldClass = FlowField;
        }
        /*field(50059; "Mobile Withdrawals"; Decimal)
        {
            CalcFormula = sum("Mobile Withdrawal Buffer".Amount where("Account No" = field("No."),
                                                                        Posted = const(false)));
            FieldClass = FlowField;
        }*/
        field(50060; "Cheque Book Mandate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Child Account Status"; Option)
        {
            OptionMembers = Child,"Pending Conversion",Converted;
        }

        field(50063; "Dormancy Period"; DateFormula)
        {
            CalcFormula = lookup("Product Setup"."Dormancy Period" where("Product ID" = field("Product Type")));
            FieldClass = FlowField;
        }

        field(50064; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loan Security" where("Account No." = field("No."),
                                                       Substituted = const(false),
                                                       "Outstanding Principal" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }


        field(50065; "ATM No."; Code[20])
        {
            Editable = false;
        }
        /*field(50066; "ATM Balance"; Decimal)
        {
            CalcFormula = sum("Coop ATM Transaction"."Total Account Debit" where("Member Account" = field("No."),
                                                                 Posted = const(true),
                                                                 "Transaction Type" = filter(<> 1420)));
            FieldClass = FlowField;
        }*/


        field(50067; "Piggy Bank Issued"; Boolean)
        {
            Editable = false;
        }

        field(50074; "Allow Bank Transfer"; Boolean)
        {
            Editable = false;
        }
        field(50068; "Mbanking Registered"; Boolean)
        {
            Editable = false;
        }
        field(50069; "Bank Transfer Trans. Limit"; Decimal)
        {
            Editable = false;
        }
        field(50070; "Bank Transfer Daily Limit"; Decimal)
        {
            Editable = false;
        }

        field(50071; "Allow Withdrawal To Others"; Boolean)
        {
            Editable = false;
        }
        field(50072; "Salary Processing"; Boolean)
        {
            Editable = false;
        }



        field(50073; "Old ATM No"; Code[20])
        {
            Editable = false;
        }



        field(50080; "Repay Mode"; Enum "Repay Mode Enum")
        {
        }


        /*field(50081; "Active Fixed Deposit"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Fixed Deposit Accounts"."FD Amount" where("Fixed Account No." = field("No."),
                                                                          Posted = const(true),
                                                                          "FD Status" = const(Active),
                                                                          "No." = field("FD Filter"),
                                                                          "Approval Status" = const(Approved)));
        }*/


        field(50082; "FD Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }

        field(50083; "Block Instant Loans"; Boolean)
        {
        }




        field(50087; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }


    }

    fieldgroups
    {
        addlast(DropDown; "Product Name", "Product Category", "ID No.", "Mobile Phone No.") { }

    }
}
