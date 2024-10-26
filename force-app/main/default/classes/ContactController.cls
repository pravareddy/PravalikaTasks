public with sharing class ContactController {
    @AuraEnabled
    public static List<Contact> getContacts(Id accId)
    {
        return [SELECT Id, Name, Email, Phone, accountId FROM Contact WHERE accountId =:accId];
    }
}