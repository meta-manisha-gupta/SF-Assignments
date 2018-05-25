@IsTest
public class OpportunityStatusTriggerTest {
    public static testmethod void testOpportunityLineItemOnStatusUpdateToReset() {
        Account newAccount = new Account(Name = 'Test account');
        insert newAccount;
        
        Contact newContact = new Contact(FirstName = 'Related con', LastName = 'con', Subject__c = 'English',accountId = newAccount.Id);
        Insert newContact;
        
        
        Date dateInstance = Date.newInstance(2018, 5, 12);
        Opportunity opportunityInstance = new Opportunity(Name = 'Test Trigger', CloseDate = dateInstance, 
                                                          Custom_Status__c = 'New', StageName = 'Prospecting', BillToContact__c = newContact.Id);
        Insert opportunityInstance;
        
        OpportunityLineItem product = new OpportunityLineItem();
        try{
            opportunityInstance.Custom_Status__c = 'Reset';
            Update opportunityInstance;
        }catch(Exception e){
            
        } 
    }
}