enum 52188425 "Marital Status Enum"
{
    Extensible = true;

    value(0; "")
    {
    }
    value(1; Single)
    {
    }
    value(2; Married)
    {
    }
    value(3; Divorced)
    {
    }
    value(4; Widowed)
    {
    }
}

enum 52188426 "Member Status Enum"
{
    Extensible = true;
    value(0; " ")
    {
    }
    value(1; Active)
    {
    }
    value(2; Dormant)
    {
    }
    value(3; "Withdrawal Application")
    {
    }
    value(4; Withdrawn)
    {
    }
    value(5; Deceased)
    {
    }
    value(6; "Closed")
    {

    }
}

enum 52188427 "New Member Type Enum"
{
    Extensible = true;

    value(0; Person)
    {
    }
    value(1; Joint)
    {
    }
    value(2; Group)
    {
    }
    value(3; Institution)
    {
    }
}

enum 52188428 "Next Of Kin Relationship Enum"
{
    Extensible = true;

    value(0; "")
    {
    }
    value(1; Father)
    {
    }
    value(2; Mother)
    {

    }
    value(3; Brother)
    {

    }
    value(4; Sister)
    {
    }
    value(5; Uncle)
    {
    }
    value(6; Aunt)
    {
    }
    value(7; Cousin)
    {
    }
    value(8; "Grand Father")
    {
    }
    value(9; "Grand Mother")
    {
    }
    value(10; Relative)
    {
    }
    value(11; Other)
    {
    }
}

enum 52188429 "Credit Status Enum"
{
    value(0; "") { }
    value(1; Active) { }
    value(2; Defaulter) { }
    value(3; "Cleared") { }

}
enum 52188430 "Recruited By Type"
{
    value(0; "") { }
    value(1; Walkins) { }
    value(2; Member) { }
    value(3; Staff) { }
    value(4; Marketer) { }
}
//' ',Active,Retired,Resigned,Dismissed,Suspended 
enum 52188431 "Job Status Enum"
{
    Extensible = true;

    value(0; "") { }
    value(1; Active) { }
    value(2; Retired) { }
    value(3; Resigned) { }
    value(4; Dismissed) { }
    value(5; Suspended) { }
}
enum 52188432 "Member Category Enum"
{
    Extensible = true;
    value(0; Member) { }
    value(1; Staff) { }
    value(2; Board) { }
}

enum 52188433 "Approval Status Enum"
{
    value(0; Open) { }
    value(1; Pending) { }
    value(2; Approved) { }
    value(3; Rejected) { }
}

enum 52188434 "Product Category Enum"
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Registration Fee") { }
    value(2; "Share Capital") { }
    value(3; "Deposit Contribution") { }
    value(4; "Benevolent Fund") { }
    value(5; "Fixed Deposit") { }
    value(6; "Dividend Account") { }
    value(7; "Junior Savings") { }
    value(8; "Holiday Savings") { }
    value(9; "Micro Member Deposit") { }
    value(10; "Micro Group Deposit") { }
    value(11; "Ordinary Savings") { }

}

enum 52188435 "Account Status Enum"
{
    Extensible = true;

    value(0; Active) { }
    value(1; Dormant) { }

    value(2; Closed) { }
    value(3; Frozen) { }
    value(4; Deceased) { }
}

enumextension 52188436 GenJournalLineAccountType extends "Gen. Journal Account Type"
{
    value(50000; Savings)
    {
    }
    value(50001; Credit)
    {
    }
}

enumextension 52188437 GenJournalLineSourceType extends "Gen. Journal Source Type"
{
    value(50000; Savings)
    {
    }
    value(50001; Credit)
    {
    }
}

enum 52188438 "Transaction Type Enum"
{
    Extensible = true;


    value(50000; " ") { }
    value(50001; "Loan Disbursement") { }
    value(50002; "Principal Repayment") { }
    value(50003; "Interest Due") { }
    value(50004; "Interest Paid") { }
    value(50005; "Appraisal Due") { }
    value(50006; "Appraisal Paid") { }
    value(50007; "Penalty Due") { }
    value(50008; "Penalty Paid") { }
    value(50009; "Partial Disbursement") { }
}

enum 52188439 "SMS Source Enum"
{
    Extensible = true;
    value(50001; "New Member") { }
    value(50002; "New Account") { }
    value(50003; "Loan Approval") { }
    value(50004; "Deposit Confirmation") { }
    value(50005; "Cash Withdrawal Confirm") { }
    value(50006; "Loan Application") { }
    value(50007; "Loan Appraisal") { }
    value(50008; "Loan Guarantors") { }
    value(50009; "Loan Rejected") { }
    value(50010; "Loan Posted") { }
    value(50011; "Loan defaulted") { }
    value(50012; "Salary Processing") { }
    value(50013; "Teller Cash Deposit") { }
    value(50014; "Teller Cash Withdrawal") { }
    value(50015; "Teller Cheque Deposit") { }
    value(50016; "Fixed Deposit Maturity") { }
    value(50017; "InterAccount Transfer") { }
    value(50018; "Account Status") { }
    value(50019; "Status Order") { }
    value(50020; "EFT Effected") { }
    value(50021; "ATM Application Failed") { }
    value(50022; "ATM Collection") { }
    value(50023; MBanking) { }
    value(50024; "Member Changes") { }
    value(50025; "Cashier Below Limit") { }
    value(50026; "Cashier Above Limit") { }
    value(50027; "Chq Book") { }
    value(50028; "Bankers Cheque") { }
    value(50029; "Teller Cheque Transfer") { }
    value(50030; "Defaulter Loan Issued") { }
    value(50031; Bonus) { }
    value(50032; Bulk) { }
    value(50033; "Standing Order") { }
    value(50034; "Loan Bill Due") { }
    value(50035; "POS Deposit") { }
    value(50036; "Mini Bonus") { }
    value(50037; "Leave Application") { }
    value(50038; "Loan Witness") { }
    value(50039; PV) { }
    value(50040; PIN) { }
    value(50041; "Loan Reminder") { }
    value(50042; "Account Dormancy") { }

}

enumextension 52188450 "Workflow Approval Limit Type" extends "Workflow Approval Limit Type"
{

    value(50002; "Tiered Limits") { }
}

enumextension 52188440 "Approval Document Type Ext" extends "Approval Document Type"
{
    value(50000; "Tracker") { }
    value(50001; "Member Application") { }
    value(50002; "Loan Application") { }
    value(50003; "Savings Application") { }
    value(50004; FDR) { }
    value(50005; "Def. Recovery") { }
    value(50006; "Loan Changes") { }
    value(50007; "Guarantor Sub.") { }
    value(50008; "Member Exit") { }
    value(50009; "Member Exit Notice") { }
    value(50010; "Member Changes") { }
    value(50011; STO) { }
    value(50012; "Cheque Book App") { }
    value(50013; "Account Transfer") { }
    value(50014; "Teller Transaction") { }
    value(50015; "Micro Transaction,") { }
    value(50016; PV) { }
    value(50017; "Petty Cash") { }
    value(50018; "Collateral Register") { }
    value(50019; "Collateral Return") { }
    value(50020; "CheckOff") { }
    value(50021; "Bankers Cheque") { }
    value(50022; Overdraft) { }
    value(50023; Imprest) { }
    value(50024; "Imprest Surrender") { }
    value(50025; Teller) { }
    value(50026; "Mbanking Application") { }
    value(50027; Leave) { }
    value(50028; "Loan Batch") { }
    value(50029; "HR Jobs") { }
    value(50030; "HR Job Requisition") { }
    value(50031; "Purchase Requisition") { }


}



enumextension 52188441 "Workflow Appr Limit Type Ext" extends "Workflow Approver Limit Type"
{
    value(50001; "Self Approver") { }
}


enumextension 52188424 "Purchase Document Ext" extends "Purchase Document Type"
{
    value(50001; "Purchase Requisition") { }
}


Enum 52188442 "Creditor Type Enum"
{
    value(50001; " ") { }
    value(50002; "Supplier") { }
    value(50003; "FOSA") { }
}

Enum 52188443 "Repay Mode Enum"
{
    value(50001; " ") { }
    value(50002; "Salary") { }
    value(50003; "Milk") { }
    value(50004; "Tea") { }
    value(50005; "Staff Salary") { }
    value(50006; "Business") { Caption = 'Date Based'; }
    value(50007; "Check Off") { }
    value(50008; "Dividends") { }
    value(50009; "Internal Standing Order") { }
    value(50010; "External Standing Order") { }
    value(50011; "Pension") { }
    value(50012; "Bonus") { }
    value(50013; "Mini-Bonus") { }
}

Enum 52188444 "How Did You Know About Us Enum"
{
    value(50001; " ") { }
    value(50002; "Newspapaer") { }
    value(50003; "Radio") { }
    value(50004; "Television") { }
    value(50005; "Advert") { }
    value(50006; "Website") { }
    value(50007; "Facebook") { }
    value(50008; "Tweeter") { }
    value(50009; "Another member") { }
    value(50010; "Sales Representative") { }
    value(50011; "Staff") { }
    value(50012; "Others") { }
}

