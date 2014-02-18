
public interface Stack<E> {
	public void push(E o);
	public E top() throws EmptyException;
	public E pop() throws EmptyException;
	public int size();
	public boolean empty();
}
