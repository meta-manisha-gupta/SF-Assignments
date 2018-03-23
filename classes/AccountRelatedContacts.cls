public class AccountRelatedContacts {
    public static void storeContactIdInAccount(String contactId) {
        Contact contact = [SELECT AccountId FROM Contact WHERE Id = :contactId];
        Account account = [SELECT Id, ContactIDs__c, (SELECT ID FROM Contacts) FROM Account WHERE Id =: contact.AccountId];
       
        List<String> listOfContactOnAccount;
        if(account.ContactIDs__c == null){
            listOfContactOnAccount = new List<String>();
            List<Contact> listOfContacts = account.Contacts;
            for( Contact con : listOfContacts) {
                if(!listOfContactOnAccount.contains(con.Id)) {
                    listOfContactOnAccount.add(con.Id);
                }
            }
        }
        else{
            listOfContactOnAccount  = account.ContactIDs__c.split(',');
            if(!(listOfContactOnAccount.contains(contactId))) {
                listOfContactOnAccount.add(contactId);
                System.debug(listOfContactOnAccount);
            }
        }
        //Loop to convert list to comma separated string
        String commaSepratedList='';
        for(String str : listOfContactOnAccount) {
            commaSepratedList += str + ',' ;
        }
        commaSepratedList = commaSepratedList.substring(0, commaSepratedList.length() - 1); 
        account.ContactIDs__c = commaSepratedList;
        System.debug('account id ->> '+account.Id+' contact ids->> '+ account.ContactIDs__c);
        update account;
	}
}