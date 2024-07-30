public with sharing class CAMPXEventTriggerHandler {
    public static void handleBeforeInsert(List<CampX__Event__c> newCampXEventList){
        // Loop through each new campX event and update status to "Planning" 
        // and status change date to current date for timeline tracking and accountability.
        for(CampX__Event__c newCampXEvent : newCampXEventList){
            newCampXEvent.CAMPX__Status__c = 'Planning';
            newCampXEvent.CAMPX__StatusChangeDate__c = DateTime.now();
        }
    }
    
    public static void handleBeforeUpdate(List<SObject> newSobjs, Map<Id,SObject> oldSobjsMap){

        List<CAMPX__Event__c> newCampXEventList = (List<CAMPX__Event__c>) newSobjs;
        Map<Id, CAMPX__Event__c> oldCampXEventMap = (Map<Id, CAMPX__Event__c>)oldSobjsMap;
        
        // Loop through each updated campX Event record
        for (CAMPX__Event__c newEvent : newCampXEventList) {

            // Use the map method "get" to retrieve the old event record from the map.
            CAMPX__Event__c oldEvent = oldCampXEventMap.get(newEvent.Id);

            // If the status has changed, update the status change date by using the DateTime class method now()
            if (newEvent.CAMPX__Status__c != oldEvent.CAMPX__Status__c) {
                newEvent.CAMPX__StatusChangeDate__c = DateTime.now();
            }
        }
    }

}