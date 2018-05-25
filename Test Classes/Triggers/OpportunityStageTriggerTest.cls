@IsTest
public class OpportunityStageTriggerTest {
    public static testmethod void testCloseDateWhenStageClosedWon() {
        Account newAccount = new Account(Name = 'Test account');
        insert newAccount;
        
        Contact newContact = new Contact(FirstName = 'Related con', LastName = 'con', Subject__c = 'English', accountId = newAccount.Id);
        Insert newContact;
        
        
        Date dateInstance = Date.newInstance(2018, 5, 12);
        Opportunity opportunityInstance = new Opportunity(Name = 'Test Trigger', CloseDate = dateInstance, 
                                                          Custom_Status__c = 'New', StageName = 'Prospecting', BillToContact__c = newContact.Id,
                                                         Manager__c = newAccount.Id);
        Insert opportunityInstance;
        
        try{
            opportunityInstance.StageName = 'Closed Won';
            Update opportunityInstance;
        }catch(Exception e){
            System.debug(e);
        } 
        
        Opportunity oppty = [SELECT CloseDate FROM Opportunity WHERE Id =: opportunityInstance.ID];
        Date expectedCloseDate = Date.today();
        Date actualCloseDate = oppty.CloseDate;
        
        System.assertEquals(expectedCloseDate, actualCloseDate);
    }
}