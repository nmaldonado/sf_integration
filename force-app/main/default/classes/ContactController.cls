public with sharing class ContactController {


    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        try {
            List<Contact> contacts = ([SELECT FirstName, LastName, Email FROM Contact LIMIT 10]);
            return contacts;
        } catch (Exception e) {
            throw new AuraHandledException('Custom Message');    
    }
}
}