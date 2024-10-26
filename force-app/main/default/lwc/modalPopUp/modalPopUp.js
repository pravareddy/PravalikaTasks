import { LightningElement,track, api } from 'lwc';

export default class ModalPopUp extends LightningElement {
  @track isModalOpen=false; 
  @api movieName;
  showModalBox() {  
    this.isModalOpen = true;
}

hideModalBox() {  
    this.isModalOpen = false;
}

}