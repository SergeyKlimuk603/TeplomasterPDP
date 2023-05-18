public class ApexClassDefaultSharing {

    public static List<TestObject__c> getRecords() {
        return [
                SELECT Id, Name
                FROM TestObject__c
        ];
    }

    public static List<TestObject__c> getRecordsFromWithSharingClass() {
        return ApexClassWithSharing.getRecords();
    }

    public static List<TestObject__c> getRecordsFromWithoutSharingClass() {
        return ApexClassWithoutSharing.getRecords();
    }

    public static List<TestObject__c> getRecordsFromInheritedSharingClass() {
        return ApexClassInheritedSharing.getRecords();
    }
}