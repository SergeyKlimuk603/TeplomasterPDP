//--------------------------------------------------------------

// Удление всех тестовых записей
List<TestObject__c> testObjectsForDelete = [SELECT Id FROM TestObject__c WHERE Name LIKE 'ResearchSOQL%'];
delete testObjectsForDelete;

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
