import { LightningElement, wire } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
const COLUMNS = [
    { label: 'Account Name', fieldName: NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Industry', fieldName: INDUSTRY_FIELD.fieldApiName, type: 'text' }
];
export default class AccountList extends LightningElement {
    columns = COLUMNS;
    accounts;
    
    fetchAccounts() {

        // Get accounts from the server
        getAccounts()
            .then((accounts) => {
                this.accounts = accounts;
            })
            .catch((error) => {
                this.error = error;
            });
    }

    //call fectchAccounts on load
    connectedCallback() {
        this.fetchAccounts();
    }
}