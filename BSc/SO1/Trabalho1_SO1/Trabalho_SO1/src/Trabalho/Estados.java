package Trabalho;

import java.util.ArrayList;

public class Estados {
	ArrayList<PCB> state; 
	int numProc;
	public Estados (int n){
		numProc = n;
		new ArrayList<PCB>(numProc);
	}
}
