trigger CAMPXEventTrigger on CAMPX__Event__c (before insert, before update) {
        if (Trigger.isInsert && Trigger.isBefore) {
        
        CAMPXEventTriggerHandler.handleBeforeInsert (Trigger.new);
        
        } else if (Trigger.isUpdate && Trigger.isBefore) {
        
        CAMPXEventTriggerHandler.handleBeforeUpdate (Trigger.new, Trigger.oldMap);
        }
}

