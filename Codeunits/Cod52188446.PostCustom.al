codeunit 52188446 PostCustom
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure OnBeforePostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    begin

        with GenJournalLine do
            case "Account Type" of
                "Account Type"::Savings:
                    begin
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                        GenJournalLine.Modify();
                    end;
                "Account Type"::Credit:
                    begin
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                        GenJournalLine."Credit Entry" := true;
                        GenJournalLine.Modify();
                    end;
            end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterGetCustomerReceivablesAccount', '', false, false)]

    local procedure OnAfterGetCustomerReceivablesAccount(GenJournalLine: Record "Gen. Journal Line"; CustomerPostingGroup: Record "Customer Posting Group"; var ReceivablesAccount: Code[20])
    var
        Loans: Record Loans;
        ProductSetup: Record "Product Setup";
    begin
        if GenJournalLine."Credit Entry" then begin

            ReceivablesAccount := '';
            GenJournalLine.TestField("Loan No.");
            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                Error('Transaction Type Missing for A/C ' + GenJournalLine."Account No.");
            Loans.Get(GenJournalLine."Loan No.");
            ProductSetup.Get(Loans."Loan Product Type");
            ReceivablesAccount := ProductSetup.GetReceivablesAccount(ProductSetup."Product ID", GenJournalLine."Transaction Type");
        end;
    end;










    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnValidateAccountNoOnAfterAssignValue', '', false, false)]
    local procedure OnValidateAccountNoOnAfterAssignValue(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line")
    begin

        case GenJournalLine."Account Type" of
            GenJournalLine."Account Type"::Savings:
                GenJournalLine.GetSavingsAccount();
            GenJournalLine."Account Type"::credit:
                GenJournalLine.GetLoanAccount();
        end;
        //GenJournalLine.Modify();

    end;



    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin


        CustLedgerEntry."Transaction Type" := GenJournalLine."Transaction Type";
        CustLedgerEntry."Loan No." := GenJournalLine."Loan No.";
        CustLedgerEntry."Member No." := GenJournalLine."Member No.";
        CustLedgerEntry."Group Code" := GenJournalLine."Group Code";
        CustLedgerEntry."Creation Date" := Today;
        CustLedgerEntry."Creation Time" := Time;
        //CustLedgerEntry.Modify();

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]

    local procedure OnBeforeInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin

        DtldCustLedgEntry."Transaction Type" := GenJournalLine."Transaction Type";
        DtldCustLedgEntry."Loan No." := GenJournalLine."Loan No.";
        DtldCustLedgEntry."Member No." := GenJournalLine."Member No.";
        DtldCustLedgEntry."Group Code" := GenJournalLine."Group Code";
        DtldCustLedgEntry."Creation Date" := Today;
        DtldCustLedgEntry."Creation Time" := Time;
        //DtldCustLedgEntry.Modify();

    end;




    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."Member No." := GenJournalLine."Member No.";
        VendorLedgerEntry."Group Code" := GenJournalLine."Group Code";
        VendorLedgerEntry."Creation Date" := Today;
        VendorLedgerEntry."Creation Time" := Time;
        //VendorLedgerEntry.Modify();
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldVendLedgEntry', '', false, false)]

    local procedure OnBeforeInsertDtldVendLedgEntry(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin

        DtldVendLedgEntry."Member No." := GenJournalLine."Member No.";
        DtldVendLedgEntry."Group Code" := GenJournalLine."Group Code";
        DtldVendLedgEntry."Creation Date" := Today;
        DtldVendLedgEntry."Creation Time" := Time;
        //DtldVendLedgEntry.Modify();

    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnGetCustomerAccountOnAfterCustGet', '', false, false)]
    local procedure OnGetCustomerAccountOnAfterCustGet(var GenJournalLine: Record "Gen. Journal Line"; var Customer: Record Customer; CallingFieldNo: Integer)
    begin
        if Customer."Account Type" = Customer."Account Type"::Members then
            Error('Invalid Account For Customer. Selected Account is a Member.');
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetVendorAccount', '', false, false)]

    local procedure OnAfterAccountNoOnValidateGetVendorAccount(var GenJournalLine: Record "Gen. Journal Line"; var Vendor: Record Vendor; CallingFieldNo: Integer)
    begin
        if Vendor."Creditor Type" = Vendor."Creditor Type"::FOSA then
            Error('Invalid Account For Vendor. Selected Account is a Fosa Account.');

    end;



    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnBeforeReverseEntries', '', false, false)]

    procedure OnBeforeReverseEntries(Number: Integer; RevType: Integer; var IsHandled: Boolean; HideDialog: Boolean)
    begin
        HideDialog := true;
    end;





}
