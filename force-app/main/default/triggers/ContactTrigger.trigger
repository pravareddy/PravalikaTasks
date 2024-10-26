trigger ContactTrigger on Contact(before insert, after insert, before update, after update, before delete, after delete, after undelete) {

    if((Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) || (Trigger.isAfter && Trigger.isUndelete))
    {
        ContactTriggerHandler.validateContactLimit(trigger.new, trigger.oldMap);
    }
    if(Trigger.isBefore && Trigger.isInsert){
        ContactTriggerHandler.handleBeforeInsert(trigger.new);
    }
}