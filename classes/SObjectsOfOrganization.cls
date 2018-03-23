public class SObjectsOfOrganization {
    public static void getListOfsObjectInOrganization(){
        List<Schema.SObjectType> listOfSObjects = Schema.getGlobalDescribe().values();
        for(Schema.SObjectType s : listOfSObjects ){
            System.debug(s.getDescribe().getLabel());
        }
    }
}