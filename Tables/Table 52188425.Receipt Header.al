
Table 52188425 "Receipt Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Receipts Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Posting Date" > Today then Error('You can not post with a future date');
            end;
        }
        field(3; Cashier; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No." where("Responsibility Center" = field("Responsibility Center"),
                                                        "Currency Code" = field("Currency Code"));

            trigger OnValidate()
            begin
                if bank.Get("Bank Code") then
                    "Bank Name" := bank.Name;
            end;
        }
        field(9; Narration; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "On Behalf Of"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Amount Recieved"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");

                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    Dim1 := DimVal.Name
            end;
        }
        field(27; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");

                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Global Dimension 2 Code");
                if DimVal.Find('-') then
                    Dim2 := DimVal.Name
            end;
        }
        field(29; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(30; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(38; "Total Amount"; Decimal)
        {
            //CalcFormula = sum("Document Line".Amount where("Header No." = field("No.")));
            Editable = false;
            //FieldClass = FlowField;
        }
        field(39; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; "Print No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(41; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(42; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "No. Printed"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(45; "Created Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; "Register No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "From Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "To Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document Date" > Today then Error('You can not post with a future date');
            end;
        }
        field(81; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin


                TestField(Status, Status::Open);
            end;
        }
        field(83; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name
            end;
        }
        field(84; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name
            end;
        }
        field(86; Dim3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(87; Dim4; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Bank Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(89; "Receipt Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Bank,Cash';
            OptionMembers = Bank,Cash;
        }
        field(90; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        }
        field(91; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions
            end;
        }
        field(481; Dim1; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(482; Dim2; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(483; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Customer where("Account Type" = const(Members));

            TableRelation = if ("Customer Type" = const(Member)) Customer where(Type = filter(Member | Group))
            else
            if ("Customer Type" = const(Customer)) Customer where(Type = filter(" "));

            trigger OnValidate()
            begin

                "Member Name" := '';
                if Members.Get("Customer No.") then begin
                    "Member Name" := Members.Name;
                    "Received From" := Members.Name;
                end;
            end;

            trigger OnLookup()
            var
                cust: Record Customer;
            begin
                if "Customer Type" = "Customer Type"::Customer then begin
                    cust.RESET;
                    cust.SetRange(Type, cust.Type::" ");
                    if cust.FindFirst() then begin
                        IF PAGE.RUNMODAL(33, cust) = ACTION::LookupOK THEN BEGIN
                            "Customer No." := cust."No.";
                            VALIDATE("Customer No.");
                        END
                    end;
                end;
                if "Customer Type" = "Customer Type"::Member then begin
                    cust.RESET;
                    cust.SetFilter(Type, '<>%1', cust.Type::" ");
                    if cust.FindFirst() then begin
                        IF PAGE.RUNMODAL(52188511, cust) = ACTION::LookupOK THEN BEGIN
                            "Customer No." := cust."No.";
                            VALIDATE("Customer No.");
                            //xxx



                        END
                    end;
                end;

            end;
        }
        field(484; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50050; "Pay Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,"Mobile Money";
        }
        field(50051; "Cheque/Deposit Slip No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Cheque No." := "Cheque/Deposit Slip No";
            end;
        }
        field(50052; "Cheque/Deposit Slip Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Cheque/Deposit Slip Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " "," Local","Up Country";
        }
        field(50054; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Member,Customer;

            trigger OnValidate()
            begin
                "Customer No." := '';
                "Member Name" := '';
                Narration := '';
            end;
        }
        field(50055; "Received From"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50056; "Receipts Pending Approval"; Integer)
        {
            //AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Receipt Header" WHERE(Status = filter(Pending)));
            Caption = 'Receipts Pending Approval';
            FieldClass = FlowField;
        }

        field(50057; "Receipts Posted"; Integer)
        {
            //AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Receipt Header" WHERE(Posted = filter(true)));
            Caption = 'Receipts posted';
            FieldClass = FlowField;
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
        fieldgroup(DropDown; "No.", "Member Name", "Amount Recieved")
        {
        }
    }

    trigger OnInsert()
    begin


        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Receipts Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Receipts Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        UserTemplate.Get(UserId);


        "Created By" := UserId;
        "Created Date Time" := CurrentDatetime;
        Cashier := UserId;

        "Global Dimension 1 Code" := UserTemplate."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserTemplate."Global Dimension 2 Code";
        "Bank Code" := UserTemplate."Default Receipt Bank";
        Validate("Bank Code");

    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserTemplate: Record "User Setup";
        //RLine: Record "Document Line";
        RespCenter: Record "Responsibility Center";
        DimVal: Record "Dimension Value";
        bank: Record "Bank Account";
        DimMgt: Codeunit DimensionManagement;
        Members: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

