@RestResource(urlMapping='/DataAvailable/*')
Global class IntegrationExpose {
	
    @httpget
    global static List<Account> getUruguayAccounts() {
        return [Select name, BillingCountry from Account where BillingCountry ='Uruguay'];
    }
}