@isTest
public class DataFactory {
    public static List<TestObject__c> createTestObjects(Integer numOfRecords, String objectNamePattern, Boolean doInsert) {
        List<TestObject__c> testObjects = new List<TestObject__c>();

        for (Integer i = 0; i < numOfRecords; i++) {
            testObjects.add(new TestObject__c(Name = objectNamePattern + ' ' + i));
        }

        if (doInsert) {
            insert testObjects;
        }

        return testObjects;
    }

    public static List<TestObject__c> createDefaultTestObjects() {
        return createTestObjects(10, 'Test Name', true);
    }

    public static User createUser(String userProfileName, String userName, Boolean doInsert) {
        // Указаны все обязательные поля для создания пользователя
        User user = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = :userProfileName LIMIT 1]
            .Id,
            FirstName = 'TestFirstName', // необязательное поле
            LastName = 'TestLastName',
            Email = userName,
            Alias = 'tester',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            TimeZoneSidKey = 'Europe/Moscow',
            // IsActive = true, // необязательное поле, но возможно полезное, по умолчанию пользователь создается АКТИВНЫМ
            Username = userName
        );

        if (doInsert) {
            insert user;
        }

        return user;
    }

    
}
