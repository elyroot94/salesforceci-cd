/*
 * le trigger qui se declanche a chaque import d'ub objet Big_Import
*/
trigger TriggerBigPicklist on Big_Import__c (after insert) { 
       for(Big_Import__c  b : Trigger.new) {
        UpdateFieldValues.UpdateMetadata(b.picklist__c,b.value__c);
        }   

}