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

import java.io.Serializable;

/**
 *
 * @author ricardo, marcus
 */
public class Espaco implements Serializable{
    
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

    /**
     * set nome
     */
    public void setNome(String nome) {
        this.nome = nome;
    }

    /**
     * set localizacao
     */
    public void setLocalizacao(String localizacao) {
        this.localizacao = localizacao;
    }

    /**
     * set area
     */
    public void setArea(String area) {
        this.area = area;
    }

    /**
     * set capacidade
     */
    public void setCapacidade(String capacidade) {
        this.capacidade = capacidade;
    }
    
    /**
     * 
     * @param esp
     * @return 
     */
    public boolean equals(Espaco esp)
    {
        if (this.nome != esp.nome) {
            return false;
        } else if (this.area != esp.area) {
            return false;
        } else if (this.capacidade != esp.capacidade) {
            return false;
        } else if (this.localizacao != esp.localizacao) {
            return false;
        }
        return true;
    }
    
    /**
     * toString espaco
     */
    public String toString() {
        return "Espaco:\n\tnome: "+nome+"\n\tLocalizacao: "+localizacao+"\n\tArea: "+area+"\n\tCapacidade: "+capacidade+"\n";
    }
    
}
