public class SOQLComponentController {
    public String contactName {get; set;}
    public String contactId {get; set;}
    public ApexPages.StandardSetController setCon{get; set;} 
    private String sortDirection = 'ASC';
   	private String sortExp = 'name';
    //public Boolean showBlock{get; set;}
    public boolean showBlock {
        get{
            if(showBlock == null){
                showBlock = true;
            }
            return showBlock;
        }
        set;
    }
    public List<Contact> listOfContacts {  
        get {  
            if(setCon != null)  
                return (List<Contact>)setCon.getRecords();  
            else  
                return null ;  
        }  
        set;
    }  
    
    public String sortExpression {
        get{
            return sortExp;
        }
        set{
            if (value == sortExp)
                sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
            else
                sortDirection = 'ASC';
            sortExp = value;
        }
    }
    public String getSortDirection() {
        if (sortExpression == null || sortExpression == '')
          return 'ASC';
        else
         return sortDirection;
        }
    
    public void setSortDirection(String value) {  
           sortDirection = value;
    }
    String strFilter = '';
    public PageReference search() {
        //String newSearchText = '%'+contactName+'%';
        String query= '';
        
        //showBlock = !showBlock;
        System.debug('inside search showBlock');
        System.debug('showBlock'+showBlock);
        if(contactName != null && (contactName ).trim() !='')
        {
           strFilter  = strFilter  +  ' where Name Like \''+contactName+'%\'' ;
        }
        if(strFilter != '')
        {
            query = 'SELECT Id, Name, Email, Subject__c FROM Contact '+strFilter+ ' LIMIT 100';
            System.debug('Query ---->'+ query );
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(query)); 
            System.debug(setCon.getRecord().Id);
            setCon.setPageSize(2);
        }
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No such value exist'));
        }
        strFilter = '';
        return null;
    }
    public PageReference ViewData() {
        string sortFullExp = sortExpression  + ' ' + sortDirection;
        System.debug('Inside View Data ->>'+sortFullExp);
        String query= 'SELECT Id, Name, Email, Subject__c FROM Contact' +strFilter+ ' order by ' + sortFullExp + ' limit 1000';
        System.debug('SELECT Id, Name, Email, Subject__c FROM Contact' +strFilter+ ' order by ' + sortFullExp + ' limit 1000');
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        setCon.setPageSize(2);
        System.debug('Inside View Data ->>'+listOfContacts);
        return null;
   }
    public Boolean hasNext  
    {  
        get  
        {  
            return setCon.getHasNext();  
        }  
        set;  
    }  
    public Boolean hasPrevious  
    {  
        get  
        {  
            return setCon.getHasPrevious();  
        }  
        set;  
    }  
    public Integer pageNumber  
    {  
        get  
        {  
            return setCon.getPageNumber();  
        }  
        set;  
    }  
    public void previous()  
    {  
        setCon.previous();  
    }  
    public void next()  
    {  
        setCon.next();  
    }
}