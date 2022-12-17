
Table 52188504 "Member Exit Notice"
{
    //DrillDownPageID = "Member Exit Notice";
    //LookupPageID = "Member Exit Notice";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                Error('Invalid Operation');
            end;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Members));

            trigger OnValidate()
            begin
                Name := '';

                if Members.Get("Member No.") then begin
                    Name := Members.Name;
                end;
            end;
        }
        field(3; "Reason for withdrawal"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Withdrawa Noticel Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Withdrawa Noticel Date" < Today then
                    Message(ErrMsg);

                SaccoSetup.Get;
                SaccoSetup.TestField(SaccoSetup."Member Exit Notice Period");
                "Maturity Date" := CalcDate(Format(SaccoSetup."Member Exit Notice Period"), "Withdrawa Noticel Date");
            end;
        }
        field(5; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(10; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(14; "Letter of Withdrawal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Guarantor Substituted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Loans Offset"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Closure Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Withdrawal - Normal","Withdrawal - Death","Withdrawal - Normal (Quick)";
            trigger OnValidate()
            begin
                GetBeneficiaries();
            end;
        }
        field(50012; "Member Exit Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Administrator,Marketing,Credit,Finance';
            OptionMembers = "Administrator","Marketing","Credit","Finance";
        }
        field(50013; "Exit No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Customer Feedback"; TExt[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Interest to Rejoin"; Option)
        {
            OptionMembers = " ",Yes;
        }
        field(50016; "Date to Rejoin"; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Closure Type", "Withdrawa Noticel Date", Name)
        {
        }
    }

    trigger OnInsert()
    begin


        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Member Exit Notice Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Member Exit Notice Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;


        "Date Entered" := Today;
        "Entered By" := UserId;
        "Time Entered" := Time;

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    end;

    var
        Members: Record Customer;
        Txt00001: label 'You cannot delete approved record';
        ErrMsg: label 'You cannot base Withdrawa Noticel Date in the past';
        SaccoSetup: Record "Sacco Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";

    local procedure GetBeneficiaries()
    var
        ben: Record "Member Exit Beneficiary";
        Nok: Record "Next of Kin.";
    begin


        ben.Reset();
        ben.SetRange("Exit No.", "No.");
        if ben.FindFirst() then begin
            ben.DeleteAll();
        end;


        if "Closure Type" = "Closure Type"::"Withdrawal - Death" then begin

            Nok.Reset();
            Nok.SetRange("No.", "Member No.");
            //Nok.SetRange(Beneficiary, true);
            if Nok.FindFirst() then begin
                repeat

                    ben.Init();
                    ben."Exit No." := "No.";
                    ben."Principal Member No." := "Member No.";
                    ben."Principal Member Name" := Name;
                    ben."Beneficiary Name" := Nok.Name;
                    ben.Relation := Nok.Relationship;
                    ben.Insert();

                until Nok.Next() = 0;
            end;

        end;
    end;
}

