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
import java.util.Vector;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

/**
 *
 * @author ricardo, marcus
 */
@ManagedBean
@SessionScoped
public class userData implements Serializable{
    private String username = "";
    private String password = "";
    private String pessoa = "";
    private String espaco = "";
    private boolean loggedIn = false;
    

    public boolean isLoggedIn() {
        return loggedIn;
    }

    public void setLoggedIn(boolean loggedIn) {
        this.loggedIn = loggedIn;
    }
    
    public String getPessoa() {
        return pessoa;
    }

    public void setPessoa(String pessoa) {
        this.pessoa = pessoa;
    }

    public String getEspaco() {
        return espaco;
    }

    public void setEspaco(String espaco) {
        this.espaco = espaco;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    
    /**
     * Efectua o login e redirecciona para o para o menu
     * @return 
     */
    public String authenticate(){
        if(username.compareTo("admin") == 0 && password.compareTo("login123") == 0){
            loggedIn = true;
            return "menuposlog";
        }
        else
            return "login";
    }
    
    /**
     * Faz o logout e redirecciona
     * @return 
     */
    public String logout(){
        loggedIn = false;
        return "menu";
    }
    
}
