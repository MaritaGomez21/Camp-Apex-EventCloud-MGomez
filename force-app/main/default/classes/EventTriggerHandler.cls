public with sharing class EventTriggerHandler {
    public static void handleBeforeInsert(List<CampX__Event__c> newCampXEventList){
        // Loop through each new campX event and update status to "Planning"
        for(CampX__Event__c newCampXEvent : newCampXEventList){
            newCampXEvent.CAMPX__Status__c = 'Planning';
        }
    }
}