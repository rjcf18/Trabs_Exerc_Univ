public class ArrayList <T> implements Iterable<T>{
	private static final int tamPorDefeito = 1;
    
    private T [] aList;
    private int size;
    public ArrayList(){
    	makeEmpty();
	}
    
    public int sizeOf(){
    	return size;
	}
	
    public boolean isEmpty(){
    	return sizeOf() == 0;
	}

    public T get(int ind){
    	if(ind < 0 || ind >= sizeOf())
    		throw new ArrayIndexOutOfBoundsException( "Index " + ind + "; size " + sizeOf());
    	return aList[ind];    
	}
    
    public boolean contains(T x){
    	ArrayListIterator it = new ArrayListIterator();
    	boolean found = false;
    	while(it.hasNext()){
    		T el = it.next();
    		if (el.equals(x)){
    			found = true;
    		}
    	}
		return found;
    }
	 
    public T set(int ind, T novoVal){
    	if(ind < 0 || ind >= sizeOf())
    		throw new ArrayIndexOutOfBoundsException( "Index " + ind + "; size " + sizeOf());
    	T anterior = aList[ind];
    	aList[ind] = novoVal;
    	return anterior;    
	}
    
    public void updateSize(int newCapacity){
    	if( newCapacity < size )
    		return;
    	T [] listAnterior = aList;
    	aList = (T []) new Object[newCapacity];
    	for(int i = 0; i < sizeOf(); i++)
    		aList[i] = listAnterior[i];
	}
	    
    public boolean insert(T x){
    	insert(sizeOf(), x);
    	return true;            
	}
	
    public void insert( int ind, T x){
    	if(aList.length == sizeOf())
    		updateSize(sizeOf()*2 + 1 );

    	for( int i = size; i > ind; i-- )
    		aList[i] = aList[i-1];
    	
    	aList[ind] = x;
    	size++;  
	}
	
    public T remove(int ind){
    	T removedItem = aList[ind];
	    
    	for( int i = ind; i < sizeOf()-1; i++ )
    		aList[i] = aList[i+1];
    	size--;    
	    
    	return removedItem;
	}
    
    public T remove(T x){
    	T removedItem = x;
	    
    	for( int i = 0; i < sizeOf(); i++ )
    		if (aList[i] == x)
    			remove(i);
    	size--;    
    	return removedItem;
	}
	
    public void makeEmpty(){
    	size = 0;
    	updateSize(tamPorDefeito);
	}
	
    public String toString(){
    	StringBuilder sb = new StringBuilder( "[ " );

    	for(T x : this)
    		sb.append( x + ", " );
    	sb = sb.replace(sb.length()-2, sb.length()-1, "]");
    	//sb.append("]");

    	return new String( sb );
	}

    public java.util.Iterator<T> iterator(){
    	return new ArrayListIterator();
	}
	
    private class ArrayListIterator implements java.util.Iterator<T>{
    	private int current = 0;
    	private boolean canRemove = false;
            
    	public boolean hasNext(){
    		return current < sizeOf();
        } 
        
    	public T next(){
    		if(!hasNext())
    			throw new java.util.NoSuchElementException( ); 
                
    		canRemove = true;    
    		return aList[current++];
    	}
         
    	public void remove(){
    		if(!canRemove)
    			throw new IllegalStateException( );
                
    		ArrayList.this.remove(--current);
    		canRemove = false;
    	}
    }
}
