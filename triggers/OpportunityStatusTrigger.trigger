trigger OpportunityStatusTrigger on Opportunity (after update) {
	if(Trigger.isUpdate) {
        Set<Id> setOfOpportunityIds = new Set<Id>();
        for(Opportunity oppty :Trigger.new) {
             if(oppty.Custom_Status__c != trigger.oldMap.get(oppty.id).Custom_Status__c) {
                if(oppty.Custom_Status__c == 'Reset' && oppty.Custom_Status__c != null) {
                	setOfOpportunityIds.add(oppty.id);
                }
            }
    	}
        List<OpportunityLineItem> listOfProducts = [SELECT Id FROM OpportunityLineItem WHERE OpportunityId IN :setOfOpportunityIds];
        if(listOfProducts.size() > 0 && listOfProducts != null) {
            delete listOfProducts;
        }
 	}
    
}