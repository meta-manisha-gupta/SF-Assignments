public class DateOperations {
    public static Integer getNumberOfWorkingDays(Date fromDate, Date toDate){
        Datetime startDate = datetime.newInstance(fromDate.year(), fromDate.month(), fromDate.day());
        Datetime dueDate = datetime.newInstance(toDate.year(), toDate.month(), toDate.day());
        Integer numberOfWorkingDays = 0;
        while( startDate < dueDate ) {
            Integer dayInWeek = Integer.valueOf(startDate.format('u'));
            if( dayInWeek != 6 && dayInWeek != 7 ) {
                numberOfWorkingDays++;
            }
            startDate = startDate.addDays(1);
        }
        //System.debug(numberOfWorkingDays);
        return numberOfWorkingDays;
    }
}