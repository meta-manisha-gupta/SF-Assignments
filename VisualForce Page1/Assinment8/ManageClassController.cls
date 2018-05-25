public class ManageClassController {
    
    public Class__c classInstance;
    public List<Class__c> listOfClasses{get; set;}
    public String selectedClass{get; set;}
    public String className{get; set;}
    public Integer classSize{get; set;} 
    public String classId;
    public boolean outputPanelEdit {
        get{
            if(outputPanelEdit == null){
                outputPanelEdit = true;
            }
            return outputPanelEdit;
        }
        set;
    }
    
    public List<Class__c> getClasses(){
        string getQuery = 'SELECT Id,Name,MaxSize__c FROM Class__c';
        listOfClasses = Database.query(getQuery);
        return listOfClasses;
    }
    
    public PageReference edit(){
        classId = ApexPages.currentPage().getParameters().get('classId');
        outputPanelEdit = !outputPanelEdit;
        return null;
    }
    
    public Pagereference editClass() {
        Class__c classToBeUpdated = [SELECT Id, Name, MyCount__c, Fee__c, MaxSize__c FROM Class__c WHERE id =:classId];
        classToBeUpdated.Name = className;
        classToBeUpdated.MaxSize__c = classSize;
        update classToBeUpdated;
        outputPanelEdit = !outputPanelEdit;
        return null;
    }
    public Pagereference deleteClass() {
        classId= ApexPages.currentPage().getParameters().get('classId'); 
        Class__c classToBeDeleted = [SELECT Id, Name, MyCount__c, Fee__c, MaxSize__c FROM Class__c WHERE id =: classId];
        delete classToBeDeleted;
        return null;
 	}
}