package Trabalho;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

public class ReadFile {
	public int [] infoProc;
	private static ArrayList<PCB> processos = new ArrayList<PCB> ();
	
	public void read(String f) throws FileNotFoundException{
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
	      // dis.available() devolve 0 quando o ficheiro n�o tem mais linhas.
	      while ((text = br.readLine()) != null) {
	    	  //System.out.println(linha);
	      /* Este switch serve para ver caso a caso em que array e colocada 
	        cada linha com o auxilio de uma variavel incrementadora 'a', ou seja, por 
	        exemplo no caso da primeira linha como linha = 1 vai ser feito o switch para
	        o caso 1 no qual vai ser guardada a primeira linha no primeiro 
	        array de chars e e de seguida incrementada a variavel a continuando o resto 
	        do ciclo desta maneira*/
	    	  
	    	  if (linha == 1) {
	    		  temp = text.split(" ");
	    		  infoProc = new int[temp.length];
  				  //System.out.println(temp.length);
	    		  for (int i = 0; i < temp.length; i++){
	    			  infoProc[i] = Integer.parseInt(temp[i]);
	    		  }
	    	  }
	    	  else{
	    		  temp = text.split(" ");
	    		  p = new PCB(linha-1, 0);
	    		  for (int i = 0; i < temp.length;i++){
	    			  p.pcb.add(Integer.parseInt(temp[i]));
	    		  }
	    		  p.setCicloChegada(p.pcb.remove(0));
	    		  getListaProcessos().add(p);
	    		  //System.out.println(Arrays.toString(p.pcb.toArray()));
	    		  //System.out.println(p.pcb.size());
	    	  }
	    	  
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

	public ArrayList<PCB> getListaProcessos() {
		return processos;
	}

	public void setListaProcessos(ArrayList<PCB> processos) {
		this.processos = processos;
	}
}
