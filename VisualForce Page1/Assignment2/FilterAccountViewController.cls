public class FilterAccountViewController {
    public string billingCity{get; set;}
    public string billingState{get; set;}
    public string billingCountry{get; set;}
    public list<Account> listOfAccount{get; set;}
    public void getAccounts() {
        listOfAccount = [SELECT Id, Name, BillingCity, BillingState, BillingCountry FROM Account 
                         WHERE BillingCity =: billingCity AND BillingState =: billingState AND BillingCountry =: billingCountry
                         LIMIT 100
                        ];
    }
}