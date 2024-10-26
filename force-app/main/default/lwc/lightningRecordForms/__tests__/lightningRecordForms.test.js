import { createElement } from 'lwc';
import LightningRecordForms from 'c/lightningRecordForms';

describe('c-lightning-record-forms', () => {
    let element;

    beforeEach(() => {
        // Create the element
        element = createElement('c-lightning-record-forms', {
            is: LightningRecordForms
        });
        document.body.appendChild(element);
    });

    afterEach(() => {
        // Cleanup the DOM after each test
        document.body.removeChild(element);
    });

    it('initializes with no error message', () => {
        // Expect errorMessage to be an empty string
        expect(element.errorMessage).toBe('');
    });

    it('handles load event correctly', () => {
        // Simulate the load event
        element.handleLoad();
        
        // Check that the error message is cleared
        expect(element.errorMessage).toBe('');
    });

    it('handles error event correctly', () => {
        // Simulate the error event
        element.handleError();

        // Check that the error message is set correctly
        expect(element.errorMessage).toBe('Record not found. Please check the ID.');
    });
});


