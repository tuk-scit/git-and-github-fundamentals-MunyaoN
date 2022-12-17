
Table 52188498 "Security Sub."
{
    ///DrillDownPageID = "Security Substitution List";
    ///LookupPageID = "Security Substitution List";

    fields
    {
        field(1; "No."; Code[10])
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
                Name := '';

                if Members.Get("Member No.") then
                    Name := Members.Name;
            end;
        }
        field(3; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(10; "Posted By"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Captured By"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Responsibility Centre"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; Date; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(19; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan No." where("Outstanding Principal" = filter(> 0),
                                                    "Member No." = field("Member No."));

            trigger OnValidate()
            begin

                if Loans.Get("Loan No.") then begin
                    Loans.CalcFields(Loans."Total Outstanding Balance");
                end;

                GenerateGuarantors();
            end;
        }
        field(20; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(23; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
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
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Security Substitution Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Security Substitution Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;


        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        "Captured By" := UserId;
        Date := Today;

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
    end;

    var
        Loans: Record Loans;
        Members: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";

    local procedure GenerateGuarantors()
    var
        SubGuarantor: Record "Security Sub. Lines";
        LoanSecurity: Record "Loan Security";
    begin

        SubGuarantor.Reset;
        SubGuarantor.SetRange("Header No.", "No.");
        if SubGuarantor.FindFirst then
            SubGuarantor.DeleteAll;

        LoanSecurity.Reset;
        LoanSecurity.SetRange(LoanSecurity."Loan No.", "Loan No.");
        //LoanSecurity.SETRANGE(LoanSecurity.Substituted,FALSE);
        if LoanSecurity.Find('-') then begin
            repeat

                SubGuarantor.Init;

                SubGuarantor.TransferFields(LoanSecurity);
                SubGuarantor."Header No." := "No.";
                SubGuarantor.Insert;

            until LoanSecurity.Next = 0;

        end;
    end;
}

