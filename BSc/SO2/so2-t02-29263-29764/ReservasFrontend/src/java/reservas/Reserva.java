package reservas;

import java.io.Serializable;

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

public class Reserva implements Serializable {
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