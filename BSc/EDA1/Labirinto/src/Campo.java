public class Campo {	
	private boolean valido, javisitado;
	private int valor;
	public Campo(int valor) {
		this.valor = valor;
		valido=true;
		javisitado=false;
	}

	public boolean isValido() {
		return valido;
	}

	public void setValido(boolean valido) {
		this.valido = valido;
	}

	public boolean isJavisitado() {
		return javisitado;
	}

	public void setJavisitado(boolean javisitado) {
		this.javisitado = javisitado;
	}

	public int getValor() {
		return valor;
	}

	public void setValor(int valor) {
		this.valor = valor;
	}

	public String toString() {
		return ""+valor;
	}
}
