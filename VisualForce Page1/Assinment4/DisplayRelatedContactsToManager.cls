public class DisplayRelatedContactsToManager {
   	public Opportunity opportunityFromURL{get;set;}
   	public list<Contact> listOfContacts{get;set;}
    public String opportunityId = ApexPages.currentPage().getparameters().get('id');
    public String accountId{get;set;}
    public String selectedContact{get; set;}
    
    public DisplayRelatedContactsToManager(){
        
        opportunityFromURL = [select id, Manager__r.id from opportunity where id =: opportunityId];
        accountId = opportunityFromURL.Manager__r.id;
       
    }
   public List<SelectOption> getContacts() {
        List<SelectOption> listOfContactsToShow = new List<SelectOption>();
        if(accountId != null) {
       		listOfContacts = [SELECT id,Name FROM Contact WHERE AccountId =: accountId];
            for(Contact contactObject : listOfContacts) {
                listOfContactsToShow.add(new SelectOption(contactObject.Name, contactObject.Name));
            }
        }
       	return listOfContactsToShow;
    }
    public PageReference save() {
        for(Contact contactObject : listOfContacts) {
            if(selectedContact == contactObject.Name) {
                opportunityFromURL.BillToContact__c = contactObject.id;
                System.debug('oppppObj'+opportunityFromURL);
                update opportunityFromURL;    
            }
        }
        return redirect();
    }
    public PageReference clear() {
        for(Contact contactObject : listOfContacts) {
            if(selectedContact == contactObject.Name) {
                opportunityFromURL.BillToContact__c = null;
                System.debug('oppppObj'+opportunityFromURL);
                update opportunityFromURL;    
            }
        }
        return redirect();
    }
    public PageReference cancel() {
        return redirect();
    }
    public PageReference redirect() {
        PageReference pageRef = new PageReference('https://ap5.lightning.force.com/one/one.app#/sObject/'+opportunityId);
        pageRef.setRedirect(true);
        return pageRef;
    }
}