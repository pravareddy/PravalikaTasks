import { createElement } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import TestCustomDataTable from 'c/testCustomDataTable';

jest.mock('@salesforce/apex/ContactController.getContacts');

describe('c-test-custom-data-table', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('renders contacts correctly', async() => {
        // Arrange
        const mockContacts=[
            {Id:'1', Name:'Pravalika Reddy', Email:'pravalikareddy3663@gmail.com', Phone:'6303161420'},
            {Id:'2', Name:'Ganesh Kusireddi', Email:'ganeshAryan@gmail.com', Phone:'9640837263'}
        ];
        getContacts.mockResolvedValue(mockContacts);

        const element = createElement('c-test-custom-data-table', {
            is: TestCustomDataTable
        });

        // Act
        element.accountId='001XXXXXXXXXXXX'; // Mock account Id
        document.body.appendChild(element);
        
       /// Wait for DOM to update
       await Promise.resolve();
        // Select the table rows
        const rows = element.shadowRoot.querySelectorAll('tbody tr');

        // Verify the number of rows
        expect(rows.length).toBe(2);

        // Verify the content of the first row
        expect(rows[0].cells[0].textContent).toBe('Pravalika Reddy');
        expect(rows[0].cells[1].textContent).toBe('pravalikareddy3663@gmail.com');
        expect(rows[0].cells[2].textContent).toBe('6303161420');

        // Verify the content of the second row
        expect(rows[1].cells[0].textContent).toBe('Ganesh Kusireddi');
        expect(rows[1].cells[1].textContent).toBe('ganeshAryan@gmail.com');
        expect(rows[1].cells[2].textContent).toBe('9640837263');


});

it('displays am error message when the apex method fails', async() => {
    // Arrange
    
    getContacts.mockRejectedValue(new Error('Failed to Load Contacts'));

    const element = createElement('c-test-custom-data-table', {
        is: TestCustomDataTable
    });

    // Act
    element.accountId='001XXXXXXXXXXXX'; // Mock account Id
    document.body.appendChild(element);
    
     // Wait for DOM to update
     await Promise.resolve();
    
    // Verify the error message
    const errorMsg = element.shadowRoot.querySelector('.slds-text-color_error');

    // Verify the number of rows
    expect(errorMsg).not.toBeNull();
    expect(errorMsg.textContent).toBe('Failed to load contacts');

    

});
});