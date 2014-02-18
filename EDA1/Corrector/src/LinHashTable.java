public class LinHashTable<T> extends HashTable<T>{
	private static final int tamanhoPorDefeito = 200;
	
	public LinHashTable(){
		this(tamanhoPorDefeito);
	}
	
	public LinHashTable(int tamanho) {
		alocarTabela(tamanho);
		tornarVazia();
	}
	
	//metodo que implementa o acesso linear
	protected int procPos(T s){
		int colisoes = 1;
		int posActual = hash(s);
		while(tabela[posActual] != null && !tabela[posActual].elemento.equals(s))
		{
			posActual += colisoes; // f(i) = i
			colisoes += 1;
			if(posActual >= tabela.length)
				posActual = posActual % tabela.length;
		}
		
		return posActual;
	}
}
