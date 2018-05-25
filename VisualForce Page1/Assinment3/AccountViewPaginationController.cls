public class AccountViewPaginationController {
    public Account account {get;set;}   
    public ApexPages.StandardSetController setCon{get; set;} 
    public AccountViewPaginationController ()
    {
        account = new Account();
        listOfAccount = new List<Account>();
    }
    public List<Account> listOfAccount 
    {  
        get  
        {  
            if(setCon != null)  
                return (List<Account>)setCon.getRecords();  
            else  
                return null ;  
        }  
        set;
    }  
    
    public PageReference Search()
    {
        String query= '';
        String strFilter = '';
        if(account.BillingCity != null && (account.BillingCity ).trim() !='')
        {
            strFilter  = strFilter  +  ' where BillingCity Like \''+account.BillingCity+'%\'' ;
        }
        if(strFilter != '')
        {
            query = 'Select name ,id, BillingCity, BillingState, BillingCountry, phone from Account '+strFilter+ ' limit 50';
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(query)); 
            setCon.setPageSize(10);
        }
        else
        {
        }
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
    
    public void last()  
    {  
        setCon.last();  
    }
    
    public void first(){
        setCon.first();
    }
}