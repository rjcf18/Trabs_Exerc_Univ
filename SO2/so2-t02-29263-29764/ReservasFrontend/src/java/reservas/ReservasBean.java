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
 */
/**
 *
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
@ManagedBean(name="reservasBean")
@SessionScoped
public class ReservasBean implements Serializable {
    private String nome = "", email = "", sala = "", local = "", inicio = "", fim = "", ano = "", mes = "", dia = "", nomeEsp = "";
    private DataManager dm = DataManager.getInstance();

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSala() {
        return sala;
    }

    public void setSala(String sala) {
        this.sala = sala;
    }

    public String getLocal() {
        return local;
    }

    public void setLocal(String local) {
        this.local = local;
    }

    public String getInicio() {
        return inicio;
    }

    public void setInicio(String inicio) {
        this.inicio = inicio;
    }

    public String getFim() {
        return fim;
    }

    public void setFim(String fim) {
        this.fim = fim;
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

    public String getNomeEsp() {
        return nomeEsp;
    }

    public void setNomeEsp(String nomeEsp) {
        this.nomeEsp = nomeEsp;
    }

    public DataManager getMd() {
        return dm;
    }

    public void setMd(DataManager dm) {
        this.dm = dm;
    }
    
    
    /**
     * Faz a listagem das reservas efectuadas para um espaco numa determinada data/hora
     * @return 
     */
    public Vector<ReservasBean> listagemResDia(){
        
        PedidoListResDia plrd = new PedidoListResDia(nomeEsp, dia, mes, ano);
        
        Vector<ReservasBean> listRes = new Vector<ReservasBean>();
        
        if (dm == null) {
            System.out.println("DATA MANAGER IS NULL");
        }
        
        Vector<Reserva> reservas =  (Vector<Reserva>)dm.sendMessage(plrd);
        
        for(Reserva r: reservas) {
            
            ReservasBean resBean = new ReservasBean();
            resBean.setNome(r.getNome());
            resBean.setEmail(r.getEmail());
            resBean.setSala(r.getSala());
            resBean.setLocal(r.getLocal());
            resBean.setInicio(r.getInicio());
            resBean.setFim(r.getFim());
            
            listRes.add(resBean);
        }
        
        return listRes;
    }
    
    /**
     * Faz a listagem dos espaço reservados por uma pessoa
     * @return 
     */
    public Vector<ReservasBean> listagemResPessoa(){
        
        
        System.out.println("LISTAGEM RESERVA PESSOA : NOME ="+nome);
        
        PedidoListResPessoa plrp = new PedidoListResPessoa(nome);
        
        Vector<ReservasBean> listRes = new Vector<ReservasBean>();
        
        if (dm == null) {
            System.out.println("DATA MANAGER IS NULL");
        }
        
        System.out.println("recebeu o pedido de listagem reserva pessoa");
        
        Vector<Reserva> reservas =  (Vector<Reserva>)dm.sendMessage(plrp);
        
        for(Reserva r: reservas) {
            
            ReservasBean resBean = new ReservasBean();
            resBean.setNome(r.getNome());
            resBean.setEmail(r.getEmail());
            resBean.setSala(r.getSala());
            resBean.setLocal(r.getLocal());
            resBean.setInicio(r.getInicio());
            resBean.setFim(r.getFim());
            listRes.add(resBean);
        }
        
        return listRes;
    }
    
    
    /**
     * Efectuar uma reserva
     * @return 
     */
    public String efectuarReserva(){
        
        Reserva r = new Reserva(nome, email, sala, local, inicio, fim);
        
        System.out.println("nome :"+nome+", email :"+email+", sala :"+sala+", local :"+local+", inicio :"+inicio+", fim :"+fim);
        PedidoEfectuarRes per = new PedidoEfectuarRes(r);
                
        if (dm == null) {
            System.out.println("DATA MANAGER IS NULL");
        }
        
        System.out.println("recebeu o pedido de listagem reserva pessoa");
        
        String rsp =  (String)dm.sendMessage(per);
        
        return rsp;
    }
}