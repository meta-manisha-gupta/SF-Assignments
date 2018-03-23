trigger RestrictHindiTeacher on Contact (before insert, before update) {
    for(Contact con : Trigger.new) {
        if(con.Subject__c == null) {
            con.addError('Please select a subject');
        } else if (con.Subject__c.Contains('Hindi')) {
            con.addError('Cant insert/update as subject is Hindi');
        }
    }
}