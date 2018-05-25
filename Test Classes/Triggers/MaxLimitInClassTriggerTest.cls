@IsTest
public class MaxLimitInClassTriggerTest {
    public static testmethod void testMaxLimitInClassTriggerOnInsert() {
        Class__c myClass = new Class__c(Name = 'MyClass', Name__c = 'MyClass', MaxSize__c = 15);
        insert myClass;
        
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer i = 1; i <= 10; i++) {
            Student__c student = new Student__c(Name = 'test '+i, LastName__c = 'Test '+ i, Class__c = myClass.Id);
            listOfStudents.add(student);
        }
        Insert listOfStudents;
        
        Class__c c = [SELECT NumberOfStudents__c FROM Class__C WHERE id =: myClass.Id];
        system.debug(c);
        Student__c newStudent = new Student__c(Name = 'test', LastName__c = 'Test');
        try{
            newStudent.Class__c = myClass.Id;
            Insert newStudent;
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('Cannot insert Record - Class is full') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        } 
    }
}