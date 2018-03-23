trigger OpportunityStageTrigger on Opportunity (before update) {
    if(Trigger.isUpdate) {
        for(Opportunity oppty :Trigger.new) {
            if(oppty.StageName!=trigger.oldMap.get(oppty.id).stageName) {
                if(oppty.StageName == 'Closed Won' || oppty.StageName == 'Closed Lost') {
                    oppty.CloseDate = Date.today();
                }
            }
    	}
 	}
}