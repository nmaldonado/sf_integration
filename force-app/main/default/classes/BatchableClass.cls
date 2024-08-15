public with sharing class BatchableClass implements Database.Batchable<SObject>
{
    //start method
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator('SELECT Id, Name,AnnualRevenue, Processed__c FROM Account');
    }

    //Execute method

    public void execute(Database.BatchableContext bc, List<Account> scope)
    {
        for(Account a : scope) {
            if(a.AnnualRevenue > 1000000000) {
                a.Processed__c = 'High';
            } else if(a.AnnualRevenue >= 1000000 && a.AnnualRevenue < 1000000000) {
                a.Processed__c = 'Medium';
            } else if(a.AnnualRevenue <= 1000000) {
                a.Processed__c = 'Low';

            }
        }
        update scope;
    }

     //Finish method

    public void finish(Database.BatchableContext bc)
    {
        System.debug('Batch finished');
    }
}