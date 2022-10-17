//-------------------------------------------------------------

//Удаление существующих тестовых записей
List<TestObject__c> testObjectForDelete = [SELECT Id FROM TestObject__c WHERE Name LIKE 'Batch_UpdateTestObjects_%'];
delete testObjectForDelete;

//-------------------------------------------------------------

//Создание новых тестовых записей
List<TestObject__c> testObjects = new List<TestObject__c>();
for(Integer i = 1; i <= 400; i++) {
    Boolean checkboxValue = (i <= 200);
    testObjects.add(
            new TestObject__c(
                    Name = ('Batch_UpdateTestObjects_' + i),
                    NumberField__c = i,
                    TextField__c = 'Some text',
                    CheckboxField__c = checkboxValue
            )
    );
}
insert testObjects;

//--------------------------------------------------------

//Запуск батча
Database.executeBatch(new Batch_UpdateTestObjects(), 10);

//--------------------------------------------------------

//Запуск батча по расписанию
System.schedule('Batch_UpdateTestObjects11111', '0 41 15 * * ?', new Batch_UpdateTestObjects());