public class DoubleHashTable<T> extends HashTable<T>{
	
	private static final int tamanhoPorDefeito = 200;
	
	public DoubleHashTable(){
		this(tamanhoPorDefeito);
	}
	
	public DoubleHashTable(int tamanho) {
		alocarTabela(tamanho);
		tornarVazia();
	}
	
	//segunda funcao de hash
	protected int hash2(T s){
		int valHash = 0;
		for( int i = 0; i < ((String) s).length( ); i++ )
			valHash += ((String) s).charAt( i );
		return valHash % capacidade();
	}
	
	//metodo que implementa o acesso linear
	protected int procPos(T s){
		int colisoes = 1;
		int posActual = hash(s); // primeira funcao de hash
		int segHash = hash2(s);// segunda funcao de hash
		while(tabela[posActual] != null && !tabela[posActual].elemento.equals(s))
		{
			posActual += colisoes*segHash; // f(i) = i*hash2(s)
			colisoes += 1;
			if(posActual >= tabela.length)
				posActual = posActual % tabela.length;
		}
		return posActual;
	}
}
