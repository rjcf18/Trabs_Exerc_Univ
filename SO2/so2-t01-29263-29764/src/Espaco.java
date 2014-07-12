package src;

/**
 * Espaco
 * @author marcussantos, ricardofusco
 */
public class Espaco implements java.io.Serializable{
    private String nome;
    private String localizacao;
    private String area;
    private String capacidade;
    
    /**
     * Class constructor
     *
     * @param nome
     * @param localizacao
     * @param area
     * @param capacidade
     */
    public Espaco(String nome, String localizacao, String area, String capacidade) {
        this.nome = nome;
        this.localizacao = localizacao;
        this.area = area;
        this.capacidade = capacidade;
    }
    
    /**
     * @return nome
     */
    public String getNome() {
        return nome;
    }
    
    /**
     * @return localizacao
     */
    public String getLocalizacao() {
        return localizacao;
    }
    
    /**
     * @return area
     */
    public String getArea() {
        return area;
    }
    
    /**
     * @return capacidade
     */
    public String getCapacidade() {
        return capacidade;
    }
    
    public String toString() {
        return "Espaco:\n\tnome: "+nome+"\n\tLocalizacao: "+localizacao+"\n\tArea: "+area+"\n\tCapacidade: "+capacidade+"\n";
    }
}
