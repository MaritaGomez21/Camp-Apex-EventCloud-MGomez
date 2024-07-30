trigger EventTrigger on CAMPX__Event__c (before insert, before update) {
    if (Trigger.isInsert && Trigger.isBefore) {
        
            EventTriggerHandler.handleBeforeInsert (Trigger.new);
        
    } else if (Trigger.isUpdate && Trigger.isBefore) {
           
                EventTriggerHandler.handleBeforeUpdate (Trigger.new, Trigger.oldMap);
            }
    }

