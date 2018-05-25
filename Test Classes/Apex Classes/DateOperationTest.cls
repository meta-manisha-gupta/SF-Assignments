@IsTest
public class DateOperationTest {
    public static testmethod void testGetNumberOfWorkingDaysShouldReturn() {
        Date date1 = Date.newInstance(2018, 2, 26);
		Date date2 = Date.newInstance(2018, 3, 27);
		Integer actualNumberOfWorkingDays = DateOperations.getNumberOfWorkingDays(date1, date2);
		Integer expectedNumberOfWorkingDays = 21;
        System.assertEquals(expectedNumberOfWorkingDays, actualNumberOfWorkingDays);
    }
    public static testmethod void testGetNumberOfWorkingDaysShouldNotReturn() {
        Date date1 = Date.newInstance(2018, 5, 13);
		Date date2 = Date.newInstance(2018, 6, 1);
		Integer actualNumberOfWorkingDays = DateOperations.getNumberOfWorkingDays(date1, date2);
        System.debug('output->>>>>'+actualNumberOfWorkingDays);
		Integer expectedNumberOfWorkingDays = 15;
        System.assertNotEquals(expectedNumberOfWorkingDays, actualNumberOfWorkingDays);
    }
}