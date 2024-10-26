public with sharing class LeadController {
   public static Map<Boolean, List<Lead>> leadDuplicateCheck(List<Lead> newLeads)
   {
     // Create a map to hold the leads by unique identifier
     Map<String, Lead> uniqueLeadsMap = new Map<String, Lead>();
     // List to store duplicate leads
     List<Lead> duplicateLeads = new List<Lead>();

     // Iterate through the new leads collection
     for (Lead lead : newLeads) {
        // Construct a unique key based on Email, Territory__r.Region__c, and Company
        String uniqueKey = lead.Email + '|' + 
                           lead.Phone + '|' + 
                           lead.Company;
        System.debug('uniqueKey>>>>>>>>>>>>>>>>>>>'+uniqueKey);
    // Check if the unique key already exists in the map
    if (uniqueLeadsMap.containsKey(uniqueKey)) {
        // If it exists, add to duplicate leads
        duplicateLeads.add(lead);
    } else {
        // If it does not exist, add it to the map
        uniqueLeadsMap.put(uniqueKey, lead);
    }
}
System.debug('uniqueLeadsMap>>>>>>>>>>>>>>>>>>>>>.'+uniqueLeadsMap);
System.debug('duplicateLeads>>>>>>>>>>>>>>>>>>>>>'+duplicateLeads);

// Prepare the return map
Map<Boolean, List<Lead>> resultMap = new Map<Boolean, List<Lead>>();
resultMap.put(true, uniqueLeadsMap.values());
resultMap.put(false, duplicateLeads);
System.debug('resultMap>>>>>>>>>>>>>>>>>>>>>'+resultMap);

return resultMap;
}
}