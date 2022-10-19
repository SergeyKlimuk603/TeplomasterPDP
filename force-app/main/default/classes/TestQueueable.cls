public with sharing class TestQueueable implements System.Queueable {
    public TestQueueable() {

    }

    public void execute(QueueableContext context) {
        //System.enqueueJob(new TestQueueable());
        List<AObjectBig__c> bigObjects = [SELECT Id, Name FROM AObjectBig__c];
        insert new List<AObjectBig__c> {
            new AObjectBig__c(Name = 'TestQueueableFromTrigger')
        };
    }
}