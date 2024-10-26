@isTest
public class LeadControllerTest {
    
    @isTest
    static void testLeadDuplicateCheck()
    {
        List<Lead> leadList = new List<Lead>();
      leadList.add(new Lead(Email='test@test.com', Phone='6303161422', Company='ABC'));
      leadList.add(new Lead(Email='test@test.com', Phone='6303161422', Company='ABC'));
      leadList.add(new Lead(Email='testing@test.com', Phone='6303161411', Company='XYZ'));


        Test.startTest();
        Map<Boolean,List<Lead>> result = LeadController.leadDuplicateCheck(leadList);
        Test.stopTest();

        System.assertEquals(2, result.size(), 'Expected result map to contain 2 keys.');
    }
    
}