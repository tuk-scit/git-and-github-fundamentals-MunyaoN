tableextension 52188425 UserSetupExt extends "User Setup"
{
    fields
    {
        field(50050; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50051; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }


        field(50052; "CashRec Journal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const("Cash Receipts"));
        }
        field(50053; "CashRec Journal Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("CashRec Journal Template"));

            trigger OnValidate()
            begin
                UserTemp.Reset;
                UserTemp.SetRange("CashRec Journal Template", "CashRec Journal Template");
                UserTemp.SetRange("CashRec Journal Batch", "CashRec Journal Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp."User ID" <> Rec."User ID") and ("CashRec Journal Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;
            end;
        }
        field(50054; "Payment Journal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(50055; "Payment Journal Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));

            trigger OnValidate()
            begin
                UserTemp.Reset;
                UserTemp.SetRange("Payment Journal Template", "Payment Journal Template");
                UserTemp.SetRange("Payment Journal Batch", "Payment Journal Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp."User ID" <> Rec."User ID") and ("Payment Journal Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;
            end;
        }
        field(50056; "General Journal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(50057; "General Journal Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("General Journal Template"));

            trigger OnValidate()
            begin
                UserTemp.Reset;
                UserTemp.SetRange("General Journal Template", "General Journal Template");
                UserTemp.SetRange("General Journal Batch", "General Journal Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp."User ID" <> Rec."User ID") and ("General Journal Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;
            end;
        }
        field(50058; "Max. Open Documents"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Default Payment Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Bank Account"."No." where ("Bank Type"=filter(Normal));
        }
        field(50060; "Default Petty Cash Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Bank Account"."No." where ("Bank Type"=filter("Petty Cash"|Cashier|Cash));
        }
        field(50061; Payroll; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Default Receipt Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(50063; "Use POS Printer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Type" = const(Member));
        }
        field(50065; "Imprest Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const("Staff Advance"));

            trigger OnValidate()
            begin
                UserTemp.Reset;
                UserTemp.SetRange("Imprest Account", "Imprest Account");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp."User ID" <> Rec."User ID") then begin
                            Error('Please note that another user has been assigned this imprest account.');
                        end;
                    until UserTemp.Next = 0;
                end;
            end;
        }
        field(50066; "Staff No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

        }
        field(50067; "Branch Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Board Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50069; "Staff Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50070; MBanking; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "View Staff Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Allow Bank to Bank Trans"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Disable SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "View Board Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50075; "File Movement Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }



    }

    var
        UserTemp: Record "User Setup";
}