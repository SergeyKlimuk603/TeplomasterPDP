public with sharing class TestObjectUpdateEventTriggerHandler extends TriggerHandler {

    private final Integer NUMBER_OF_UPDATE_ATTEMPTS = 5;

    protected override void afterInsert(Map<Id, sObject> newMap) {
        try {
            update createTestObjectsForUpdate(newMap.values());
        } catch (Exception ex) {
            retryEvent();
        }
    }

    private List<TestObject__c> createTestObjectsForUpdate(List<TestObjectUpdatedEvent__e> newList) {
        List<TestObject__c> testObjectsForUpdate = new List<TestObject__c>();

        for (TestObjectUpdatedEvent__e testObjectUpdateEvent : newList) {
            testObjectsForUpdate.add(
                    new TestObject__c(
                            Id = testObjectUpdateEvent.TestObjectId__c,
                            IsLastUpdateSuccessful__c = testObjectUpdateEvent.IsSuccessfulUpdate__c,
                            TextField__c = '00000000000000000000000000000000000000000000000000000000000000000000000000000' +
                                    '00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000' +
                                    '00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
                    )
            );
        }

        return testObjectsForUpdate;
    }

    private void retryEvent() {
        if (EventBus.TriggerContext.currentContext().retries < NUMBER_OF_UPDATE_ATTEMPTS) {
            throw new EventBus.RetryableException('Error Message');
        } else {
            System.debug('----- ERROR: Cannot update records');
            insert new TestObject__c(
                    Name = 'Batch_UpdateTestObjects_',
                    TextField__c = 'ERROR: Cannot update records',
                    NumberField__c = EventBus.TriggerContext.currentContext().retries
            );
        }
    }
}