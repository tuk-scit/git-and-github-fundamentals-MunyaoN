Table 55006 "Loan Guarantors"
{

    fields
    {
        field(1; "Loan No"; Code[20])
        {
        }
        field(2; "SACCO Account No."; Code[20])
        {
            TableRelation = "SACCO Account"."No." where("Product Type" = filter('S02'));

            trigger OnValidate()
            var
                iEntryNo: Integer;
                LoansGTS: Record "Loan Guarantors";
                AmtGuaranteed: Decimal;
            begin






                //Set Member Guaranteed
                if LoansR.Get("Loan No") then
                    "Member Guaranteed" := LoansR."Member No.";






                //Check Max garantors
                LoansG := 0;
                GuaranteedPerc := 0;
                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."SACCO Account No.", "SACCO Account No.");
                if LoanGuarantors.Find('-') then begin


                end;


                //changed

                "No Of Loans Guaranteed" := LoansG;
                "Total Guaranteed" := TotalGuaranteed;
                "Available Shares" := Shares - "Total Guaranteed";



                //Check If Self Guarantee



                // send guarantors SMS


                // send guarantors SMS
            end;
        }
        field(3; Name; Text[200])
        {
            Editable = false;
        }
        field(4; "Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(5; Shares; Decimal)
        {
            Editable = false;
        }
        field(6; "No Of Loans Guaranteed"; Integer)
        {
            Editable = false;
        }
        field(7; Substituted; Boolean)
        {

            trigger OnValidate()
            begin
                Date := Today;
            end;
        }
        field(8; Date; Date)
        {
        }
        field(9; "Shares Recovery"; Boolean)
        {
        }
        field(10; "New Upload"; Boolean)
        {
        }
        field(11; "Amount Guaranteed"; Decimal)
        {

            trigger OnValidate()
            var
                AmtGuaranteed: Decimal;
                iEntryNo: Integer;
            begin
                //"Percentage Guaranteed":=("Amount Guaranteed"/Loans."Approved Amount")*100;


                /*
                IF Loans.GET("Loan No") THEN
                "Percentage Guaranteed":=("Amount Guaranteed"/Loans."Approved Amount")*100;
                 */


                AmtGuaranteed := "Amount Guaranteed";


            end;
        }
        field(12; "Staff/Payroll No."; Code[20])
        {

            trigger OnValidate()
            begin

                Cust.Reset;
                Cust.SetRange(Cust."Payroll/Staff No", "Staff/Payroll No.");
                Cust.SetRange(Cust."Loan Security Inclination", Cust."loan security inclination"::"Long Term Loan Security");
                if Cust.Find('-') then begin
                    "SACCO Account No." := Cust."No.";
                    Validate("SACCO Account No.");
                end
                else begin
                    "SACCO Account No." := '';
                    Error('Member deposits account not found.');
                end;
            end;
        }
        field(13; "Account No."; Code[20])
        {
        }
        field(14; "Self Guarantee"; Boolean)
        {
        }
        field(15; "ID No."; Code[50])
        {
        }
        field(17; "Member Guaranteed"; Code[50])
        {
        }
        field(18; "Percentage Guaranteed"; Decimal)
        {
        }
        field(19; "Total Guaranteed"; Decimal)
        {
        }
        field(20; "Available Shares"; Decimal)
        {
        }
        field(21; Signature; Blob)
        {
        }
        field(22; "Member No"; Code[20])
        {
        }
        field(24; "Guaranteed Balance"; Decimal)
        {
        }
        field(25; "Loanee Name"; Text[150])
        {
        }
        field(26; "% Proportion"; Decimal)
        {
        }
        field(27; "Amount Committed"; Decimal)
        {
        }
        field(28; "Amount Released"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", "Staff/Payroll No.", "SACCO Account No.", "Amount Guaranteed", Name)
        {
        }
        key(Key2; "Loan No", "SACCO Account No.")
        {
            Clustered = true;
            SumIndexFields = Shares;
        }
    }

    fieldgroups
    {
    }


    var
        Cust: Record "SACCO Account";
        LoanGuarantors: Record "Loan Guarantors";
        Loans: Record Loans;
        LoansR: Record Loans;
        LoansG: Integer;
        SelfGuaranteedA: Decimal;
        TotalGuaranteed: Decimal;
        BalanceRemaining: Decimal;
        LoanGuar: Record "Loan Guarantors";
        TotG: Decimal;
        Times4Shares: Decimal;
        GuaranteedPerc: Decimal;
        SumGuranteed: Decimal;

}

