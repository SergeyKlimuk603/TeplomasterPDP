/**
 * Created by user on 11/2/22.
 */

public with sharing class TestApexInProcessBuilder {
    @InvocableMethod
    public static List<String> testMethod1(List<String> parameters) {
        System.debug('-----555 parameters: ' + parameters);
        return parameters;
    }
}