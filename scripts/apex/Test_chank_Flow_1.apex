
//
//----------------------------------------------------------------------------------
// Delete all test records
List<TestObject__c> testObjectsForDelete = [SELECT Id FROM TestObject__c];
delete testObjectsForDelete;

List<TestObjectParent__c> testObjectParentsForDelete = [SELECT Id FROM TestObjectParent__c];
delete testObjectParentsForDelete;

//--------------------------------------------------------------------------------
// Create Parent Record with child
Integer numOfParentRecords = 21;
Integer numOfRecords = 5;

// Create parents
List<TestObjectParent__c> testObjectParents = new List<TestObjectParent__c>();
for (Integer i = 0; i < numOfParentRecords; i++) {
    testObjectParents.add(
            new TestObjectParent__c (
                    Name = 'Test_chank_Flow_1 ' + i
            )
    );
}
insert testObjectParents;

// Create childs
List<TestObject__c> testObjects = new List<TestObject__c>();
for (TestObjectParent__c testParent : testObjectParents) {
    for(Integer i = 0; i < numOfRecords; i++) {
        testObjects.add(
                new TestObject__c (
                        Name = 'Test_chank_Flow_1 ' + i,
                        TestObjectParent__c = testParent.Id
                )
        );
    }
}
insert testObjects;

//----------------------------------------------------------------------------------------------
// Update parent records

List<TestObjectParent__c> testObjectParentsForUpdate = [
        SELECT Id, Name, TextField__c
        FROM TestObjectParent__c
        WHERE Name LIKE 'Test_chank_Flow_1%'
];
for (TestObjectParent__c testParent : testObjectParentsForUpdate) {
    testParent.TextField__c = 'run update';
}
update testObjectParentsForUpdate;

//==========================================================================================

//Флоу разделяет поступившие записи на пакеты по 200 штук каждый такой пакет формирует 1 SOQL и 1 DML