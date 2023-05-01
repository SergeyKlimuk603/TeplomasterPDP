private final String recordsNameBegining = 'Report';

private final Integer NUM_OF_ACCOUNTS = 20;             // Количесвтво клиентов
private final Integer NUM_OF_SOFFICES = 20;            // Количество торговых офисов
private final Integer NUM_OF_CITIES = 5;                // Количество городов, в которых расположены торговые офисы
private final Integer NUM_OF_PRODUCTS = 10;              // Количество продуктов (видов продукции)
private final Integer PRODUCTS_PRICE_RANGE = 1000;      // Диапазон стоимости продуктов
private final Integer PRODUCTS_PRICE_DIFFERENCE = 20;   // Отличие цены в разных PriceBook по сравнению с нулевой. Величина в процнтах
private final Integer NUM_OF_PRICEBOOKS = 2;            // Количество Pricebook
private final Integer OPP_RANGE_FOR_EACH_ACCOUNT = 10;  // Количество сделок для каждого клиента
private final Integer QUANTITY_RANGE_FOR_EACH_OLI = 5;  // Количество единиц купленного продукта
private final Integer NUM_OF_OLIS = 3;                  // Количество видов продукта, купленного в одной сделке
private final Integer CASE_RANGE_FOR_EACH_ACCOUNT = 3;  // Количество обращений для каждого клиента

private List<Account> accounts;
private List<SalesOffice__c> sOffices;
private List<Product2> products;
private Pricebook2 standartPricebook;
private List<PricebookEntry> standartPricebookEntries;
private List<Pricebook2> pricebooks;
private List<PricebookEntry> pricebookEntries;
private List<Opportunity> opportunities;
private List<OpportunityLineItem> opportunityLineItems;
private List<Case> cases;

accounts = createAccounts(NUM_OF_ACCOUNTS);
sOffices = createSalesOffices(NUM_OF_SOFFICES);
products = createProducts(NUM_OF_PRODUCTS);
standartPricebook = getStandartPriceBooks();
standartPricebookEntries = createStandartPricebookEntries(standartPricebook, products, PRODUCTS_PRICE_RANGE);
pricebooks = createPriceBooks(NUM_OF_PRICEBOOKS);
pricebookEntries = createPricebookEntries(pricebooks, standartPricebookEntries, PRODUCTS_PRICE_DIFFERENCE);
opportunities = createOpportunities(accounts, sOffices, pricebooks, OPP_RANGE_FOR_EACH_ACCOUNT);
opportunityLineItems = createOpportunityProducts(opportunities, pricebookEntries);
cases = createCases(accounts, CASE_RANGE_FOR_EACH_ACCOUNT);

private List<Account> createAccounts(Integer numOfAccounts) {
    List<Account> accounts = new List<Account>();

    for(Integer i = 0; i < numOfAccounts; i++) {
        accounts.add(
            new Account(Name = (recordsNameBegining + ' Account ' + i))
        );
    }

    insert accounts;

    return accounts;
}

private List<SalesOffice__c> createSalesOffices(Integer numOfSalesOffices) {
    List<SalesOffice__c> sOffices = new List<SalesOffice__c>();

    for(Integer i = 0; i < numOfSalesOffices; i++) {
        sOffices.add(
            new SalesOffice__c(
                Name = (recordsNameBegining + ' SalesOffice ' + i),
                City__c = (recordsNameBegining + ' City ' + (Integer.valueOf(Math.random() * NUM_OF_CITIES)))
            )
        );
    }

    insert sOffices;

    return sOffices;
}

private List<Product2> createProducts(Integer numOfProducts) {
    List<Product2> products = new List<Product2>();

    for(Integer i = 0; i < numOfProducts; i++) {
        products.add(
            new Product2(
                Name = (recordsNameBegining + ' Product ' + i)
            )
        );
    }

    insert products;

    return products;
}

private Pricebook2 getStandartPriceBooks() {
    return [SELECT Id, Name FROM Pricebook2 WHERE Name = 'Standard Price Book' LIMIT 1];
}

private List<PricebookEntry> createStandartPricebookEntries(
            Pricebook2 standartPricebook, 
            List<Product2> products, 
            Integer productPriceRange
        ) {    
    List<PricebookEntry> standartPricebookEntries = new List<PricebookEntry>();
 
    for(Integer p = 0; p < products.size(); p++) {
        Double unitPrice = (Math.random() * productPriceRange + 10);
            
        standartPricebookEntries.add(
            new PricebookEntry(
                isActive = true,
                UnitPrice = unitPrice,
                Pricebook2Id = standartPricebook.Id,
                Product2Id = products[p].Id
            )
        );
    }

    insert standartPricebookEntries;

    return standartPricebookEntries;
}

private List<Pricebook2> createPriceBooks(Integer numOfPriceBooks) {
    List<Pricebook2> pricebooks = new List<Pricebook2>();
    
    for(Integer i = 0; i < numOfPriceBooks; i++) {
        pricebooks.add(
            new Pricebook2(
                Name = (recordsNameBegining + ' PriceBook ' + i),
                IsActive = true
            )
        );
    }
    
    upsert pricebooks;

    return pricebooks;
}

private List<PricebookEntry> createPricebookEntries(
            List<Pricebook2> pricebooks, 
            List<PricebookEntry> standartPricebookEntries, 
            Integer productPriceDifference
        ) {    
    List<PricebookEntry> pricebookEntries = new List<PricebookEntry>();

    for(Pricebook2 pb : pricebooks) {
        for(PricebookEntry spbe : standartPricebookEntries) {
            Double priceDifference = ((Math.random() * productPriceDifference) - productPriceDifference / 2) / 100;
            pricebookEntries.add(
                new PricebookEntry(
                    isActive = true,
                    UnitPrice = (spbe.UnitPrice * (1 + priceDifference)),
                    Pricebook2Id = pb.Id,
                    Product2Id = spbe.Product2Id
                )
            );
        }
    }

    insert pricebookEntries;

    return pricebookEntries;
}

private List<Opportunity> createOpportunities(
            List<Account> accounts, 
            List<SalesOffice__c> sOffices, 
            List<Pricebook2> pricebooks, 
            Integer oppRangeForEachAccount
        ) {    
    List<Opportunity> opportunities = new List<Opportunity>();
    
    for(Integer a = 0; a < accounts.size(); a++) {
        Integer numOfOpps = Integer.valueOf(Math.random() * oppRangeForEachAccount);
        for(Integer o = 0; o < numOfOpps; o++) {
            List<Schema.PicklistEntry> oppStagePicklist = Opportunity.StageName.getDescribe().getPicklistValues();
            opportunities.add(
                new Opportunity(
                    Name = (recordsNameBegining + ' Opportunity ' + a + ' - ' + o),
                    AccountId = accounts[a].Id,
                    SalesOffice__c = sOffices.get(Integer.valueOf(Math.random() * sOffices.size())).Id,
                    Pricebook2Id = pricebooks.get(Integer.valueOf(Math.random() * pricebooks.size())).Id,
                    CloseDate = Date.today().addDays(Integer.valueOf(Math.random() * 30)),
                    StageName = oppStagePicklist.get(Integer.valueOf(Math.random() * oppStagePicklist.size())).getLabel()
                )
            );
        }
    }

    insert opportunities;

    return opportunities;
}

private List<OpportunityLineItem> createOpportunityProducts(List<Opportunity> opportunities, List<PricebookEntry> pricebookEntries) {
    List<OpportunityLineItem> opportunityLineItems = new List<OpportunityLineItem>();
    Map<Id, List<PricebookEntry>> pricebookEntryByPricebookId = getPricebookEntryByPricebookId(pricebookEntries);

    for(Opportunity opp : opportunities) {
        for(Integer i = 0; i < Integer.valueOf(Math.random() * (NUM_OF_OLIS - 1) + 1); i++) {
            PricebookEntry pbe = pricebookEntryByPricebookId.get(opp.Pricebook2Id).get(Integer.valueOf(Math.random() * NUM_OF_PRODUCTS));
            opportunityLineItems.add(
                new OpportunityLineItem(
                    OpportunityId = opp.Id,
                    Product2Id = pbe.Id,
                    UnitPrice = pbe.UnitPrice,
                    Quantity = Integer.valueOf(Math.random() * (QUANTITY_RANGE_FOR_EACH_OLI - 1) + 1)
                )
            );
        }
    }
    
    insert opportunityLineItems;

    return opportunityLineItems;
}

private Map<Id, List<PricebookEntry>> getPricebookEntryByPricebookId(List<PricebookEntry> pricebookEntries){
    Map<Id, List<PricebookEntry>> pricebookEntryByPricebookId = new Map<Id, List<PricebookEntry>>();

    for(PricebookEntry pbe : pricebookEntries) {
        List<PricebookEntry> pricebookEntryById = pricebookEntryByPricebookId.get(pbe.Pricebook2Id);
        if (pricebookEntryById == null) {
            pricebookEntryById = new List<PricebookEntry>();
            pricebookEntryByPricebookId.put(pbe.Pricebook2Id, pricebookEntryById);
        }
        pricebookEntryById.add(pbe);
    }

    return pricebookEntryByPricebookId;
}

private List<Case> createCases(List<Account> accounts, Integer caseRangeForEachAccount) {    
    List<Case> cases = new List<Case>();
    
    for(Integer a = 0; a < accounts.size(); a++) {
        Integer numOfCases = Integer.valueOf(Math.random() * caseRangeForEachAccount);
        for(Integer c = 0; c < numOfCases; c++) {
            List<Schema.PicklistEntry> caseStagePicklist = Case.Status.getDescribe().getPicklistValues();
            cases.add(
                new Case(
                    AccountId = accounts[a].Id,
                    Status = caseStagePicklist.get(Integer.valueOf(Math.random() * caseStagePicklist.size())).getLabel()
                )
            );
        }
    }

    insert cases;

    return cases;
}




