public with sharing class EventTriggerHandler {
    public static void handleBeforeInsert(List<CampX__Event__c> newCampXEventList){
        // Loop through each new campX event and update status to "Planning"
        for(CampX__Event__c newCampXEvent : newCampXEventList){
            newCampXEvent.CAMPX__Status__c = 'Planning';
        }
    }
    public static void handleBeforeUpdate(
        List<CampX__Event__c> campXEventForUpdate, 
        Map<Id, CampX__Event__c> oldCampXEventMap){
            // When the CAMPX__Status__c field is edited, the CAMPX__StatusChangeDate__c field
            // should capture the current date and time

            // Instantiate a list of CampX__Event__c objects to hold the updated records
            // This is because we need to update the CAMPX__StatusChangeDate__c field
            List<CampX__Event__c> updatedCampXEventList = new List<CampX__Event__c>();


            // Loop through each updated CampX event and check if their status has changed
            for(CampX__Event__c origEvent : campXEventForUpdate){
            
                // compare the update Event record to the old version to see what has changed
                // We can use the oldCampXEventMap, pass it the CampX__Event__c.Id, 
                // to get the old version for comparison
                CampX__Event__c oldCampXEvent = oldCampXEventMap.get(origEvent.Id);
                
                // make the comparison of the CAMPX__Status__c field
                if(oldCampXEvent.CAMPX__Status__c!= origEvent.CAMPX__Status__c){
                CampX__Event__c origEventUpdate = new CampX__Event__c(Id=origEvent.Id, CAMPX__StatusChangeDate__c = system.today());
                
                    // add the updated record to the list
                    updatedCampXEventList.add(origEventUpdate);
                    
                }
            }
            update updatedCampXEventList;
    }
}