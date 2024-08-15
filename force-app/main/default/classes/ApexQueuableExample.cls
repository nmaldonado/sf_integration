public class ApexQueuableExample implements Queueable {

    public void execute(QueueableContext context) {
        System.debug('Start!!!!!');
        List<Account> accList = ([SELECT Id, Name, AnnualRevenue, Processed__c FROM Account LIMIT 200]);
        for(Account acc : accList){
            System.debug('acc::::: '+acc);
            //acc.AnnualRevenue = acc.AnnualRevenue * 2;
            acc.Name = acc.Name + ' - Updated';
            acc.Processed__c = Datetime.now().format('dd/MM/yyyy');
            System.debug('ApexQueuableExample - execute - accList: ' + accList);
        }
        update accList;
    }
}