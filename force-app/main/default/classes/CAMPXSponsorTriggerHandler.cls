public with sharing class CAMPXSponsorTriggerHandler {
    public static void handleBeforeInsert(List<CampX__Sponsor__c> newCampXSponsorList){
        // Loop through each new campX sponsor and update status to "Pending" if NULL
        for(CampX__Sponsor__c newSponsor : newCampXSponsorList){
            if (newSponsor.CAMPX__Status__c == NULL) {
                newSponsor.CAMPX__Status__c = 'Pending';
            }
            if(newSponsor.CAMPX__Email__c == NULL){
                newSponsor.CAMPX__Email__c.addError('A sponsor can not be created without an email address');
            }
        }
        CAMPXSponsorTriggerHandler.helperUpdateSponsorTier(newCampXSponsorList);
            
        CAMPXSponsorTriggerHandler.helperSponsorAssociation(newCampXSponsorList);  
    }

    public static void handleBeforeUpdate(
        List<SObject> newSobjs, Map<Id,SObject> oldSobjsMap){

            List<CAMPX__Sponsor__c> newCampXSponsorList = (List<CAMPX__Sponsor__c>) newSobjs;
            Map<Id, CAMPX__Sponsor__c> oldCampXSponsorMap = (Map<Id, CAMPX__Sponsor__c>)oldSobjsMap;

        // Loop through each updated campX Event record
        for (CAMPX__Sponsor__c newSponsor : newCampXSponsorList) {

            // Use the map method "get" to retrieve the old event record from the map.
            CAMPX__Sponsor__c oldSponsor = oldCampXSponsorMap.get(newSponsor.Id);

            }
        CAMPXSponsorTriggerHandler.helperSponsorAssociation(newCampXSponsorList);

        CAMPXSponsorTriggerHandler.helperUpdateSponsorTier(newCampXSponsorList);
    }

    /**Marita: Updating Event Gross Revenue upon Sponsor Acceptance
     * public static void handleAfterUpdate(List<SObject> newSobjs, Map<Id,SObject> oldSobjsMap){
        // Instantiate variables
        List<CAMPX__Sponsor__c> newCampXSponsorList = (List<CAMPX__Sponsor__c>) newSobjs;
        Map<Id, CAMPX__Sponsor__c> oldCampXSponsorMap = (Map<Id, CAMPX__Sponsor__c>)oldSobjsMap;
        Decimal totalContributedAmount;
        

        // Loop through each updated campX Event record
        for (CAMPX__Sponsor__c newSponsor : newCampXSponsorList) {

            // Use the map method "get" to retrieve the old event record from the map.
            CAMPX__Sponsor__c oldSponsor = oldCampXSponsorMap.get(newSponsor.Id);

            // If the status has changed, update the status change date by using the DateTime class method now()
            if (newSponsor.CAMPX__Status__c == 'Accepted' && oldSponsor.CAMPX__Status__c != 'Accepted') {
                // Add Sponsor's Contributed Amount to the Event's Gross Revenue field
                if(newSponsor.CAMPX__ContributionAmount__c != NULL || newSponsor.CAMPX__Event__r.CAMPX__GrossRevenue__c != NULL){
                    totalContributedAmount = newSponsor.CAMPX__ContributionAmount__c + newSponsor.CAMPX__Event__r.CAMPX__GrossRevenue__c;
                    newSponsor.CAMPX__Event__r.CAMPX__GrossRevenue__c = totalContributedAmount;

                } else if (newSponsor.CAMPX__ContributionAmount__c != NULL && newSponsor.CAMPX__Event__r.CAMPX__GrossRevenue__c == NULL){
                    newSponsor.CAMPX__Event__r.CAMPX__GrossRevenue__c = 0;
                    totalContributedAmount = newSponsor.CAMPX__ContributionAmount__c + newSponsor.CAMPX__Event__r.CAMPX__GrossRevenue__c;

                } else {
                    // do nothing
                }
            }
            }
    }*/

    /*ai version: Updating Event Gross Revenue upon Sponsor Acceptance
    public static void handleAfterUpdate(List<CAMPX__Sponsor__c> newSponsors, Map<Id, CAMPX__Sponsor__c> oldSponsorMap) {
        Set<Id> eventIds = new Set<Id>();
        Map<Id, Decimal> revenueUpdates = new Map<Id, Decimal>();

        for (CAMPX__Sponsor__c newSponsor : newSponsors) {
            CAMPX__Sponsor__c oldSponsor = oldSponsorMap.get(newSponsor.Id);
            if (newSponsor.CAMPX__Status__c == 'Accepted' && oldSponsor.CAMPX__Status__c != 'Accepted') {
                if (newSponsor.CAMPX__Event__c != null) {
                    eventIds.add(newSponsor.CAMPX__Event__c);
                    if (!revenueUpdates.containsKey(newSponsor.CAMPX__Event__c)) {
                        revenueUpdates.put(newSponsor.CAMPX__Event__c, 0);
                    }
                    revenueUpdates.put(newSponsor.CAMPX__Event__c, revenueUpdates.get(newSponsor.CAMPX__Event__c) + newSponsor.CAMPX__ContributionAmount__c);
                }
            }
        }

        if (!eventIds.isEmpty()) {
            List<CAMPX__Event__c> eventsToUpdate = [SELECT Id, CAMPX__GrossRevenue__c FROM CAMPX__Event__c WHERE Id IN :eventIds];
            for (CAMPX__Event__c event : eventsToUpdate) {
                event.CAMPX__GrossRevenue__c += revenueUpdates.get(event.Id);
            }
            update eventsToUpdate;
        }
    }*/


    public static void helperSponsorAssociation(List<CampX__Sponsor__c> newCampXSponsorList){
        for(CampX__Sponsor__c newSponsor : newCampXSponsorList){
            // Check if acceptated sponsor record is related to an event to maintain meaningful relationships
            if (newSponsor.CAMPX__Status__c == 'Accepted' && newSponsor.CAMPX__Event__c == NULL){
                newSponsor.CAMPX__Status__c.addError('A Sponsor must be associated with an event before being Accepted.');
            }
        }
    }

    public static void helperUpdateSponsorTier(List<CampX__Sponsor__c> newCampXSponsorList){
        for(CampX__Sponsor__c newSponsor : newCampXSponsorList){
        // To ensure sponsors are recognized for their contributions, 
        // update the sponsor tier based on the contribution amount.
            if (newSponsor.CAMPX__ContributionAmount__c!= NULL) {
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