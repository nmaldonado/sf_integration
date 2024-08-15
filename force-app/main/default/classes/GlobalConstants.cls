public class GlobalConstants {
    //Account Record Types -specify one for each account record type in org
    //Customer
    public static String acctCustomer {
        get {
             return ApexUtilities.getRecordTypeIdBySObjectAndName(Account.SObjectType, 'Customer'); 
        } 
        private set;
    }

    //Commerce
    public static String acctCommerce {
        get {
            return ApexUtilities.getRecordTypeIdBySObjectAndName(Account.SObjectType, 'Commerce'); 
        } 
        private set;
    }

    //Contact record types
    public static String conOwner {
        get { 
            return ApexUtilities.getRecordTypeIdBySObjectAndName(Contact.SObjectType, 'Owner'); 
         } 
        private set;
    }

    public static String conSales {
        get { 
            return ApexUtilities.getRecordTypeIdBySObjectAndName(Contact.SObjectType, 'Sales');
        }
        private set;
    }
}