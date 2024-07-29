trigger EventTrigger on CAMPX__Event__c (before insert, before update) {
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            EventTriggerHandler.handleBeforeInsert(Trigger.new);
        
    } else if (Trigger.isUpdate) {
           if (Trigger.isBefore) {
                EventTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
            }
    }
}
}