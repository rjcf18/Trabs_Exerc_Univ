import java.util.ArrayList;

public class PedraDomino implements Pedras{
	private int ladoDir, ladoEsq;
	private static ArrayList <PedraDomino> todasP = new ArrayList<PedraDomino> ();
	
	public PedraDomino(int lE, int lD){
		ladoEsq = lE;
		ladoDir = lD;
	}
	
	public void setLadoDir(int lD){
		ladoDir = lD;
	}
	
	public void setLadoEsq(int lE){
		ladoEsq = lE;
	}
	
	public int getLadoDir(){
		return ladoDir;
	}
	
	public int getLadoEsq(){
		return ladoEsq;
	}
	
	public int getTotalPontos(){
		return (getLadoEsq() + getLadoDir()); 
	}
	
	public boolean eDuplo(){
		return (getLadoEsq() == getLadoDir());
	}

	public String pedraToString(){
		return "["+getLadoEsq()+"-"+getLadoDir()+"]";
	}

	public static ArrayList<PedraDomino> todas(int n){
		for(int i = 0; i <= n; i++){
			for(int j = 0; j <= i; j++){
				todasP.add(new PedraDomino(i,j));
			}
		}
		return todasP;
	}

}
