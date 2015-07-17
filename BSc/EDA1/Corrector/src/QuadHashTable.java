public class QuadHashTable<T> extends HashTable<T>{
	private static final int tamanhoPorDefeito = 200;
	
	public QuadHashTable(){
		this(tamanhoPorDefeito);
	}
	
	public QuadHashTable(int tamanho) {
		alocarTabela(tamanho);
		tornarVazia();
	}

	//metodo que implementa o acesso quadrático
	protected int procPos(T s){
		int colisoes = 1;
		int posActual = hash(s);
		while(tabela[posActual] != null && !tabela[posActual].elemento.equals(s))
		{
			posActual += colisoes*colisoes; // f(i) = i²
			colisoes += 1;
			if(posActual >= tabela.length)
				posActual = posActual % tabela.length;
		}
		return posActual;
	}

}
