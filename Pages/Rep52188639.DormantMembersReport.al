report 52188639 "Dormant Members Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DormantMembers.rdl';
    ApplicationArea = All;
    Caption = 'Dormant Members Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(AccountCategory; "Account Category")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; "Address 2")
            {
            }
            column(AdviceMethod; "Advice Method")
            {
            }
            column(AgencyPin; AgencyPin)
            {
            }
            column(AllowLineDisc; "Allow Line Disc.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(ApplicationMethod; "Application Method")
            {
            }
            column(Balance; Balance)
            {
            }
            column(BalanceLCY; "Balance (LCY)")
            {
            }
            column(BalanceDue; "Balance Due")
            {
            }
            column(BalanceDueLCY; "Balance Due (LCY)")
            {
            }
            column(BankAccountNo; "Bank Account No.")
            {
            }
            column(BankCode; "Bank Code")
            {
            }
            column(BankName; "Bank Name")
            {
            }
            column(BaseCalendarCode; "Base Calendar Code")
            {
            }
            column(BillToNoofBlanketOrders; "Bill-To No. of Blanket Orders")
            {
            }
            column(BillToNoofCreditMemos; "Bill-To No. of Credit Memos")
            {
            }
            column(BillToNoofInvoices; "Bill-To No. of Invoices")
            {
            }
            column(BillToNoofOrders; "Bill-To No. of Orders")
            {
            }
            column(BillToNoofPstdCrMemos; "Bill-To No. of Pstd. Cr. Memos")
            {
            }
            column(BillToNoofPstdInvoices; "Bill-To No. of Pstd. Invoices")
            {
            }
            column(BillToNoofPstdReturnR; "Bill-To No. of Pstd. Return R.")
            {
            }
            column(BillToNoofPstdShipments; "Bill-To No. of Pstd. Shipments")
            {
            }
            column(BillToNoofQuotes; "Bill-To No. of Quotes")
            {
            }
            column(BillToNoofReturnOrders; "Bill-To No. of Return Orders")
            {
            }
            column(BilltoCustomerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoNoOfArchivedDoc; "Bill-to No. Of Archived Doc.")
            {
            }
            column(BlockPaymentTolerance; "Block Payment Tolerance")
            {
            }
            column(Blocked; Blocked)
            {
            }
            column(BranchCode; "Branch Code")
            {
            }
            column(BranchManager; "Branch Manager")
            {
            }
            column(BranchManagerName; "Branch Manager Name")
            {
            }
            column(BranchName; "Branch Name")
            {
            }
            column(BudgetedAmount; "Budgeted Amount")
            {
            }
            column(BusinessRegNo; "Business Reg. No.")
            {
            }
            column(BusinessGroupLocation; "Business/Group Location")
            {
            }
            column(CRBEmployerIndustryType; "CRB Employer Industry Type")
            {
            }
            column(CannotGuarantee; "Cannot Guarantee")
            {
            }
            column(CapturedBy; "Captured By")
            {
            }
            column(CashFlowPaymentTermsCode; "Cash Flow Payment Terms Code")
            {
            }
            column(ChainName; "Chain Name")
            {
            }
            column(ChequesBounced; "Cheques Bounced")
            {
            }
            column(City; City)
            {
            }
            column(CollectionMethod; "Collection Method")
            {
            }
            column(CombineShipments; "Combine Shipments")
            {
            }
            column(Comment; Comment)
            {
            }
            column(CommissionPaid; "Commission Paid")
            {
            }
            column(CompanyName; "Company Name")
            {
            }
            column(CompanyNo; "Company No.")
            {
            }
            column(Contact; Contact)
            {
            }
            column(ContactGraphId; "Contact Graph Id")
            {
            }
            column(ContactID; "Contact ID")
            {
            }
            column(ContactType; "Contact Type")
            {
            }
            column(ContractGainLossAmount; "Contract Gain/Loss Amount")
            {
            }
            column(CopySelltoAddrtoQteFrom; "Copy Sell-to Addr. to Qte From")
            {
            }
            column(CountryRegionCode; "Country/Region Code")
            {
            }
            column(County; County)
            {
            }
            column(CoupledtoCRM; "Coupled to CRM")
            {
            }
            column(CrMemoAmounts; "Cr. Memo Amounts")
            {
            }
            column(CrMemoAmountsLCY; "Cr. Memo Amounts (LCY)")
            {
            }
            column(CreditAmount; "Credit Amount")
            {
            }
            column(CreditAmountLCY; "Credit Amount (LCY)")
            {
            }
            column(CreditLimitLCY; "Credit Limit (LCY)")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(CurrencyId; "Currency Id")
            {
            }
            column(CustomerDiscGroup; "Customer Disc. Group")
            {
            }
            column(CustomerPostingGroup; "Customer Posting Group")
            {
            }
            column(CustomerPriceGroup; "Customer Price Group")
            {
            }
            column(DateRejoined; "Date Rejoined")
            {
            }
            column(DateofBirth; "Date of Birth")
            {
            }
            column(DateofBusIncorporation; "Date of Bus. Incorporation")
            {
            }
            column(DateofBusReg; "Date of Bus. Reg.")
            {
            }
            column(DebitAmount; "Debit Amount")
            {
            }
            column(DebitAmountLCY; "Debit Amount (LCY)")
            {
            }
            column(DisableSearchbyName; "Disable Search by Name")
            {
            }
            column(DocumentLimit; "Document Limit")
            {
            }
            column(DocumentSendingProfile; "Document Sending Profile")
            {
            }
            column(DontChargeTransactions; "Dont Charge Transactions")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(EORINumber; "EORI Number")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(EmploymentSection; "Employment Section")
            {
            }
            column(FaxNo; "Fax No.")
            {
            }
            column(FinChargeMemoAmountsLCY; "Fin. Charge Memo Amounts (LCY)")
            {
            }
            column(FinChargeTermsCode; "Fin. Charge Terms Code")
            {
            }
            column(FinanceChargeMemoAmounts; "Finance Charge Memo Amounts")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(FromAnotherSacco; "From Another Sacco")
            {
            }
            column(GLN; GLN)
            {
            }
            column(GenBusPostingGroup; "Gen. Bus. Posting Group")
            {
            }
            column(Gender; Gender)
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(GrossDividends; "Gross Dividends")
            {
            }
            column(GroupAccount; "Group Account")
            {
            }
            column(GroupCategory; "Group Category")
            {
            }
            column(GroupNo; "Group No.")
            {
            }
            column(GroupSection; "Group Section")
            {
            }
            column(GroupType; "Group Type")
            {
            }
            column(HomePage; "Home Page")
            {
            }
            column(HowDidYouKnowAboutUs; "How Did You Know About Us")
            {
            }
            column(ICPartnerCode; "IC Partner Code")
            {
            }
            column(IDNo; "ID No.")
            {
            }
            column(IDType; "ID Type")
            {
            }
            column(Image; Image)
            {
            }
            column(IncorporationNo; "Incorporation No.")
            {
            }
            column(IndustryType; "Industry Type")
            {
            }
            column(InternalStaffEmployer; "Internal Staff Employer")
            {
            }
            column(InvAmountsLCY; "Inv. Amounts (LCY)")
            {
            }
            column(InvDiscountsLCY; "Inv. Discounts (LCY)")
            {
            }
            column(InvoiceAmounts; "Invoice Amounts")
            {
            }
            column(InvoiceCopies; "Invoice Copies")
            {
            }
            column(InvoiceDiscCode; "Invoice Disc. Code")
            {
            }
            column(IsAgencyActivated; IsAgencyActivated)
            {
            }
            column(KRAPIN; "KRA PIN")
            {
            }
            column(LanguageCode; "Language Code")
            {
            }
            column(LastDateModified; "Last Date Modified")
            {
            }
            column(LastDepositDateBF; "Last Deposit Date BF")
            {
            }
            column(LastModifiedDateTime; "Last Modified Date Time")
            {
            }
            column(LastStatementNo; "Last Statement No.")
            {
            }
            column(LoanQualification; "Loan Qualification")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(MaritalStatus; "Marital Status")
            {
            }
            column(MeetingDay; "Meeting Day")
            {
            }
            column(MeetingLocation; "Meeting Location")
            {
            }
            column(MemberCategory; "Member Category")
            {
            }
            column(MemberClass; "Member Class")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberStatus; "Member Status")
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(MobileLoanDefaulter; "Mobile Loan Defaulter")
            {
            }
            column(MobilePhoneNo; "Mobile Phone No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Name2; "Name 2")
            {
            }
            column(Nationality; Nationality)
            {
            }
            column(NetChange; "Net Change")
            {
            }
            column(NetChangeLCY; "Net Change (LCY)")
            {
            }
            column(No; "No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(NoofBlanketOrders; "No. of Blanket Orders")
            {
            }
            column(NoofCreditMemos; "No. of Credit Memos")
            {
            }
            column(NoofInvoices; "No. of Invoices")
            {
            }
            column(NoofOrders; "No. of Orders")
            {
            }
            column(NoofPstdCreditMemos; "No. of Pstd. Credit Memos")
            {
            }
            column(NoofPstdInvoices; "No. of Pstd. Invoices")
            {
            }
            column(NoofPstdReturnReceipts; "No. of Pstd. Return Receipts")
            {
            }
            column(NoofPstdShipments; "No. of Pstd. Shipments")
            {
            }
            column(NoofQuotes; "No. of Quotes")
            {
            }
            column(NoofReturnOrders; "No. of Return Orders")
            {
            }
            column(NoofShiptoAddresses; "No. of Ship-to Addresses")
            {
            }
            column(OldMemberNo; "Old Member No.")
            {
            }
            column(OtherAmounts; "Other Amounts")
            {
            }
            column(OtherAmountsLCY; "Other Amounts (LCY)")
            {
            }
            column(OtherGroupType; "Other Group Type")
            {
            }
            column(OtherTypeOfBusiness; "Other Type Of Business")
            {
            }
            column(OurAccountNo; "Our Account No.")
            {
            }
            column(OutstandingInvoices; "Outstanding Invoices")
            {
            }
            column(OutstandingInvoicesLCY; "Outstanding Invoices (LCY)")
            {
            }
            column(OutstandingOrders; "Outstanding Orders")
            {
            }
            column(OutstandingOrdersLCY; "Outstanding Orders (LCY)")
            {
            }
            column(OutstandingServOrdersLCY; "Outstanding Serv. Orders (LCY)")
            {
            }
            column(OutstandingServInvoicesLCY; "Outstanding Serv.Invoices(LCY)")
            {
            }
            column(PartnerType; "Partner Type")
            {
            }
            column(Passport; Passport)
            {
            }
            column(PaymentMethodCode; "Payment Method Code")
            {
            }
            column(PaymentMethodId; "Payment Method Id")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(PaymentTermsId; "Payment Terms Id")
            {
            }
            column(Payments; Payments)
            {
            }
            column(PaymentsLCY; "Payments (LCY)")
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(Pensioner; Pensioner)
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(PhysicallyChallenged; "Physically Challenged")
            {
            }
            column(PlaceofExport; "Place of Export")
            {
            }
            column(PlotBldgStreetRoad; "Plot/Bldg/Street/Road")
            {
            }
            column(PmtDiscToleranceLCY; "Pmt. Disc. Tolerance (LCY)")
            {
            }
            column(PmtDiscountsLCY; "Pmt. Discounts (LCY)")
            {
            }
            column(PmtToleranceLCY; "Pmt. Tolerance (LCY)")
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(PreferredBankAccountCode; "Preferred Bank Account Code")
            {
            }
            column(Prepayment; "Prepayment %")
            {
            }
            column(PreviousSaccoNo; "Previous Sacco No.")
            {
            }
            column(PriceCalculationMethod; "Price Calculation Method")
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PrimaryContactNo; "Primary Contact No.")
            {
            }
            column(PrintStatements; "Print Statements")
            {
            }
            column(Priority; Priority)
            {
            }
            column(PrivacyBlocked; "Privacy Blocked")
            {
            }
            column(ProfitLCY; "Profit (LCY)")
            {
            }
            column(RecruitedBy; "Recruited By")
            {
            }
            column(RecruitedByName; "Recruited By Name")
            {
            }
            column(RecruitedbyType; "Recruited by Type")
            {
            }
            column(Refunds; Refunds)
            {
            }
            column(RefundsLCY; "Refunds (LCY)")
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(Rejoined; Rejoined)
            {
            }
            column(RelationshipOfficer; "Relationship Officer")
            {
            }
            column(RelationshipOfficerName; "Relationship Officer Name")
            {
            }
            column(ReminderAmounts; "Reminder Amounts")
            {
            }
            column(ReminderAmountsLCY; "Reminder Amounts (LCY)")
            {
            }
            column(ReminderTermsCode; "Reminder Terms Code")
            {
            }
            column(Reserve; Reserve)
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(RestrictedMember; "Restricted Member")
            {
            }
            column(SalesLCY; "Sales (LCY)")
            {
            }
            column(SalespersonCode; "Salesperson Code")
            {
            }
            column(SalutationCode; "Salutation Code")
            {
            }
            column(SearchName; "Search Name")
            {
            }
            column(SelfEmployed; "Self Employed")
            {
            }
            column(SelltoNoOfArchivedDoc; "Sell-to No. Of Archived Doc.")
            {
            }
            column(ServShippedNotInvoicedLCY; "Serv Shipped Not Invoiced(LCY)")
            {
            }
            column(ServiceZoneCode; "Service Zone Code")
            {
            }
            column(ShiptoCode; "Ship-to Code")
            {
            }
            column(ShipmentMethodCode; "Shipment Method Code")
            {
            }
            column(ShipmentMethodId; "Shipment Method Id")
            {
            }
            column(ShippedNotInvoiced; "Shipped Not Invoiced")
            {
            }
            column(ShippedNotInvoicedLCY; "Shipped Not Invoiced (LCY)")
            {
            }
            column(ShippingAdvice; "Shipping Advice")
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentServiceCode; "Shipping Agent Service Code")
            {
            }
            column(ShippingTime; "Shipping Time")
            {
            }
            column(SigningInstructionnarration; "Signing Instruction narration")
            {
            }
            column(SigningInstructions; "Signing Instructions")
            {
            }
            column(SpecialAccount; "Special Account")
            {
            }
            column(StatisticsGroup; "Statistics Group")
            {
            }
            column(Status; Status)
            {
            }
            column(StopInterestDue; "Stop Interest Due")
            {
            }
            column(Surname; Surname)
            {
            }
            column(SwiftCode; "Swift Code")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TaxAreaCode; "Tax Area Code")
            {
            }
            column(TaxAreaID; "Tax Area ID")
            {
            }
            column(TaxLiable; "Tax Liable")
            {
            }
            column(TelexAnswerBack; "Telex Answer Back")
            {
            }
            column(TelexNo; "Telex No.")
            {
            }
            column(TermsofEmployment; "Terms of Employment")
            {
            }
            column(TerritoryCode; "Territory Code")
            {
            }
            column(TestNo; "Test No")
            {
            }
            column(Type; "Type")
            {
            }
            column(TypeofBusiness; "Type of Business")
            {
            }
            column(UseGLNinElectronicDocument; "Use GLN in Electronic Document")
            {
            }
            column(VATBusPostingGroup; "VAT Bus. Posting Group")
            {
            }
            column(VATRegistrationNo; "VAT Registration No.")
            {
            }
            column(ValidateEUVatRegNo; "Validate EU Vat Reg. No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                ShareDeposit: Decimal;
                OrdinaryShares: Decimal;
                ShareCapital: decimal;
                MActivities: Codeunit "Member Activities";
                legacy: Codeunit Legacy;
                product: Record Vendor;

            begin
                ShareCapital := 0;
                OrdinaryShares := 0;
                ShareCapital := 0;


                //Share Deposit
                ShareDeposit := MActivities.GetAccountBalance(legacy.GetDepositAccount("No."));
                //Ordinary Shares
                OrdinaryShares := MActivities.GetAccountBalance(legacy.GetOrdinaryAccount("No."));
                //Share Capital
                ShareCapital := MActivities.GetAccountBalance(legacy.GetShareCapitalAccount("No."));

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }

        }
    }
}
