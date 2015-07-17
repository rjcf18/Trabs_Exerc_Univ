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

package rm;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;
import reservas.Espaco;
import reservas.Reserva;

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

    public BD(String PG_HOST, String PG_DB, String USER, String PWD, String REPLICA){

        this.replica = REPLICA;
        // valores devem ser recebidos como argumento:
        // dados para ligar 'a BD
        // nao podem estar no codigo fonte
        // podem ser lidos de um ficheiro de propriedades

        this.con= null;
        this.stmt= null;

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
     * Devolve um vector com todos os espacos disponiveis
     * @return vector de reservas
     */
    public synchronized Vector<Espaco> executeQueryGetEspacos()
    {
        String query = "SELECT * FROM espacos"+replica;
        Vector<Espaco> espacos = new Vector<Espaco>();

        try {
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                //int id= rs.getInt("id");
                espacos.add(new Espaco(rs.getString("nome"),
                                    rs.getString("localizacao"),
                                    rs.getString("area"),
                                    rs.getString("capacidade")
                                       )
                            );
            }
            rs.close();
        }
        catch (Exception e) {
           // e.printStackTrace();
            System.out.println("Problems retrieving data from db...");
        }

        return espacos;
    }

    /**
     * Devolve um vector com todas as reservas feitas
     * @return vector de reservas
     */
    public synchronized Vector<Reserva> executeQueryGetAllReservas()
    {
        String query = "SELECT * FROM reservas"+replica;
        Vector<Reserva> reservas = new Vector<Reserva>();

        try {
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                //int id= rs.getInt("id");
                reservas.add(new Reserva(rs.getString("nome"),
                                         rs.getString("email"),
                                         rs.getString("fg_k_nome"),
                                         rs.getString("fg_k_local"),
                                         rs.getTimestamp("inicio").toString(),
                                         rs.getTimestamp("fim").toString()
                                         )
                             );
            }
            rs.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            System.err.println("Problems retrieving data from db...");
        }

        return reservas;
    }

    /**
     * Devolve o numero de reservas
     * @return numero de reservas
     */
    public synchronized int executeQueryGetNumReservas()
    {
        String query = "SELECT COUNT(*) FROM reservas"+replica;
        int numRes = 0;
        try {
            ResultSet rs = stmt.executeQuery(query);

            numRes = rs.getInt(1);

            rs.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            System.err.println("Problems retrieving data from db...");
        }

        return numRes;
    }

    /**
     * Vai verificar todas as reservas para um determinado nome
     * @param nome (String)
     * @return vector de reservas
	 */
    public synchronized Vector<Reserva> executeQueryGetReservas(String nome)
    {
        String query = "SELECT * FROM reservas"+replica+" where nome='"+nome+"'";
        Vector<Reserva> reservas = new Vector<Reserva>();

        System.out.println(query);
        try {
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                //int id= rs.getInt("id");
                reservas.add(new Reserva(rs.getString("nome"),
                                         rs.getString("email"),
                                         rs.getString("fg_k_nome"),
                                         rs.getString("fg_k_local"),
                                         rs.getTimestamp("inicio").toString(),
                                         rs.getTimestamp("fim").toString()
                                         )
                             );
            }
            rs.close();
        }
        catch (Exception e) {
            //e.printStackTrace();
            System.out.println("Problems retrieving data from db: reservas efectuadas pelo "+nome);
        }

        return reservas;
    }

    /**
     * verifica se um espaco estara livre a dada hora e data
     * @param espaco (String)
     * @param timestamp (String)
     * @return retorna true se um dado espaco esta livre numa determinada data-hora
     */
    public synchronized boolean executeQueryGetEspLivDia(String esp, String ts)
    {
        //conta quantos espacos terao reservas durante essa data-hora
        String query = "SELECT count(*) as c FROM reservas"+replica+" WHERE fg_k_nome='"+esp+"' AND inicio <'"+ts+"' AND fim >='"+ts+"'";
        boolean livre = true;
        
        try {
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {

                //se o numero de reservas resultante da contagem for superior a 0,
                //significa que o espaco nao se encontra livre nessa hora
                if (rs.getInt("c") != 0) {
                    livre = false;
                }
            }
            rs.close();
        }
        catch (Exception e) {
            //e.printStackTrace();
            System.out.println("Problems retrieving data from db: Get espaco disponivel num determinado dia");
        }

        //verifica se o espaco nao esta no vector, ou seja, se esta livre
        return livre;
    }

    /**
     * lista todas as reservas para um determinado dia
     * @param espaco (String)
     * @param ano (String)
     * @param mes (int)
     * @param dia (int)
     * @return vector de reservas
     */
    public synchronized Vector<Reserva> executeQueryGetReservasDia(String espaco, String ano, String mes, String dia)
    {
        String query = "SELECT * FROM reservas"+replica+" WHERE fg_k_nome='"+espaco+"' AND inicio>='"+ano+"-"+mes+"-"+dia+" 00:00:00' AND inicio<'"+ano+"-"+mes+"-"+dia+" 23:59:59'";
        Vector<Reserva> reservas = new Vector<Reserva>();

        System.out.println(query);
        
        try {
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                reservas.add(new Reserva(rs.getString("nome"),
                                         rs.getString("email"),
                                         rs.getString("fg_k_nome"),
                                         rs.getString("fg_k_local"),
                                         rs.getTimestamp("inicio").toString(),
                                         rs.getTimestamp("fim").toString()
                                         )
                                );

            }
            rs.close();
        }
        catch (Exception e) {
            //e.printStackTrace();
            System.out.println("Problems retrieving data from db...");
        }

        return reservas;
    }

    /**
     * Passar um objecto Reserva para ser inserido na BD
     * @param reserva (Reserva)
     * @return feedback message (String)
     */
    public synchronized String executeQueryInsertReserva(Reserva reserva) throws ParseException{

        String msg = "";

        String nome = reserva.getNome();
        String email = reserva.getEmail();
        String sala = reserva.getSala();
        String local = reserva.getLocal();
        String inicio = reserva.getInicio();
        String fim = reserva.getFim();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
        Date inFormat = dateFormat.parse(inicio+".000");
        Timestamp inTs = new Timestamp(inFormat.getTime());

        dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
        Date fmFormat = dateFormat.parse(fim+".000");
        Timestamp fmTs = new Timestamp(fmFormat.getTime());

        if (inTs.before(fmTs)) {

            //verifica se o espaco que se deseja reservar existe
            String query = "SELECT count(*) as c FROM espacos"+replica+" WHERE fg_k_nome='"+sala+"'";

            // *******************
            // update/insert
            try {
                // APENAS se a tabela nao existe:
                //stmt.executeUpdate("create table personl99999 (id int4, name varchar(64), birth timestamp)");
                ResultSet rs = stmt.executeQuery(query);
                rs.next();

                if(rs.getInt("c") == 0){
                    msg = "Problemas na insercao: Espaco nao existente!";
                }
                else{
                    //verifica se ha alguma reserva do espaco no periodo especificado
                    query = "SELECT count(*) as c FROM reservas"+replica+" WHERE ("+"inicio>='"+inicio +"' AND inicio<'"+fim+"') OR (fim<='"+fim+"' AND fim>'"+inicio+"')";
                    rs = stmt.executeQuery(query);
                    rs.next();

                    if(rs.getInt("c") == 0){
                        query = "insert into reservas"+replica+" values('"+nome+"','"+email+"','"+inicio+"','"+fim+"', '"+sala+"', '"+local+"')";
                        this.stmt.executeUpdate(query);
                        msg = "Reserva efectuada com sucesso!";
                    }
                    else{
                        msg = "Problemas na insercao: Reserva ja existente durante esse horario!";
                    }
                }


            }
            catch (Exception e) {
                e.printStackTrace();
                //System.err.println("Problems on insert...");
                msg = "Problems on insert... query: "+query;
            }
        }else{
            msg = "\nA data de inicio tem de ser antes da data de fim!!";
        }
        return msg;

    }
}
