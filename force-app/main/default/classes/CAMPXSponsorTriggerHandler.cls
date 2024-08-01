public with sharing class CAMPXSponsorTriggerHandler {
    public static void handleBeforeInsert(List<CampX__Sponsor__c> newCampXSponsorList){
        // Loop through each new campX sponsor and update status to "Pending" if NULL
        for(CampX__Sponsor__c newCampXSponsor : newCampXSponsorList){
            if (newCampXSponsor.CAMPX__Status__c == NULL) {
            newCampXSponsor.CAMPX__Status__c = 'Pending';
            }
            if(newCampXSponsor.CAMPX__Email__c == NULL){
                newCampXSponsor.CAMPX__Email__c.addError('A sponsor can not be created without an email address');
            }
            if (newCampXSponsor.CAMPX__ContributionAmount__c!= NULL) {
                if (newCampXSponsor.CAMPX__ContributionAmount__c >= 5000) {
                    newCampXSponsor.CAMPX__Tier__c = 'Gold';
                } 
                else if (newCampXSponsor.CAMPX__ContributionAmount__c >= 1000) {
                    newCampXSponsor.CAMPX__Tier__c = 'Silver';
                }
                else if (newCampXSponsor.CAMPX__ContributionAmount__c > 0) {
                    newCampXSponsor.CAMPX__Tier__c = 'Bronze';
                }
                else { //do nothing
                }
            }
            // Check if acceptated sponsor record is related to an event to maintain meaningful relationships
            if (newCampXSponsor.CAMPX__Status__c == 'Accepted' && newCampXSponsor.CAMPX__Event__c == NULL){
                newCampXSponsor.CAMPX__Status__c.addError('A Sponsor must be associated with an event before being Accepted.');
            }
        }
    }
    public static void handleBeforeUpdate(
        List<SObject> newSobjs, Map<Id,SObject> oldSobjsMap){

            List<CAMPX__Sponsor__c> newCampXSponsorList = (List<CAMPX__Sponsor__c>) newSobjs;
            Map<Id, CAMPX__Sponsor__c> oldCampXSponsorMap = (Map<Id, CAMPX__Sponsor__c>)oldSobjsMap;

        // Loop through each updated campX Event record
        for (CAMPX__Sponsor__c newSponsor : newCampXSponsorList) {

            // Use the map method "get" to retrieve the old event record from the map.
            CAMPX__Sponsor__c oldSponsor = oldCampXSponsorMap.get(newSponsor.Id);

            // Check if acceptated sponsor record is related to an event to maintain meaningful relationships
            if (newSponsor.CAMPX__Status__c == 'Accepted' && newSponsor.CAMPX__Event__c == NULL){
                newSponsor.CAMPX__Status__c.addError('A Sponsor must be associated with an event before being Accepted.');
            }
            
        }
    }
}