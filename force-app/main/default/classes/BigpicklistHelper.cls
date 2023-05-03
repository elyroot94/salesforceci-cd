public class BigpicklistHelper {
 public static void updatePicklistField(String newValue)
    {
       

      /* MetadataService.MetadataPort service = new MetadataService.MetadataPort();
       MetadataService.CustomField customField = new MetadataService.CustomField();
        customField.fullName = 'Lead.Industry';
        customField.label = 'Industry';
        customField.type_x = 'Picklist';
        metadataservice.Picklist pt = new metadataservice.Picklist();
        pt.sorted= false;
        metadataservice.PicklistValue two = new metadataservice.PicklistValue();
        two.fullName= 'second';
     
        two.default_x=false ;
        metadataservice.PicklistValue three = new metadataservice.PicklistValue();
        three.fullName= 'third';
        three.default_x=false ;
        pt.picklistValues = new list<metadataservice.PicklistValue>{two,three};
        customField.valueSet.valueSetDefinition=pt;
        List<MetadataService.SaveResult> results =
            service.updateMetadata(
                new MetadataService.Metadata[] { customField });
        handleSaveResults(results[0]);
   */  
  }
    
    //@future(callout=true)
    public static void addNewPiklistValue(String value) {
        try{
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.timeout_x =120000;
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        MetadataService.CustomField customFieldOfPO = 
            (MetadataService.CustomField) service.readMetadata('CustomField', new String[] { 'Industry' }).getRecords()[0];    
       MetadataService.CustomValue valueToAdd = new MetadataService.CustomValue();
        valueToAdd.fullName = value;
        valueToAdd.default_x=false;
        valueToAdd.label=value;
        customFieldOfPO.valueSet.valueSetDefinition.value.add(valueToAdd);
        MetadataService.SaveResult result = service.updateMetadata(new MetadataService.Metadata[] 
                                                                   {customFieldOfPO})[0];
        }catch(Exception e){
            System.debug(e);
        }
    }
    
   
    
}