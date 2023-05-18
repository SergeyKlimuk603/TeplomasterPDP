@IsTest
private class ApexSharingTest {
    static final String SYS_ADMIN_PROFILE_NAME = 'System Administrator';
    static final String SALES_PROFILE_NAME = 'Custom: Sales Profile';
    static final String OBJECT_NAME_PATTERN = 'Security';
    static final String SALES_USER_1 = 'salesuser1@klim.by';
    static final String SALES_USER_2 = 'salesuser2@klim.by';
    static final String SYS_ADMIN_USER = 'sysadminuser@klim.by';
    static Map<String, User> userByUsername;

    static{
        userByUsername = getTestUserByUsernameMap();
    }

    @TestSetup
    static void setup() {
        createTestUsers();
        createTestRecords();
    }

    @IsTest
    static void queryFromTestMethod_Test() {
        System.debug('-----queryFromTestMethod_Test()');
        String className = 'FromTest';
        showRecords(className, [SELECT Id, Name FROM TestObject__c]);

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, [SELECT Id, Name FROM TestObject__c]);
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, [SELECT Id, Name FROM TestObject__c]);
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, [SELECT Id, Name FROM TestObject__c]);
        }
    }

    @IsTest
    static void ApexClassDefaultSharingClass_Test() {
        System.debug('-----ApexClassDefaultSharingClass_Test()');
        String className = ApexClassDefaultSharing.class.getName();
        showRecords(className, ApexClassDefaultSharing.getRecords());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassDefaultSharing.getRecords());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassDefaultSharing.getRecords());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassDefaultSharing.getRecords());
        }
    }

    @IsTest
    static void ApexClassWithoutSharingClass_Test() {
        System.debug('-----ApexClassWithoutSharingClass_Test()');
        String className = ApexClassWithoutSharing.class.getName();
        showRecords(className, ApexClassWithoutSharing.getRecords());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassWithoutSharing.getRecords());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassWithoutSharing.getRecords());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassWithoutSharing.getRecords());
        }
    }

    @IsTest
    static void ApexClassWithSharingClass_Test() {
        System.debug('-----ApexClassWithSharingClass_Test()');
        String className = ApexClassWithSharing.class.getName();
        showRecords(className, ApexClassWithSharing.getRecords());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassWithSharing.getRecords());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassWithSharing.getRecords());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassWithSharing.getRecords());
        }
    }

    @IsTest
    static void ApexClassInheritedSharingClass_Test() {
        System.debug('-----ApexClassInheritedSharingClass_Test()');
        String className = ApexClassInheritedSharing.class.getName();
        showRecords(className, ApexClassInheritedSharing.getRecords());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassInheritedSharing.getRecords());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassInheritedSharing.getRecords());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassInheritedSharing.getRecords());
        }
    }

    // FromDefaultSharing --------------------------------------------------------------

    @IsTest
    static void FromDefaultSharingToWithoutSharing_Test() {
        System.debug('-----FromDefaultSharingToWithoutSharing_Test()');
        String className = ApexClassDefaultSharing.class.getName();
        showRecords(className, ApexClassDefaultSharing.getRecordsFromWithoutSharingClass());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassDefaultSharing.getRecordsFromWithoutSharingClass());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassDefaultSharing.getRecordsFromWithoutSharingClass());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassDefaultSharing.getRecordsFromWithoutSharingClass());
        }
    }

    @IsTest
    static void FromDefaultSharingToWithSharing_Test() {
        System.debug('-----FromDefaultSharingToWithSharing_Test()');
        String className = ApexClassDefaultSharing.class.getName();
        showRecords(className, ApexClassDefaultSharing.getRecordsFromWithSharingClass());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassDefaultSharing.getRecordsFromWithSharingClass());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassDefaultSharing.getRecordsFromWithSharingClass());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassDefaultSharing.getRecordsFromWithSharingClass());
        }
    }

    @IsTest
    static void FromDefaultSharingToInheritedSharing_Test() {
        System.debug('-----FromDefaultSharingToInheritedSharing_Test()');
        String className = ApexClassDefaultSharing.class.getName();
        showRecords(className, ApexClassDefaultSharing.getRecordsFromInheritedSharingClass());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassDefaultSharing.getRecordsFromInheritedSharingClass());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassDefaultSharing.getRecordsFromInheritedSharingClass());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassDefaultSharing.getRecordsFromInheritedSharingClass());
        }
    }

    // FromWithoutSharing --------------------------------------------------------------

    @IsTest
    static void FromWithoutSharingToDefaultSharing_Test() {
        System.debug('-----FromWithoutSharingToDefaultSharing_Test()');
        String className = ApexClassWithoutSharing.class.getName();
        showRecords(className, ApexClassWithoutSharing.getRecordsFromDefaultSharingClass());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassWithoutSharing.getRecordsFromDefaultSharingClass());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassWithoutSharing.getRecordsFromDefaultSharingClass());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassWithoutSharing.getRecordsFromDefaultSharingClass());
        }
    }

    @IsTest
    static void FromWithoutSharingToWithSharing_Test() {
        System.debug('-----FromWithoutSharingToWithSharing_Test()');
        String className = ApexClassWithoutSharing.class.getName();
        showRecords(className, ApexClassWithoutSharing.getRecordsFromWithSharingClass());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassWithoutSharing.getRecordsFromWithSharingClass());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassWithoutSharing.getRecordsFromWithSharingClass());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassWithoutSharing.getRecordsFromWithSharingClass());
        }
    }

    @IsTest
    static void FromWithoutSharingToInheritedSharing_Test() {
        System.debug('-----FromWithoutSharingToInheritedSharing_Test()');
        String className = ApexClassWithoutSharing.class.getName();
        showRecords(className, ApexClassWithoutSharing.getRecordsFromInheritedSharingClass());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassWithoutSharing.getRecordsFromInheritedSharingClass());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassWithoutSharing.getRecordsFromInheritedSharingClass());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassWithoutSharing.getRecordsFromInheritedSharingClass());
        }
    }

    // FromWithSharing --------------------------------------------------------------

    @IsTest
    static void FromWithSharingToDefaultSharing_Test() {
        System.debug('-----FromWithSharingToDefaultSharing_Test()');
        String className = ApexClassWithSharing.class.getName();
        showRecords(className, ApexClassWithSharing.getRecordsFromDefaultSharingClass());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassWithSharing.getRecordsFromDefaultSharingClass());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassWithSharing.getRecordsFromDefaultSharingClass());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassWithSharing.getRecordsFromDefaultSharingClass());
        }
    }

    @IsTest
    static void FromWitSharingToInheritedSharing_Test() {
        System.debug('-----FromWitSharingToInheritedSharing_Test()');
        String className = ApexClassWithSharing.class.getName();
        showRecords(className, ApexClassWithSharing.getRecordsFromInheritedSharingClass());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassWithSharing.getRecordsFromInheritedSharingClass());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassWithSharing.getRecordsFromInheritedSharingClass());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassWithSharing.getRecordsFromInheritedSharingClass());
        }
    }


    @IsTest
    static void FromWithSharingToWithoutSharing_Test() {
        System.debug('-----FromWithSharingToWithoutSharing_Test()');
        String className = ApexClassWithSharing.class.getName();
        showRecords(className, ApexClassWithSharing.getRecordsFromWithoutSharingClass());

        System.runAs(userByUsername.get(SALES_USER_1)) {
            showRecords(className, ApexClassWithSharing.getRecordsFromWithoutSharingClass());
        }

        System.runAs(userByUsername.get(SALES_USER_2)) {
            showRecords(className, ApexClassWithSharing.getRecordsFromWithoutSharingClass());
        }

        System.runAs(userByUsername.get(SYS_ADMIN_USER)) {
            showRecords(className, ApexClassWithSharing.getRecordsFromWithoutSharingClass());
        }
    }

    private static User createUser(String userProfileName, String userName, Boolean doInsert) {
        User user = new User(
                ProfileId = [SELECT Id FROM Profile WHERE Name = :userProfileName LIMIT 1].Id,
                LastName = 'TestLastName',
                Email = userName,
                Alias = 'tester',
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                TimeZoneSidKey = 'Europe/Moscow',
                IsActive = true,
                Username = userName
        );

        if (doInsert) {
            insert user;
        }

        return user;
    }

    private static List<TestObject__c> createTestObjectsWithOwner(Integer numOfRecords, String objectNamePattern, Boolean doInsert, Id ownerId) {
        List<TestObject__c> testObjects = new List<TestObject__c>();

        for (Integer i = 0; i < numOfRecords; i++) {
            TestObject__c testObject = new TestObject__c(Name = objectNamePattern + ' ' + i);
            if(ownerId != null) {
                testObject.OwnerId = ownerId;
            }
            testObjects.add(testObject);
        }

        if (doInsert) {
            insert testObjects;
        }

        return testObjects;
    }

    private static List<TestObject__c> createTestObjectWithOwner(String objectNamePattern, Id ownerId) {
        return createTestObjectsWithOwner(1, objectNamePattern, true, ownerId);
    }

    private static List<TestObject__c> createTestObjects(Integer numOfRecords, String objectNamePattern, Boolean doInsert) {
        return createTestObjectsWithOwner(numOfRecords, objectNamePattern, doInsert, null);
    }

    private static Map<String, User> getTestUserByUsernameMap() {
        Map<String, User> userByUsername = new Map<String, User>();

        List<User> usersList= [
                SELECT Id, Username
                FROM User
                WHERE Username IN (:SALES_USER_1, :SALES_USER_2, :SYS_ADMIN_USER)
        ];

        for(User user : usersList) {
            userByUsername.put(user.Username, user);
        }

        return userByUsername;
    }

    private static List<User> createTestUsers() {
        List<User> testUsers = new List<User>{
                createUser(SALES_PROFILE_NAME, SALES_USER_1, false),
                createUser(SALES_PROFILE_NAME, SALES_USER_2, false),
                createUser(SYS_ADMIN_PROFILE_NAME, SYS_ADMIN_USER, false)
        };
        insert testUsers;

        return testUsers;
    }

    private static List<TestObject__c> createTestRecords() {
        userByUsername = getTestUserByUsernameMap();
        createTestObjectWithOwner(OBJECT_NAME_PATTERN + ' ' + SALES_USER_1, userByUsername.get(SALES_USER_1).Id);
        createTestObjectWithOwner(OBJECT_NAME_PATTERN + ' ' + SALES_USER_2, userByUsername.get(SALES_USER_2).Id);
        createTestObjectWithOwner(OBJECT_NAME_PATTERN + ' ' + SYS_ADMIN_USER, userByUsername.get(SYS_ADMIN_USER).Id);
        showTestObjectsFromDB('1');

        return new List<TestObject__c>();
    }

    private static void showTestObjectsFromDB(String index) {
        List<TestObject__c> testObjects = [
                SELECT Id, OwnerId
                FROM TestObject__c
        ];

        System.debug('-----testObjectsFromDB_' + index + ': ' + testObjects);
    }

    private static void showRecords(String logIndex, List<SObject> records) {
        System.debug('-----user: ' + UserInfo.getUserName());
        System.debug('-----' + logIndex + '.records.size(): ' + records.size());
        System.debug('-----' + logIndex + '.records: ' + records);
    }
}