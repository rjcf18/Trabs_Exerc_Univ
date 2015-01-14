package Trab2;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

import Trabalho.PCB;
import Trabalho.ReadFile;

public class GestProg {
	private static ArrayList<PCB> processos = new ArrayList<PCB> ();
	
	public GestProg(){
		
	}
	public void readFile(String f) throws FileNotFoundException{
		PCB p;
		/* aqui e colocado o caminho do ficheiro a utilizar, de seguida sao criadas
  	  variaveis para receber e processar o input*/
	    File ficheiro = new File(f);
	    BufferedReader br = null;

	    int linha = 1;
		String[] temp;
		
	    try {
	      br = new BufferedReader(new FileReader(ficheiro));
	      String text;
	     
	      while ((text = br.readLine()) != null) {
	    	 
	    	  temp = text.split(" ");
    		  p = new PCB(linha, 0);
    		  for (int i = 0; i < temp.length;i++){
    			  p.pcb.add(Integer.parseInt(temp[i]));
    		  }
    		  p.setCicloChegada(p.pcb.remove(0));
    		  processos.add(p);
    		  System.out.println(Arrays.toString(p.pcb.toArray()));
	    	  
	    	linha += 1;
	      }
	     
	      // terminar todos os recursos depois de acabar de ler o ficheiro
	      br.close();


	    } catch (FileNotFoundException e) {
	      e.printStackTrace();
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
		
	 }
	
	public static void main(String[] args) throws FileNotFoundException{
		String s = "";
		Scanner sc = new Scanner(System.in);
		System.out.println("Insira o caminho(directoria) do ficheiro de texto:");
		s = sc.nextLine();
		GestProg g = new GestProg();
		g.readFile(s);
	}
}
