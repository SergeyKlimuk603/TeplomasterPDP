/**
 * Created by user on 11/22/22.
 */

public class LunchApexFromFlow {
    @InvocableMethod(label='runApexMethod')
    public static List<OutputVariables> runApexMethod(List<InputVariables> inputVariableList) {
        List<OutputVariables> outputVariables = new List<OutputVariables>();

        for (InputVariables input : inputVariableList) {
            OutputVariables outputVariable = new OutputVariables();
            outputVariable.stringOutputs = new List<String>();
            outputVariable.intOutputs = new List<Integer>();


            for (String inputString : input.stringInputs) {
                outputVariable.stringOutputs.add(inputString + ' returned');
            }

            for (Integer inputInt : input.intInputs) {
                outputVariable.intOutputs.add(inputInt * -1);
            }
            outputVariables.add(outputVariable);
        }

        return outputVariables;
    }

    public class InputVariables {
        @InvocableVariable
        public List<String> stringInputs;

        @InvocableVariable
        public List<Integer> intInputs;
    }

    public class OutputVariables {
        @InvocableVariable
        public List<String> stringOutputs;

        @InvocableVariable
        public List<Integer> intOutputs;
    }

}