/**
 * Created by user on 11/22/22.
 */

public class LunchApexFromRecordTriggerFlow {
    @InvocableMethod
    public static List<String> runApex(List<String> inputVar) {
        List<String> outputList = new List<String> ();
        for (String inputString : inputVar) {
            outputList.add(inputString + ' returned');
        }
        System.debug('-----outputList: ' + outputList);
        return outputList;
    }
}