public abstract class HashTable<T> {
	public ElementoTabela<T> [] tabela; 
	private int ocupados; //quantas posicoes estao ocupadas na hash actualmente
	
	private boolean estaActivo( int currentPos ){
		return tabela[currentPos] != null && tabela[currentPos].activo;
	}
	
	public int ocupados(){
		return ocupados;
	}
	
	// funcao de hashing optimizada para strings utilizando a regra de Horner 
	// incluindo todos os caracteres na string resultando numa distribuicao razoavel
	// sendo esta uma funcao mais rapida no calculo do hash
	protected int hash(T s){
		int valHash = 0;

		for( int i = 0; i < ((String) s).length(); i++)
			valHash = 37 * valHash + ((String) s).charAt(i);
			
		valHash %= capacidade();
		if( valHash < 0 )
			valHash += capacidade();
		return valHash;
	}
	
	//get do tamanho da tabela
	public int capacidade(){
		return tabela.length;
	}
	
	protected abstract int procPos(T s);
	
	public void alocarTabela(int dim){
		tabela = (ElementoTabela<T>[])new ElementoTabela[proxPrimo(dim)];
	}
	
	private static boolean ePrimo(int n){
        if( n == 1 || n % 2 == 0 )
            return false;
        if( n == 2 || n == 3 )
            return true;
        for( int i = 3; i * i <= n; i += 2 )
            if( n % i == 0 )
                return false;
        
        return true;
    }
	
	private static int proxPrimo( int n ){
        if( n % 2 == 0 )
            n++;

        for(;!ePrimo(n); n += 2 )
            ;
        
        return n;
    }
	
	public void tornarVazia(){
        ocupados = 0;
        for( int i = 0; i < tabela.length; i++)
        	tabela[i] = null;
	}
	
	public boolean procurar(T x){
		int posActual = procPos(x);
		return estaActivo(posActual);
	}
	
	public boolean remove(T x){
		int posActual = procPos(x);
        if(estaActivo(posActual))
        {
            tabela[posActual].activo = false;
            ocupados--;
            return true;
        }
        else
            return false;
	}
	
	public void insere(T x){
		// Insere o elemento x como activo
		int posActual = procPos(x);
		if(estaActivo(posActual))
			return; //se ja estiver na tabela nao faz nada
		tabela[posActual] = new ElementoTabela<T>( x, true );
		ocupados++;
		//System.out.println(Arrays.toString(tabela));
		// faz o rehash se metade da tabela ja estiver ocupada
		if( ocupados > tabela.length / 2 )
			rehash();
	}
	
	public void rehash(){
		ElementoTabela<T> [ ] tabelaAntiga = tabela;
		// Cria uma tabela vazia com o dobro do tamanho que tinha
		alocarTabela(proxPrimo(2*tabelaAntiga.length));
		ocupados = 0;
		// copia a tabela antiga para a nova tabela com o dobro do tamanho
		for( int i = 0; i < tabelaAntiga.length; i++ )
			if(tabelaAntiga[i] != null && tabelaAntiga[i].activo)
				insere(tabelaAntiga[i].elemento);
	}	
	
	public String toString(){
		StringBuffer buffer = new StringBuffer();

	    buffer.append(System.getProperty("line.separator"));
	    buffer.append("{");
	    buffer.append(System.getProperty("line.separator"));

	    for (int i = 0; i < this.tabela.length; i++) {
	    	if (this.tabela[i] != null) {
	    		buffer.append("\t"+this.tabela[i].toString());
	    		buffer.append(System.getProperty("line.separator"));
	    	}
	    }

	    buffer.append("}");

	    return buffer.toString();
	}
	
	public void print(){
		System.out.println("\nHashTable: ");
		System.out.println(toString());
	}
}
