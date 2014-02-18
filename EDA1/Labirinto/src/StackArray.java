public class StackArray<E> {

	private E[] stack;
	private int maxSize;
	private int size;

	public StackArray(int tamanho){
		this.maxSize = tamanho;
		size = 0;
		stack = (E[]) new Object[this.maxSize];

	}
	public void push(E object){
		try{
			if(equals(size, maxSize))
				throw new OverflowException("Stack Cheia");
			else{
				stack[size] = object;
				size++;
			}
		}catch(OverflowException e){
			e.printStackTrace();
		}


	}

	public E top() throws EmptyException {
		if(isEmpty())
			throw new EmptyException("Stack Vazia");
		else{
			return stack[size-1];
		}
	}

	public E pop(){
		E result = null;
		try{
			if(isEmpty())
				throw new EmptyException("Stack Vazia");
			else{
				E element = stack[size -1 ];
				size--;
				result = element;

			}
		}catch(EmptyException e){
			e.printStackTrace();
		}
		return result;
	}

	public int size() {
		if(isEmpty())
			return 0;
		else
			return size;
	}

	public boolean isEmpty() {
		return size == 0;
	}

	public boolean equals(int a, int b){
		return a == b;
	}

	public String toString() {
		int i=0;
		StringBuilder sb= new StringBuilder("");
		sb.append("stack[");

		for(i=0;i<size;i++){
			sb.append(stack[i] + " ");
		}
		return new String(sb+"]");
	}

}
