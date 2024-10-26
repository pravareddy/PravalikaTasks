public with sharing class ContactTriggerHandler {

    public static void validateContactLimit(List<Contact> newConList, Map<Id, Contact> oldContactsMap) {
        System.debug('newConList>>>>>>>>>>>>'+newConList);
        System.debug('oldContactsMap>>>>>>>>>>>>'+oldContactsMap);
        Map<Id, Integer> countOfContactsInMap = new Map<Id, Integer>();
        Set<Id> AccountIdSet = new Set<Id>();

        if(trigger.isInsert){
          for(Contact conObj:newConList){
            System.debug('isInsert>>>>>>>>>>>>');
            if(conObj.AccountId !=null){
                AccountIdSet.add(conObj.AccountId);
            }
          }
        }
        if(trigger.isUpdate){
            for(Contact conObj : newConList){
                System.debug('isUpdate>>>>>>>>>>>>isUndelete');
                if(conObj.AccountId !=null && conObj.AccountId != oldContactsMap.get(conObj.Id).AccountId){
                    AccountIdSet.add(conObj.AccountId);
                    AccountIdSet.add(oldContactsMap.get(conObj.Id).AccountId);  
                }
            }
        }
        if(trigger.isUndelete){
          for(Contact oldConObj : newConList){
            System.debug('isUndelete>>>>>>>>>>>>isUndelete');
            if(oldConObj.AccountId !=null){
                AccountIdSet.add(oldConObj.AccountId);
            }
        }

        }
        System.debug('AccountIdSet>>>>>>>>>>>>'+AccountIdSet);

        for(AggregateResult result: [SELECT Count(Id) contactCount, accountId FROM Contact WHERE accountId IN : AccountIdSet GROUP BY AccountId]){
          System.debug('result>>>>>>>>>>>>'+result);
          countOfContactsInMap.Put((Id)result.get('accountId'), (Integer)result.get('contactCount'));
        }
        System.debug('countOfContactsInMap>>>>>>>>>>>>'+countOfContactsInMap);
        for(Contact conObj : newConList){
          if(conObj.AccountId !=null && countOfContactsInMap.get(conObj.AccountId)>=2){
            conObj.addError('you cant add contacts to this account its already have 2 contacts');
          }
        }
    
    }
    
    // Static variable to prevent recursive trigger execution
    public static Boolean isTriggerExecuted = false;
    //recusrion
    public static void handleBeforeInsert(List<Contact> newContacts){
      if (isTriggerExecuted) {
        System.debug('return');
        return; // Exit if already executed
    }
    
    // Set the static variable to true to prevent recursion
    isTriggerExecuted = true;

    // Implement your business logic here
    for (Contact con : newContacts) {
        if (con.Email != null) {
            con.Email = 'reddyprava@gmail.com'; // Example logic
            System.debug('con>>>>>>>>>>>>'+con);
        }
    }
}
}