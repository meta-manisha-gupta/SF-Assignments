trigger MaxLimitInClassTrigger on Student__c (before insert) {
    Set<Id> setOfClassIDs = new Set<Id>();
 
    for(Student__c student : Trigger.new){
      	setOfClassIDs.add(student.class__c);
        //System.debug(student.Id);
         System.debug(student.class__c);
    }
    List<Class__c> listOfClass = [SELECT NumberOfStudents__c,MaxSize__c from class__c where Id IN :setOfClassIDs];
    Map<Id,class__c> mapOfClassIdAndClass = new Map<Id,class__c>();
    for(class__c clss : listOfClass){
        if(!mapOfClassIdAndClass.containsKey(clss.Id)) {
            mapOfClassIdAndClass.put(clss.Id,clss); 
        }
   }
   for(student__c studentInclass : trigger.new){
        if(mapOfClassIdAndClass.get(studentInclass.Class__c).NumberOfStudents__c >= mapOfClassIdAndClass.get(studentInclass.Class__c).MaxSize__c) {
             studentInclass.addError('Cannot insert Record - Class is full');
        }
   }
}