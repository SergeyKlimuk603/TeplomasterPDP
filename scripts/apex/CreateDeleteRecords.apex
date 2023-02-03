//--------------------------------------------------------------


// Удление тестовых записей TestObject__c ветки ResearchSOQL
List<TestObject__c> testObjectsForDelete = [SELECT Id FROM TestObject__c WHERE Name LIKE 'ResearchSOQL%'];
delete testObjectsForDelete;

// Удление тестовых записей TestObjectParent__c ветки ResearchSOQL
List<TestObjectParent__c> testObjectsParentForDelete = [SELECT Id FROM TestObjectParent__c WHERE Name LIKE 'ResearchSOQL%'];
delete testObjectsParentForDelete;

//--------------------------------------------------------------

// Полное удление всех тестовых записей TestObject__c
List<TestObject__c> testObjectsForDeleteFull = [SELECT Id FROM TestObject__c];
delete testObjectsForDeleteFull;

// Полное удление всех тестовых записей TestObjectParent__c
List<TestObjectParent__c> testObjectsParentForDeleteFull = [SELECT Id FROM TestObjectParent__c];
delete testObjectsParentForDeleteFull;


//--------------------------------------------------------------------------------
// Create Parent Record with child
Integer numOfParentRecords = 10;
Integer numOfRecordsForEveryParent = 3; 

// Create parents
List<TestObjectParent__c> testObjectParents = new List<TestObjectParent__c>();
for (Integer i = 0; i < numOfParentRecords; i++) {
    testObjectParents.add(
            new TestObjectParent__c (
                    Name = 'ResearchSOQL ' + i
            )
    );
}
insert testObjectParents;

// Create childs
List<TestObject__c> testObjects = new List<TestObject__c>();
for (Integer p = 0; p < numOfParentRecords; p++) {
    for(Integer i = 0; i < numOfRecordsForEveryParent; i++) {
        testObjects.add(
                new TestObject__c (
                        Name = 'ResearchSOQL ' + p + ' - ' + i,
                        TestObjectParent__c = testObjectParents[p].Id
                )
        );
    }
}
insert testObjects;
//--------------------------------------------------------------

// Создание тестовых записей
List<TestObject__c> testObjects = new List<TestObject__c>();
for(Integer i = 0; i < 10; i++) {
    testObjects.add(
        new TestObject__c (
            Name = 'ResearchSOQL_a' + i,
            NumberField__c = 5
        )
    );
}
insert testObjects;

//--------------------------------------------------------------
//Изучение групповых запросов
System.debug('-----' + [SELECT COUNT(Name) FROM TestObject__c WHERE Name LIKE 'ResearchSOQL%']);

System.debug('-----' + [
    SELECT COUNT(Id) numOfRecords, AVG(NumberField__c) avarage, MAX(NumberField__c) max, Name
    FROM TestObject__c 
    WHERE Name 
    LIKE 'ResearchSOQL%' 
    GROUP BY Name
    ]);

    System.debug('-----' + [
    SELECT COUNT(NumberField__c) numOfRecords, COUNT(Id) Ids
    FROM TestObject__c 
    WHERE Name 
    LIKE 'ResearchSOQL%' 
    ]);
