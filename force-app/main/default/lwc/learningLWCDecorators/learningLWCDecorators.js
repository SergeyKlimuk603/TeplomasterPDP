import { LightningElement, wire } from 'lwc';
import showTestVariable from '@salesforce/apex/LearningLWCDecoratorsController.showTestVariable';

export default class LearningLwcDecorators extends LightningElement {

    testVariable = '';
    testVariable1 = '';
    testVariable2 = '';
    errorMessage = 'some error';
    error;

    // @wire(showTestVariable, {testVariable: '$testVariable'})
    // testVariable_fromApex;

    @wire(showTestVariable, {testVariable: '$testVariable'})
    afterTestVariableHandledByApex({data, error}) {
        console.log("-----@wire(showTestVariable, {testVariable: '$testVariable'})");
        if (data) {
            console.log('-----result_fromApex data:', data);
        } else if (error) {
            console.log('-----result_fromApex error: ', JSON.parse(JSON.stringify(error)));
            this.errorMessage = error.body.message;
            this.error = error;
        } else {
            console.log('-----result_fromApex no error, no data');
        }
    }

    @wire(showTestVariable, {testVariable1: '$testVariable1', testVariable2: '$testVariable2'})
    afterTestVariableHandledByApex({data, error}) {
        console.log("-----@wire(showTestVariable, {testVariable1: '$testVariable1', testVariable2: '$testVariable2'})");
        if (data) {
            console.log('-----result_fromApex data:', data);
        } else if (error) {
            console.log('-----result_fromApex error: ', JSON.parse(JSON.stringify(error)));
            this.errorMessage = error.body.message;
            this.error = error;
        } else {
            console.log('-----result_fromApex no error, no data');
        }
    }

    ignoreClose(event) {
        console.log('----- onClick on div ignoreClose(event)');
            event.stopPropagation();
            return false;
        }

    closeError(){
        this.errorMessage = '';
    }

    handleClick(event) {
        console.log('-----handleClick(event)');
        //console.log('-----testVariable2: ', this.testVariable2);
        this.testVariable = event.target.title;
    }

    handleClick1(event) {
        console.log('-----handleClick1(event)');
        //console.log('-----testVariable2: ', this.testVariable2);
        this.testVariable1 = event.target.title;
    }

    handleClick2(event) {
        console.log('-----handleClick2(event)');
        this.testVariable2 = event.target.title;
    }

    handleClick3(event) {
        console.log('-----handleClick3(event)');
        console.log('-----testVariable2: ', this.testVariable2);
        this.testVariable1 = event.target.title;
        this.testVariable2 = event.target.title;
    }
}