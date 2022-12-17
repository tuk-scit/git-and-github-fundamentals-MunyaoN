
TableExtension 52188504 tableextension52188404 extends Customer
{

    fields
    {
        modify("E-Mail")
        {
            Caption = 'Personal E-mail';
        }

        modify("County")
        {
            TableRelation = County;
        }

        field(50100; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Group,Member';
            OptionMembers = " ",Group,Member;
        }
        field(50101; Nationality; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Member Status"; Enum "Member Status Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Employer Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));
        }
        field(50106; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" <> 0D then
                    if "Date of Birth" > Today then
                        Error('Invalid Date of Birth. Future Date Detected');
            end;
        }
        field(50107; "Terms of Employment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(50108; "Payroll/Staff No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "ID No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50111; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Divorced,Widowed,Others';
            OptionMembers = " ",Single,Married,Divorced,Widowed,Others;
        }
        field(50112; "ID Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "National ID","Alien ID","Military ID",Passport;
        }
        field(50113; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Male,Female';
            OptionMembers = "  ",Male,Female;
        }
        field(50114; "First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50116; Surname; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50117; "Member Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member";
        }
        field(50118; "Test No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50119; "Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50120; "Bank Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50121; "Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50122; "Branch Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50123; "Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50124; "Bank Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50125; "KRA PIN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50126; "Recruited by Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Walk In",Marketer,Staff,"Board Member",Member,Website;

            trigger OnValidate()
            begin
                "Recruited By" := '';
                "Recruited By Name" := '';
            end;
        }
        field(50127; "Relationship Officer"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                "Relationship Officer Name" := '';
                if Employee.Get("Relationship Officer") then begin
                    "Relationship Officer Name" := Employee."First Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(50128; "Employer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50129; "Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Restricted Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Recruited By"; Code[100])
        {
            Caption = 'Recruited By';
            DataClassification = ToBeClassified;
        }
        field(50033; "Company No."; Code[20])
        {
            Caption = 'Company No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(Company));

            trigger OnValidate()
            var
                Opp: Record Opportunity;
                OppEntry: Record "Opportunity Entry";
                Task: Record "To-do";
                InteractLogEntry: Record "Interaction Log Entry";
                SegLine: Record "Segment Line";
                SalesHeader: Record "Sales Header";
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
            end;
        }
        field(50034; "Company Name"; Text[50])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(Company));
            ValidateTableRelation = false;
        }
        field(50035; "Salutation Code"; Code[10])
        {
            Caption = 'Salutation Code';
            DataClassification = ToBeClassified;
            TableRelation = Salutation;
        }
        field(50036; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Recruited By Name"; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Special Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Other Type Of Business"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Business Reg. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Incorporation No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Date of Bus. Incorporation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Business/Group Location"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Plot/Bldg/Street/Road"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Group Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Single,Joint,Corporate,"Group",Parish,"Church & Church Development",Others;
        }
        field(50048; "Other Group Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Date of Bus. Reg."; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Group Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Incorporated,"Non-Incorporated";
        }
        field(50051; "Type of Business"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Limited Company","Investment Company",Other;
        }
        field(50052; "Group No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where(Type = const(Group),
                                                 "Group Category" = const("Non-Incorporated"));
        }
        field(50053; "Physically Challenged"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Gross Dividends"; Decimal)
        {
            CalcFormula = sum("Dividends Progression"."Gross Dividends" where("Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(50055; "Cheques Bounced"; Integer)
        {
            CalcFormula = count("Teller Transaction" where("Member No." = field("No."),
                                                            "Cheque Status" = const(Bounced),
                                                            Posted = const(true)));
            FieldClass = FlowField;
        }
        field(50056; "Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Individual,Joint,Chamaa,Business,MicroGroup;
        }
        field(50057; "Relationship Officer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Branch Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Branch Manager Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Group Section"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Micro Group","Other Groups";
        }
        field(50061; "Last Deposit Date BF"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Mobile Loan Defaulter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; IsAgencyActivated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; AgencyPin; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(50000; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Travel Advance",Partner,"Staff Advance",Members,"Training Advance",Employer,"Cashier Excess","Cashier Shortage","MPESA",Shop;

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                //TestNoEntriesExist(FIELDCAPTION("Account Type"));
            end;
        }
        field(50002; "Document Limit"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Advice Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Changes,Everything';
            OptionMembers = " ",Changes,Everything;
        }
        field(50004; "Internal Staff Employer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(50006; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50007; "Dont Charge Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Loan Qualification"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Basic Pay,Gross Pay,Standing Order,Net Pay';
            OptionMembers = "Basic Pay","Gross Pay","Standing Order","Net Pay";
        }
        field(50010; "Self Employed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Cannot Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "CRB Employer Industry Type"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Stop Interest Due"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "From Another Sacco"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Member Class"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Class";
        }
        field(50017; "How Did You Know About Us"; Enum "How Did You Know About Us Enum")
        {
            DataClassification = ToBeClassified;
        }

        field(50066; "Employment Section"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Sections";
        }


        field(50067; Passport; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50069; "Industry Type"; Option)
        {
            OptionMembers = " ",Agriculture,Manufacturing,"Building/Construction","Mining/Quarrying","Energy/water",Trade,"Tourism/Restaurant/Hotels","Transport/Communications","Real Estate",Finance,Government,Other;
        }

        field(50070; "Meeting Day"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "Meeting Location"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50072; "Signing Instruction narration"; Text[30])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Mandate;
        }

        field(50073; "Previous Sacco No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "Pensioner"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "Commission Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
        }



        field(50076; "Rejoined"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Date Rejoined"; Date)
        {
            DataClassification = ToBeClassified;
        }



        field(50087; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Old Member No.", "ID No.", "Mobile Phone No.") { }

    }
}

