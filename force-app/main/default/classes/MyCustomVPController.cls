public class MyCustomVPController {

    public TestObject__c testObject;

    public MyCustomVPController () {
        System.debug('-----MyCustomVPController constructor running');
        testObject = new TestObject__c(
            Name = 'Visualforce from constructor'
        );
    }
 
    public TestObject__c getNewTestObject() {
        System.debug('-----getNewTestObject()');
        return new TestObject__c(
            Name = 'Visualforce Custom Controller Test with get'
        );
    }
    
    public TestObject__c getTestObject() {
        System.debug('-----getTestObject()');
        return testObject;
    }
    
    public Integer getSomeInteger() {
        System.debug('-----getSomeInteger()');
        return 15;
    }
    
    public String getSomeText() {
        System.debug('-----getSomeText()');
        return 'Some text from MyCustomVPController';
    }
    
    public PageReference someAction() {
        System.debug('-----someAction()');
        return new PageReference('/lightning/page/home');
    }  
    
    public PageReference save() {
        System.debug('-----save()');
        System.debug('-----testObject:' + testObject);
        return null;
    }  
}