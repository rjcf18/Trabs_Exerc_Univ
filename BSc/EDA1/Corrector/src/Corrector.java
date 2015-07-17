import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.StringTokenizer;

public class Corrector {
	public static LinHashTable<String> dic = new LinHashTable<String>(815166);
	
	// metodo que insere todas as palavras dum ficheiro de texto na hashtable
	public void popularHashTable(String s){
		FileReader fr;
		BufferedReader ler;
		int idk=0;
		try{ 
			fr= new FileReader(s);
			ler = new BufferedReader(fr);
			}
		catch(Exception e){
			System.out.println("Erro: Ficheiro nao existente.");
			return;}
		
		String line="";
		try{
			while ((line = ler.readLine()) != null){
				dic.insere(line);
				idk++;
				//System.out.println(dic.procPos(line));
	        }
	    }
		catch(IOException x){
	            
	    }
		//dic.print();
		System.out.println("Numero Palavras Dicionario: "+ idk);
		System.out.println("Numero Palavras na HashTable: "+dic.ocupados());
		System.out.println("Tamanho da Tabela: " + dic.capacidade());
	}
	
	public void writePalErradas(ArrayList<Tuplo> e) throws IOException{
		FileWriter fw= new FileWriter("palavrasErradas.txt");
		fw.write("#########################################");
		fw.write("\n# Palavras Erradas e respectivas linhas #\n");
		fw.write("#########################################\n\n");
		for (int i=0;i<e.sizeOf();i++) {
			fw.write("Palavra Errada: "+e.get(i).x);
			fw.write("\nEste erro ocorre na linha: "+e.get(i).y);
			fw.write("\n\n");
			//System.out.println("###############PASSOU##############");
		}
		fw.close();
		System.out.println("\nFicheiro com as palavras erradas e respectivas linhas escrito.");
	}
	
	//gera o ficheiro de texto com as sugestoes por insercao de 1 letra
	public void writeSugestoesIns(ArrayList<Tuplo> erradas) throws IOException{
		ArrayList <Tuplo<String, ArrayList<String>>> sugestoesAdc = new ArrayList();
		ArrayList<String> alfabeto = criaAlfabeto();
		ArrayList sug = new ArrayList();
		for (int i = 0; i < erradas.sizeOf();i++){
			sug = adicionaLetra((String) erradas.get(i).x, alfabeto);
			sugestoesAdc.insert(new Tuplo(erradas.get(i).x, sug));
		}
		//System.out.println(sugestoesAd1.toString());
		FileWriter fw= new FileWriter("sugestoesInsercao.txt");
		fw.write("#######################################");
		fw.write("\n# Sugestoes por insercao de uma letra #\n");
		fw.write("#######################################\n");
		for (int i = 0; i<sugestoesAdc.sizeOf();i++){
			fw.write("\nPalavra errada: " + sugestoesAdc.get(i).x);
			fw.write("\n  Sugestoes: \n");
			if (sugestoesAdc.get(i).y.isEmpty()){
				fw.write("    - Nao existem sugestoes para esta palavra.\n");
			}
			else{
				for (String s : sugestoesAdc.get(i).y) {
					fw.write("    -"+s+"\n");
				}
			}
		}
		fw.close();
		System.out.println("Ficheiro com as palavras erradas e respectivas sugestoes por insercao de uma letra.");
	}
	
	//gera o ficheiro de texto com as sugestoes por remocao de 1 letra
	public void writeSugestoesRem(ArrayList<Tuplo> erradas) throws IOException{
		ArrayList <Tuplo<String, ArrayList<String>>> sugestoesRem = new ArrayList();
			
		ArrayList sug = new ArrayList();
		for (int i = 0; i < erradas.sizeOf();i++){
			sug = removeLetra((String) erradas.get(i).x);
			sugestoesRem.insert(new Tuplo(erradas.get(i).x, sug));
		}
		//System.out.println(sugestoesAd1.toString());
		FileWriter fw= new FileWriter("sugestoesRemocao.txt");
		fw.write("########################################");
		fw.write("\n#  Sugestoes por remocao de uma letra  #\n");
		fw.write("########################################\n");
		for (int i = 0; i<sugestoesRem.sizeOf();i++){
			fw.write("\nPalavra errada: " + sugestoesRem.get(i).x);
			fw.write("\n  Sugestoes: \n");
			if (sugestoesRem.get(i).y.isEmpty()){
				fw.write("    - Nao existem sugestoes para esta palavra.\n");
			}
			else{
				for (String s : sugestoesRem.get(i).y) {
					fw.write("    -"+s+"\n");
				}
			}
		}
		fw.close();
		System.out.println("Ficheiro com as palavras erradas e respectivas sugestoes por remocao de uma letra.");
	}
	
	//gera o ficheiro de texto com as sugestoes por troca de 2 letras adjacentes
	public void writeSugestoesTroca(ArrayList<Tuplo> erradas) throws IOException{
		ArrayList <Tuplo<String, ArrayList<String>>> sugestoesTroca = new ArrayList();
			
		ArrayList sug = new ArrayList();
		for (int i = 0; i < erradas.sizeOf();i++){
			sug = trocaLetras((String) erradas.get(i).x);
			sugestoesTroca.insert(new Tuplo(erradas.get(i).x, sug));
		}
		//System.out.println(sugestoesAd1.toString());
		FileWriter fw= new FileWriter("sugestoesTroca.txt");
		fw.write("####################################");
		fw.write("\n# Sugestoes por troca de uma letra #\n");
		fw.write("####################################\n");
		for (int i = 0; i<sugestoesTroca.sizeOf();i++){
			fw.write("\nPalavra errada: " + sugestoesTroca.get(i).x);
			fw.write("\n  Sugestoes: \n");
			if (sugestoesTroca.get(i).y.isEmpty()){
				fw.write("    - Nao existem sugestoes para esta palavra.\n");
			}
			else{
				for (String s : sugestoesTroca.get(i).y) {
					fw.write("    -"+s+"\n");
				}
			}
		}
		fw.close();
		System.out.println("Ficheiro com as palavras erradas e respectivas sugestoes por troca de letras adjacentes.");
	}
	
	/* devolve uma ArrayList com as palavras erradas e a respectiva linha para 
	 * o ficheiro que recebe como argumento, de acordo com a hashtable */ 
	public ArrayList<Tuplo> palavrasErradas(String ficheiro){
		
		ArrayList<Tuplo> listaPalavras = new ArrayList();
		FileReader fr;
		BufferedReader ler;
		int linha=0;
		try{ 
			fr= new FileReader(ficheiro);
			ler = new BufferedReader(fr);
		}
		catch(Exception e){
			System.out.println("Erro: Ficheiro nao existente.");
			return null;
		}
		
		String slinha = "";
		try {
			while ((slinha = ler.readLine()) != null){
				linha++;
				StringTokenizer st = new StringTokenizer(slinha, "\t\r\n ,.'");
				while(st.hasMoreElements())
				{
					/*e criada uma arraylist com todas as palavras e as 
					 * respectivas linhas no texto que e suposto corrigir */
					listaPalavras.insert(new Tuplo<String, Integer>(st.nextToken(), linha));
				}
			}
		} catch (IOException e) {
		
		}
		/* cria uma arraylist com o tuplo (palavra, sugestoes) com uma arraylist
		 * com as sugestoes para a palavra que lhe esta associada */
		ArrayList<Tuplo> erradas = new ArrayList();
		for (Tuplo t : listaPalavras) {
			if(!dic.procurar((String) t.x)){
				erradas.insert(t);
			}
		}
	    
		//System.out.println(erradas.toString());
		return erradas;
	}
	
	//cria o alfabeto de acordo com as palavras que se encontram na hashtable
	public ArrayList<String> criaAlfabeto(){
		ArrayList<String> alfabeto = new ArrayList<String> ();
		String letra;
		
		/* constroi uma arraylist com todas as letras do alfabeto segundo o 
		 * dicionario a ser utilizado, incluindo caracteres especiais*/
		for (int i = 0; i<dic.capacidade(); i++){
			if (dic.tabela[i] != null){
				for (int l = 0; l< dic.tabela[i].elemento.length();l++){
					letra = Character.toString(dic.tabela[i].elemento.charAt(l));
					if (!alfabeto.contains(letra) && letra!=" "){
						alfabeto.insert(letra);
					}
				}
			}		
		}
		
		alfabeto.remove(" ");
		return alfabeto;
	}
	
	//devolve as correccoes da palavra que recebe como arg por adicao de 1 letra
	public ArrayList<String> adicionaLetra(String palavra, ArrayList<String> alfabeto){
		ArrayList<String> correccoes = new ArrayList<String> ();
		String novaPal = palavra;
		for (int l = 0; l < alfabeto.sizeOf();l++){
			for (int i = 0; i <= palavra.length();i++){
				novaPal = new StringBuilder(palavra).insert(i, alfabeto.get(l)).toString();
				if(dic.tabela[dic.procPos(novaPal)] != null)
					correccoes.insert(novaPal);
			}
		}
		return correccoes;
		//System.out.println(correccoes.toString());
		//System.out.println(alfabeto.toString());
		
	}
	//devolve as correccoes da palavra que recebe como arg por remocao de 1 letra
	public ArrayList<String> removeLetra(String palavra){
		ArrayList<String> correccoes = new ArrayList<String> ();
		String novaPal = palavra;
		for (int i = 0; i < palavra.length();i++){
			novaPal = new StringBuilder(palavra).deleteCharAt(i).toString();
			if(dic.tabela[dic.procPos(novaPal)] != null && !correccoes.contains(novaPal))
				correccoes.insert(novaPal);
		}
		
		//System.out.println(correccoes);
		return correccoes;
	}
	
	//devolve as correccoes da palavra que recebe como arg por troca de letras
	public ArrayList<String> trocaLetras(String palavra){
		ArrayList<String> correccoes = new ArrayList<String> ();
		char[] p; 
		String novaPal;
		for (int i = 0; i < palavra.length();i++){
			if(i+1!=palavra.length()){
				//converte a string para um array de chars 
				// e troca os caracteres adjacentes
				p = palavra.toCharArray();
				char tmp = p[i];
				p[i] = p[i+1];
				p[i+1] = tmp;
				novaPal = String.valueOf(p);
				if(dic.tabela[dic.procPos(novaPal)] != null && !correccoes.contains(novaPal))
					correccoes.insert(novaPal);
			}
		}
		
		//System.out.println(correccoes);
		return correccoes;
	}
	
	//gera todo o output pretendido
	public void geraOutput() throws IOException{
		/*Scanner sc=new Scanner(System.in);
		System.out.println("Insira o dicionario que deseja usar para o corrector ortografico:\n(do tipo dicionario.dic)\n>>> ");
		String dicionario = sc.nextLine();
		
		sc=new Scanner(System.in);
		System.out.println("Insira o nome do ficheiro de texto que deseja corrigir:\n(do tipo ficheiro.txt)\n>>> ");
		String texto = sc.nextLine();
		
		popularHashTable(dicionario);
		ArrayList <Tuplo> erradas = palavrasErradas(texto);*/
		
		popularHashTable("portugues.dic");
		ArrayList <Tuplo> erradas = palavrasErradas("texto1.txt");
		writePalErradas(erradas);
		writeSugestoesIns(erradas);
		writeSugestoesRem(erradas);
		writeSugestoesTroca(erradas);
		System.out.println("\nOutput gerado.");
	}
	
	public static void main(String[] args) throws IOException{
		Corrector corrector = new Corrector();
		
		corrector.geraOutput();
		
		
		//t.trocaLetras("vriações");
	}

}
