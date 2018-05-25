@IsTest
public class RestrictHindiTeacherTest {
    public static testmethod void testRestrictHindiTeacherOnInsert() {
        Contact newContact = new Contact(FirstName = 'Hindi Teacher', LastName = 'con');
        
        try{
            newContact.Subject__c = 'Hindi';
            Insert newContact;
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('Cant insert/update as subject is Hindi') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        } 
    }
    
    public static testmethod void testRestrictHindiTeacherOnUpdate() {
        Contact newContact = new Contact(FirstName = 'Hindi Teacher', Subject__c = 'English', LastName = 'con');
        Insert newContact;
        try{
            newContact.Subject__c = 'Hindi';
            Update newContact;
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('Cant insert/update as subject is Hindi') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        } 
    }
    public static testmethod void testRestrictHindiTeacherWhenSubjectIsNull() {
        Contact newContact = new Contact(FirstName = 'Hindi Teacher',  LastName = 'con');
        
        try{
            Insert newContact;
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('Please select a subject') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        } 
    }
}