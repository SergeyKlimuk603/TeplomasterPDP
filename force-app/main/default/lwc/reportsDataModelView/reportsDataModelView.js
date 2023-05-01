import { LightningElement } from 'lwc';
import DATA_MODEL from '@salesforce/resourceUrl/ReportsDataModel'

export default class ReportsDataModelView extends LightningElement {
    dataModel = DATA_MODEL;
}