
Table 52188435 "Member Changes"
{
    DrillDownPageID = "Member Changes List";
    LookupPageID = "Member Changes List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Members));

            trigger OnValidate()
            begin

                SetMemberDetails("Member No.");
                GetNextofkin;
                GetSignatory;
                GetPictures;
            end;
        }
        field(3; Name; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Address; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; City; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Phone No.", "Post Code", County, "KRA PIN", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(7; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Country/Region Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.ValidateCountryCode("Phone No.", "Post Code", County, "KRA PIN");
            end;
        }
        field(9; "Post Code"; Code[20])
        {
            Editable = false;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Phone No.", "Post Code", County, "KRA PIN", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(10; County; Text[30])
        {
            Editable = false;
        }
        field(11; "E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(12; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Member,Account;
        }
        field(13; Nationality; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Status"; Enum "Member Status Enum")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Employer Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Customer where("Account Type" = const(Employer));
        }
        field(16; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" <> 0D then
                    if "Date of Birth" > Today then
                        Error('Invalid Date of Birth. Future Date Detected');
            end;
        }
        field(17; "Terms of Employment"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(18; "Payroll/Staff No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "ID No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Mobile Phone No."; Code[15])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Single,Married,Divorced,Widowed,Others';
            OptionMembers = " ",Single,Married,Divorced,Widowed,Others;
        }
        field(22; "ID Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = "National ID","Alien ID","Military ID",Passport;
        }
        field(23; Gender; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = '  ,Male,Female';
            OptionMembers = "  ",Male,Female;
        }
        field(24; "First Name"; Text[15])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Middle Name"; Text[15])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; Surname; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Member Category"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member,Housing';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member",Housing;
        }
        field(28; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Bank Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "KRA PIN"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Recruited by Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Walk In,Marketer,Staff,Board Member,Member';
            OptionMembers = "Walk In",Marketer,Staff,"Board Member",Member;
        }
        field(37; "Relationship Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38; "Employer Name"; Text[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; "Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; "Restricted Member"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(41; "Recruited By"; Code[10])
        {
            Caption = 'Recruited By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42; Type; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Customer,Member,Employer;
        }
        field(43; "Company No."; Code[20])
        {
            Caption = 'Company No.';
            DataClassification = ToBeClassified;
            Editable = false;
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
        field(44; "Company Name"; Text[50])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Contact where(Type = const(Company));
            ValidateTableRelation = false;
        }
        field(45; "Salutation Code"; Code[10])
        {
            Caption = 'Salutation Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Salutation;
        }
        field(47; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(48; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(49; "Recruited By Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "Special Account"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Cannot Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "Other Type Of Business"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53; "Business Reg. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54; "Incorporation No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55; "Date of Bus. Incorporation"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56; "Business/Group Location"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(57; "Plot/Bldg/Street/Road"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(58; "Other Group Type"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(59; "Date of Bus. Reg."; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60; "Group Category"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ",Incorporated,"Non-Incorporated";
        }
        field(61; "Type of Business"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = "Limited Company","Investment Company",Other;
        }
        field(62; "Group No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Customer."No." where(Type = const(Group),
                                                 "Group Category" = const("Non-Incorporated"));
        }
        field(63; "Physically Challenged"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(64; "Group Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ",Single,Joint,Corporate,"Group",Parish,"Church & Church Development",Others;

        }
        field(65; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(66; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(67; "Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Individual,Joint,"Group(Non-Group)";
        }
        field(68; "Group Section"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Micro Group","Other Groups";
        }

        field(69; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(70; "Member Class"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Class";
        }
        field(50000; "Type of Change"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Bio Data","Communication Details","Banking Details","System Details";
        }
        field(50003; "New Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "New Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "New Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "New City"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Phone No.", "Post Code", County, "KRA PIN", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(50007; "New Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(50008; "New Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.ValidateCountryCode("Phone No.", "Post Code", County, "KRA PIN");
            end;
        }
        field(50009; "New Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Phone No.", "Post Code", County, "KRA PIN", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(50010; "New County"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "New E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(50012; "New Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Member,Account;
        }
        field(50013; "New Nationality"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "New Status"; Enum "Member Status Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "New Employer Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));
        }
        field(50016; "New Date of Birth"; Date)
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
        field(50017; "New Terms of Employment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(50018; "New Payroll/Staff No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "New ID No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "New Mobile Phone No."; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "New Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Divorced,Widowed,Others';
            OptionMembers = " ",Single,Married,Divorced,Widowed,Others;
        }
        field(50022; "New ID Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "National ID","Alien ID","Military ID",Passport;
        }
        field(50023; "New Gender"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Male,Female';
            OptionMembers = "  ",Male,Female;
        }
        field(50024; "New First Name"; Text[15])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "New Name" := CalculatedName;
            end;
        }
        field(50025; "New Middle Name"; Text[15])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "New Name" := CalculatedName;
            end;
        }
        field(50026; "New Surname"; Text[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "New Name" := CalculatedName;
            end;
        }
        field(50027; "New Member Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member,Housing';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member",Housing;
        }
        field(50028; "New Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "New Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "New Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "New Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "New Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "New Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "New Bank Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "New KRA PIN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "New Recruited by Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Walk In,Marketer,Staff,Board Member,Member';
            OptionMembers = "Walk In",Marketer,Staff,"Board Member",Member;
        }
        field(50037; "New Relationship Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "New Employer Name"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "New Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "New Restricted Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "New Recruited By"; Code[10])
        {
            Caption = 'Recruited By';
            DataClassification = ToBeClassified;
        }
        field(50042; "New Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Customer,Member,Employer;
        }
        field(50043; "New Company No."; Code[20])
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
        field(50044; "New Company Name"; Text[50])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(Company));
            ValidateTableRelation = false;
        }
        field(50045; "New Salutation Code"; Code[10])
        {
            Caption = 'Salutation Code';
            DataClassification = ToBeClassified;
            TableRelation = Salutation;
        }
        field(50047; "New Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "New Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "New Recruited By Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "New Special Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "New Cannot Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "New Other Type Of Business"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "New Business Reg. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "New Incorporation No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "New Date of Bus. Incorporation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "New Business/Group Location"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "New Plot/Bldg/Street/Road"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "New Other Group Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "New Date of Bus. Reg."; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "New Group Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Incorporated,"Non-Incorporated";
        }
        field(50061; "New Type of Business"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Limited Company","Investment Company",Other;
        }
        field(50062; "New Group No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where(Type = const(Group),
                                                 "Group Category" = const("Non-Incorporated"));
        }
        field(50063; "New Physically Challenged"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "New Group Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Single,Joint,Corporate,"Group",Parish,"Church & Church Development",Others;
        }
        field(50065; "New Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50066; "New Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50067; "Change Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",General,"Employment Details",Communication,"Bank Details","Other Information","Next of Kin","Authorized Persons","Pic & Signature","Group Details",Rejoining;

            trigger OnValidate()
            begin
                if "Change Type" = "change type"::"Next of Kin" then
                    Validate("Member No.");

                if "Change Type" = "change type"::"Authorized Persons" then
                    Validate("Member No.");

                if "Change Type" = "Change Type"::Rejoining then
                    Validate("Member No.");

            end;
        }
        field(50068; Picture; Blob)
        {
            Caption = 'Picture';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50069; Signature; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50070; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(50071; "Reason For Change"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50072; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50074; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "New Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Individual,Joint,"Group(Non-Group)";
        }
        field(50076; "User Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "New Group Section"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Micro Group","Other Groups";
        }

        field(50078; "New Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50079; "New Member Class"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Class";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if Code = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Member Changes Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Member Changes Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;

        Date := Today;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        CommentLine: Record "Comment Line";
        SalesOrderLine: Record "Sales Line";
        CustBankAcc: Record "Customer Bank Account";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ShippingAgentService: Record "Shipping Agent Services";
        //ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        //SalesPrice: Record "Sales Price";
        //SalesLineDisc: Record "Sales Line Discount";
        SalesPrepmtPct: Record "Sales Prepayment %";
        ServContract: Record "Service Contract Header";
        ServiceItem: Record "Service Item";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InsertFromContact: Boolean;
        InsertFromTemplate: Boolean;
        LookupRequested: Boolean;
        Members: Record Customer;
        AppAccountSignatories: Record "Account Signatories.";
        AccountSignatories: Record "Account Signatories.";


    procedure InitFields()
    begin


        Type := Type::Member;
        "First Name" := '';
        Surname := '';
        "Middle Name" := '';
        Name := '';
        "Registration Date" := 0D;
        "ID No." := '';
        "Date of Birth" := 0D;
        "KRA PIN" := '';
        Gender := Gender::"  ";
        "Marital Status" := "marital status"::" ";
        "Employer Code" := '';
        "Employer Name" := '';
        "Terms of Employment" := "terms of employment"::" ";
        "Payroll/Staff No." := '';
        "Member Category" := 0;
        Address := '';
        "Address 2" := '';
        City := '';
        Nationality := '';
        "Country/Region Code" := '';
        "Phone No." := '';
        "Mobile Phone No." := '';
        "E-Mail" := '';
        "Group Section" := "group section"::" ";

        "Global Dimension 2 Code" := '';
        "Recruited by Type" := 0;
        "Recruited By" := '';
        "Recruited By Name" := '';
        "Status" := "Status"::" ";
        "Bank Code" := '';
        "Bank Name" := '';
        "Branch Code" := '';
        "Branch Name" := '';
        "Bank Account No." := '';
        "Swift Code" := '';
        "Salutation Code" := '';
        "Group No." := '';
        "Physically Challenged" := false;
        "Special Account" := false;
        "Cannot Guarantee" := false;
        "Member Class" := '';

        //Group
        "Group Account" := false;
        "Other Type Of Business" := '';
        "Business Reg. No." := '';
        "Incorporation No." := '';
        "Date of Bus. Incorporation" := 0D;
        "Business/Group Location" := '';
        "Group Type" := 0;
        "Other Group Type" := '';
        "Date of Bus. Reg." := 0D;
        "Group Category" := 0;
        "Type of Business" := 0;
        "Account Category" := "account category"::Individual;



        //NEW


        "New Type" := "new type"::Member;
        "New First Name" := '';
        "New Surname" := '';
        "New Middle Name" := '';
        "New Name" := '';
        "New Registration Date" := 0D;
        "New ID No." := '';
        "New Date of Birth" := 0D;
        "New KRA PIN" := '';
        "New Gender" := "new gender"::"  ";
        "New Marital Status" := "new marital status"::" ";
        "New Employer Code" := '';
        "New Employer Name" := '';
        "New Terms of Employment" := 0;
        "New Payroll/Staff No." := '';
        "New Member Category" := 0;
        "New Address" := '';
        "New Address 2" := '';
        "New City" := '';
        "New Nationality" := '';
        "New Country/Region Code" := '';
        "New Phone No." := '';
        "New Mobile Phone No." := '';
        "New E-Mail" := '';

        "New Global Dimension 2 Code" := '';
        "New Recruited by Type" := 0;
        "New Recruited By" := '';
        "New Recruited By Name" := '';
        "New Status" := "new status"::" ";
        "New Bank Code" := '';
        "New Bank Name" := '';
        "New Branch Code" := '';
        "New Swift Code" := '';
        "New Branch Name" := '';
        "New Bank Account No." := '';
        "New Salutation Code" := '';
        "New Group No." := '';
        "New Physically Challenged" := false;
        "New Special Account" := false;
        "New Cannot Guarantee" := false;
        "New Member Class" := '';

        //Group
        "New Group Account" := false;
        "New Other Type Of Business" := '';
        "New Business Reg. No." := '';
        "New Incorporation No." := '';
        "New Date of Bus. Incorporation" := 0D;
        "New Business/Group Location" := '';
        "New Group Type" := 0;
        "New Other Group Type" := '';
        "New Date of Bus. Reg." := 0D;
        "New Group Category" := 0;
        "New Type of Business" := 0;
    end;


    procedure SetMemberDetails(MNo: Code[20])
    begin

        InitFields;
        if Members.Get(MNo) then begin

            Type := Members.Type;
            "First Name" := UpperCase(Members."First Name");
            Surname := UpperCase(Members.Surname);
            "Middle Name" := UpperCase(Members."Middle Name");
            Name := UpperCase(Members.Name);
            "Registration Date" := Members."Registration Date";
            "ID No." := Members."ID No.";
            "Date of Birth" := Members."Date of Birth";
            "KRA PIN" := Members."KRA PIN";
            Gender := Members.Gender;
            "Marital Status" := Members."Marital Status";
            "Employer Code" := Members."Employer Code";
            "Employer Name" := Members."Employer Name";
            "Terms of Employment" := Members."Terms of Employment";
            "Payroll/Staff No." := Members."Payroll/Staff No.";
            "Member Category" := Members."Member Category";
            "Captured By" := Members."Captured By";
            Address := Members.Address;
            "Address 2" := Members."Address 2";
            City := Members.City;
            Nationality := Members.Nationality;
            "Country/Region Code" := Members."Country/Region Code";
            "Phone No." := Members."Phone No.";
            "Mobile Phone No." := Members."Mobile Phone No.";
            "E-Mail" := Members."E-Mail";
            "Global Dimension 2 Code" := Members."Global Dimension 2 Code";
            "Recruited by Type" := Members."Recruited by Type";
            "Recruited By" := Members."Recruited By";
            "Recruited By Name" := Members."Recruited By Name";
            "Status" := Members."Member Status";

            if "Change Type" = "Change Type"::Rejoining then begin

                if Members."Member Status" <> Members."Member Status"::Closed then
                    if Members."Member Status" = Members."Member Status"::Withdrawn then
                        Error('Member is not withdrawan');
            end;
            "Bank Code" := Members."Bank Code";
            "Swift Code" := Members."Swift Code";
            "Bank Name" := Members."Bank Name";
            "Branch Code" := Members."Branch Code";
            "Branch Name" := Members."Branch Name";
            "Bank Account No." := Members."Bank Account No.";
            "Salutation Code" := Members."Salutation Code";
            "Group No." := Members."Group No.";
            "Group Section" := Members."Group Section";

            "Physically Challenged" := Members."Physically Challenged";
            "Special Account" := Members."Special Account";
            "Cannot Guarantee" := Members."Cannot Guarantee";
            "Member Class" := Members."Member Class";


            //Group
            "Group Account" := Members."Group Account";
            "Other Type Of Business" := Members."Other Type Of Business";
            "Business Reg. No." := Members."Business Reg. No.";
            "Incorporation No." := Members."Incorporation No.";
            "Date of Bus. Incorporation" := Members."Date of Bus. Incorporation";
            "Business/Group Location" := Members."Business/Group Location";
            "Group Type" := Members."Group Type";
            "Other Group Type" := Members."Other Group Type";
            "Date of Bus. Reg." := Members."Date of Bus. Reg.";
            "Group Category" := Members."Group Category";
            "Type of Business" := Members."Type of Business";
            "Account Category" := Members."Account Category";


        end;
    end;


    procedure UpdateMember(MNo: Code[20])
    var
        NextOfKinApp: Record "Next of Kin.";
        NextOfKin: Record "Next of Kin.";
        MemberImages: Record "Member Images";
        ProductSetup: Record "Product Setup";
        PGroup: Record "Vendor Posting Group";
        MemberAccounts: Record Vendor;
        MemberActivities: Codeunit "Member Activities";
        SActivities: Codeunit "Sacco Activities";
        JTemplate: Code[20];
        JBatch: Code[20];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        PreviousMember: Record Customer;




    begin

        if PreviousMember.Get(MNo) then;

        if Members.Get(MNo) then begin

            if "Change Type" = "change type"::"Bank Details" then begin
                if "New Swift Code" <> '' then
                    Members."Swift Code" := "New Swift Code";
                if "New Bank Code" <> '' then
                    Members."Bank Code" := "New Bank Code";
                if "New Bank Name" <> '' then
                    Members."Bank Name" := "New Bank Name";
                if "New Branch Code" <> '' then
                    Members."Branch Code" := "New Branch Code";
                if "New Branch Name" <> '' then
                    Members."Branch Name" := "New Branch Name";
                if "New Bank Account No." <> '' then
                    Members."Bank Account No." := "New Bank Account No.";

                Members.Modify;
            end;
            if "Change Type" = "change type"::Communication then begin
                if "New Address" <> '' then
                    Members.Address := "New Address";
                if "New Address 2" <> '' then
                    Members."Address 2" := "New Address 2";
                if "New Nationality" <> '' then
                    Members.Nationality := "New Nationality";
                if "New City" <> '' then
                    Members.City := "New City";
                if "New Country/Region Code" <> '' then
                    Members."Country/Region Code" := "New Country/Region Code";
                if "New Phone No." <> '' then
                    Members."Phone No." := "New Phone No.";
                if "New Mobile Phone No." <> '' then begin

                    Members."Mobile Phone No." := "New Mobile Phone No.";

                    MemberAccounts.Reset;
                    MemberAccounts.SetRange("Member No.", Members."No.");
                    if MemberAccounts.FindFirst then begin
                        MemberAccounts.ModifyAll("Mobile Phone No.", "New Mobile Phone No.");
                    end;
                end;
                if "New E-Mail" <> '' then
                    Members."E-Mail" := "New E-Mail";

                Members.Modify;
            end;
            if "Change Type" = "change type"::"Employment Details" then begin

                if "New Employer Code" <> '' then
                    Members."Employer Code" := "New Employer Code";
                if "New Employer Name" <> '' then
                    Members."Employer Name" := "New Employer Name";
                if "New Terms of Employment" <> "new terms of employment"::" " then
                    Members."Terms of Employment" := "New Terms of Employment";
                if "New Payroll/Staff No." <> '' then
                    Members."Payroll/Staff No." := "New Payroll/Staff No.";

                Members.Modify;
            end;

            if "Change Type" = "change type"::General then begin

                if "New First Name" <> '' then
                    Members."First Name" := UpperCase("New First Name");
                if "New Surname" <> '' then
                    Members.Surname := UpperCase("New Surname");
                if "New Middle Name" <> '' then
                    Members."Middle Name" := UpperCase("New Middle Name");
                Members."Member Category" := "New Member Category";
                if "New Name" <> '' then
                    Members.Name := UpperCase("New Name");
                if "New ID No." <> '' then
                    Members."ID No." := "New ID No.";
                if "New Date of Birth" <> 0D then
                    Members."Date of Birth" := "New Date of Birth";
                if "New KRA PIN" <> '' then
                    Members."KRA PIN" := "New KRA PIN";
                if "New Gender" <> "new gender"::"  " then
                    Members.Gender := "New Gender";
                if "New Marital Status" <> "new marital status"::" " then
                    Members."Marital Status" := "New Marital Status";

                if "New Name" <> '' then begin
                    MemberAccounts.Reset;
                    MemberAccounts.SetRange("Member No.", Members."No.");
                    if MemberAccounts.FindFirst then begin
                        MemberAccounts.ModifyAll(Name, UpperCase("New Name"));
                    end;
                end;
                if "New Member Class" <> '' then
                    Members."Member Class" := UpperCase("New Member Class");


                if "New Salutation Code" <> '' then
                    Members."Salutation Code" := "New Salutation Code";
                if "New Status" <> "new status"::" " then
                    Members."Member Status" := "New Status";
                if "New Physically Challenged" <> xRec."New Physically Challenged" then
                    Members."Physically Challenged" := "New Physically Challenged";
                if "New Group No." <> '' then
                    Members."Group No." := "New Group No.";


                Members.Modify;

                if "New Group No." <> '' then begin
                    ProductSetup.Reset;
                    ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Micro Member Deposit");
                    if ProductSetup.FindFirst then begin
                        MemberAccounts.Reset;
                        MemberAccounts.SetRange("Member No.", Members."No.");
                        MemberAccounts.SetRange("Product Type", ProductSetup."Product ID");
                        if not MemberAccounts.FindFirst then
                            MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, false, ProductSetup."Repay Mode");
                    end;
                end;

            end;

            if "Change Type" = "change type"::Rejoining then begin
                Members."Member Status" := Members."Member Status"::Active;
                Members."Registration Date" := Today;
                Members.Rejoined := true;
                Members."Date Rejoined" := Today;

                Members.Modify();

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    repeat
                        MemberAccounts.Status := MemberAccounts.Status::Active;
                        MemberAccounts.Blocked := MemberAccounts.Blocked::" ";
                        MemberAccounts.Modify;
                    until MemberAccounts.Next() = 0;
                end;

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Registration Fee");
                MemberAccounts.SetFilter("Balance (LCY)", '<>%1', 0);
                if MemberAccounts.FindFirst then begin
                    SActivities.GetGeneralJournalTemplate(JTemplate, JBatch);
                    MemberAccounts.CalcFields("Balance (LCY)");
                    SActivities.JournalInit(JTemplate, JBatch);
                    PGroup.Get(MemberAccounts."Vendor Posting Group");

                    SActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        Code,
                        Today,
                        Accttype::Savings,
                        MemberAccounts."No.",
                        CopyStr('REJOINING ZEROLIZATION', 1, 50),
                        Balaccttype::"G/L Account",
                        PGroup."Payables Account",
                        MemberAccounts."Balance (LCY)" * -1,
                        cODE,
                        '',
                        Transtype::" ",
                        "Global Dimension 1 Code",
                        "Global Dimension 2 Code",
                        true
                        );
                    SActivities.JournalPost(JTemplate, JBatch);

                end;
            end;

            if "Change Type" = "change type"::"Other Information" then begin

                if "New Recruited by Type" <> xRec."New Recruited by Type" then
                    Members."Recruited by Type" := "New Recruited by Type";
                if "New Recruited By" <> '' then
                    Members."Recruited By" := "New Recruited By";
                if "New Recruited By Name" <> '' then
                    Members."Recruited By Name" := "New Recruited By Name";
                if "New Member Category" <> xRec."New Member Category" then
                    Members."Member Category" := "New Member Category";
                if "New Global Dimension 2 Code" <> '' then
                    Members."Global Dimension 2 Code" := "New Global Dimension 2 Code";
                if "New Special Account" <> xRec."New Special Account" then
                    Members."Special Account" := "New Special Account";
                if "New Cannot Guarantee" <> xRec."New Cannot Guarantee" then
                    Members."Cannot Guarantee" := "New Cannot Guarantee";
                if "New Account Category" <> xRec."New Account Category" then
                    Members."Account Category" := "New Account Category";

                Members.Modify;
            end;


            if "Change Type" = "change type"::"Group Details" then begin
                //Group

                if "New Other Type Of Business" <> '' then
                    Members."Other Type Of Business" := "New Other Type Of Business";
                if "New Business Reg. No." <> '' then
                    Members."Business Reg. No." := "New Business Reg. No.";
                if "New Incorporation No." <> '' then
                    Members."Incorporation No." := "New Incorporation No.";
                if "New Date of Bus. Incorporation" <> 0D then
                    Members."Date of Bus. Incorporation" := "New Date of Bus. Incorporation";
                if "New Business/Group Location" <> '' then
                    Members."Business/Group Location" := "New Business/Group Location";
                if "New Group Type" <> xRec."New Group Type" then
                    Members."Group Type" := "New Group Type";
                if "New Other Group Type" <> '' then
                    Members."Other Group Type" := "New Other Group Type";
                if "New Date of Bus. Reg." <> 0D then
                    Members."Date of Bus. Reg." := "New Date of Bus. Reg.";
                if "New Group Category" <> xRec."New Group Category" then
                    Members."Group Category" := "New Group Category";
                if "New Type of Business" <> xRec."New Type of Business" then
                    Members."Type of Business" := "New Type of Business";
                if "New Group Section" <> xRec."New Group Section" then
                    Members."Group Section" := "New Group Section";

                Members.Modify;
            end;

            if "Change Type" = "change type"::"Next of Kin" then begin

                NextOfKinApp.Reset;
                NextOfKinApp.SetRange("No.", Code);
                if NextOfKinApp.Find('-') then begin

                    NextOfKin.Reset;
                    NextOfKin.SetRange("No.", Members."No.");
                    if NextOfKin.Find('-') then
                        NextOfKin.DeleteAll;

                    repeat
                        NextOfKin.Init;
                        NextOfKin."No." := Members."No.";
                        NextOfKin."ID No." := NextOfKinApp."ID No.";
                        NextOfKin.Name := UpperCase(NextOfKinApp.Name);
                        NextOfKin.Relationship := NextOfKinApp.Relationship;
                        NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                        NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                        NextOfKin."Mobile Phone No." := NextOfKinApp."Mobile Phone No.";
                        NextOfKin.Email := NextOfKinApp.Email;
                        NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                        NextOfKin.Spouse := NextOfKinApp.Spouse;
                        NextOfKin.Insert;
                    until NextOfKinApp.Next = 0;
                end;

            end;

            if "Change Type" = "change type"::"Authorized Persons" then begin


                AppAccountSignatories.Reset;
                AppAccountSignatories.SetRange(AppAccountSignatories.Code, Code);
                if AppAccountSignatories.Find('-') then begin
                    repeat
                        AccountSignatories.Init;
                        AccountSignatories.Code := Members."No.";
                        AccountSignatories."Member No." := AppAccountSignatories."Member No.";
                        AccountSignatories."ID No." := AppAccountSignatories."ID No.";
                        AccountSignatories.Name := UpperCase(AppAccountSignatories.Name);
                        AccountSignatories."Date Of Birth" := AppAccountSignatories."Date Of Birth";
                        AccountSignatories."Staff/Payroll" := AppAccountSignatories."Staff/Payroll";
                        //AccountSignatories."Salesperson Code":=AppAccountSignatories."Salesperson Code";
                        AccountSignatories."Phone No." := AppAccountSignatories."Phone No.";
                        AccountSignatories.Signatory := AppAccountSignatories.Signatory;
                        AccountSignatories."Must Sign" := AppAccountSignatories."Must Sign";
                        AccountSignatories."Must be Present" := AppAccountSignatories."Must be Present";
                        AppAccountSignatories.CalcFields(AppAccountSignatories.Signature, AppAccountSignatories.Picture);
                        AccountSignatories.Picture := AppAccountSignatories.Picture;
                        AccountSignatories.Signature := AppAccountSignatories.Signature;
                        AccountSignatories."Expiry Date" := AppAccountSignatories."Expiry Date";
                        //AccountSignatories."Mobile No.":=AppAccountSignatories."Mobile No.";
                        AccountSignatories.Insert;

                        if AppAccountSignatories.Picture.Hasvalue then begin
                            Clear(AppAccountSignatories.Picture);
                            AppAccountSignatories.Modify;
                        end;

                        if AppAccountSignatories.Signature.Hasvalue then begin
                            Clear(AppAccountSignatories.Signature);
                            AppAccountSignatories.Modify;
                        end;

                    until AppAccountSignatories.Next = 0;
                end;

            end;

            if "Change Type" = "change type"::"Pic & Signature" then begin

                MemberImages.Reset;
                MemberImages.SetRange("Member No.", Members."No.");
                if MemberImages.Find('-') then
                    MemberImages.DeleteAll;

                CalcFields(Picture, Signature);

                MemberImages.Init;
                MemberImages."Member No." := Members."No.";
                MemberImages.Picture := Picture;
                MemberImages.Signature := Signature;
                MemberImages.Insert(true);
            end;

            TrackTheChangesDone(Rec, PreviousMember, Members);

        end;
    end;

    procedure TrackTheChangesDone(Memberchanges: Record "Member Changes"; PrevMember: Record Customer; UpdatedMember: Record Customer)
    var
        PrevRecRef: RecordRef;
        UpdatedRecRef: RecordRef;
        Field: Record Field;
        MemberChgLog: Record "Member Change Log";
        PFRef: FieldRef;
        UpdatedFRef: FieldRef;
    begin

        if Memberchanges."Change Type" in [Memberchanges."Change Type"::"Authorized Persons",
        Memberchanges."Change Type"::"Next of Kin", Memberchanges."Change Type"::"Pic & Signature"] then
            exit;

        PrevRecRef.GetTable(PrevMember);
        UpdatedRecRef.GetTable(UpdatedMember);

        Field.Reset();
        Field.SetRange(TableNo, Database::Customer);
        Field.SetRange(ObsoleteState, Field.ObsoleteState::No);
        Field.SetFilter(Type, '<>%1&<>%2&<>%3', Field.Type::BLOB, Field.Type::Media, Field.Type::MediaSet);
        Field.SetFilter(FieldName, '<>%1&<>%2', Field.FieldName(SystemModifiedAt), Field.FieldName(SystemModifiedBy));
        IF Field.FindSet() THEN
            Repeat
                PFRef := PrevRecRef.Field(Field."No.");
                UpdatedFRef := UpdatedRecRef.Field(Field."No.");
                if (PFRef.Value <> UpdatedFRef.Value) then begin


                    MemberChgLog.Init();
                    MemberChgLog."Log No." := 0;
                    MemberChgLog."Member No." := UpdatedMember."No.";
                    MemberChgLog."Field Name" := Field.FieldName;
                    MemberChgLog."Date Changed" := Today;
                    MemberChgLog."Time Changed" := Time;
                    MemberChgLog."User ID" := UserId;
                    MemberChgLog."Previous Value" := CopyStr(Format(PFRef.Value), 1, 250);
                    MemberChgLog."New Value" := CopyStr(Format(UpdatedFRef.Value), 1, 250);
                    MemberChgLog."Reason For Change" := Memberchanges."Reason For Change";
                    MemberChgLog."Member Change No" := Memberchanges.Code;
                    MemberChgLog.Insert();
                end;
            until Field.Next() = 0;
    end;


    procedure GetNextofkin()
    var
        NextOfKinApp: Record "Next of Kin.";
        NextOfKin: Record "Next of Kin.";
    begin
        NextOfKinApp.Reset;
        NextOfKinApp.SetRange("No.", Code);
        if NextOfKinApp.Find('-') then
            NextOfKinApp.DeleteAll;

        NextOfKin.Reset;
        NextOfKin.SetRange("No.", "Member No.");
        if NextOfKin.Find('-') then begin
            repeat

                NextOfKinApp.Init;
                NextOfKinApp."No." := Code;
                NextOfKinApp."ID No." := NextOfKin."ID No.";
                NextOfKinApp.Name := UpperCase(NextOfKin.Name);
                NextOfKinApp.Relationship := NextOfKin.Relationship;
                NextOfKinApp.Beneficiary := NextOfKin.Beneficiary;
                NextOfKinApp."Date of Birth" := NextOfKin."Date of Birth";
                NextOfKinApp."Mobile Phone No." := NextOfKin."Mobile Phone No.";
                NextOfKinApp.Email := NextOfKin.Email;
                NextOfKinApp."%Allocation" := NextOfKin."%Allocation";
                NextOfKinApp.Spouse := NextOfKin.Spouse;
                NextOfKinApp.Insert;

            until NextOfKin.Next = 0;
        end;
    end;

    local procedure GetPictures()
    var
        MemberImages: Record "Member Images";
    begin

        MemberImages.Reset;
        MemberImages.SetRange("Member No.", "Member No.");
        if MemberImages.Find('-') then begin
            MemberImages.CalcFields(Picture, Signature);
            Picture := MemberImages.Picture;
            Signature := MemberImages.Signature;
        end;
    end;


    procedure GetSignatory()
    var
        NextOfKinApp: Record "Next of Kin.";
        NextOfKin: Record "Next of Kin.";
    begin

        AppAccountSignatories.Reset;
        AppAccountSignatories.SetRange(Code, Code);
        if AppAccountSignatories.Find('-') then
            AppAccountSignatories.DeleteAll;



        AccountSignatories.Reset;
        AccountSignatories.SetRange(Code, "Member No.");
        if AccountSignatories.Find('-') then begin
            repeat

                AppAccountSignatories.Init;
                AppAccountSignatories.Code := Code;
                AppAccountSignatories."Member No." := AccountSignatories."Member No.";
                AppAccountSignatories."ID No." := AccountSignatories."ID No.";
                AppAccountSignatories.Name := UpperCase(AccountSignatories.Name);
                AppAccountSignatories."Date Of Birth" := AccountSignatories."Date Of Birth";
                AppAccountSignatories."Staff/Payroll" := AccountSignatories."Staff/Payroll";
                //AppAccountSignatories."Salesperson Code":=AccountSignatories."Salesperson Code";
                AppAccountSignatories."Phone No." := AccountSignatories."Phone No.";
                AppAccountSignatories.Signatory := AccountSignatories.Signatory;
                AppAccountSignatories."Must Sign" := AccountSignatories."Must Sign";
                AppAccountSignatories."Must be Present" := AccountSignatories."Must be Present";
                AccountSignatories.CalcFields(AccountSignatories.Signature, AccountSignatories.Picture);
                AppAccountSignatories.Picture := AccountSignatories.Picture;
                AppAccountSignatories.Signature := AccountSignatories.Signature;
                AppAccountSignatories."Expiry Date" := AccountSignatories."Expiry Date";
                //AppAccountSignatories."Mobile No.":=AccountSignatories."Mobile No.";
                AppAccountSignatories.Insert;

            until AccountSignatories.Next = 0;
        end;
    end;

    local procedure CalculatedName() NewName: Text[50]
    var
        NewName92: Text[92];
    begin
        if "New First Name" <> '' then
            NewName92 := "New First Name"
        else
            NewName92 := "First Name";
        if "New Middle Name" <> '' then
            NewName92 := NewName92 + ' ' + "New Middle Name"
        else
            NewName92 := NewName92 + ' ' + "Middle Name";
        if "New Surname" <> '' then
            NewName92 := NewName92 + ' ' + "New Surname"
        else
            NewName92 := NewName92 + ' ' + Surname;

        NewName92 := DelChr(NewName92, '<', ' ');
        NewName := CopyStr(NewName92, 1, MaxStrLen(NewName));
    end;
}

