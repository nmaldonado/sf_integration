import { LightningElement, track } from 'lwc';

export default class TrackDecorator extends LightningElement {

    @track itemList = [];
    newItem;

    handleChange(event) {
        this.newItem = event.target.value;
    }

    addNewItem() {
        this.itemList.push(this.newItem);
        console.log( "Item List: ", this.itemList);
    }
}