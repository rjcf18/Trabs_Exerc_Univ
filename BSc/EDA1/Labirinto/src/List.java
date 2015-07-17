
public interface List<T> {
	void add(T x);
	void add(SingleNode<T> prev, T x);
	void set(int i, T x);
	void remove(int i);
	void remove(SingleNode<T> prev);
	T get(int i) throws IndexOutOfBoundsException;
	int size();
}
