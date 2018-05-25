public class PDFController {
    public ID parentId {get;set;}
  	public String pdfName {get;set;}
    Date myDate = system.today();
    public Student__c student;
    public String studentId {get; set;}
    public Boolean initialised{get; set;}
    public List<Student__c> listOfStudents{get; set;}

    public PDFController(ApexPages.StandardController stdController) {
        this.student = (Student__c)stdController.getRecord();
        studentId = ApexPages.currentPAge().getParameters().get('id');
        getListOfStudents(studentId);
        initialised=false;
    }
    
    
    public void getListOfStudents(Id studentId) {
		listOfStudents = [SELECT Id, Name, Age__c, Email__c FROM Student__c WHERE Id =: studentId];       
    }
    public void attachmentExist() {
        List<Student__c> listOfStudentAndAttachments = [SELECT Id, Name, (SELECT Id, Name FROM Attachments) FROM Student__c where Id =: studentId];
        List<Attachment> attachments;
        for(Student__c student : listOfStudentAndAttachments) {
            attachments = student.Attachments;
        }
        if(attachments.size() > 0) {
            delete attachments;
            saveAttachement();
        }
        saveAttachement();
    }
    
    public void saveAttachement() {   
       
        if (!initialised && studentId !=NULL) {
            PageReference pdf = Page.PDFGeneratorVF;
            Attachment attach = new Attachment();
            
            Blob body;
            
            try {
                body = pdf.getContent();
                    
            } catch (VisualforceException e) {
                body = Blob.valueOf('Some Text');
            }
            
            attach.Body = body;
            attach.Name = 'pdf' + myDate + '.pdf';
            
            attach.IsPrivate = false;
            attach.ParentId = studentId;
            
            insert attach;
            system.debug(attach);
            initialised=true;
      } else system.debug('tried to run twice');
    } 
}