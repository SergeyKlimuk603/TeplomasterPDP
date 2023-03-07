@isTest
private class SomeClassForTesting_Test {
    static final String SYS_ADMIN_PROFILE_NAME = 'System Administrator';

    static Profile sysAdminProfile;

    {
        // Этот блок не запускается, т.к. во время тестов не создается экземпляр класса.
        System.debug('-----NON static block');
    }

    static {
        // Этот статический блок запустится перед выполнением каждого тестового метода, включая testSetup
        // Его можно использовать, чтобы создавать статические переменные и затем использовать их в других тестовых методах
        System.debug('-----static block');

        sysAdminProfile = [SELECT Id, Name FROM Profile WHERE Name = :SYS_ADMIN_PROFILE_NAME LIMIT 1];

        System.debug('-----sysAdminProfile: ' + sysAdminProfile);
    }

    @testSetup
    private static void testSetup() {
        System.debug('-----testSetup runs');

        // One record creating
        insert new TestObject__c(Name = 'For test');

        // Creating records from static resources
        List<TestObject__c> testObjectsFromStaticResources = Test.loadData(TestObject__c.sObjectType, 'testObjectsForTests');
        System.debug('-----testObjectsFromStaticResources: ' + testObjectsFromStaticResources);
        System.debug('-----testObjectsFromStaticResources from database: ' + getTestObjects(1000));

        // Creating records from DataFactory
        List<TestObject__c> testObjectsFromDataFactory = DataFactory.createDefaultTestObjects();
        System.debug('-----testObjectsFromDataFactory: ' + getTestObjects(1000));

        // Create Test User
        Profile userProfile = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        System.debug('-----userProfile: ' + userProfile);

        System.debug('-----UserInfo.getUserName(): ' + UserInfo.getUserName());
        System.debug('-----UserInfo.getProfileId(): ' + UserInfo.getProfileId());
    }

    // В тестовом классе может быть только один метод помеченный аннотацией @testSetup
    // @testSetup
    // private static void testSetup1() {
    //     System.debug('-----UserInfo.getUserName(): ' + UserInfo.getUserName());
    //     System.debug('-----UserInfo.getProfileId(): ' + UserInfo.getProfileId());
    // }

    @isTest
    private static void test1() {
        TestObject__c testObject = getTestObject();
        System.debug('-----testObject test1: ' + getTestObject());

        testObject.Name = testObject.Name + '1';
        update testObject;

        System.debug('-----testObject test1 after update: ' + getTestObject());
    }

    @isTest
    private static void test2() {
        TestObject__c testObject = getTestObject();
        System.debug('-----testObject test2: ' + getTestObject());

        testObject.Name = testObject.Name + '2';
        update testObject;

        System.debug('-----testObject test2 after update: ' + getTestObject());
    }

    @isTest
    private static void test3() {
        User user1 = DataFactory.createUser(SYS_ADMIN_PROFILE_NAME, 'userName1@testKlim.com', false);
        System.debug('-----user1: ' + user1);

        List<User> users = [SELECT Id, Name, isActive FROM User WHERE Id = :user1.Id];
        System.debug('-----users: ' + users);

        System.debug('-----current user Name: ' + UserInfo.getName());

        // Чтобы использовать метод System.runAs(user1) не обязательно инсертать созданного пользователя.
        System.runAs(user1) {
            System.debug('-----inside the runAs');
            System.debug('-----current user Name: ' + UserInfo.getName());
        }
    }

    //Test class containing a test setup method cannot have any methods annotated with @isTest(SeeAllData=true)
    // @isTest(SeeAllData=true)
    // private static void test3() {
    //     System.debug('-----testObjects where SeeAllData=true: ' + getTestObjects(1000));
    // }

    private static TestObject__c getTestObject() {
        return getTestObjects(1).get(0);
    }

    private static List<TestObject__c> getTestObjects(Integer numOfRecords) {
        return [
            SELECT Id, Name
            FROM TestObject__c
            ORDER BY Name
            LIMIT :numOfRecords
        ];
    }

    //----------------------------------------------------------------------------------------------------------------------------
    //CustomMetadataType testing
    @isTest
    static void testCustomMetadataTypes() {
        //Создаем тестовые записи CustomMetadataType
        Map<String, TestCMT__mdt> testCmdMap = new Map<String, TestCMT__mdt>{
            'Default' => new TestCMT__mdt(DeveloperName = 'Default', Label = 'Default', TextField__c = 'Test default'),
            'testRecord' => new TestCMT__mdt(DeveloperName = 'testRecord', Label = 'testRecord', TextField__c = 'Test')
        };

        SomeClassForTesting instance = new SomeClassForTesting();

        //Подставляем созданные тестовые записи CustomMetadataType
        instance.testCmdMap = testCmdMap;

        Assert.areEqual('Test default', instance.getTextFromCmt('Default'));
        Assert.areEqual('Test', instance.getTextFromCmt('testRecord'));
    }
    //----------------------------------------------------------------------------------------------------------------------------
    //Обработка исключений в тестах https://help.salesforce.com/s/articleView?id=release-notes.rn_apex_new_assert_class.htm&release=240&type=5
    @isTest
    static void exceptionHandlingTest() {
        SomeClassForTesting instance = new SomeClassForTesting();

        try {
            instance.throwException('Test exception');
            Assert.fail('Exception failure is always an option');
        } catch (Exception ex) {
            Assert.isInstanceOfType(ex, IllegalArgumentException.class);
            // Additional assertions
        }
    }
    //----------------------------------------------------------------------------------------------------------------------------
}
