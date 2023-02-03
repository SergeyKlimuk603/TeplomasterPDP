//------------------------------------------------------------------------
//Проверка синхронных лимитов SOQL в случае вызова родительских записей вместе с дочерними

List<TestObjectParent__c> testObjectParents = [SELECT Id, (SELECT Id FROM TestObjects__r) FROM TestObjectParent__c];
//Number of SOQL queries: 1 out of 100
//Number of query rows: parent records + child records

List<TestObjectParent__c> testObjectParents = [
                                                SELECT Id
                                                FROM TestObjectParent__c 
                                                WHERE Id IN (SELECT TestObjectParent__c FROM TestObject__c WHERE Name = 'ResearchSOQL 1 - 0')
                                                ];
System.debug('-----testObjectParents: ' + testObjectParents);
System.debug('-----Limits.getQueries(): ' + Limits.getQueries());
//Number of SOQL queries: 1 out of 100
//Number of query rows: parent records


SELECT Id, Name
FROM Account
WHERE Id IN
( SELECT AccountId
FROM Opportunity
WHERE StageName = 'Closed Lost'
)


for (Integer i = 0; i < 100; i++) {
    List<TestObjectParent__c> testObjectParents = [SELECT Id, (SELECT Id FROM TestObjects__r) FROM TestObjectParent__c];
}
//Number of SOQL queries: 100 out of 100 ******* CLOSE TO LIMIT
//Number of query rows: parent records + child records

for (Integer i = 0; i < 200; i++) {
    List<TestObjectParent__c> testObjectParents = [SELECT Id, (SELECT Id FROM TestObjects__r) FROM TestObjectParent__c];
}
//Error: System.LimitException: Too many SOQL queries: 101
//Number of SOQL queries: 101 out of 100 ******* CLOSE TO LIMIT
//Number of query rows: parent records + child records

//------------------------------------------------------------------------

//Количество DML операций в случае обновления разных объектово в одном List
TestObject__c testObject = new TestObject__c(Name = 'ResearchSOQL DML check');
TestObjectParent__c testObjectParent = new TestObjectParent__c(Name = 'ResearchSOQL DML check');
List<SObject> differentObjectList = new List<SObject>{testObject, testObjectParent};
insert differentObjectList;
//Number of DML statements: 1 out of 150
//Number of DML rows: 2 out of 10000

//------------------------------------------------------------------------