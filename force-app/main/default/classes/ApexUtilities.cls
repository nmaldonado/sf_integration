public class ApexUtilities {

    class RecordTypeIdNotfoundException extends Exception {}

    //map of Record types Id by SObject and name
    private static Map<String,Id> mapRTIdBysObjectAndName;

    public static String getRecordTypeIdBySObjectAndName(Schema.SObjectType objectType, String recordTypeName) {
        return getRecordTypeIdBySObjectAndNameFromSchema(objectType, recordTypeName);
    }

    public static String getRecordTypeIdBySObjectAndNameFromSchema (Schema.SObjectType objectType, String recordTypeName) {
    	
    	if (mapRTIdBysObjectAndName == null || (! mapRTIdBysObjectAndName.containsKey(recordTypeName)) ) {
    		recordTypeFromSchema(objectType);
    	}
       	if (mapRTIdBysObjectAndName.containsKey(recordTypeName)) {
            System.debug('mapRTIdBysObjectAndName: '+ mapRTIdBysObjectAndName);
       		return mapRTIdBysObjectAndName.get(recordTypeName);
       	}  else {
       		throw new RecordTypeIdNotfoundException('No RecordType found for '+ objectType.getDescribe().getName() + ' with name "'+ recordTypeName +'".');
       	}
    }

    private static void recordTypeFromSchema(Schema.SObjectType objectType) {
        Schema.DescribeSObjectResult describeResult = objectType.getDescribe();
        
        if (mapRTIdBysObjectAndName == null) {
            mapRTIdBysObjectAndName = new Map<String,Id>();
        }

        Map<String, Schema.RecordTypeInfo> mapRecordTypeInfoByName = new Map<String,Schema.RecordTypeInfo>();
        mapRecordTypeInfoByName = describeResult.getRecordTypeInfosByName();
        
        for (String recordTypeName : mapRecordTypeInfoByName.keySet()){
			Id recordTypeId = mapRecordTypeInfoByName.get(recordTypeName).getRecordTypeId();

			mapRTIdBysObjectAndName.put(recordTypeName, recordTypeId);
		}
    }

}