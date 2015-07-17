package src;
import java.sql.Timestamp;

/**
 * Reserva
 * @author marcussantos, ricardofusco
 */
public class Reserva implements java.io.Serializable {
    private String nome;
    private String email;
    private String sala;
    private String local;
    private String inicio;
    private String fim;
    
    /**
     * Class constructor
     *
     * @param nome
     * @param email
     * @param sala
     * @param local
     * @param inicio
     * @param fim
     */
    public Reserva(String nome, String email, String sala, String local, String inicio, String fim) {
        this.nome = nome;
        this.email = email;
        this.sala = sala;
        this.local = local;
        this.inicio = inicio;
        this.fim = fim;
    }
    
    /**
     * @return nome
     */
    public String getNome(){
        return nome;
    }
    
    /**
     * @return email
     */
    public String getEmail(){
        return email;
    }
    
    /**
     * @return sala
     */
    public String getSala(){
        return sala;
    }
    
    /**
     * @return local
     */
    public String getLocal(){
        return local;
    }
    
    /**
     * @return inicio
     */
    public String getInicio(){
        return inicio;
    }
    
    /**
     * @return fim
     */
    public String getFim(){
        return fim;
    }
    
    public String toString() {
        return "Reserva:\n\tNome: "+nome+"\n\tEmail: "+email+"\n\tSala: "+sala+"\n\tLocal: "+local+"\n\tInicio: "+inicio+"\n\tFim: "+fim+"\n";
    }
}
