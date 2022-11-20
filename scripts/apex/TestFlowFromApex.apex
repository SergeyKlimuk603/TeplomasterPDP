// Example from here
// https://www.greytrix.com/blogs/salesforce/2021/12/06/how-to-invoke-lightning-auto-launched-flow-from-the-apex-class/

//Create parameter
Map<String, Object> Params = new Map<String, Object>();
Params.put('recordId','006p000000Aal2EAAR');

//create instance of Interview
Flow.Interview.GetOpprtunityStageName stage = new Flow.Interview.GetOpprtunityStageName(Params);

//Invoke start method
stage.start();

//get value from Flow
string stageName=(string)stage.getvariableValue('opprtunityStage');
system.debug('stageName::: '+stageName);

//--------------------------------------------------------------------------------------------------------------
// Запуск флоу Create_TestObject и получение результатов от него.
Map<String, String> params = new Map<String, String> {
    'TestObjectName' => 'invoke Flow from Apex'
};

Flow.Interview.Create_TestObject flow = new Flow.Interview.Create_TestObject(params);

flow.start();

System.debug('-----TestObjectId: ' + flow.getvariableValue('TestObjectId'));

//---------------------------------------------------------------------------------------------------------------