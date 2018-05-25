trigger OpportunityStatusMailTrigger on Opportunity (after update) {
    if(Trigger.isUpdate) {
        Set<Id> setOfOpportunityIds = new Set<Id>();
        for(Opportunity OpportunityInLoop :Trigger.new) {
            if(OpportunityInLoop.Custom_Status__c != trigger.oldMap.get(OpportunityInLoop.id).Custom_Status__c) {
                setOfOpportunityIds.add(OpportunityInLoop.id);
            }
        }
        Opportunity OpportunityInstance = [SELECT Id, Name, OwnerId, Owner.Email FROM Opportunity Where id in :setOfOpportunityIds];
        OrgWideEmailAddress owa = [select id, DisplayName, Address from OrgWideEmailAddress limit 1];
        EmailTemplate template = [Select id, Name from EmailTemplate where name = 'Opportunity Status Email' and isActive = true Limit 1];
        User user = [select email, firstName, lastName from User where id = :OpportunityInstance.OwnerId];
        Contact tempContact = new Contact(subject__c='English',email = user.email+'45121', firstName = user.firstName, lastName = user.lastName);
  		insert tempContact;
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        email.setReplyTo(owa.Address);
        email.setWhatId(OpportunityInstance.Id);
        email.setSaveAsActivity(false);
        email.setTemplateId(template.Id); 
        email.setOrgWideEmailAddressId(owa.id);
        email.setTargetObjectId(tempContact.Id);
        email.setToAddresses(new String[]{OpportunityInstance.Owner.Email}); 
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});
        delete tempContact;
        
    }
}