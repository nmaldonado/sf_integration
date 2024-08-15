public class AccountTriggerHandler {

    List<Account> newAccounts = new List<Account>();
    List<Account> oldAccounts = new List<Account>();
    Map<Id, Account> oldAccountMap = new Map<Id, Account>();
    
    public static void run(Boolean isBefore, Boolean isAfter, TriggerOperation operationType) {
        if(isBefore) {
            if(operationType == TriggerOperation.BEFORE_INSERT) {
                beforeInsert(Trigger.new);
            } else if(operationType == TriggerOperation.BEFORE_UPDATE) {
                beforeUpdate(Trigger.new, Trigger.oldMap);
            }
        } 
        
        if(isAfter) {
            if(operationType == TriggerOperation.AFTER_INSERT) {
                afterInsert(Trigger.newMap);
            } else if(operationType == TriggerOperation.AFTER_UPDATE) {
                afterUpdate(Trigger.new, Trigger.oldMap);
            }
        }
    }
    
    private static void beforeInsert(List<Account> newAccounts) {
        // Business logic for before insert
    }
    
    private static void beforeUpdate(List<sObject> newAccounts, Map<Id, sObject> oldAccountMap) {
        // Business logic for before update
    }
    
    private static void afterInsert(Map<Id, sObject> newAccountMap) {
        // Business logic for after insert
        sendPostRequest(newAccountMap.keySet());
    }
    
    private static void afterUpdate(List<sObject> newAccounts, Map<Id, sObject> oldAccountMap) {
        // Business logic for after update
    }


    @future(callout=true)
    public static void sendPostRequest(Set<Id> accountsId) {
        
        // Prepare the HTTP request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SF_NM_pandaTo4dc'); // Update with your Named Credential and endpoint
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        
        //get accounts
        Account acc =[Select Name, Phone,BillingCity, BillingCountry FROM ACCOUNT WHERE ID in :accountsId LIMIT 1];
		acc.Source__c = 'Panda';
        acc.Id = null;
        
		
        
        
        String accountJson = JSON.serialize(wrapAccount(acc));
        
        // Send the request and handle the response
        request.setBody(accountJson);
        

        
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            System.debug('Accounts sent successfully: ' + response.getBody());
        } else {
            System.debug('Failed to send accounts: ' + response.getStatus());
        }
    }
    
    
    private static Account_wrapper wrapAccount(Account acct) {
        Account_wrapper wrapper = new Account_wrapper();
        wrapper.acct = acct;
        return wrapper;
    }
    

    
    
}