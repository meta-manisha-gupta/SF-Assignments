@IsTest
public class FemaleStudentsInClassTriggerTest {
    public static testmethod void testDeletionOfClassWithFemaleStudents() {
        Class__c myClass = new Class__c(Name = 'MyClass', Name__c = 'MyClass', MaxSize__c = 15);
        insert myClass;
        
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer i = 1; i < 14; i++) {
            Student__c student = new Student__c(Name = 'test '+i, LastName__c = 'Test '+ i, Sex__c = 'Female', Class__c = myClass.Id);
            listOfStudents.add(student);
        }
        Insert listOfStudents;
        
        try{
            delete myClass;
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('Cant delete class as number of female student is more then 1') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        } 
    }
    public static testmethod void testDeletionOfClassWithMaleStudents() {
        Class__c myClass = new Class__c(Name = 'MyClass', Name__c = 'MyClass', MaxSize__c = 15);
        insert myClass;
        
        List<Student__c> listOfStudents = new List<Student__c>();        
        Student__c maleStudent = new Student__c(Name = 'test male', LastName__c = 'Test ', Sex__c = 'Male', Class__c = myClass.Id);
        Student__c femaleStudent = new Student__c(Name = 'test female', LastName__c = 'Test ', Sex__c = 'Female', Class__c = myClass.Id);
        listOfStudents.add(maleStudent);
        listOfStudents.add(femaleStudent);
    
        Insert listOfStudents;
        
        try{
            delete myClass;
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('Cant delete class as number of female student is more then 1') ? true : false;
            System.AssertEquals(expectedExceptionThrown, false);
        } 
    }
}