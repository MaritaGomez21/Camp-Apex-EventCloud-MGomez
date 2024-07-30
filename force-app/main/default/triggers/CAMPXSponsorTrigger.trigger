trigger CAMPXSponsorTrigger on CAMPX__Sponsor__c (before insert) {
    if (Trigger.isInsert && Trigger.isBefore) {
        CAMPXSponsorTriggerHandler.handleBeforeInsert(trigger.new);
    }
}