trigger TestObjectTrigger on TestObject__c(
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete
) {
    //new TestObjectTriggerHandler().execute();

    if(Trigger.isBefore && Trigger.isDelete) {
        System.debug('-----Trigger.isBefore && Trigger.isDelete');
        for (TestObject__c testObject : [
            SELECT Id
            FROM TestObject__c
            WHERE Id IN (SELECT TestObject__c FROM TestObjectChild__c) AND Id IN :Trigger.old
        ]) {
            System.debug('-----testObject: ' + testObject);
            Trigger.oldMap.get(testObject.Id).addError('Cannot delete record with related TestObjectChild__c records');
        }
    }
    
}
