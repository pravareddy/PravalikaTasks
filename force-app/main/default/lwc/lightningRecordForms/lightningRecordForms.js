import { LightningElement, api, track } from 'lwc';

export default class LightningRecordForms extends LightningElement {
    @api recordId;
    @track errorMessage = ''; // Initialize errorMessage as an empty string

    handleLoad() {
        // Logic to handle successful load
        this.errorMessage = '';
    }

    handleError() {
        // Logic to handle error
        this.errorMessage = 'Record not found. Please check the ID.';
    }
}
