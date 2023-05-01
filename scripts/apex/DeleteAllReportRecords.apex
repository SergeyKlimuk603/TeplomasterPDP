private final String recordsNameBegining = 'Report%';

List<Case> casesForDelete = [SELECT Id FROM Case WHERE AccountId IN (SELECT Id FROM Account WHERE Name LIKE :recordsNameBegining)];
delete casesForDelete;

List<Opportunity> oppsForDelete = [SELECT Id FROM Opportunity WHERE Name LIKE :recordsNameBegining];
delete oppsForDelete;

List<Account> accountsForDelete = [SELECT Id FROM Account WHERE Name LIKE :recordsNameBegining];
delete accountsForDelete;

List<Shop__c> shopsForDelete = [SELECT Id FROM Shop__c WHERE Name LIKE :recordsNameBegining];
delete shopsForDelete;

List<SalesOffice__c> sOfficeForDelete = [SELECT Id FROM SalesOffice__c WHERE Name LIKE :recordsNameBegining];
delete sOfficeForDelete;

List<Pricebook2> pricebookForDelete = [SELECT Id FROM Pricebook2 WHERE Name LIKE :recordsNameBegining];
delete pricebookForDelete;

List<OpportunityLineItem> olisForDelete = [SELECT Id FROM OpportunityLineItem WHERE Name LIKE :recordsNameBegining];
delete olisForDelete;

List<PricebookEntry> pbesForDelete = [SELECT Id FROM PricebookEntry WHERE Name LIKE :recordsNameBegining];
delete pbesForDelete;

List<Product2> productsForDelete = [SELECT Id FROM Product2 WHERE Name LIKE :recordsNameBegining];
delete productsForDelete;

