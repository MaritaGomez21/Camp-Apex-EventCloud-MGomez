trigger EventTrigger on CAMPX__Event__c (before insert, after insert) {
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            EventTriggerHandler.handleBeforeInsert(Trigger.new);
        } else if (Trigger.isAfter) {
            // Process after insert
        }
    }
}