trigger LoanStatusChangeEmail on MyLoan__c (after update) {
	if(Trigger.isUpdate) {
        Set<Id> setOfLoanIds = new Set<Id>();
        for(MyLoan__c loanInLoop :Trigger.new) {
            if(loanInLoop.Status__c != trigger.oldMap.get(loanInLoop.id).Status__c) {
                setOfLoanIds.add(loanInLoop.id);
            }
        }
        List<MyLoan__c> listOfLoans = [Select Id, Name, Applicant_Email__c, Status__c, Amount__c from MyLoan__c where id in :
                                       setOfLoanIds];
        for(MyLoan__c loan : listOfLoans) {
            EmailManager.sendMail(loan.Applicant_Email__c, 'Loan Status change', 'Dear '+loan.Name+',\n Your loan is '
                                  +loan.Status__c+' for the amount '+loan.Amount__c+'.');
        }
	}
    
}