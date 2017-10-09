/**
 * Created by Adelchi on 07/10/2017.
 */

public with sharing class ContactDuplicateCheck {
    Private static boolean isDupe = False;

    public static boolean duplicateCheck(String caseEmail, List<Contact> contactList){
        for(Integer i=0; i<contactList.size(); i++){
            if(contactList[i].email==caseEmail){
                isDupe = True;
            }
        }
         return isDupe;
    }

}