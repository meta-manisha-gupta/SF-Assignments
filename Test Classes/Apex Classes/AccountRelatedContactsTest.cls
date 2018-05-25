@IsTest
private class AccountRelatedContactsTest {
    @IsTest
    static void teststoreContactIdInAccountWhenContactIDFieldIsNull() {
        Account newAccount = new Account();
        newAccount.Name = 'Test account ';
        newAccount.ContactIds__c = null;
        try{
            Insert newAccount;
        }catch(DMLException ex){
            System.debug(ex);
        }
        
        
        Contact contact = new Contact();
        contact.FirstName = 'Related con';
        contact.LastName = 'con';
        contact.accountId = newAccount.Id;
        contact.Subject__c = 'English';
        Insert contact;
        
        Test.startTest();
        	AccountRelatedContacts.storeContactIdInAccount(contact.Id);
        Test.stopTest();
        
        Account resultantOutput = [SELECT ContactIds__c 
                                   FROM Account WHERE ID =: newAccount.Id LIMIT 1];
       	String expectedContactId = contact.Id;
        String actualContactId = resultantOutput.ContactIDs__c;
        System.assertEquals(expectedContactId, actualContactId);
        
    }
    
    @IsTest
    static void teststoreContactIdInAccountWhenContactIDFieldIsNotNull() {
        Account newAccount = new Account();
        newAccount.Name = 'Test account ';
        newAccount.ContactIds__c = null;
        try{
            Insert newAccount;
        }catch(DMLException ex){
            System.debug(ex);
        }
        Contact contact = new Contact();
        contact.FirstName = 'Related con';
        contact.LastName = 'con';
        contact.accountId = newAccount.Id;
        contact.Subject__c = 'English';
        Insert contact;
        newAccount.ContactIds__c = contact.Id;
        update newAccount;
        Contact newcontact = new Contact();
        newcontact.FirstName = 'Related con';
        newcontact.LastName = 'con';
        newcontact.accountId = newAccount.Id;
        newcontact.Subject__c = 'English';
        
        Insert newcontact;
        Test.startTest();
        	AccountRelatedContacts.storeContactIdInAccount(newcontact.Id);
        Test.stopTest();
        
        Account resultantOutput = [SELECT ContactIds__c 
                                   FROM Account WHERE ID =: newAccount.Id LIMIT 1];
       	String expectedContactId = contact.Id+','+newcontact.Id;
        String actualContactId = resultantOutput.ContactIDs__c;
        System.assertEquals(expectedContactId, actualContactId);
        
    }
}