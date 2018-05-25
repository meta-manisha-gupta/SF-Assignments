public class AddStudentController {
    public string studentName {get; set;}
    public id classId{get;set;}
    public Student__c student;
    public AddStudentController(){
        classId = apexpages.currentpage().getparameters().get('classId');
    }
    
    public void save(){
        student = new student__c();
        student.Class__c = classId;
        student.Name = studentName;
        student.LastName__c = studentName;
    }
    
}