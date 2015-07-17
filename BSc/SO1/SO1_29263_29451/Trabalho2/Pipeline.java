package Trab2;

import java.lang.reflect.Array;
import java.util.LinkedList;

import Trabalho.PCB;

public class Pipeline {

	
	public static final int PRE_ESTADO = 0;
	public static final int ESTADO_NEW = 1;
	public static final int ESTADO_READY = 2;
	public static final int ESTADO_RUN = 3;
	public static final int ESTADO_BLOCK = 4;
	public static final int ESTADO_EXIT = 5;
	
	public int tempRUN = 3;
	public int tempBLOCK = 3;
	
	public int cycle;
	public boolean running;
	public static LinkedList<PCB>[] estado;
	public int numOfProcess;
	public static Array MEM [];
	
	public Pipeline(int numP){
		cycle = 0;
		running =  true;
		numOfProcess = 0;
		estado  = new LinkedList[6];
		for (int i = 0; i < estado.length; i++){
			estado[i] = new LinkedList<PCB> ();
		}
	}
	
	public void run(){
		
		while(running){
			// faz todos os processos avancarem um ciclo
			for(int i = 0; i < estado.length; i++)
			{
				switch (i) {
				case Pipeline.PRE_ESTADO:
				{
					preEstado();
				}break;
				case Pipeline.ESTADO_NEW:
				{
					estadoNew();
				}break;
				case Pipeline.ESTADO_READY:
				{
					estadoReady();
				}break;
				case Pipeline.ESTADO_RUN:
				{
					estadoRun();
				}break;
				case Pipeline.ESTADO_EXIT:
				{
					estadoExit();
				}break;
				default:
					break;
				}
			}
			cycle++;
		}
		
	}
	
	public void preEstado(){
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
	
	public void estadoNew(){
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
	
	public void estadoReady()
	{
		// Evita que o processo avance para o proximo estado
		// antes da altura correcta
		if(estado[ESTADO_READY].peek().getCicloActual() < cycle)
		{
			PCB process = estado[ESTADO_READY].poll();
			if(process != null)
			{
				process.setCicloActual(process.getCicloActual()+1);
				process.setEstado(ESTADO_RUN);
				estado[ESTADO_NEW].add(process);
			}
		}
	}
	
	
	public void estadoRun()
	{
		// Evita que o processo avance para o proximo estado
		// antes da altura correcta
		if(estado[ESTADO_RUN].peek().getCicloActual() < cycle)
		{
			PCB process = estado[ESTADO_RUN].poll();
			if(process != null)
			{
				// implementar aqui as funcoes do enunciado
				process.setCicloActual(process.getCicloActual()+1);
				process.setTempRun(process.getTempRun() + 1);
			}
			// manter o processo no estado run durante 3 ciclos
			if(process.getTempRun() == tempRUN){
				process.setEstado(ESTADO_READY);
				process.setTempRun(0);
				estado[ESTADO_READY].add(process);
			}
		}
	}
	
	public void estadoBlock()
	{
		// Evita que o processo avance para o proximo estado
		// antes da altura correcta
		if(estado[ESTADO_BLOCK].peek().getCicloActual() < cycle)
		{
			PCB process = estado[ESTADO_BLOCK].poll();
			if(process != null)
			{
				process.setCicloActual(process.getCicloActual()+1);
				process.setTempBlock(process.getTempBlock()+1);
			}
			// manter o processo no estado block durante 3 ciclos
			if(process.getTempBlock() == tempBLOCK ){
				process.setEstado(ESTADO_READY);
				process.setTempBlock(0);
				estado[ESTADO_READY].add(process);
			}
		}
	}
	
	public void estadoExit()
	{
		if(estado[ESTADO_EXIT].size() == numOfProcess)
		{
			running = false;
		}
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}