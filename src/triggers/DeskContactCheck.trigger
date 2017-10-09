/**
 * Created by Adelchi on 09/10/2017.
 */

trigger DeskContactCheck on Case (before insert) {
    List<Case> listCases = new List<Case>();
    List<Contact> contactList = [SELECT Id, email, recordtype.name FROM Contact ];
    /*List<Contact> existingContacts = ContactDiscriminator.checkDatabase(c.suppliedEmail);*/
    Id recTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('SCMT').getRecordTypeId();
    for(Case c : Trigger.new){
        if(!ContactDuplicateCheck.duplicateCheck(c.SuppliedEmail, contactList)){
            Contact cont = new Contact();
            cont.email = c.SuppliedEmail;
            if(c.suppliedName!=null){
                cont.FirstName = c.SuppliedName.split(' ')[0];
                cont.LastName = c.SuppliedName.split(' ')[1];
            }
            cont.RecordTypeId = recTypeId;
            insert cont;
            c.ContactId = cont.Id;
        }else{
            List<Contact> existingContacts = ContactDiscriminator.checkDatabase(c.suppliedEmail);
            for( Contact existingCont : existingContacts) {
                if(existingCont.RecordType.Name == 'SCMT' && existingCont.Email == c.suppliedEmail){
                    c.ContactId = existingCont.Id;
                } else if(existingCont.Email == c.suppliedEmail){
                    c.ContactId = existingCont.Id;
                }
            }
        }
    }
}