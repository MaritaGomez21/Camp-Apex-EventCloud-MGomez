trigger CAMPXSponsorTrigger on CAMPX__Sponsor__c (before insert, before update, after update) {
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            CAMPXSponsorTriggerHandler.handleBeforeInsert(trigger.new);
        }
    } else if (Trigger.isUpdate ) {
        if (Trigger.isBefore) {
            CAMPXSponsorTriggerHandler.handleBeforeUpdate(trigger.new, trigger.oldmap);
        } else if (Trigger.isAfter) {
            //CAMPXSponsorTriggerHandler.handleAfterUpdate(trigger.new, trigger.oldmap);
        }
    }
    
}