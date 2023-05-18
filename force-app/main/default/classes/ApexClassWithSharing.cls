public with sharing class ApexClassWithSharing {
    public static List<TestObject__c> getRecords() {
        return [
                SELECT Id, Name
                FROM TestObject__c
        ];
    }

    public static List<TestObject__c> getRecordsFromWithoutSharingClass() {
        return ApexClassWithoutSharing.getRecords();
    }

    public static List<TestObject__c> getRecordsFromInheritedSharingClass() {
        return ApexClassInheritedSharing.getRecords();
    }

    public static List<TestObject__c> getRecordsFromDefaultSharingClass() {
        return ApexClassDefaultSharing.getRecords();
    }
}