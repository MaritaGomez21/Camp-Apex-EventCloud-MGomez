public with sharing class EventTriggerHandler {
    public static void handleBeforeInsert(List<CampX__Event__c> newCampXEventList){
        // Loop through each new campX event and update status to "Planning"
        for(CampX__Event__c newCampXEvent : newCampXEventList){
            newCampXEvent.CAMPX__Status__c = 'Planning';
            newCampXEvent.CAMPX__StatusChangeDate__c = DateTime.now();
        }
    }
    
    public static void handleBeforeUpdate(List<SObject> newSobjs, Map<Id,SObject> oldSobjsMap){

        List<CAMPX__Event__c> newCampXEventList = (List<CAMPX__Event__c>) newSobjs;
        Map<Id, CAMPX__Event__c> oldCampXEventMap = (Map<Id, CAMPX__Event__c>)oldSobjsMap;
        

        for (CAMPX__Event__c newEvent : newCampXEventList) {
            CAMPX__Event__c oldEvent = oldCampXEventMap.get(newEvent.Id);
            if (newEvent.CAMPX__Status__c != oldEvent.CAMPX__Status__c) {
                newEvent.CAMPX__StatusChangeDate__c = DateTime.now();
            }
        }
    }

}