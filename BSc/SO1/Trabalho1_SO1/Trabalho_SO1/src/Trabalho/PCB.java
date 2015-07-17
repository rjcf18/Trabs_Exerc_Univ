package Trabalho;

public class PCB {
	private int procid;
	private String estado;
	private int tamanho;
	int[] arrayPCB;
	
	public PCB(int pid, String e, int t) {
		procid = pid;
		estado = e;
		tamanho = t;
		arrayPCB = new int[tamanho];
		arrayPCB[0] = procid;
	}
}
