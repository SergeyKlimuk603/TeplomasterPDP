/**
 * Created by user on 10/19/22.
 */

public with sharing class TestObjectTriggerHandler extends TriggerHandler {
    private static Boolean isActive = true;

    protected override void afterInsert(Map<Id, SObject> newObjectsMap) {
    }

    protected override void beforeUpdate(List<SObject> newObjectsList, Map<Id, SObject> oldObjectsMap) {
        if (!isActive) {
            return;
        }

        List<TestObject__c> newList = newObjectsList;
        System.debug('-----beforeUpdate');
        System.debug('-----newList: ' + newList);
        for (TestObject__c testObject : newList) {
            System.debug('-----testObject: ' + testObject);
            if (testObject.TextField__c.startsWith('TestOrderOfExecution|')) {
                testObject.TextField__c += ' |buTrigger|';
            }
        }
    }

    protected override void afterUpdate(List<SObject> newObjectsList, Map<Id, SObject> oldObjectsMap) {
        if (!isActive) {
            return;
        }

        List<TestObject__c> newList = newObjectsList;

        System.debug('-----afterUpdate');
        System.debug('-----newList: ' + newList);

        List<TestObject__c> newSelectedList = [
            SELECT Id, TextField__c
            FROM TestObject__c
            WHERE Id IN :newList AND TextField__c LIKE 'TestOrderOfExecution|%'
        ];

        for (TestObject__c testObject : newSelectedList) {
            System.debug('-----testObject: ' + testObject);
            testObject.TextField__c += ' |auTrigger|';
        }

        updateWithoutTrigger(newSelectedList);
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
