@isTest
public class ContactTriggerHandlerTest {
    
    @isTest
    static void testContactLimit() {
        // Step 1: Create test accounts
        Account account1 = new Account(Name = 'Test Account 1');
        Account account2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{account1, account2};

        // Step 2: Create and insert contacts for account1
        Contact contact1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = account1.Id);
        Contact contact2 = new Contact(FirstName = 'Jane', LastName = 'Doe', AccountId = account1.Id);
        insert new List<Contact>{contact1, contact2};

        // Step 3: Attempt to add a third contact to account1
        Contact contact3 = new Contact(FirstName = 'Jim', LastName = 'Beam', AccountId = account1.Id);
        
        // Step 4: Use Test.startTest() and Test.stopTest() for testing context
        Test.startTest();
        try {
            insert contact3; // This should trigger the error
            System.assert(false, 'you cant add contacts to this account its already have 2 contacts');
        } catch (DmlException e) {
            // Expected to catch an error due to the limit exceeded
            System.assert(e.getMessage().contains('you cant add contacts to this account its already have 2 contacts'), 'Expected error message not found.');
        }
        Test.stopTest();

        // Step 5: Fetch contacts after trigger execution to ensure contact3 was not inserted
        List<Contact> allContacts = [SELECT Id, FirstName, LastName FROM Contact WHERE AccountId = :account1.Id];
        System.assertEquals(2, allContacts.size(), 'There should be 2 contacts for account1.');

        // Step 6: Update a contact to move it to account2
        contact1.AccountId = account2.Id;
        Test.startTest();
        update contact1; // This should trigger the validation again
        Test.stopTest();

        // Assert that the update succeeded and the counts are correct
        List<Contact> updatedContacts = [SELECT Id, AccountId FROM Contact WHERE Id = :contact1.Id];
        System.assertEquals(account2.Id, updatedContacts[0].AccountId, 'Contact1 should now be associated with account2.');
    }

    @isTest
    static void testContactUndelete() {
        // Step 1: Create a test account
        Account account1 = new Account(Name = 'Test Account 1');
        insert account1;

        // Step 2: Create and insert contacts
        Contact contact1 = new Contact(FirstName = 'Alice', LastName = 'Smith', AccountId = account1.Id);
        insert contact1;

        // Step 3: Delete the contact
        delete contact1;

        // Step 4: Undelete the contact
        Test.startTest();
        List<Database.UndeleteResult> undeleteResults = Database.undelete(new List<Id>{contact1.Id}, false);
        Test.stopTest();

        // Assert that the contact has been restored
        List<Contact> allContacts = [SELECT Id, FirstName, LastName FROM Contact WHERE Id = :contact1.Id];
        System.assertEquals(1, allContacts.size(), 'Contact should be undeleted.');
    }

    @isTest
    static void testContactDelete() {
        // Step 1: Create a test account
        Account account1 = new Account(Name = 'Test Account 1');
        insert account1;

        // Step 2: Create and insert contacts
        Contact contact1 = new Contact(FirstName = 'Bob', LastName = 'Jones', AccountId = account1.Id);
        insert contact1;

        // Step 3: Delete the contact
        Test.startTest();
        delete contact1;
        Test.stopTest();

        // Assert that the contact was deleted
        List<Contact> deletedContacts = [SELECT Id FROM Contact WHERE Id = :contact1.Id ALL ROWS];
        System.assertEquals(1, deletedContacts.size(), 'Contact should be deleted.');
    }
}

