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
    //Обработка исключений в тестах https://help.salesforce.com/s/articleView?id=release-notes.rn_apex_new_assert_class.htm&release=240&type=5
    public void throwException(String message) {
        //Здесь может быть любой тип Exception
        throw new IllegalArgumentException(message);
    }
}
