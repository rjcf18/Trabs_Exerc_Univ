public class ListaLabirinto {
	private String output = "Caminho: "; // variavel que ira conter o o fluxo do caminho no labirinto(cima,baixo, esq, dir)

	//Lista ligada que ira conter os valores lidos do ficheiro de texto
	private LinkedList<Campo> labirinto;

	// variaveis para as coordenadas de entrada e de saida e para o numero de colunas
	private int l_entrada,c_entrada,l_saida,c_saida, numcolunas;

	StackArray<Integer> lastVis = new StackArray<Integer>(100); //stack que guarda os indices da lista do labirinto

	//construtor que inicializa uma nova instancia de uma ListaLabirinto
	public ListaLabirinto(){
		labirinto = new LinkedList<Campo>();
		numcolunas=0;
	}

	public LinkedList<Campo> getLabirinto() {
		return labirinto;
	}

	public void setLabirinto(LinkedList<Campo> labirinto) {
		this.labirinto = labirinto;
	}

	public int getNumcolunas() {
		return numcolunas;
	}

	public void setNumcolunas(int numcolunas) {
		this.numcolunas = numcolunas;
	}

	public String getOutput() {
		return output;
	}

	public void setOutput(String output) {
		this.output = output;
	}

	public int getL_entrada() {
		return l_entrada;
	}

	public void setL_entrada(int l_entrada) {
		this.l_entrada = l_entrada;
	}


	public int getC_entrada() {
		return c_entrada;
	}


	public void setC_entrada(int c_entrada) {
		this.c_entrada = c_entrada;
	}


	public int getL_saida() {
		return l_saida;
	}


	public void setL_saida(int l_saida) {
		this.l_saida = l_saida;
	}


	public int getC_saida() {
		return c_saida;
	}


	public void setC_saida(int c_saida) {
		this.c_saida = c_saida;
	}

	// metodo que adiciona campos (posicoes) com o valor igual a zero ou um na lista do labirinto
	public void addCampo(int i){
		if(i==0){
			labirinto.add(new Campo(0));
		}
		else{
			Campo n=new Campo(1);
			n.setValido(false);
			labirinto.add(n);
		}
	}

	//metodo que serve para colocar uma frame (moldura) à volta do labirinto inserindo 1's no inicio e fim de cada linha e coluna
	// isto serve para garantir que o caminho percorrido nao salta de uma linha para outra visto que os elementos estao todos dispostos
	// linearmente num lista ligada
	public void setMoldura()throws IndexOutOfBoundsException{
		LinkedList<Campo> la=labirinto;
		int i,j,temp=0;
		this.labirinto = new LinkedList<Campo>(); 
		for(i=0;i<numcolunas+2;i++){
			addCampo(1);
		}
		for(j=0;j*numcolunas<la.size();j++){
			addCampo(1);
			for(i=0;i<numcolunas;i++){

				labirinto.add(la.get(temp++));
			}
			addCampo(1);
		}

		for(i=0;i<(numcolunas+2);i++){
			addCampo(1);
		}
		setNumcolunas(numcolunas+2);
	}
	
	/**Os proximos 5 metodos (get_cima,get_baixo,get_esquerda e get_direita) 
	 * irao devolver o valor do campo acima,abaixo, à esquerda e à direita 
	 * do campo actual e o ultimo devolve o campo actual multiplicando a linha 
	 * actual pelo numero de colunas e somando a coluna actual  **/
	public int get_cima(int c, int l)throws IndexOutOfBoundsException{
		return calcValActual(c, l-1);
	}
	
	public int get_baixo(int c, int l)throws IndexOutOfBoundsException{
		return calcValActual(c, l+1);
	}
	
	public int get_esquerda(int c, int l)throws IndexOutOfBoundsException{
		return calcValActual(c-1, l);
	}
	
	public int get_direita(int c,int l) throws IndexOutOfBoundsException{
		return calcValActual(c+1, l);  
	}
	
	public int calcValActual(int c, int l) throws IndexOutOfBoundsException{
		return getLabirinto().get(l*numcolunas+c).getValor();
	}
	
	/**Metodo cujo objectivo e o de inverter a ordem do caminho na stack fazendo o pop
	da stack do caminho para outra stack na qual iremos pegar no valor no topo(entrada) 
	e compara-lo com os restantes elementos da stack construindo assim a string do output. **/
	public void stackToOutput() throws IndexOutOfBoundsException, EmptyException{
		StackArray<Integer> temp1 = lastVis;
		StackArray<Integer> temp2 = new StackArray<Integer>(100);
		int valTemp;
		while(!temp1.isEmpty()){
			temp2.push(temp1.pop());
		}
		valTemp = temp2.top();
		temp2.pop();
		while(!temp2.isEmpty()){
			if (temp2.top() == valTemp+1){
				setOutput(output += "Direita ---->");
			}
			else if (temp2.top() == valTemp-1){
				setOutput(output += "Esquerda ---->");
			}
			else if (temp2.top() == valTemp-numcolunas){
				setOutput(output += "Cima ---->");
			}
			else if (temp2.top() == valTemp+numcolunas){
				setOutput(output += "Baixo ---->");
			}
			valTemp = temp2.top();
			temp2.pop();

		}
		setOutput(output.substring(0, (output.length()-1)-5));
	}

	/**Metodo que ira encontrar o caminho da entrada ate a saida do labirinto devolvendo a stack
	 *  com os indices dos campos do caminho que se encontram na linked list **/
	public StackArray<Integer> encontraSaida() throws IndexOutOfBoundsException, EmptyException{
		int current_c=c_entrada+1,current_l=l_entrada+1;
		int t=-1; // variavel que ira conter os elem
		
		// a variavel incEnd serve apenas para controlar quando
		// nao e possivel encontrar caminho para um determinado labirinto.
		int incEnd = 0;

		while(true){
			if(current_c==getC_saida()+1 && current_l==getL_saida()+1){
				break;
			}
			 
			incEnd = 0;

			//Ira ser verificado se e possivel achar caminho em cada uma das direccoes
			
			
			/*Aqui a ordem de prioridades definida por nos foi: 1º - Esquerda, 2º - Baixo, 3º - Direita e 4º - Cima
			 * ou seja, o primeiro campo a ser verificado e o que esta a esquerda*/
			t=get_esquerda(current_c, current_l);
			//se o campo for valido vai ser verificado se ja foi visitado
			// (um campo ser valido significa que o valor que contem e um zero)
			// Para se verificar o elemento que esta a esquerda basta subtrair um a coluna pois este esta na coluna anterior e na mesma linha 
			if(labirinto.get(current_l*(numcolunas)+(current_c-1)).isValido()){
				if(!labirinto.get(current_l*(numcolunas)+(current_c-1)).isJavisitado()){//verifica se a casa abaixo nao ta na stack
					labirinto.get(current_l*(numcolunas)+(current_c)).setJavisitado(true);
					lastVis.push(current_l*(numcolunas)+(current_c--));
					continue;
				}
			}  
			else{
				incEnd++;
			}


			/*proximo lado a ser verificado e para baixo. Para se verificar o elemento que
			 * esta abaixo basta somar um a coluna pois este esta na mesma coluna
			 * e na linha seguinte*/
			t=get_baixo(current_c, current_l);
			if(labirinto.get((current_l+1)*(numcolunas)+(current_c)).isValido()){
				if(!labirinto.get((current_l+1)*(numcolunas)+(current_c)).isJavisitado()){//verifica se a casa abaixo nao ta na stack
					labirinto.get(current_l*(numcolunas)+(current_c)).setJavisitado(true);
					lastVis.push((current_l++)*(numcolunas)+current_c);
					continue;
				}
			}	
			else{
				incEnd++;
			}

			/*proximo lado a ser verificado e a direita. Para se verificar o elemento que
			 * esta a direita basta somar um a coluna pois este esta na coluna
			 * seguinte e na mesma linha*/
			t=get_direita(current_c, current_l);
			if(labirinto.get(current_l*(numcolunas)+(current_c+1)).isValido()){
				if(!labirinto.get(current_l*(numcolunas)+(current_c+1)).isJavisitado()){//verifica se a casa � direita nao ta na stack
					labirinto.get(current_l*(numcolunas)+(current_c)).setJavisitado(true);
					lastVis.push(current_l*(numcolunas)+(current_c++));
					continue;
				}
			}  
			else{
				incEnd++;
			}

			/*proximo lado a ser verificado e para cima. Para se verificar o elemento que
			 * esta acima basta somar um a coluna pois este esta na mesma coluna
			 * e na linha anterior*/
			t=get_cima(current_c, current_l);
			if(labirinto.get((current_l-1)*(numcolunas)+(current_c)).isValido()){
				if(!labirinto.get((current_l-1)*(numcolunas)+(current_c)).isJavisitado()){//verifica se a casa acima nao ta na stack
					labirinto.get(current_l*(numcolunas)+(current_c)).setJavisitado(true);
					lastVis.push((current_l--)*(numcolunas)+current_c);
					continue;
				}
			}  
			else{
				incEnd++;
			}

			//se a variavel incrementadora incEnd chega a 4 significa que a stack esta vazia
			// e que nao ha mais caminho possivel a percorrer para encontrar a saida 
			if(incEnd == 4){
				return null;
			}
			
			//Nao sendo possivel ir em nenhuma outra direccao e colocado o campo
			//como invalido(como se tivesse um) e e feito o pop ate a ultima posicao com algum caminho possivel
			labirinto.get(current_l*(numcolunas)+current_c).setValido(false);
			t=lastVis.pop();
			current_l=t/(numcolunas);
			current_c=t-((numcolunas)*current_l);
			t=-1;
		}
		lastVis.push((current_l)*(numcolunas)+current_c);

		return lastVis;
	}

	/**Metodo toString que devolve uma representacao em String do labirinto contido na linked list **/
	public String toString() {
		StringBuilder sb= new StringBuilder("");
		int temp=0;
		for(Campo x: labirinto){
			if(temp==numcolunas){
				sb.append("\n");
				temp=0;
			}
			sb.append(x.toString() + " ");
			temp++;
		}

		return new String(sb);
	}

}
