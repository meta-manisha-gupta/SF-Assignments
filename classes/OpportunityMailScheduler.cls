global class OpportunityMailScheduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Opportunity> listOfOpportunity = [Select Id,ownerID from Opportunity where LastModifiedDate = LAST_N_DAYS:30];
        for(Opportunity o : listOfOpportunity) {
            EmailManager.sendMail('manisha.gupta1@metacube.com', 'Reminder to modify', 'Opportunity has not been modified for last 30 days');
        }
    }
}