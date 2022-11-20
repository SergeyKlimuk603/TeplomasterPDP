
// 
//----------------------------------------------------------------------------------
// Delete all test records

List<TestObjectParent__c> testObjectParentsForDelete = [SELECT Id FROM TestObjectParent__c WHERE Name LIKE '%Test chank in Flow%'];
delete testObjectParentsForDelete;

List<TestObject__c> testObjectsForDelete = [SELECT Id FROM TestObject__c WHERE Name LIKE '%Test chank in Flow%'];
delete testObjectsForDelete;

//--------------------------------------------------------------------------------
// Create Parent Record with child
Integer numOfParentRecords = 51;
Integer numOfRecords = 10;

List<TestObjectParent__c> testObjectParents = new List<TestObjectParent__c>();
for(Integer i = 0; i < numOfParentRecords; i++) {
    testObjectParents.add(
        new TestObjectParent__c (
            Name = 'Test chank in Flow Parent ' + i
        )
    );
}
insert testObjectParents;

List<TestObject__c> testObjects = new List<TestObject__c>();
for (TestObjectParent__c testParent : testObjectParents) {
    for(Integer i = 0; i < numOfRecords; i++) {
        testObjects.add(
            new TestObject__c (
                Name = 'Test chank in Flow ' + i,
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
    WHERE Name LIKE 'Test chank in Flow%'
    ];
for (TestObjectParent__c testParent : testObjectParentsForUpdate) {
    testParent.TextField__c = 'start update';
}
update testObjectParentsForUpdate;

//==========================================================================================

