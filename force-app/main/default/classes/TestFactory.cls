public class TestFactory {

    class TestFactoryException extends Exception{}
    

    public static void testApi(){
        HttpRequest req = new HttpRequest();
        req.setHeader('X-API-Key', 'e8c06880');
        req.setEndpoint('https://my.api.mockaroo.com/contacts_mock_api.json');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        System.debug('RES: ' + res.getBody());
        System.debug(res.getStatusCode());
        System.debug(res.getStatus());
        System.debug(res.getHeaderKeys());
        System.debug(res.getHeader('x-api-key'));
    }


    public static SObject createSObject(SObject sObj) {

        Schema.SObjectType sObjectType = sObj.getSObjectType();
        if (sObjectType == null) {
            throw new TestFactoryException('The object type of the sObject is null and it must be defined.');
        } else {
            // Check what object is the SObject
            String objectName = sObjectType.getDescribe().getName();
            // Construct the default values class. Salesforce doesn't allow '__' in class names
            String defaultValuesClassName = 'TestFactoryDefaultValues.' + objectName.replace('__c', '') + 'Defaults';
            // If there is a class that matches the default values for the object, then use those            
            if (Type.forName(defaultValuesClassName) != null) {
                sObj = createSObject(sObj, defaultValuesClassName);
            }

            return sObj;
        }
        
    }

    public static SObject createSObject(SObject sObj, String defaultClassName) {
        // Create an instance of the defaults class so we can get the Map of field defaults
        Type t = Type.forName(defaultClassName);
        if (t == null) {
            throw new TestFactoryException('No defaults class found named ' + defaultClassName);
        }
        FieldDefaults defaults = (FieldDefaults)t.newInstance();
        addFieldDefaults(sObj, defaults.getFieldDefaults());
        return sObj;   
    }

    public static SObject[] createSObjectList(Sobject sObj, Integer numberOfObjects) {
        return createSObjectList(sObj, numberOfObjects, null);
    }

    public static SObject[] createSObjectList(Sobject sObj, Integer numberOfObjects, String defaultClassName) {

        SObject[] sObjs = new SObject[]{};
        SObject newObj;

        // Get one copy of the object
        if (defaultClassName == null) {
            newObj = createSObject(sObj);
        } else {
            newObj = createSObject(sObj, defaultClassName);
        }

        // The name field of the object - not all objects have a field called "Name" so nameFieldMap provides for mapping of objects that don't have name field.  
        String nameField = nameFieldMap.get(String.valueOf(sObj.getSObjectType()));
        if (nameField == null) {
            nameField = 'Name';
        }

        // Clone the object the number of times requested. Increment the name field so each record is unique
        for (Integer i = 0; i < numberOfObjects; i++) {
            SObject clonedSObj = newObj.clone(false, true);
            clonedSObj.put(nameField, (String)clonedSObj.get(nameField) + ' ' + i);
            sObjs.add(clonedSObj);
        }
        return sObjs;
    }

    private static void addFieldDefaults(SObject sObj, Map<String, Object> defaults) {
        
        // Loop through the map of fields and if they value is null on the sObj, fill it with the default
        for (String field : defaults.keySet()) {
            if (sObj.get(field) == null) {
                sObj.put(field, defaults.get(field));
            }
        }
    }

    //FieldDefault interface

    public interface FieldDefaults {
        Map<String, Object> getFieldDefaults();
    }



    // To specify defaults for objects, use the naming convention [ObjectName]Defaults.
    // For custom objects, omit the __c from the Object Name.
    
    public class AccountDefaults implements FieldDefaults {
        public Map<String, Object> getFieldDefaults() {
            return new Map<String, Object> {
                'Name' => 'Test Account',
                'BillingStreet' => '123 Main Street',
                'BillingCity' => 'Portland',
                'BillingState' => 'OR',
                'BillingPostalCode' => '97204',
                'BillingCountry' => 'USA',
                'Phone' => '(555)867-5309',
                'Website' => 'http://www.tester.com',
                'Category__c' => 'Sales Prospect',
                'RecordTypeId' => globalConstants.acctCustomer, // recordType of 'Customer'
                'Industry' => 'Other',
                'AnnualRevenue' => 100000000.00,
                'NumberOfEmployees' => 72
            };
        }
    }





    // Specify the "name" field of each object. The default name field is "name"
    // for example, Contact - requires LastName
    //              Case -- doesn't have a Name field - so map it to Subject - we get unique subjects
    //              Opportunity -- Name field exists - it is the Opportunity Name - don't specify - let it default to Name above
    private static Map<String, String> nameFieldMap = new Map<String, String> {
        'Contact' => 'LastName',
        'Case' => 'Subject'
    };
}