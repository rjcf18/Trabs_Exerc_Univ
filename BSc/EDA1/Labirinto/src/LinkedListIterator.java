public class LinkedListIterator<E> implements java.util.Iterator<E> {
	private SingleNode<E> current;

	public LinkedListIterator(SingleNode<E> c){
		current=c;
	}
	public boolean hasNext(){
		return current!=null;
	}


	public E next(){ 
		if (!hasNext())
			throw new java.util.NoSuchElementException("No element");

		E nextItem = current.element() ;
		current = current.getNext();
		return nextItem;
	}

	public void remove(){
		throw new UnsupportedOperationException();
	}
}
