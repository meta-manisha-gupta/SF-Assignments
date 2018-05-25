public class AccountRelatedOpportunityController {
    public List<account> listOfAccounts {get; set;}
    public Map<Account, Decimal> mapOfAccountAndSumOfAmount {get; set;}
    public Decimal sumOfOpportunityamount {get; set;}
    
    public AccountRelatedOpportunityController() {
        fetchData();
    }
    
    public void fetchData() {
        listOfAccounts = [SELECT id, Name,(SELECT Id,Name,Amount FROM Opportunities )FROM Account where name like 'pare%' order by name limit 10];
        getMapOfClassNameAndStudent();
    }
    public void getMapOfClassNameAndStudent() {
        Decimal sum;
        Map<Account, Decimal> mapOfAccountAndSum = new Map<Account, Decimal> ();
        for(Account accountObject : listOfAccounts) {
            sum = 0;
            if(!accountObject.Opportunities.isEmpty()){
                List<Opportunity> listOfOpportunitiesInAccount = accountObject.Opportunities;
                for(Opportunity OpportunityInstance : listOfOpportunitiesInAccount){
                    if(OpportunityInstance.Amount != null) {
                    	sum = sum + OpportunityInstance.Amount;
                    }
                }
            }
            mapOfAccountAndSum.put(accountObject, sum);
        }
        mapOfAccountAndSumOfAmount = mapOfAccountAndSum;
    }
}