
Codeunit 52188443 "HR Make Leave Ledg. Entry"
{

    trigger OnRun()
    begin
    end;


    procedure CopyFromJnlLine(var InsCoverageLedgEntry: Record "HR Leave Ledger Entries.";var InsuranceJnlLine: Record "HR Leave Journal Line.")
    begin
        with InsCoverageLedgEntry do begin
          "User ID" := UserId;
          "Leave Calendar Code" := InsuranceJnlLine."Leave Calendar Code";
          "Staff No." := InsuranceJnlLine."Staff No.";
          "Staff Name" := InsuranceJnlLine."Staff Name";
          "Posting Date" := InsuranceJnlLine."Posting Date";
          "Leave Recalled No.":=InsuranceJnlLine."Leave Recalled No.";
          "Leave Entry Type" := InsuranceJnlLine."Leave Entry Type";
          "Leave Type":=InsuranceJnlLine."Leave Type";
          "Leave Approval Date" := InsuranceJnlLine."Leave Approval Date";
          "Leave Type":=InsuranceJnlLine."Leave Type";
           //"Leave Types":=InsuranceJnlLine."Leave Type Option";
          if "Leave Approval Date" = 0D then
          "Leave Approval Date" := "Posting Date";
          "Document No." :=  InsuranceJnlLine."Document No.";
          "External Document No." := InsuranceJnlLine."External Document No.";
           if InsuranceJnlLine."Leave Entry Type"=InsuranceJnlLine."leave entry type"::Negative then
           "No. of days" := -InsuranceJnlLine."No. of Days"
           else begin
           "No. of days" := InsuranceJnlLine."No. of Days";
          end;
          "Leave Posting Description" := InsuranceJnlLine.Description;
          "Global Dimension 1 Code" := InsuranceJnlLine."Global Dimension 1 Code";
          "Global Dimension 2 Code" := InsuranceJnlLine."Global Dimension 2 Code";
          "Source Code" := InsuranceJnlLine."Source Code";
          "Journal Batch Name" := InsuranceJnlLine."Journal Batch Name";
          "Reason Code" := InsuranceJnlLine."Reason Code";
          Closed := SetDisposedFA(InsCoverageLedgEntry."Staff No.");
          "No. Series" := InsuranceJnlLine."Posting No. Series";
        end;
    end;


    procedure CopyFromInsuranceCard(var InsCoverageLedgEntry: Record "HR Leave Ledger Entries.";var Insurance: Record "HR Leave Application.")
    begin
        /*WITH InsCoverageLedgEntry DO BEGIN
          "FA Class Code" := Insurance."FA Class Code";
          "FA Subclass Code" := Insurance."FA Subclass Code";
          "FA Location Code" := Insurance."FA Location Code";
          "Location Code" := Insurance."Location Code";
        END;*/

    end;


    procedure SetDisposedFA(FANo: Code[20]): Boolean
    var
        FASetup: Record "HR Setup.";
    begin
        /*FASetup.GET;
        FASetup.TESTFIELD("Insurance Depr. Book");
        IF FADeprBook.GET(FANo,FASetup."Insurance Depr. Book") THEN
          EXIT(FADeprBook."Disposal Date" > 0D)
        ELSE
          EXIT(FALSE);
         */

    end;


    procedure UpdateLeaveApp(LeaveCode: Code[20];Status: Option)
    var
        LeaveApplication: Record "HR Leave Application.";
    begin
    end;
}

