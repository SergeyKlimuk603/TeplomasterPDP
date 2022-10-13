trigger TestObjectUpdateEventTrigger on TestObjectUpdatedEvent__e (after insert) {

    new TestObjectUpdateEventTriggerHandler().execute();
}