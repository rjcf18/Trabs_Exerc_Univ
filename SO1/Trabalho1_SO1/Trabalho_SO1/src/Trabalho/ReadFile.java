package Trabalho;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

public class ReadFile {
	int linha = 0;
	char[] temp;
	int infoProc;
	
	public ReadFile(int [] t, String f) throws FileNotFoundException{
		/* aqui é colocado o caminho do ficheiro a utilizar, de seguida são criadas
  	  variáveis para O FileInputStream, BufferedInputStream e DataInputStream para
  	  facilitar a leitura e não causar muita confusão com nomes muito extensos.*/
	    File ficheiro = new File(f);
	    FileInputStream fis = null;
	    BufferedInputStream bis = null;
	    DataInputStream dis = null;

	    try {
	      fis = new FileInputStream(ficheiro);
	      bis = new BufferedInputStream(fis);
	      dis = new DataInputStream(bis);

	      // dis.available() devolve 0 quando o ficheiro não tem mais linhas.
	      while (dis.available() != 0) {

	      /* Este switch serve para ver caso a caso em que array é colocada 
	        cada linha com o auxilio de uma variavel incrementadora 'a', ou seja, por 
	        exemplo no caso da primeira linha como linha = 1 vai ser feito o switch para
	        o caso 1 no qual vai ser guardada a primeira linha no primeiro 
	        array de chars e é de seguida incrementada a variavel a continuando o resto 
	        do ciclo desta maneira*/
	    	switch(linha) {
	    		case 1: temp = dis.readLine().toCharArray();
	    				for (int i = 0; i < temp.length; i++){
	    					infoProc = (int)temp[i];
	    				}
	    				break;
	    		case 2: temp = dis.readLine().toCharArray();
	    				PCB p1 = new PCB(1,"New", temp.length);
	    				for (int i = 1; i < temp.length; i++){
	    					p1.arrayPCB[1] = (int)temp[i];
	    				}
	    				break;
	    		case 3: temp = dis.readLine().toCharArray();
			    		PCB p2 = new PCB(2,"New", temp.length);
						for (int i = 1; i < temp.length; i++){
							p2.arrayPCB[1] = (int)temp[i];
						}
						break;
	    		case 4: temp = dis.readLine().toCharArray();
			    		PCB p3 = new PCB(3,"New", temp.length);
						for (int i = 1; i < temp.length; i++){
							p3.arrayPCB[1] = (int)temp[i];
						}
						break;
	    	}
	    	
	    	linha += 1;
	      }

	      // terminar todos os recursos depois de acabar de ler o ficheiro
	      fis.close();
	      bis.close();
	      dis.close();

	    } catch (FileNotFoundException e) {
	      e.printStackTrace();
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
	    // Este for é para testar se as linhas ficaram de facto guardadas nos arrays
	    /*for (int i = 0; i < proc1.length; i++){
	    	System.out.println(proc1[i]);
	    }*/
	 }
	
}
