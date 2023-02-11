public class MyVisualforceExtention1 {

    public MyVisualforceExtention1 (MyCustomVPController myController) {
        System.debug('-----MyVisualforceExtention1 constructor running');
    }
    
    public Integer getSomeInteger() {
        System.debug('-----MyVisualforceExtention1 getSomeInteger()');
        return 25;
    }
    
    public String getSomeText() {
        System.debug('-----MyVisualforceExtention1 getSomeText()');
        return 'Some text from MyVisualforceExtention1';
    } 
}