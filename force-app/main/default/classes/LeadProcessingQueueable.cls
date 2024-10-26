public class LeadProcessingQueueable implements Queueable{
    
    private List<Lead> leadsToProcess;

    public LeadProcessingQueueable(List<Lead> leads){
       this.leadsToProcess = leads;
    }
    public void execute(QueueableContext QC){
        Set<String> phoneNameKeys = new Set<String>();
        Set<String> EmailNameKeys = new Set<String>();
        Set<String> phoneEmailKeys = new Set<String>();
        for(Lead leadObj:leadsToProcess){
            if(leadObj.Name !=null && leadObj.Phone !=null){
                phoneNameKeys.add(leadobj.Phone+'|'+leadObj.Name);
            }
            if(leadObj.Name !=null && leadObj.Email !=null){
                EmailNameKeys.add(leadobj.Email+'|'+leadObj.Name);
            }
            if(leadObj.Email !=null && leadObj.Phone !=null){
                phoneEmailKeys.add(leadobj.Phone+'|'+leadObj.Email);
            }
        }
        
    List<Leads> qualifiedLeads = new List<Lead>();
    //Quering existing Leads
    List<Lead> existingLeads = [SELECT Id, Name, Phone, Email FROM Lead];
    // Checking for matches if matches storing them in List
    For(Lead leadObj : existingLeads){
        if((leadObj.Name !=null && leadObj.Phone !=null && phoneNameKeys.contains(leadObj.Phone+'|'+leadObj.Name))||(leadObj.Name !=null && leadObj.Email !=null && phoneNameKeys.contains(leadObj.Email+'|'+leadObj.Name))||(leadObj.Email !=null && leadObj.Phone !=null && phoneNameKeys.contains(leadObj.Phone+'|'+leadObj.Email)) ){
            qualifiedLeads.add(leadObj);
        }
    }
}

    
}