//--------------------------------------------------------------

// Удление тестовых записей TestObject__c ветки Visualforce
List<TestObject__c> testObjectsForDelete = [SELECT Id FROM TestObject__c WHERE Name LIKE 'Visualforce%'];
delete testObjectsForDelete;

// Удление тестовых записей TestObjectParent__c ветки Visualforce
List<TestObjectParent__c> testObjectsParentForDelete = [SELECT Id FROM TestObjectParent__c WHERE Name LIKE 'Visualforce%'];
delete testObjectsParentForDelete;

// Удление тестовых записей TestObjectChild__c ветки Visualforce
List<TestObjectChild__c> testObjectsChildForDelete = [SELECT Id FROM TestObjectChild__c WHERE Name LIKE 'Visualforce%'];
delete testObjectsChildForDelete;

//--------------------------------------------------------------

// Полное удление всех тестовых записей TestObject__c
List<TestObject__c> testObjectsForDeleteFull = [SELECT Id FROM TestObject__c];
delete testObjectsForDeleteFull;

// Полное удление всех тестовых записей TestObjectParent__c
List<TestObjectParent__c> testObjectsParentForDeleteFull = [SELECT Id FROM TestObjectParent__c];
delete testObjectsParentForDeleteFull;

// Удление тестовых записей TestObjectChild__c
List<TestObjectChild__c> testObjectsChildForDelete = [SELECT Id FROM TestObjectChild__c];
delete testObjectsChildForDelete;


//--------------------------------------------------------------------------------
// Create Parent Record with child
Integer numOfRecords = 1;
Integer numOfChildRecords = 3;
 

// Create parents
List<TestObjectParent__c> testObjectParents = new List<TestObjectParent__c>();
for (Integer p = 0; p < numOfRecords; p++) {
    testObjectParents.add(
            new TestObjectParent__c (
                    Name = 'Visualforce ' + p,
                    TextField__c = 'Parent ' + p + ' TextField'
            )
    );
}
insert testObjectParents;

// Create records
List<TestObject__c> testObjects = new List<TestObject__c>();
for (Integer p = 0; p < testObjectParents.size(); p++) {    
        testObjects.add(
                new TestObject__c (
                        Name = 'Visualforce ' + p + ' - ' + p,
                        TextField__c = 'Record ' + p + ' TextField',
                        NumberField__c = p,
                        DateTimeField__c = DateTime.now(),
                        TestObjectParent__c = testObjectParents[p].Id
                )
        );
}
insert testObjects;

// Create childs
List<TestObjectChild__c> testObjectChilds = new List<TestObjectChild__c>();
for (Integer r = 0; r < testObjects.size(); r++) {
    for(Integer c = 0; c < numOfChildRecords; c++) {
        testObjectChilds.add(
                new TestObjectChild__c (
                        Name = 'Visualforce ' + r + ' - ' + c,
                        TextField__c = 'Record ' + c + ' TextField',
                        NumberField__c = c,
                        TestObject__c = testObjects[r].Id
                )
        );
    }
}
insert testObjectChilds;
//--------------------------------------------------------------