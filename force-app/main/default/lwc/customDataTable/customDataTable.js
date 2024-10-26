import { LightningElement, api } from 'lwc';
import contactsList from '@salesforce/apex/ContactController.getContacts';
export default class CustomDataTable extends LightningElement {
@api recordId;
contactList=[];
errrors;
connectedCallback()
{
}

loadContacts()
{
  getContacts({accId:'$recordId'})
  .then(result=>{
   this.contactList=result;
   this.error=undefined;
  })
  .catch(error=>{
    this.errors = error.body.message;
    this.contactList=undefined;
  })
}
}