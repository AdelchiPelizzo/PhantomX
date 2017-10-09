/**
 * Created by Adelchi on 08/10/2017.
 */

public with sharing class ContactDiscriminator {
    public static List<Contact> checkDatabase(String email){
        List<Contact> listCont = [SELECT Id, RecordType.Name, Email FROM Contact];
        List<Contact> listOfExistingContacts = new List<Contact>();
        for(Contact c : listCont){
            if(c.RecordType.Name == 'SCMT'){
                listOfExistingContacts.add(c);
            }
        }
        return listOfExistingContacts;
    }
}