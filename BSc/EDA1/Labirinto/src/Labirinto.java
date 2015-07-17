import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;


public class Labirinto {

	public static void main(String[] args) throws IndexOutOfBoundsException, EmptyException{
		FileReader fr;
		BufferedReader ler;
		Scanner sc=new Scanner(System.in);
		System.out.println("Insira o nome do ficheiro:\n(O ficheiro deve estar no directorio da pasta src.)\n>>> ");
		String ficheiro = sc.nextLine();
		try{ 
			fr= new FileReader(ficheiro);
			ler = new BufferedReader(fr);
		}
		catch(Exception e){
			System.out.println("Error: File not found.");
			return;
		}

		ListaLabirinto lab= new ListaLabirinto();
		int i=0,  t=0,e=0,count=0;
		char c;
		try{
			while ((i=ler.read())!=-1){
				c= (char)i;
				if(lab.getNumcolunas()==0 && c=='\n'){
					//conta o numero de colunas
					lab.setNumcolunas(count);
				}
				if(c=='('){
					break;
				}

				if (c=='0' || c=='1'){
					count++;
					if (c =='0'){
						lab.addCampo(0);
					}
					else{
						lab.addCampo(1);
					}
				}            

			}
			while ((i=ler.read())!=-1){
				c=(char) i;
				if(c==')'){
					/*quando encontra um fecha parenteses verifica se e o primeiro
					 *  fecha parenteses ou o segundo
					 *  para verificar qual a entrada e saida */
					if(t==0){
						lab.setC_entrada(e);
					}
					else{
						lab.setC_saida(e);
					}
					t=1;
					e=0;
					continue;
				}
				/*quando encontra uma virgula significa que acabou de ler a
				 * linha(de entrada ou saida consoante o valor de t - 0:entrada e 1:saida)*/
				if(c==','){
					if(t==0)
						lab.setL_entrada(e);
					else{
						lab.setL_saida(e);
					}
					e=0;
					continue;
				}

				//verifica se encontra um numero
				if (c>=48 && c<=57){
					e=e+(c-48);}
			}

		}
		catch(IOException x){
			System.out.println("Error reading file.");
		}

		System.out.println("\n"+ lab.toString()+"\n");
		lab.setMoldura();

		System.out.println("Entrada: (" + lab.getL_entrada()+ "," + 
				lab.getC_entrada()+ ")\nSaida:   ("+lab.getL_saida()
				+","+lab.getC_saida()+")\n");


		if(lab.encontraSaida()==null){
			System.out.println("Labirinto sem solucao possivel.");
			System.exit(0);
		}
		lab.stackToOutput();
		System.out.println(lab.getOutput());
	}

}
