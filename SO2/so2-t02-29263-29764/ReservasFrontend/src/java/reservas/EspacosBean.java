package reservas;

/*
 * Copyright (C) 2014 Ricardo Fusco e Marcus Santos
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * @author ricardo, marcus
 */

import java.io.Serializable;
import java.util.Vector;
import javax.enterprise.context.SessionScoped;
import javax.faces.bean.ManagedBean;

/**
 *
 * @author ricardo, marcus
 */
@ManagedBean(name="espacosBean")
@SessionScoped
public class EspacosBean implements Serializable {

    private String nome = "";
    private String localizacao = "";
    private String area = "";
    private String capacidade = "";
    private DataManager md = DataManager.getInstance();
    private String hora, min;
    private String ts;
    private String ano, mes, dia;

    public String getNome() {
        return nome;
    }

    public String getLocalizacao() {
        return localizacao;
    }

    public String getArea() {
        return area;
    }

    public String getCapacidade() {
        return capacidade;
    }

    public DataManager getMd() {
        return md;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setLocalizacao(String localizacao) {
        this.localizacao = localizacao;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public void setCapacidade(String capacidade) {
        this.capacidade = capacidade;
    }

    public void setMd(DataManager md) {
        this.md = md;
    }
    
    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public String getMin() {
        return min;
    }

    public void setMin(String min) {
        this.min = min;
    }

    public String getTs() {
        return ts;
    }

    public void setTs(String ts) {
        this.ts = ts;
    }

    public String getAno() {
        return ano;
    }

    public void setAno(String ano) {
        this.ano = ano;
    }

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }
    
    
    /**
     * Insere zeros à esquerda numa string caso
     * o seu tamanho seja 1
     * Tem como objectivo ajudar a criar uma string
     * com o formato Timestamp ou Datetime
     * @param string
     */
    public String insereZeros(String n) {
        return n.length() == 1? "0"+n : n;
    }
    
    
    public String createTS(){
        ts = ano+"-"+insereZeros(mes)+"-"+insereZeros(dia)+" "+insereZeros(hora)+":"+insereZeros(min)+":00"; 
        
        return "dispEsp2";
    }
    
    public Vector<EspacosBean> listagemEsp(){
        
        PedidoListagemEspacos ple = new PedidoListagemEspacos();
        
        Vector<EspacosBean> listEsp = new Vector<EspacosBean>();
        
        if (md == null) {
            System.out.println("DATA MANAGER IS NULL");
        }
        
        Vector<Espaco> espacos =  (Vector<Espaco>)md.sendMessage(ple);
        
        for(Espaco e: espacos) {
            
            EspacosBean espBean = new EspacosBean();
            espBean.setNome(e.getNome());
            espBean.setArea(e.getArea());
            espBean.setCapacidade(e.getCapacidade());
            espBean.setLocalizacao(e.getLocalizacao());
            
            listEsp.add(espBean);
        }
        
        return listEsp;
    }
    
    public String getDispEspaco(){
        
        PedidoDispEsp pde = new PedidoDispEsp(nome, ts);
        
        if (md == null) {
            System.out.println("DATA MANAGER IS NULL");
        }
        
        boolean found =  (boolean)md.sendMessage(pde);
        
        if(found)
            return "O espaço está disponível!";
        else
            return "O espaço não está disponível!";

    }
}
