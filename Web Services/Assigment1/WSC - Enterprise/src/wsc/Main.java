package wsc;

import com.sforce.soap.enterprise.Connector;
import com.sforce.soap.enterprise.DeleteResult;
import com.sforce.soap.enterprise.EnterpriseConnection;
import com.sforce.soap.enterprise.Error;
import com.sforce.soap.enterprise.QueryResult;
import com.sforce.soap.enterprise.SaveResult;
import com.sforce.soap.enterprise.sobject.Account;
import com.sforce.soap.enterprise.sobject.Contact;
import com.sforce.soap.enterprise.sobject.Student__c;
import com.sforce.ws.ConnectionException;
import com.sforce.ws.ConnectorConfig;

public class Main {
  
static final String USERNAME = "manisha.gupta1@metacube.com";
static final String PASSWORD = "Metacube123p98a1oPc1rZFnuMcalic5YH8";
  static EnterpriseConnection connection;

  public static void main(String[] args) {

    ConnectorConfig config = new ConnectorConfig();
    config.setUsername(USERNAME);
    config.setPassword(PASSWORD);
    
    try {
      
      connection = Connector.newConnection(config);
      
      System.out.println("Auth EndPoint: "+config.getAuthEndpoint());
      System.out.println("Service EndPoint: "+config.getServiceEndpoint());
      System.out.println("Username: "+config.getUsername());
      System.out.println("SessionId: "+config.getSessionId());
      
      
      queryContacts();
      createStudent();
      
      
    } catch (ConnectionException e1) {
        e1.printStackTrace();
    }  

  }
  
  // queries and displays the 5 newest contacts
  private static void queryContacts() {
    
    System.out.println("Querying for the 5 newest Contacts...");
    
    try {
        
      QueryResult queryResults = connection.query("SELECT Id, FirstName, LastName, Account.Name " +
      		"FROM Contact WHERE AccountId != NULL ORDER BY CreatedDate DESC LIMIT 5");
      if (queryResults.getSize() > 0) {
        for (int i=0;i<queryResults.getRecords().length;i++) {
          Contact c = (Contact)queryResults.getRecords()[i];
          System.out.println("Id: " + c.getId() + " - Name: "+c.getFirstName()+" "+
              c.getLastName()+" - Account: "+c.getAccount().getName());
        }
      }
      
    } catch (Exception e) {
      e.printStackTrace();
    }    
    
  }
  private static void createStudent() {
	    
	    System.out.println("Creating 5 new test Student...");
	    Student__c[] records = new Student__c[5];
	      		
	    try {
	       
	      // create 5 test students
	      for (int i=0;i<5;i++) {
	    	  Student__c student = new Student__c();
	    	  student.setName("Test"+i+" student "+i);
	    	  student.setLastName__c("Test student "+i);
	    	  student.setClass__c("a0E7F0000077Y8BUAU");
	    	  
	    	  records[i] = student;
	      }
	      
	      // create the records in Salesforce.com
	      SaveResult[] saveResults = connection.create(records);
	    } catch (Exception e) {
	      e.printStackTrace();
	    }    
	    
	  }
	} 
