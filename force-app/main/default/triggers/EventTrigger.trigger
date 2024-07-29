trigger EventTrigger on CAMPX__Event__c (before insert, after update) {
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            EventTriggerHandler.handleBeforeInsert(Trigger.new);
        
    } else if (Trigger.isUpdate) {
           if (Trigger.isAfter) {
                EventTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
            }
    }
}
}