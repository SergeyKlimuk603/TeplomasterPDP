public with sharing class CustomMetadaTypeManager {
    @TestVisible
    private static List<ActivityPageLayout__mdt> fieldsActivityPageLayout;
    @TestVisible
    private static LayoutNameMapping__mdt layoutNameMapping;
    @TestVisible
    private static Map<String ,ValuesPicklistActivity__mdt> valuesPick;
    @TestVisible
    private static List<CompactLayout__mdt> compactLayouts;
    @TestVisible
    private static List<PrivateProfilesActivities__mdt> privateProfilesActivities;
    @TestVisible
    private static List<ExcludedProfInOppCreateProc__mdt> excludedProfInOppCreateProc;
    @TestVisible
    private static List<Object_Queue_Transfer__mdt> leadQueueTransfer;
    @TestVisible
    private static List<Record_Custom_View__mdt> recordCustomView;
    @TestVisible
    private static List<Record_Custom_View_Field__mdt> recordCustomViewFields;
    @TestVisible
    private static List<OppBatchUpdateConfig__mdt> batchUpdateConfigs;
    @TestVisible
    private static List<Create_Record_Fields__mdt> createRecordFields;
    @TestVisible
    private static List<Activity_Counter_Object__mdt> counterObjects;
    @TestVisible
    private static List<Activity_Counter_Config__mdt> counterConfigs;
    @TestVisible
    private static Single_Related_List__mdt singleRelatedList;
    @TestVisible
    private static SCOR_Credentials__mdt SCORCredentials;
    @TestVisible
    private static List<Contract_Redline_Docx_Merge_Field__mdt> redlineDocxMergeFields;
    @TestVisible
    private static List<Lead_Conversion_Field_Mapping__mdt> leadConversionFieldMapping;
    @TestVisible
    private static List<Validation_In_Opp_Approval_Creation__mdt> validationFieldsForOpp;
    @TestVisible
    private static List<User_Config__mdt> userConfigs;

    public static List<Create_Record_Fields__mdt> getCreateRecordFields(String layoutType, String objectType) {
        if (createRecordFields == null) {
            return getCreateRecordFieldRecords(layoutType,objectType);
        }
        return createRecordFields;
    }

    public static List<Record_Custom_View_Field__mdt> getCustomRecordViewsFields(Set<String> recordViewNames) {
        if (recordCustomView == null) {
            return returnRecordCustomViewsFields(recordViewNames);
        }
        return recordCustomViewFields;
    }

    public static List<OppBatchUpdateConfig__mdt> getBatchUpdateConfigs(String updateToStage, String developerName) {
        if (batchUpdateConfigs == null) {
            return returnBatchUpdateConfigs(updateToStage, developerName);
        }
        return batchUpdateConfigs;
    }

    public static List<ExcludedProfInOppCreateProc__mdt> getExcludedProfInOppCreateProc(String profileName) {
        if(excludedProfInOppCreateProc == null) {
            return  returnExcludedProfInOppCreateProc(profileName);
        }

        return excludedProfInOppCreateProc;
    }

    public static List<ActivityPageLayout__mdt> getFieldsActivityPageLayout(String nameAction, Profile profileUser) {
        if(fieldsActivityPageLayout == null) {
            return  returnActivityPageLayout(nameAction, profileUser);
        }

        return fieldsActivityPageLayout;
    }

    public static LayoutNameMapping__mdt getLayoutNameMapping(Profile profileUser,String sObjectName, RecordType recordType) {
        if(layoutNameMapping ==  null) {
            return returnLayoutNameMapping(profileUser,sObjectName, recordType);
        }

        return layoutNameMapping;
    }

    public static Map<String ,ValuesPicklistActivity__mdt> getValuesPick(String nameObject, Profile profileUser, String recordTypeName) {
        if(valuesPick == null){
            return getValuesPicklistActivities(nameObject, profileUser, recordTypeName);
        }

        return valuesPick;
    }

    public static List<CompactLayout__mdt>  getCompactLayouts(String typeObject, RecordType recordType) {
        if(compactLayouts == null){
            return getCompactLayoutsObject(typeObject, recordType);
        }

        return compactLayouts;
    }

    public static List<PrivateProfilesActivities__mdt> getPrivateProfilesRules(String condition){
        if(privateProfilesActivities == null){
            return getPrivateProfilesActivities(condition);
        }

        return privateProfilesActivities;
    }

    public static List<Object_Queue_Transfer__mdt> getObjectQueueTransfer(String developerName) {
        if(leadQueueTransfer == null){
            return getObjectQueueTransferRecord(developerName);
        }
        return leadQueueTransfer;
    }

    public static List<Activity_Counter_Object__mdt> getCounterObjects(){
        if(counterObjects == null){
            return returnCounterObjects();
        }
        return counterObjects;
    }

    public static List<Activity_Counter_Config__mdt> getCounterConfigs(){
        if(counterConfigs == null){
            return returnCounterConfigs();
        }
        return counterConfigs;
    }

    public static Single_Related_List__mdt getSingleRelatedList(String sobjectApiName){
        if(singleRelatedList == null){
            return returnSingleRelatedList(sobjectApiName);
        }
        return singleRelatedList;
    }

    public static SCOR_Credentials__mdt getSCORCredentials(String typeOfOrg){
        if(SCORCredentials == null){
            return returnSCORCredentials(typeOfOrg);
        }
        return SCORCredentials;
    }

    public static List<User_Config__mdt> getUserConfigsByRoleNames(List<String> roleNames) {
        if (roleNames == null || roleNames.isEmpty()) {
            return new List<User_Config__mdt>();
        }

        if (userConfigs == null) {
            return [SELECT Label, DeveloperName, Config__c FROM User_Config__mdt WHERE DeveloperName IN :roleNames];
        }

        return userConfigs;
    }

    public static List<Contract_Redline_Docx_Merge_Field__mdt> getRedlineDocxMergeFields(Set<String> contractTemplateNames) {
        if(redlineDocxMergeFields == null) {
            return returnRedlineDocxMergeFields(contractTemplateNames);
        }

        return redlineDocxMergeFields;
    }

    public static List<Validation_In_Opp_Approval_Creation__mdt> getValidationsInOppCreation(){
        if(validationFieldsForOpp == null){
            return returnValidationsForOppCreation();
        }
        return validationFieldsForOpp;
    }

    public static List<Lead_Conversion_Field_Mapping__mdt> getLeadConversionFieldMapping() {
        if (leadConversionFieldMapping == null) {
            return returnLeadConversionFieldMapping();
        }
        return leadConversionFieldMapping;
    }

    private static List<ExcludedProfInOppCreateProc__mdt> returnExcludedProfInOppCreateProc(String profileName){
        return (List<ExcludedProfInOppCreateProc__mdt>) ObjectManager.getObjects('ExcludedProfInOppCreateProc__mdt', null, 'ProfileName__c=\''+profileName+'\'');
    }

    private static List<ActivityPageLayout__mdt> returnActivityPageLayout (String nameAction, Profile profileUser) {
        List<ActivityPageLayout__mdt> activityPageLayout;
        String condition;

        if(profileUser != null){
            condition  = 'NameAction__c = \''+nameAction +'\' AND ProfileName__c = \'' + profileUser.Name + '\' ORDER BY Number__c ASC ';

            activityPageLayout =   (List<ActivityPageLayout__mdt>) ObjectManager.getObjects('ActivityPageLayout__mdt', null,  condition);
        }

        if(activityPageLayout != null && !activityPageLayout.isEmpty()){
            return activityPageLayout;
        }

        condition =  'NameAction__c = \'' + nameAction +'\' AND isDefault__c = true ORDER BY Number__c ASC';

        return  (List<ActivityPageLayout__mdt>) ObjectManager.getObjects('ActivityPageLayout__mdt', null,  condition);
    }

    private static LayoutNameMapping__mdt returnLayoutNameMapping (Profile profileUser,String sObjectName, RecordType  recordType) {
        LayoutNameMapping__mdt layoutNameMapping;
        String condition;

        if(recordType != null && profileUser != null){
            condition  = 'RecordType__c = \''+recordType.DeveloperName +'\' AND ProfileName__c = \'' + profileUser.Name + '\'AND sObject__c = \'' + sObjectName +'\' AND isDefault__c = false ';
            layoutNameMapping =   (LayoutNameMapping__mdt) ObjectManager.getObject('LayoutNameMapping__mdt', null,  condition);
        }

        if(layoutNameMapping != null){
            return layoutNameMapping;
        }

        condition =  'sObject__c = \'' + sObjectName +'\' AND isDefault__c = true ';

        return  (LayoutNameMapping__mdt) ObjectManager.getObject('LayoutNameMapping__mdt', null,  condition);
    }

    private static Map<String ,ValuesPicklistActivity__mdt> getValuesPicklistActivities(String nameObject, Profile profileUser, String recordTypeName) {
        Map<String ,ValuesPicklistActivity__mdt> valuesPick = new Map<String, ValuesPicklistActivity__mdt>();

        List<ValuesPicklistActivity__mdt> valuesPicklist;
        String conditionPicklistValues;

        if(String.isNotBlank(nameObject) && profileUser != null && String.isNotBlank(recordTypeName)){
            conditionPicklistValues = 'TypeObject__c = \''+nameObject +'\' AND ProfileName__c = \'' + profileUser.Name + '\' AND RecordTypeName__c = \''+ recordTypeName+'\'';
            valuesPicklist = (List<ValuesPicklistActivity__mdt>) ObjectManager.getObjects('ValuesPicklistActivity__mdt', null,  conditionPicklistValues);
        }

        if(valuesPicklist == null || valuesPicklist.isEmpty()){
            conditionPicklistValues = 'TypeObject__c = \''+nameObject +'\' AND isDefault__c = true';
            valuesPicklist = (List<ValuesPicklistActivity__mdt>) ObjectManager.getObjects('ValuesPicklistActivity__mdt', null,  conditionPicklistValues);
        }

        if(valuesPicklist == null) {
            return valuesPick;
        }

        for(ValuesPicklistActivity__mdt valuesPicklistActivity:valuesPicklist){
            valuesPick.put(valuesPicklistActivity.ApiNameField__c, valuesPicklistActivity);
        }

        return valuesPick;
    }

    private static List<CompactLayout__mdt> getCompactLayoutsObject(String typeObject, RecordType recordType) {
        List<CompactLayout__mdt> compactLayouts;
        String condition;

        if(recordType != null)  {
            condition = 'TypeObject__c = \''+ typeObject +'\' AND RecordTypeName__c = \'' + recordType.DeveloperName + '\' ORDER BY Order__c ASC ';
            compactLayouts =   (List<CompactLayout__mdt>) ObjectManager.getObjects('CompactLayout__mdt', null,  condition);
        }

        if(compactLayouts != null && !compactLayouts.isEmpty()){
            return compactLayouts;
        }

        condition =  'TypeObject__c = \'' + typeObject +'\' AND isDefault__c = true ORDER BY Order__c ASC';

        return (List<CompactLayout__mdt>) ObjectManager.getObjects('CompactLayout__mdt', null,  condition);
    }

    private static List<PrivateProfilesActivities__mdt> getPrivateProfilesActivities (String condition) {
        return (List<PrivateProfilesActivities__mdt>) ObjectManager.getObjects('PrivateProfilesActivities__mdt',null,condition);
    }

    private static List<Object_Queue_Transfer__mdt> getObjectQueueTransferRecord(String developerName) {
        List<Object_Queue_Transfer__mdt> result = (List<Object_Queue_Transfer__mdt>) ObjectManager.getObjects('Object_Queue_Transfer__mdt',
                null, 'developerName=\'' + developerName + '\'');
        if (Test.isRunningTest()) {
            result = new List<Object_Queue_Transfer__mdt>{
                    new Object_Queue_Transfer__mdt(DeveloperName = 'Test', Transfer_From__c = 'TEST_TRANSFER_FROM_QUEUE_1;TEST_TRANSFER_FROM_QUEUE_2',
                            Transfer_To__c = 'TEST_TRANSFER_TO_QUEUE', Object_Type__c = 'Lead')
            };
        }
        return result;
    }

    private static List<Record_Custom_View_Field__mdt> returnRecordCustomViewsFields(Set<String> recordViewNames) {
        if (recordViewNames == null || recordViewNames.isEmpty()) return new List<Record_Custom_View_Field__mdt>();
        List<Record_Custom_View_Field__mdt> result = (List<Record_Custom_View_Field__mdt>) ObjectManager.getObjects('Record_Custom_View_Field__mdt',
                null, 'Record_Custom_View__r.DeveloperName in (\'' + String.join(new List<String>(recordViewNames), '\',\'') + '\')');
        if (Test.isRunningTest()) {
            Record_Custom_View_Field__mdt customView = new Record_Custom_View_Field__mdt(
                    Object_Type__c='Account',
                    Field_API_Name__c='First_Transaction_Date__c',
                    Section_Name__c='Host Information System',
                    Order__c=1
            );
            result = new List<Record_Custom_View_Field__mdt>{customView};
        }
        return result;
    }

    private static List<OppBatchUpdateConfig__mdt> returnBatchUpdateConfigs(String updateToStage, String developerName) {
        String condition;
        if (!String.isBlank(developerName)) {
            condition = 'DeveloperName = \'' + developerName + '\'';
        } else if (!String.isBlank(updateToStage)) {
            condition = 'UpdateToStage__c = \'' + updateToStage + '\'';
        }

        return (List<OppBatchUpdateConfig__mdt>) ObjectManager.getObjects('OppBatchUpdateConfig__mdt', null,  condition);
    }

    private static List<Create_Record_Fields__mdt> getCreateRecordFieldRecords(String layoutType, String objectType) {
        String condition= 'Layout_Type__c = \'' + layoutType + '\' And Object_Type__c = \'' +objectType+'\' ORDER BY Order__c ASC NULLS LAST';

        return (List<Create_Record_Fields__mdt>) ObjectManager.getObjects('Create_Record_Fields__mdt', null,  condition);
    }

    private static List<Activity_Counter_Object__mdt> returnCounterObjects(){
        List<Activity_Counter_Object__mdt> counterObjects=(List<Activity_Counter_Object__mdt>) ObjectManager.getObjects('Activity_Counter_Object__mdt', null,  null);

        return counterObjects;
    }

    private static List<Activity_Counter_Config__mdt> returnCounterConfigs(){
        List<Activity_Counter_Config__mdt> counterConfigs=(List<Activity_Counter_Config__mdt>) ObjectManager.getObjects('Activity_Counter_Config__mdt', null,  null);

        return counterConfigs;
    }

    private static Single_Related_List__mdt returnSingleRelatedList(String sobjectApiName){
        String condition= 'SObject_Api_Name__c = \'' + sobjectApiName + '\'';
        return (Single_Related_List__mdt)ObjectManager.getObject('Single_Related_List__mdt',null,condition);
    }

    private static SCOR_Credentials__mdt returnSCORCredentials(String orgType) {
        String condition = 'Type__c = \'' + orgType + '\'';
        return (SCOR_Credentials__mdt) ObjectManager.getObject('SCOR_Credentials__mdt', null, condition);
    }

    private static List<Contract_Redline_Docx_Merge_Field__mdt> returnRedlineDocxMergeFields(Set<String> contractTemplateNames) {
        List<Contract_Redline_Docx_Merge_Field__mdt> redlineDocxMergeFieldsMap = new List<Contract_Redline_Docx_Merge_Field__mdt>();
        if (contractTemplateNames != null && !contractTemplateNames.isEmpty()) {
            redlineDocxMergeFieldsMap = [
                    SELECT Label, Merge_Field_Tag_Name__c, Field_API_Name__c,
                            IsDate__c, DevString__c
                    FROM Contract_Redline_Docx_Merge_Field__mdt
                    WHERE Label IN :contractTemplateNames
            ];
        }

        return redlineDocxMergeFieldsMap;
    }
    private static List<Lead_Conversion_Field_Mapping__mdt> returnLeadConversionFieldMapping() {
        return (List<Lead_Conversion_Field_Mapping__mdt>) ObjectManager.getObjects('Lead_Conversion_Field_Mapping__mdt', null, null);
    }
    private static List<Validation_In_Opp_Approval_Creation__mdt> returnValidationsForOppCreation(){
        return (List<Validation_In_Opp_Approval_Creation__mdt>) ObjectManager.getObjects('Validation_In_Opp_Approval_Creation__mdt', null,  null);
    }
}