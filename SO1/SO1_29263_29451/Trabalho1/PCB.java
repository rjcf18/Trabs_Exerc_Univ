package Trabalho;

import java.util.ArrayList;

public class PCB {
	
	private int PID;
	private int estado;
	private int dispSeg;
	
	private int tempRun;// utilizada para manter o processo no RUN os ciclos necessarios
	private int tempBlock;// utilizada para manter o processo no BLOCK os ciclos necessarios
	private int cicloActual;
	private int cicloChegada;
	
	public ArrayList <Integer> pcb = new ArrayList<Integer> ();
	
	public PCB(int pid, int estado) {
		setProcid(pid);
		setEstado(estado);
	}
	
	public void setDispSeg(int n){
		dispSeg = n;
	}
	
	public int getDispSeg(){
		return dispSeg;
	}
	
	public void setProcid(int n){
		PID = n;
	}
	
	public int getProcid(){
		return PID;
	}
	
	public void setEstado(int e){
		estado = e;
	} 
	
	public int getEstado(){
		return estado; 
	}

	public int getCicloActual() {
		return cicloActual;
	}

	public void setCicloActual(int cicloActual) {
		this.cicloActual = cicloActual;
	}

	public int getCicloChegada() {
		return cicloChegada;
	}

	public void setCicloChegada(int cicloChegada) {
		this.cicloChegada = cicloChegada;
	}

	public int getTempRun() {
		return tempRun;
	}

	public void setTempRun(int tempRun) {
		this.tempRun = tempRun;
	}

	public int getTempBlock() {
		return tempBlock;
	}

	public void setTempBlock(int tempBlock) {
		this.tempBlock = tempBlock;
	}
	
}
