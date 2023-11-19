/**
 * Created by user on 5/25/23.
 */

public with sharing class LearningLWCDecoratorsController {

    @AuraEnabled(cacheable=true)
    public static String showTestVariable(String testVariable) {
        System.debug('-----showTestVariable(String testVariable)');
        System.debug('-----testVariable: ' + testVariable);
        try {
            if (testVariable == 'forException') {
                AuraHandledException exception1 = new AuraHandledException('Exception Value was sent');
                exception1.setMessage('Exception Value was sent');
                throw exception1;
            }

            return testVariable + '_from Apex';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static String showTestVariable(String testVariable1, String testVariable2) {
        System.debug('-----showTestVariable(String testVariable1, String testVariable2)');
        System.debug('-----testVariable1: ' + testVariable1);
        System.debug('-----testVariable2: ' + testVariable2);
        try {
            AuraHandledException exception1 = new AuraHandledException('Exception Value was sent');
            if (testVariable1 == 'forException' && testVariable2 == 'forException') {               
                exception1.setMessage('Exception Value was sent from testVariable1 & testVariable2');
                throw exception1;
            }
            
            if (testVariable1 == 'forException') {               
                exception1.setMessage('Exception Value was sent from testVariable1');
                throw exception1;
            }

            if (testVariable2 == 'forException' ) {              
                exception1.setMessage('Exception Value was sent from testVariable2');
                throw exception1;
            }

            return testVariable1 + ' & ' + testVariable2 + ' from Apex';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}