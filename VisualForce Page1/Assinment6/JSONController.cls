public class JSONController {
	public String jsonString {get;set;}
	
    public JSONController() {
        jsonString = prepareData();
    }
    
    private String prepareData() {
        List<Account> listOfAccount = [SELECT Id, Name, BillingCity FROM Account WHERE Name LIKE 'a%'];
        return JSON.serialize(listOfAccount);
    }
}