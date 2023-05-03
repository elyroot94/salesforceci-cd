public class UpdateFieldValues {
    /*
     * cette fonction prend en parametre picklistApiName,et la value a ajouter 
     * dans la picklist 
     * ensuite on instancie la classe MetadataService de la library MEtadata-api
     * on recupere la session de l'utilisateur connecter actuellement 
     * 
    */
    @future(callout=true)
    public static void UpdateMetadata(String picklistApiName, String newValue){
        try {
            //on instancie la classe MetadataService de la library MEtadata-api
            MetadataService.MetadataPort service = new MetadataService.MetadataPort();
            service.SessionHeader = new MetadataService.SessionHeader_element();
            //on recupere la session de l'utilisateur connecter actuellement 
            service.SessionHeader.sessionId = UserInfo.getSessionId();
            //on recupere les valeurs de la picklist a l'aide metadata-api
            MetadataService.CustomField customField = (MetadataService.CustomField)
                service.readMetadata('CustomField', new String[]{
                    picklistApiName
                        }).getRecords()[0];
            
            System.debug('customField' + JSON.serialize(customField));
            
            Map<String, String> existingValues = new Map<String, String>();
            //on insert toute les valeurs existantes dans un map 
            for (MetadataService.CustomValue objCustomValue : customField.valueSet.valueSetDefinition.value) {
                
                existingValues.put(objCustomValue.fullName, objCustomValue.label);
            }
            
            //on cree un custom value pour l'ajouter a la picklist 
            MetadataService.CustomValue objCustomValue = new MetadataService.CustomValue();
            objCustomValue.fullName = newValue;
            objCustomValue.label = newValue;
            objCustomValue.default_x = false;
            objCustomValue.isActive = true;
            //si la  nouvelle valeur a ajouter n'existe pas dans la picklist on l'ajouter ensuite on mais ajour la picklist a l'aide de l'api metadata-api
            if (existingValues.get(newValue) == null) {
                customField.valueSet.valueSetDefinition.value.add(objCustomValue);
                
                List<MetadataService.SaveResult> lstResults = service.updateMetadata(new
                                                                                     MetadataService.Metadata[]{
                                                                                         customField
                                                                                             });
                for (MetadataService.SaveResult objResult : lstResults) {
                    if (objResult.success) {
                        System.debug('Successfully updated');
                    } else {
                        if (objResult.errors.size() > 0) {
                            System.debug('erorr : ' + objResult.errors[0].message);
                        }
                    }
                }
            }
        } catch (Exception e){
            System.debug( 'Error for Object '+ picklistApiName+ 'error');
        }
    }
    
    /* public static void updatepicklist(){
         try {
              MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        MetadataService.CustomField customField = new MetadataService.CustomField();
        customField.fullName = 'Lead.Industry';
        customField.label = 'picklist';
        customField.type_x = 'Picklist';
        
        // Define the Value Set and Value Set Definitions
        MetadataService.ValueSet vs = new MetadataService.ValueSet();
        MetadataService.ValueSetValuesDefinition vd = new MetadataService.ValueSetValuesDefinition();
        
        // Define the picklist values
        List<MetadataService.CustomValue> customValues = new List<MetadataService.CustomValue>();
        MetadataService.CustomValue cv1 = new MetadataService.CustomValue();
        cv1.label = 'One';
        cv1.fullName = 'One';
        cv1.isActive = true;
        cv1.default_x = false;
        customValues.add(cv1);
        MetadataService.CustomValue cv2 = new MetadataService.CustomValue();
        cv2.label = 'Two';
        cv2.fullName = 'Two';
        cv2.isActive = true;
        cv2.default_x = true;
        customValues.add(cv2);
        
        
        vd.value = customValues;
        vd.sorted = true;
        
        vs.valueSetDefinition = vd;
        
        // Use valueSet instead of Picklist
        customField.valueSet  = vs;
        
        List<MetadataService.SaveResult> results =
            service.createMetadata(
                new MetadataService.Metadata[] { customField });
         }catch(Exception e){
             System.debug(e);
         }
      
    } */
}