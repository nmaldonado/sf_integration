import { LightningElement } from 'lwc';
import getAccountsFromMock from '@salesforce/apex/MockarooAPIHandler.getAccountsFromMock';

export default class AccountMockCreator extends LightningElement {

    handleClick() {
        getAccountsFromMock()
            .then(result => {
                console.log(result);
            })
            .catch(error => {
                console.log(error);
            });
    }
}