@RestResource(urlMapping='/Account/*')
global with sharing class MyRestResource {
    @HttpGet
    global static TestObject__c getRecord() {
        return new TestObject__c(Name = 'Rest resource learning');
    }
}
