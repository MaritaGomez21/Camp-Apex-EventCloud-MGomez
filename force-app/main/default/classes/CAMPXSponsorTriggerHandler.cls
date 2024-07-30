public with sharing class CAMPXSponsorTriggerHandler {
    public static void handleBeforeInsert(List<CampX__Sponsor__c> newCampXSponsorList){
        // Loop through each new campX sponsor and update status to "Pending" if NULL
        for(CampX__Sponsor__c newCampXSponsor : newCampXSponsorList){
            if (newCampXSponsor.CAMPX__Status__c == NULL) {
            newCampXSponsor.CAMPX__Status__c = 'Pending';
            }
        }
    }
}