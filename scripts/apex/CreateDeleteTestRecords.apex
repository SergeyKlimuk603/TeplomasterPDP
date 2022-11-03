// Удаление всех существующих записей объекта TestObject__c
List<TestObject__c> recordsForDElete = [SELECT Id FROM TestObject__c];
delete recordsForDElete;

//-----------------------------------------------------------------------------------------