public class MyVisualforceExtention2 {

    public MyVisualforceExtention2 (MyCustomVPController myController) {
        System.debug('-----MyVisualforceExtention2 constructor running');
    }
    
    public Integer getSomeInteger() {
        System.debug('-----MyVisualforceExtention2 getSomeInteger()');
        return 35;
    }
    
    public String getSomeText() {
        System.debug('-----MyVisualforceExtention2 getSomeText()');
        return 'Some text from MyVisualforceExtention2';
    } 
}