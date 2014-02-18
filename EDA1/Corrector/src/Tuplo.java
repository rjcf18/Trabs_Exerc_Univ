public class Tuplo <X, Y> { 
	public final X x; 
	public final Y y; 
	
	public Tuplo(X x, Y y) {
		this.x = x;
		this.y = y; 
	}

	public String toString(){
		return "("+x+","+y+")";
	}
}
