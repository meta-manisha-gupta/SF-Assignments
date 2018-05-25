trigger updateChildCountTrigger on Account (After Insert, After delete, After update) {
    Set<Id> setOfParentAccountIds = new Set<Id>();
    Set<Id> setOfAccountIds = new Set<Id>();
    if (Trigger.isDelete) {
        for(Account account :Trigger.old) {
            setOfAccountIds.add(account.Id);
            setOfParentAccountIds.add(account.Parent_Account_of_account__c);
        }
    }
    else{
        for(Account account :Trigger.new) {
            setOfAccountIds.add(account.Id);
            setOfParentAccountIds.add(account.Parent_Account_of_account__c);
        }
    }
    List<account> listOfChildAccounts = [SELECT Id, Name, Child_Count__c FROM Account WHERE Parent_Account_of_account__r.Id in :setOfParentAccountIds];
    List<Account> parentAccount = [SELECT id, Name, Child_Count__c FROM Account WHERE id in :setOfParentAccountIds];
    
    List<Account> listOfParentAccountToBeUpdated = new List<Account>();
    for(Account accountInstance : parentAccount){
        accountInstance.Child_Count__c = listOfChildAccounts.size();
        listOfParentAccountToBeUpdated.add(accountInstance);
    }
    update listOfParentAccountToBeUpdated;
}