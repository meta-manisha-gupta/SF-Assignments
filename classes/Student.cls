public class Student {
	public static List<Student__c> getStudentsByClassId(String classId){
        List<Student__c> studentList = [SELECT Name FROM Student__c WHERE Class__r.Id =: classId];
        return studentList;
    }
    
    public static Map<Class__c, List<Student__c>> getMapOfClassNameAndStudent() {
        Map<Class__c, List<Student__c>> mapOfClassNameAndStudent = new Map<Class__c, List<Student__c>>();
        List<Class__c> listOfClasses = [SELECT Name, (SELECT Name FROM Students__r) FROM Class__c];
        for(Class__c classObject : listOfClasses) {
            List<Student__c> listOfStudentsInClass = classObject.Students__r;
            mapOfClassNameAndStudent.put(classObject, listOfStudentsInClass);
        }
        return mapOfClassNameAndStudent;
    }
    
}