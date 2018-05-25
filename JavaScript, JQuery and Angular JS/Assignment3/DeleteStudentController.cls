public class DeleteStudentController {
    public List<string> listOfStudentIds;
    public List<Student__c> listOfStudentToBeDeleted{get; set;}
    string allIds;

    public DeleteStudentController(){
        allIds = apexpages.currentpage().getparameters().get('rec');
        listOfStudentIds = allIds.split(',');
        listOfStudentToBeDeleted = [SELECT Id, Name,Email__c,Class__r.Name FROM Student__c WHERE Id IN :listOfStudentIds ];
    }
    
    public PageReference deleteStudents(){
        delete listOfStudentToBeDeleted;
        listOfStudentToBeDeleted.clear();
        return redirect();
    }
    
    public PageReference cancel(){
        return redirect();
    }
    public PageReference redirect() {
        PageReference pageRef= new PageReference('https://ap5.salesforce.com/a0D/o');
        pageRef.setRedirect(true);
        return pageRef;
    }
    

}