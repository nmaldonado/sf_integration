import { LightningElement,wire } from 'lwc';
import getDadJoke from '@salesforce/apex/DadJokeController.getDadJoke';

export default class ShowDadJokeComponent extends LightningElement {

    loading = false;
    dadJoke;
    error;
    
    handleJokes() {
        this.loading = true;
        this.dadJoke=undefined;
        getDadJoke()
        .then(result => {
            this.dadJoke = JSON.parse(result);
        })
        .catch(error => {
            console.error('This is the error::: ' + error);
            
        });
        this.loading = false;
    }

    connectedCallback() {
        this.handleJokes();
    }

    handleRefresh() {
        this.handleJokes();
    }
}