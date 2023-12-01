@RestResource(urlMapping='/myFirstApexRest/*')
global class MyFirstApexRest {
    private static final String URL_MARKER = '/myFirstApexRest/';
    private static final String ACCOUNT_MARKER = 'Account';
    private static final String ACCOUNT_WITH_DATA_MARKER = ACCOUNT_MARKER + '/';
    private static final String TEST_OBJECT_MARKER = 'TestObject';
    private static final String TEST_OBJECT_WITH_DATA_MARKER = TEST_OBJECT_MARKER + '/';

    @HttpPost
    global static SObject doPost() {
        //System.debug('-----name: ' + name);
        RestRequest request = RestContext.request;
        System.debug('-----request.requestBody: ' + request.requestBody.toString());
        // String urlParams =
        //     request.requestURI.substring(request.requestURI.indexOf(URL_MARKER) + URL_MARKER.length());

        List<String> params = getUrlParams(request);
        return createNewSobject(params);

        // String objectTypeFromUrl = urlSobjectType.substring(0, urlSobjectType.indexOf('/'));
        // if (urlSobjectType.startsWith(ACCOUNT_MARKER)) {
        //     String urlData = getDataFromUrl(urlSobjectType, ACCOUNT_MARKER);
        //     createNewSobject(Account.sObjectType, name, urlData);
        //     return createNewSobject(Account.sObjectType, name, urlData);
        // } else if (urlSobjectType.startsWith(TEST_OBJECT_MARKER)) {
        //     String urlData = urlSobjectType.substring(TEST_OBJECT_MARKER.length());
        //     System.debug('-----urlData: ' + urlData);
        //     return new TestObject__c(Name = 'I am TestObject and my name is ' + name + '. You send me this data: ' + urlData);
        // } else {
        //     String urlData = urlSobjectType;
        //     System.debug('-----urlData: ' + urlData);
        //     return new TestObject__c(Name = 'I am SObject and my name is ' + name + '. You send me this data: ' + urlData);
        // }
    }

    private static String getDataFromUrl(String urlData, String marker) {
        return urlData.substring(marker.length());
    }

    private static SObject createNewSobject(Schema.SObjectType sObjectType, String name, String urlData) {
        SObject obj = sObjectType.newSObject();
        obj.put('Name', 'I am ' + sObjectType.getDescribe().getName() + ' and my name is ' + name + '. You send me this data: ' + urlData);
        return obj;
    }

    private static List<String> getUrlParams(RestRequest request) {
        String urlParams = request.requestURI.substring(request.requestURI.indexOf(URL_MARKER) + URL_MARKER.length());

        return urlParams.split('/');
    }

    private static SObject createNewSobject(List<String> params) {
        if (params == null || params.isEmpty()) {
            return null;
        }

        SObject obj = Schema.getGlobalDescribe().get(params.get(0))?.newSObject(); // return null

        if (obj == null) {
            throw new MyRestException('Wrong SObjet API name: ' + params.get(0) + '. ');
        }

        if (params.size() < 2) {
            return obj;
        }

        obj.put('Name', 'I am ' + obj.getSObjectType().getDescribe().getName() + '. You send me this data: ' + params.get(1));

        return obj;
    }

    // @HttpGet
    // global static Account doGet() {

    //     Account account = new Account();
    //     account.Name = 'MethodGet';
    //     insert account;
    //     return account;
    // }

    class MyRestException extends Exception {
    }
}
