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

package map;

import java.sql.*;
import java.util.Vector;

/**
 *
 * @author ricardo, marcus
 */
public class BD {

    public Connection con;
    public Statement stmt;

    String replica;
    /**
     * Class constructor
     * @param host (String)
     * @param database (String)
     * @param user (String)
     * @param pass (String)
     */

    public BD(String PG_HOST, String PG_DB, String USER, String PWD, String replica){

        // valores devem ser recebidos como argumento:
        // dados para ligar 'a BD
        // nao podem estar no codigo fonte
        // podem ser lidos de um ficheiro de propriedades

        this.con= null;
        this.stmt= null;
        this.replica = replica;

        try {
            Class.forName ("org.postgresql.Driver");
            // url = "jdbc:postgresql://host:port/database",
            con = DriverManager.getConnection("jdbc:postgresql://"+PG_HOST+":5432/"+PG_DB,
                                              USER,
                                              PWD);

            this.stmt = this.con.createStatement();

        }
        catch (Exception e) {
            e.printStackTrace();
            System.err.println("Problems setting the connection");
        }
    }

    /**
	 * Fecha a ligação com a base de dados
	 */
    public void closeBD(){
        // importante: fechar a ligacao 'a BD
        try {
            stmt.close();
            con.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Devolve um vector com todas as reservas feitas
     * @return vector de strings
     */
    public Vector<String> executeQueryGetAllReservas()
    {
        Vector<String> reservas = new Vector<String>();
        
        String query = "SELECT * FROM reservas"+replica;
        String line = "";
        try {
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                //int id= rs.getInt("id");
                line = rs.getString("nome")+',';
                line += rs.getString("email")+ ',';
                line += rs.getString("fg_k_nome") + ',';
                line += rs.getString("fg_k_local") + ',';
                line += rs.getTimestamp("inicio").toString()+ ',';
                line += rs.getTimestamp("fim").toString();
                
                reservas.add(line);
            }
            rs.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            System.err.println("Problems retrieving data from db...");
        }

        return reservas;
    }
}