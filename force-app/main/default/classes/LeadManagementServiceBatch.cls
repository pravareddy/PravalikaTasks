public class LeadManagementServiceBatch implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
     return Database.getQueryLocator([SELECT name, Email, Phone from lead ]);
    }
    public void execute(Database.BatchableContext BC, List<Lead> leadList){
      String jobId = BC.getJobId();
      System.debug('leadList>>>>>>>>>>>>'+leadList);
      System.debug('jobId>>>>>>>>>>>>'+jobId);

      if(!leadList.isEmpty()){
      LeadProcessingQueueable leadProcessingObj = new LeadProcessingQueueable(leadList);
      System.enqueueJob(leadProcessingObj);
      }

    }
    public void Finish(Database.BatchableContext BC)
    {

    }
}