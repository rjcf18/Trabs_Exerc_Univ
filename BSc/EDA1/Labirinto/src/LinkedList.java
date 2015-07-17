import java.util.Iterator;

public class LinkedList<T> implements Iterable<T>,List<T>{
	private SingleNode<T> header, tail;
	private int size;

	public LinkedList(){
		tail=header=new SingleNode<T>();
		size=0;
	}
	public java.util.Iterator<T> iterator(){
		return (Iterator<T>)new LinkedListIterator<T>(header.next);
	}
	public int size(){
		return size;
	}
	public boolean isEmpty(){
		return size==0;
	}
	public SingleNode<T> header(){
		return header;
	}
	public void add(SingleNode<T> prev, T x){
		SingleNode<T> newNode= new SingleNode<T>(x,prev.getNext());
		prev.setNext(newNode);
		tail=newNode;
		size++;
	}
	public void add(T x){
		add(tail, x);
	}

	public void remove(SingleNode<T> prev){
		prev.setNext(prev.getNext().getNext());
		size--;
	}
	SingleNode<T> getNode(int i){
		int index=-1;
		SingleNode<T> s=header();
		while(index++<i)
			s=s.getNext();
		return s;
	}
	public void remove(int index){ //try{ remove.....} catch ( exception e)}
		remove(getNode(index-1));
	}
	SingleNode<T> findPrevious(T x){ 
		SingleNode<T> p= header();
		for(T v:this){
			if (v.equals(x)) 
				return p;
			else
				p=p.getNext();
		}
		throw new java.util.NoSuchElementException("No element");
	}

	public String toString(){
		StringBuilder sb= new StringBuilder("");
		for(T x: this)
			sb.append(x + " ");
		return new String(sb);
	}

	public void set(int index, T x){
		getNode(index).setElement(x);
	}

	public T get(int ind) throws IndexOutOfBoundsException{
		if(ind>=0 && ind <=size()-1)
			return getNode(ind).elemento;
		else
			throw new IndexOutOfBoundsException ("getNode index:"+ ind +";size:"+size());
	}

}
