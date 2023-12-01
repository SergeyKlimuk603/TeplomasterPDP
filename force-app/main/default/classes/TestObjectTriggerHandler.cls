public with sharing class TestObjectTriggerHandler extends TriggerHandler {
    private static Boolean isActive = true;
    private static Integer recursionLimit = 3;
    private static Integer executionCount = 0;
    private static Integer count = 0;

    protected override void afterInsert(Map<Id, SObject> newObjectsMap) {
    }

    protected override void beforeUpdate(List<SObject> newObjectsList, Map<Id, SObject> oldObjectsMap) {
        if (!isActive) {
            return;
        }

        if (executionCount >= recursionLimit) {
            return;
        }

        List<TestObject__c> newList = newObjectsList;

        for (TestObject__c testObject : newList) {
            if (testObject.Name == 'TestOrderOfExecution') {
                testObject.TextAreaField__c += '<p>beforeApdate Trigger' + count + '</p>';
            }
        }
    }

    protected override void afterUpdate(List<SObject> newObjectsList, Map<Id, SObject> oldObjectsMap) {
        if (!isActive) {
            return;
        }

        if (executionCount >= recursionLimit) {
            executionCount = 0;
            return;
        }

        List<TestObject__c> newList = newObjectsList;

        List<TestObject__c> newSelectedList = [
            SELECT Id, TextAreaField__c
            FROM TestObject__c
            WHERE Id IN :newList AND Name LIKE 'TestOrderOfExecution%'
        ];

        for (TestObject__c testObject : newSelectedList) {
            testObject.TextAreaField__c += '<p>afterApdate Trigger' + count + '</p>';
        }

        executionCount++;
        count++;
        update newSelectedList;
        //updateWithoutTrigger(newSelectedList);
    }

    private static void updateWithoutTrigger(List<TestObject__c> testObjectsList) {
        if (testObjectsList == null || testObjectsList.isEmpty()) {
            return;
        }

        Boolean isCurrentActive = isActive;
        isActive = false;
        update testObjectsList;
        isActive = isCurrentActive;
    }
}
