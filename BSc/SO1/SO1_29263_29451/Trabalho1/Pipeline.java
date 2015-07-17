package Trabalho;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Queue;
import java.util.Scanner;
import java.util.LinkedList;
public class Pipeline {
	
	public static final int PRE_ESTADO = 0;
	public static final int ESTADO_NEW = 1;
	public static final int ESTADO_READY = 2;
	public static final int ESTADO_RUN = 3;
	public static final int ESTADO_BLOCK = 4;
	public static final int ESTADO_EXIT = 5;
	
	public int tempRUN = 4;
	public int tempBLOCK = 3;
	
	public int cycle;
	public boolean running;
	public static LinkedList<PCB>[] estado;
	public int numOfProcess;
	
	public Pipeline(int numP){
		cycle = 0;
		running =  true;
		numOfProcess = numP;
		estado = new LinkedList[6];
		for (int i = 0; i < estado.length; i++){
			estado[i] = new LinkedList<PCB> ();
		}
	}
	
	public void run(){
		
		while(running){
			// faz todos os processos avancarem um ciclo e trata de todas as transicoes entre estados
			for(int i = 0; i < estado.length; i++){
				switch (i) {
					case Pipeline.PRE_ESTADO:{
						preEstadoToNew();
					}
					break;
					case Pipeline.ESTADO_NEW:{
						if (Pipeline.estado[ESTADO_READY].size() <= 2){
							estadoNewToReady();
						}
					}
					break;
					case Pipeline.ESTADO_READY:{
						if (Pipeline.estado[ESTADO_RUN].isEmpty()){
							estadoReadyToRun();
						}
						
					}
					break;
					case Pipeline.ESTADO_RUN:{
						estadoRunToReady();
					}
					break;
					case Pipeline.ESTADO_EXIT:{
						estadoExit();
					}
					break;
					
					default:
						break;
					}
				}
			/*if (cycle == 3){
				System.out.println(Pipeline.estado[PRE_ESTADO].size());
				System.out.println(Pipeline.estado[ESTADO_NEW].size());
				System.out.println(Pipeline.estado[ESTADO_READY].size());
				System.out.println(Pipeline.estado[ESTADO_RUN].size());
				System.out.println(Pipeline.estado[ESTADO_BLOCK].size());
				System.out.println(Pipeline.estado[ESTADO_EXIT].size());
				//          /home/rjcf18/workspace/SO1/src/Trabalho/trabalho.txt
				break;
			}*/
			cycle++;
			
		}
		System.out.println("Gestao de processos terminada.\nForam executados todos os processos.");
		
	}
	
	public void preEstadoToNew(){
		// Evita que o processo avance para o proximo estado
		// antes da altura correcta
		if (!estado[PRE_ESTADO].isEmpty()){
			if(estado[PRE_ESTADO].peek().getCicloChegada() == cycle){
				PCB process = estado[PRE_ESTADO].poll();
				process.setEstado(ESTADO_NEW);
				if(process != null)
					estado[ESTADO_NEW].add(process);
			}
		}
		
	}
	
	public void estadoNewToReady(){
		// Evita que o processo avance para o proximo estado
		// antes da altura correcta
		if(!estado[ESTADO_NEW].isEmpty()){
			if(estado[ESTADO_NEW].peek().getCicloActual() < cycle){
				PCB process = estado[ESTADO_NEW].poll();
				if(process != null){
					process.setCicloActual(process.getCicloActual()+1);
					process.setEstado(ESTADO_READY);
					estado[ESTADO_READY].add(process);
				}
			}
		}
	}
	
	public void estadoReadyToRun(){
		// Evita que o processo avance para o proximo estado
		// antes da altura correcta
		//System.out.println(Pipeline.estado[ESTADO_READY].size());
		if(!estado[ESTADO_READY].isEmpty()){
			if(estado[ESTADO_READY].peek().getCicloActual() < cycle){
				PCB process = estado[ESTADO_READY].poll();
				if(process != null){
					process.setCicloActual(process.getCicloActual()+1);
					process.setEstado(ESTADO_RUN);
					estado[ESTADO_RUN].add(process);
				}
			}
		}
	}
	
	
	public void estadoRunToReady(){
		// Evita que o processo avance para o proximo estado
		// antes da altura correcta
		if (!estado[ESTADO_RUN].isEmpty()){
			if(estado[ESTADO_RUN].peek().getCicloActual() < cycle){
				PCB process = estado[ESTADO_RUN].poll();
				if(process != null){
					process.setCicloActual(process.getCicloActual()+1);
					process.setTempRun(process.getTempRun() + 1);
				}
				// manter o processo no estado run durante 4 ciclos
				if(process.getTempRun() == tempRUN){
					process.setEstado(ESTADO_READY);
					process.setTempRun(0);
					estado[ESTADO_READY].add(process);
				}
			}
		}
		
	}
	
	public void estadoRunToExit(){
		// Evita que o processo avance para o proximo estado
		// antes da altura correcta
		if (!estado[ESTADO_RUN].isEmpty()){
			if(estado[ESTADO_RUN].peek().getCicloActual() < cycle){
				PCB process = estado[ESTADO_RUN].poll();
				if(process != null){
					process.setCicloActual(process.getCicloActual()+1);
					process.setTempRun(process.getTempRun() + 1);
					process.setEstado(ESTADO_EXIT);
					estado[ESTADO_EXIT].add(process);
				}
			}
		}
		
	}
	
	public void estadoBlockToReady(){
		// Evita que o processo avance para o proximo estado
		// antes da altura correcta
		if (!estado[ESTADO_BLOCK].isEmpty()){
			if(estado[ESTADO_BLOCK].peek().getCicloActual() < cycle){
				PCB process = estado[ESTADO_BLOCK].poll();
				if(process != null){
					process.setCicloActual(process.getCicloActual()+1);
					process.setTempBlock(process.getTempBlock()+1);
				}
				// manter o processo no estado block durante o numero de ciclos do respectivo dispositivo
				if(process.getTempBlock() == tempBLOCK ){
					process.setEstado(ESTADO_READY);
					process.setTempBlock(0);
					estado[ESTADO_READY].add(process);
				}
			}
		}
	}
	
	public void estadoExit(){
		if(estado[ESTADO_EXIT].size() == numOfProcess){
			running = false;
			System.out.println("Processos terminados.");
		}
	}
	

	public static void main(String[] args) throws FileNotFoundException {
		String s = "";
		Scanner sc = new Scanner(System.in);
		ReadFile f = new ReadFile();
		System.out.println("Insira o caminho(directoria) do ficheiro de texto:");
		s = sc.nextLine();
		f.read(s);
		Pipeline pl = new Pipeline (f.getListaProcessos().size());
		for (int i = 0; i<f.getListaProcessos().size(); i++){
			f.getListaProcessos().get(i).setCicloChegada(f.getListaProcessos().get(i).pcb.get(0));
			f.getListaProcessos().get(i).pcb.remove(0);
			pl.estado[PRE_ESTADO].add(f.getListaProcessos().get(i));
		}
		pl.run();
	
		
		//System.out.println("Gestao de processos terminada.\nForam executados todos os processos.");
	}
}
