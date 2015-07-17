package Trab2;

public class PCB {
	
	private int PID;
	private int estado;
	private int dispSeg;
	
	private int tempRun;// utilizada para manter o processo no RUN os ciclos necessarios
	private int tempBlock;// utilizada para manter o processo no BLOCK os ciclos necessarios
	private int cicloActual;
	private int cicloChegada;
	private int pc; // program counter
	private int memSize; // tamanho que ocupa em memoria
	private int memStart; // onde vai estar em memoria(onde comeca)
	
	public PCB(int pid, int estado) {
		setProcid(pid);
		setPc(0);
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

	public int getPc() {
		return pc;
	}

	public void setPc(int pc) {
		this.pc = pc;
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

	public int getMemSize() {
		return memSize;
	}

	public void setMemSize(int memSize) {
		this.memSize = memSize;
	}

	public int getMemStart() {
		return memStart;
	}

	public void setMemStart(int memStart) {
		this.memStart = memStart;
	}
	
}