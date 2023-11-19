import { LightningElement } from 'lwc';

export default class RecordEditFormTest extends LightningElement {
    recordId1 = '';
    buttonLabel = 'Create TestObject';
    handleSubmit(event) {
        console.log('-----handleSubmit() event: ', event);
        console.log('-----handleSubmit() event.detail.fields: ', JSON.parse(JSON.stringify(event.detail.fields)) );
    }

    handleSuccess(event) {
        console.log('-----handleSuccess() event: ', event);
        //console.log('-----handleSubmit() event.getParams().response.id: ', event.getParams().response.id);
        //this.recordId1 = event.getParams().response.id
        console.log('-----Id: ', event.detail.id);
        this.recordId1 = event.detail.id
    }

    handleError(event) {
        console.log('-----handleSuccess() event: ', event);
    }

    createError(event) {
        console.log('-----createError() event: ', event);
        this.template.querySelector('[data-id="errorMessage"]').setError('some error message');
    }
}