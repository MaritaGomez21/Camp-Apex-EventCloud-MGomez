trigger CAMPXEventTrigger on CAMPX__Event__c (before insert, before update) {
        if (Trigger.isInsert && Trigger.isBefore) {
        //commenting to test flows
        //CAMPXEventTriggerHandler.handleBeforeInsert (Trigger.new);
        
        } else if (Trigger.isUpdate && Trigger.isBefore) {
        //commenting to test flows
        //CAMPXEventTriggerHandler.handleBeforeUpdate (Trigger.new, Trigger.oldMap);
        }
}

