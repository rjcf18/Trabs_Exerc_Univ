public class SingleNode<T> {
	T elemento;
	SingleNode<T> next;

	public SingleNode(T e){
		elemento=e;
		next=null;
	}
	public SingleNode(){
		this(null);
	}
	public SingleNode(T e , SingleNode<T> n){
		elemento=e;
		next=n;
	}
	public T element(){
		return elemento;
	}
	public void setElement(T e){
		this.elemento=e;
	}
	public void setNext(SingleNode<T> n){
		next=n;
	}
	public SingleNode<T> getNext(){
		return next;
	}

}
