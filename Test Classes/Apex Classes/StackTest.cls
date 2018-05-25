@IsTest
public class StackTest {
    public static Stack stackInstance;
    public static testmethod void testPush(){
        stackInstance = Stack.getInstance();
        stackInstance.initiateStack();
        stackInstance.push(10);
        stackInstance.push(20);
        List<Integer> expectedStack = new List<Integer>();
        expectedStack.add(10);
        expectedStack.add(20);
        List<Integer> actualStack = stackInstance.stack;
        System.assertEquals(expectedStack, actualStack);
    }
    public static testmethod void testPop(){
        stackInstance = Stack.getInstance();
        stackInstance.initiateStack();
        stackInstance.push(10);
        stackInstance.push(20);
        Integer actual = stackInstance.pop();
        Integer expected = 20;
        System.assertEquals(expected, actual);
    }
}