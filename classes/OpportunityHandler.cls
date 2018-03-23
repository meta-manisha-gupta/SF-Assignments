public class OpportunityHandler {
    public static void updateManagerByRelatedAccount(List<Opportunity> listOfOpportunity) {
        List<Opportunity> listOfOpportunityToBeUpdated = new List<Opportunity>();
        for(Opportunity oppty : listOfOpportunity) {
            String billToContact = oppty.BillToContact__c;
            String opportunityManager = oppty.Manager__c;
            System.debug('bill -> '+billToContact + ' manager-> '+ opportunityManager);
            if(billToContact != null && opportunityManager == null ) {
                Contact contact = [SELECT AccountId from Contact WHERE Id = :oppty.BillToContact__c];
                Id accountId = contact.AccountId;
                System.debug(accountId);
                oppty.Manager__c = accountId;
                listOfOpportunityToBeUpdated.add(oppty);
            }else{
               System.debug('Opportunity Field BillToContact is null or Manager Field is not null');
           }
        }
        if(listOfOpportunityToBeUpdated.size() > 0) {
			update listOfOpportunityToBeUpdated;            
        }
        else{System.debug('empty');}
    }
}