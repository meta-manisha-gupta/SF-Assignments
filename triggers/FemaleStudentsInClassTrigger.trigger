trigger FemaleStudentsInClassTrigger on Class__c (before delete) {
   List<Student__c> students = [SELECT Id, Class__r.Id, sex__c FROM Student__c WHERE Sex__c = 'Female'];
       for(Class__c clss : Trigger.old){
           Integer countOfFemaleStudents = 0;
           for(Student__c student : students){
               if(clss.Id == student.Class__c ){
                   clss.addError('Can\'t Delete This Class Because it\'s having female student/s.');
                   countOfFemaleStudents++;
               }
           }
           if(countOfFemaleStudents > 1) {
                clss.addError('Cant delete class as number of female student is more then 1');
            }
   }
  

}