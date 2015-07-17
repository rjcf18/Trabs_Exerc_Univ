public class ElementoTabela<T>
	{
		public T elemento; // o elemento da tabela
		public boolean activo; // é false quando o elemento está apagado
		public ElementoTabela( T e )
		{ 
			this( e, true ); 
		}
		public ElementoTabela( T e, boolean i )
		{ 
			elemento = e; 
			activo = i; 
		}
		public String toString(){
			return (String) elemento;
		}
	}