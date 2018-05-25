@IsTest
public class StudentTest {
    public static Id createTestRecord() {
        Class__c newClass = new Class__c();
        newClass.Name = 'TestClass';
        newClass.Name__c = 'TestClass';
        insert newClass;
        List<Student__c> expectedListOfStudents = new List<Student__C>();
        for(Integer i = 0; i < 10; i++) {
            expectedListOfStudents.add(new Student__c(Name = 'Test' + i, LastName__c = 'LN', CLass__c = newClass.Id));
        }
        insert expectedListOfStudents;
        return newClass.Id;
    }
    
    @IsTest static void testGetStudentsByClassIdShouldReturn() {
        Id classId = createTestRecord();
        Integer expectedSizeOfListOfStudents = 10;
        Test.startTest();
        List<Student__c> actualListOfStudents = Student.getStudentsByClassId(classId);
        Integer actualSizeOfListOfStudents = actualListOfStudents.size();
        System.assertEquals(expectedSizeOfListOfStudents, actualSizeOfListOfStudents);
        Test.stopTest();
    }
    
    @IsTest static void testGetMapOfClassNameAndStudentShouldReturn() {
        Id classId = createTestRecord();
        Map<Class__c, List<Student__c>> actualMapOfClassAndStudent = Student.getMapOfClassNameAndstudent();
        for(Class__c key: actualMapOfClassAndStudent.keySet()){
    		System.debug('class'+key+' students '+actualMapOfClassAndStudent.get(key));
            System.assertEquals(classId,key.Id);
            System.assertEquals(10, actualMapOfClassAndStudent.get(key).size());
		}
    }
}