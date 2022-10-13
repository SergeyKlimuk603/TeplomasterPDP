/**
 * Created by user on 9/30/22.
 */

public with sharing class Batch_UpdateTestObjects implements Database.Batchable<SObject>, Schedulable, Database.Stateful{

    private final Integer START_NEW_BATCH_PERIOD = 5;

    private String query = 'SELECT Id, Name, TextField__c, CheckboxField__c, NumberField__c ' +
            'FROM TestObject__c ' +
            'WHERE CheckboxField__c = TRUE';

    private Integer numOfSuccessfulRecords = 0;

    //Constructors
    public Batch_UpdateTestObjects() {}

    public Batch_UpdateTestObjects(String query) {
        this.query = query;
    }

    //Schedulable
    public void execute(SchedulableContext schedulableContext) {
        Database.executeBatch(new Batch_UpdateTestObjects(query));
    }

    //Batchable
    public Database.QueryLocator start(Database.BatchableContext batchableContext) {
        Database.QueryLocator queryLocator = Database.getQueryLocator(query);

        return queryLocator;
    }

    public void execute(Database.BatchableContext batchableContext, List<TestObject__c> testObjects) {
        List<TestObject__c> testObjectsForUpdate = handleTestObjects(testObjects);

        List<Database.SaveResult> saveResults = Database.update(testObjectsForUpdate, false);

        List<TestObjectUpdatedEvent__e> testObjectUpdatedEvents = getEventsBySaveResults(saveResults);

        EventBus.publish(testObjectUpdatedEvents);
    }

    public void finish(Database.BatchableContext batchableContext) {
        System.debug('-----numOfSuccessfulRecords: ' + numOfSuccessfulRecords);

        if (Database.query(query + ' LIMIT 1').isEmpty()) {
            return;
        }

        System.scheduleBatch(
                new Batch_UpdateTestObjects(query),
                Batch_UpdateTestObjects.class.getName(),
                START_NEW_BATCH_PERIOD
        );
    }

    //Others
    private List<TestObject__c> handleTestObjects(List<TestObject__c> testObjects) {
        for (TestObject__c testObject : testObjects) {
            testObject.CheckboxField__c = false;
            testObject.TextField__c = 'Checkbox was changed';
            createFailedRecords(testObject);
        }

        return testObjects;
    }

    private void createFailedRecords(TestObject__c testObject) {
        Decimal rand = Math.random() * 2;
        if (rand > 1) {
            System.debug('-----failed testObject: ' + testObject.Id);
            testObject.TextField__c = '00000000000000000000000000000000000000000000000000000000000000000000000000000' +
                    '00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000' +
                    '00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
        }
    }

    private List<TestObjectUpdatedEvent__e> getEventsBySaveResults(List<Database.SaveResult> saveResults) {
        List<TestObjectUpdatedEvent__e> testObjectUpdatedEvents = new List<TestObjectUpdatedEvent__e>();
        for (Database.SaveResult saveResult : saveResults) {
            if (saveResult.isSuccess()) {
                numOfSuccessfulRecords++;
            }

            testObjectUpdatedEvents.add(
                    new TestObjectUpdatedEvent__e(
                            TestObjectId__c = saveResult.getId(),
                            IsSuccessfulUpdate__c = saveResult.isSuccess()
                    )
            );
        }

        return testObjectUpdatedEvents;
    }
}