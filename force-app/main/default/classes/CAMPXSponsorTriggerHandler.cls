public with sharing class CAMPXSponsorTriggerHandler {
    public static void handleBeforeInsert(List<CampX__Sponsor__c> newCampXSponsorList){
        // Loop through each new campX sponsor and update status to "Pending" if NULL
        for(CampX__Sponsor__c newCampXSponsor : newCampXSponsorList){
            if (newCampXSponsor.CAMPX__Status__c == NULL) {
            newCampXSponsor.CAMPX__Status__c = 'Pending';

                if(newCampXSponsor.CAMPX__Email__c == NULL){
                    newCampXSponsor.CAMPX__Email__c.addError('A sponsor can not be created without an email address');
                }
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
        }
    }
    public static void handleBeforeUpdate(
        List<CampX__Sponsor__c> newCampXSponsorList, Map<Id,CampX__Sponsor__c> oldCampXSponsorMap){

        // Loop through each updated campX Event record
        for (CAMPX__Sponsor__c newSponsor : newCampXSponsorList) {

            // Use the map method "get" to retrieve the old event record from the map.
            CAMPX__Sponsor__c oldSponsor = oldCampXSponsorMap.get(newSponsor.Id);

            // Check the ContributionAmount
            if (newSponsor.CAMPX__ContributionAmount__c!= NULL || 
                newSponsor.CAMPX__ContributionAmount__c > 0) {
                    if (newSponsor.CAMPX__ContributionAmount__c >= 5000) {
                        newSponsor.CAMPX__Tier__c = 'Gold';
                    } 
                    else if (newSponsor.CAMPX__ContributionAmount__c >= 1000) {
                        newSponsor.CAMPX__Tier__c = 'Silver';
                    }
                    else if (newSponsor.CAMPX__ContributionAmount__c > 0) {
                        newSponsor.CAMPX__Tier__c = 'Bronze';
                    }
                    else { //do nothing
                    }
            }
        }
    }
}