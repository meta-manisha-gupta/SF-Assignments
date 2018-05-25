@IsTest
public class OpportunityHandlerTriggerTest {
    public static testmethod void testupdateManagerByRelatedAccount() {
        Account newAccount = new Account();
        newAccount.Name = 'Test account ';
        insert newAccount;
        
        Contact newContact = new Contact(FirstName = 'Related con', LastName = 'con', Subject__c = 'English',accountId = newAccount.Id);
        Insert newContact;
        
        Opportunity newOpportunity = new Opportunity();
        newOpportunity.Name = 'Test Trigger';
        newOpportunity.CloseDate = date.today();
        newOpportunity.StageName = 'Prospecting';
        newOpportunity.BillToContact__c = newContact.Id;
        insert newOpportunity;
        
        Test.startTest();
        	newOpportunity.Name = 'Test Trigger 1';
        try{
            update newOpportunity;
        }catch(DMLException ex){
            System.debug(ex);
        }
        	
        Test.stopTest();
        Opportunity oppty = [SELECT Manager__c FROM Opportunity WHERE Id =: newOpportunity.ID];
        Id expectedManager = newContact.AccountId;
        Id acctualManagerId = oppty.Manager__c;
        System.assertEquals(expectedManager, acctualManagerId);
    }
}