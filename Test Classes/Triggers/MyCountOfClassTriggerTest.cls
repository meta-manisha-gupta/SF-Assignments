@IsTest
public class MyCountOfClassTriggerTest {
    public static testmethod void testMyCountOfClass() {
        Class__c myClass = new Class__c(Name = 'Test Class', Name__c = 'Test Class');
        insert myClass;
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer i = 1; i < 14; i++) {
            Student__c student = new Student__c(Name = 'test '+i, LastName__c = 'Test '+ i, Class__c = myClass.Id);
            listOfStudents.add(student);
        }
        Insert listOfStudents;
        Class__c MyClassInstance = [SELECT NumberOfStudents__c, MyCount__c FROM Class__C WHERE id =: myClass.Id];
        Decimal actualMyCount = MyClassInstance.MyCount__c;
        Decimal expectedMyCount = 13;
        System.assertEquals(expectedMyCount, actualMyCount);
    }
}