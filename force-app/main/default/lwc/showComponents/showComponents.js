import { LightningElement, wire } from 'lwc';
import getObjects from '@salesforce/apex/ReceiveComponentsController.getObjects';

export default class ShowComponents extends LightningElement {
    isLoading = true;
    records = [];
    errorOccurred = false;


    get hasRecords() {
        return this.records.length > 0;
    }

    connectedCallback() {
        this.fetchMap();
    }


    async fetchMap() {
        try {
            let mapData = await getObjects();
            console.log(JSON.parse(JSON.stringify(Object.values(mapData))));
   
            this.records = Object.values(mapData);
            this.isLoading = false;

        } catch (error) {
            this.errorOccurred = true;  
            this.errorMessage = error.message;
        }
    }

    deleteHandler(event) {

        let recordId = event.target.dataset.recordid;
        console.log(recordId);
        //TODO Delete record from server

    }

}