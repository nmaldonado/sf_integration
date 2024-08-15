public with sharing class MockarooAPIHandler {

    static String apiHeaderKey;
    static String apiHeaderValue;
    static String apiUrl;
    static HttpRequest req;
    static HttpResponse res;
    static String mode;
    

    public static void setApiConnectionData(String mode) {
        // Access the custom metadata record by its DeveloperName
        Integration_API__mdt metadataRecord = Integration_API__mdt.getInstance('Mockaroo_API');
        apiHeaderKey = metadataRecord.Key__c;
        apiHeaderValue = metadataRecord.Value__c;
        apiUrl = metadataRecord.Url__c + mode +'.json'; 


    }

    public static void convertContactsMockToContacts() {

        List<Contact> contactsToCreate = new List<Contact>();
        List<MockarooContact> mockContacts = MockarooAPIHandler.getMockContacts();
        for (MockarooContact mc : mockContacts) {

            contactsToCreate.add( new Contact(
                FirstName = mc.firstName,
                LastName = mc.lastName,
                Email = mc.email
            ));
        }

        insert contactsToCreate;
    }

    @auraenabled(cacheable=false)
    @future(callout=true)
    public static  void getAccountsFromMock() {

        List<Account> accountsToCreate = new List<Account>();
        List<MockarooAccount> mockAccounts = getMockAccounts();
        System.debug('size :'+ mockAccounts.size());
        for (MockarooAccount ma : mockAccounts) {

            accountsToCreate.add( new Account(
                Name = ma.name,
                RecordTypeId = ma.recordTypeId,
                Industry = ma.industry,
                Phone = ma.phone,
                BillingStreet = ma.billingAddress,
                BillingCity = ma.billingCity,
                BillingState = ma.billingState,
                BillingCountry = ma.billingCountry,
                AnnualRevenue = Double.valueOf(ma.AnnualRevenue)
            ));
        }

        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.AllowSave = true; 
        List<Database.SaveResult> results = Database.insert(accountsToCreate, dml);

        for (Database.SaveResult sr : results) {
            if (sr.isSuccess()) {
                System.debug('Successfully inserted account. Account ID: ' + sr.getId());
            } else {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');                   
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
        }
    }


    public static List<MockarooContact> getMockContacts() {
        setApiConnectionData('contacts');

        HttpRequest req = new HttpRequest();
        req.setHeader(apiHeaderKey,apiHeaderValue);
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json');
        req.setEndpoint(apiUrl);
        req.setCompressed(true);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('res: '+ res.getBody());
        return (List<MockarooContact>)JSON.deserialize(res.getBody(), List<MockarooContact>.class);
    }

    public static List<MockarooAccount> getMockAccounts() {
        setApiConnectionData('accounts');
        HttpRequest req = new HttpRequest();
        req.setHeader(apiHeaderKey,apiHeaderValue);
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json');
        req.setEndpoint(apiUrl);
        req.setCompressed(true);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('res: '+ res.getBody());
        return (List<MockarooAccount>)JSON.deserialize(res.getBody(), List<MockarooAccount>.class);

    }

    class MockarooContact {
        public String firstName;
        public String lastName;
        public String email;
    }

    class MockarooAccount {
        public String name;
        public String recordTypeId;
        public String industry;
        public String phone;
        public String billingAddress;
        public String billingCity;
        public String billingState;
        public String billingCountry;
        public String AnnualRevenue;
    }
}