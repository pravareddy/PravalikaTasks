public with sharing class MovieController {
    @AuraEnabled
    public static List<Movie__c> getMovies(){
        return [SELECT Id,Title__c, Synopsis__c, Release_Date__c, Rating__c, Poster_Image__c, OwnerId, Genre__c, Director__c, Cast__c FROM Movie__c];
    }
    
}