public with sharing class SomeClassForTesting {
    public static String str { private get; set; }

    //----------------------------------------------------------------------------------------------------------
    //CustomMetadataType testing
    @TestVisible
    private Map<String, TestCMT__mdt> testCmdMap {
        get {
            if (testCmdMap == null) {
                testCmdMap = TestCMT__mdt.getAll();
            }

            return testCmdMap;
        }
        set;
    }

    public String getTextFromCmt(String cmtName) {
        return testCmdMap.get(cmtName).TextField__c;
    }
    //----------------------------------------------------------------------------------------------------------
}
