trigger MyCountOfClassTrigger on Class__c (before insert, before update) {
    for(Class__c classInLoop : Trigger.new) {
        classInLoop.MyCount__c = classInLoop.NumberOfStudents__c;
    }
}