public with sharing class ContactController {
    @AuraEnabled
    public static List<Contact> getContacts(Id accId)
    {
        
         List<Contact> conList= [SELECT Id, Name, Email, Phone, accountId FROM Contact WHERE accountId =:accId];

            return conList;
    }
}