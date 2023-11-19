import { LightningElement, api } from 'lwc';

export default class MtmErrorMessage extends LightningElement {

    @api errorMessage;

    closeError(){
        this.dispatchEvent(new CustomEvent("closeerror"));
    }

    ignoreClose(event) {
         event.stopPropagation();
         return false;
    }
}