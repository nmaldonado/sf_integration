import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE_FIELD from '@salesforce/schema/Account.Phone';
export default class WireGetRecordProperty extends LightningElement {
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD,ACCOUNT_PHONE_FIELD], layoutTypes: ["Full"], modes: ["Edit"] })
    account;
    get name() {
        return getFieldValue(this.account.data, ACCOUNT_NAME_FIELD);
    }
    get phone() {
        return getFieldValue(this.account.data, ACCOUNT_PHONE_FIELD);
    }
}