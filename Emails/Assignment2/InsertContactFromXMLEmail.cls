global class InsertContactFromXMLEmail implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        
        if(email.textAttachments != null) {
            for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
                Attachment attachment = new Attachment();
                attachment.Name = tAttachment.fileName;
                parse(tAttachment.body);
            }
        }
        if(email.binaryAttachments != null) {
            for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
                Attachment attachment = new Attachment();
                
                attachment.Name = bAttachment.fileName;
                attachment.Body = bAttachment.body;
                parse(attachment.Body.toString());
            }
        }
        return result;
    }
    private void parse(String toParse) {
        DOM.Document doc = new DOM.Document();      
        try {
            doc.load(toParse);  
            DOM.XMLNode root = doc.getRootElement();
            DOM.XMLNode[] contactsArray = root.getChildElements();
            List<Contact> listOfContactsToBeInserted = new List<Contact>();
            for(DOM.XMLNode con : contactsArray){
                String fname = con.getChildElement('fname', null).getText();
                String lname = con.getChildElement('lname',null).getText();
                String subject = con.getChildElement('subject',null).getText();
                Contact newContact = new Contact(FirstName = fname, LastName = lname, Subject__c = subject );
                listOfContactsToBeInserted.add(newContact);
            }
            System.debug('listOfContactsToBeInserted'+listOfContactsToBeInserted);
            insert listOfContactsToBeInserted;            
        } catch (System.XMLException e) {  // invalid XML
            System.debug(e.getMessage());
        }
    }
    
    
}