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
        //Removed the following validation for situations when a sponsor is dissociated from an event
        //CAMPXSponsorTriggerHandler.helperSponsorAssociation(newCampXSponsorList);

        CAMPXSponsorTriggerHandler.helperUpdateSponsorTier(newCampXSponsorList);
    }

    
    /*public static void handleAfterUpdate(List<SObject> newSobjs, Map<Id,SObject> oldSobjsMap){
        // Instantiate variables
        List<CAMPX__Sponsor__c> newCampXSponsorList = (List<CAMPX__Sponsor__c>) newSobjs;
        Map<Id, CAMPX__Sponsor__c> oldCampXSponsorMap = (Map<Id, CAMPX__Sponsor__c>)oldSobjsMap;
        Set<CAMPX__Event__c> eventSet = new Set<CAMPX__Event__c>();
        Decimal totalContributedAmount;
        
        // Loop through each updated campX Sponsor record
        for (CAMPX__Sponsor__c newSponsor : newCampXSponsorList) {

            // Use the map method "get" to retrieve the old event record from the map.
            CAMPX__Sponsor__c oldSponsor = oldCampXSponsorMap.get(newSponsor.Id);

        
            }
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