/**
 * Created by user on 10/19/22.
 */

public with sharing class TestObjectTriggerHandler extends TriggerHandler{
    protected override void afterInsert(Map<Id, sObject> newMap) {
        System.debug('-----startQueue');
        System.debug('-----newMap.size()' + newMap.size());
        System.enqueueJob(new TestQueueable());
    }
}