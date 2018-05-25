@isTest
public class AccountViewPaginationControllerTest {
    public static AccountViewPaginationController paginationControllerInstance = new AccountViewPaginationController();
    
    @testSetup static void setup(){
        
        List<Account> listOfAccount = new List<Account>();
        
        for(Integer i = 1 ; i <= 30 ; i++){
            Account newAccount = new Account(Name = 'TestAccountFromTest'+i);
            listOfAccount.add(newAccount);
        }
        
        for(Integer i = 31 ; i <= 60 ; i++){
            Account newAccount = new Account(Name = 'AccountFromTest'+i );
            listOfAccount.add(newAccount);
        }
        
        
        for(Integer i = 61 ; i <= 90 ; i++){
            Account newAccount = new Account(Name='MyAccountFromTest'+i );
            listOfAccount.add(newAccount);
        }
        
        Insert listOfAccount;
    }
    
    //To Test Search Result
    @isTest static void testPaginationControllerForSearch(){
        PageReference pageRef = Page.AccountViewPagination;
        Test.setCurrentPageReference(pageRef);
        
        Test.startTest();
        paginationControllerInstance.acc.Name = 'T';
        paginationControllerInstance.Search();
        Test.stopTest();
        
        List<Account> expectedListOfAccount = [SELECT Id, Name 
                                               FROM Account 
                                               WHERE Name 
                                               LIKE '%T%'
                                               LIMIT 10
                                              ];
        
        List<Account> actualListOfAccount = paginationControllerInstance.listOfAccount;
        System.assertEquals(expectedListOfAccount, actualListOfAccount);
        
    }
    
    //To Test Next CommandButton
    @isTest static void testPaginationControllerNext(){
        PageReference pageRef = Page.AccountViewPagination;
        Test.setCurrentPageReference(pageRef);
        
        Test.startTest();
        paginationControllerInstance.acc.Name = 'T';
        paginationControllerInstance.Search();
        paginationControllerInstance.next();
        Test.stopTest();
        
        List<Account> listOfAccountForRange = [SELECT Id, Name
                                               FROM Account 
                                               WHERE Name 
                                               LIKE '%T%'
                                              ];
        List<Account> expectedListOfAccount = new List<Account>();
        Integer i = 1 ;
        for(Account acc : listOfAccountForRange){
            if(i>10){
                expectedListOfAccount.add(acc);
                if(i==20)
                    break;
            }
            i++;
        }
        
        List<Account> acctualListOfAccount = paginationControllerInstance.listOfAccount;
        System.assertEquals(expectedListOfAccount, acctualListOfAccount);
    }
    
    //To Test Next CommandButton
    @isTest static void testPaginationControllerPrevious(){
        PageReference pageRef = Page.AccountViewPagination;
        Test.setCurrentPageReference(pageRef);
        
        Test.startTest();
        paginationControllerInstance.acc.Name = 'T';
        paginationControllerInstance.Search();
        paginationControllerInstance.next();
        paginationControllerInstance.previous();
        Test.stopTest();
        
        List<Account> expectedListOfAccount = [SELECT Id, Name
                                               FROM Account 
                                               WHERE Name 
                                               LIKE '%T%'
                                               LIMIT 10
                                              ];
        
        List<Account> acctualListOfAccount = paginationControllerInstance.listOfAccount;
        System.assertEquals(expectedListOfAccount, acctualListOfAccount);
    }
    
    //To Test Next CommandButton
    @isTest static void testPaginationControllerFirst(){
        PageReference pageRef = Page.AccountViewPagination;
        Test.setCurrentPageReference(pageRef);
        
        Test.startTest();
        paginationControllerInstance.acc.Name = 'T';
        paginationControllerInstance.Search();
        paginationControllerInstance.next();
        paginationControllerInstance.first();
        Test.stopTest();
        
        List<Account> expectedListOfAccount = [SELECT Id, Name
                                               FROM Account 
                                               WHERE Name 
                                               LIKE '%T%'
                                               LIMIT 10
                                              ];
        
        List<Account> acctualListOfAccount = paginationControllerInstance.listOfAccount;
        System.assertEquals(expectedListOfAccount, acctualListOfAccount);
    }
    
        //To Test Next CommandButton
    @isTest static void testPaginationControllerLast(){
        PageReference pageRef = Page.AccountViewPagination;
        Test.setCurrentPageReference(pageRef);
        
        Test.startTest();
        paginationControllerInstance.acc.Name = 'T';
        paginationControllerInstance.Search();
        paginationControllerInstance.last();
        Test.stopTest();
        
        List<Account> listOfAccountForRange = [SELECT Id, Name
                                               FROM Account 
                                               WHERE Name 
                                               LIKE '%T%'
                                              ];
        List<Account> expectedListOfAccount = new List<Account>();
        Integer i = 1 ;
        for(Account acc : listOfAccountForRange){
            if(i>20){
                expectedListOfAccount.add(acc);
                if(i==30)
                    break;
            }
            i++;
        }
        
        List<Account> acctualListOfAccount = paginationControllerInstance.listOfAccount;
        System.assertEquals(expectedListOfAccount, acctualListOfAccount);
    }
    
}