public class Stack {
	private List<Integer> stack;
    
    public Stack(){
        stack = new List<Integer>();
    }
    
    public void push(Integer item){
        stack.add(item);
    }
    
    public Integer pop(){
        if(!stack.isEmpty()){
            return stack.remove(stack.size() - 1);
        }
        return null;
    }
}