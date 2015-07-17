package src;

import java.sql.*;
import java.util.Vector;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

/**
 * @author marcussantos, ricardofusco
 */
public class BD {
    
    public Connection con;
    public Statement stmt;
    
    /**
	 * Class constructor
	 * @param host (String)
     * @param database (String)
     * @param user (String)
     * @param pass (String)
	 */
    public BD(String PG_HOST, String PG_DB, String USER, String PWD){
        
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
    public Vector<Espaco> executeQueryGetEspacos()
    {
        String query = "SELECT * FROM espacos";
        Vector<Espaco> espacos = new Vector<Espaco>();
        
        try {
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                //int id= rs.getInt("id");
                espacos.add(new Espaco(rs.getString("nome"),
                                    rs.getString("localizacao"),
                                    rs.getString("capacidade"),
                                    rs.getString("capacidade")
                                       )
                            );
            }
            rs.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            System.err.println("Problems retrieving data from db...");
        }
        
        return espacos;
    }
    
    /**
     * Devolve um vector com todas as reservas feitas
     * @return vector de reservas
     */
    public Vector<Reserva> executeQueryGetAllReservas()
    {
        String query = "SELECT * FROM reservas";
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
    public int executeQueryGetNumReservas()
    {
        String query = "SELECT COUNT(*) FROM reservas";
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
    public Vector<Reserva> executeQueryGetReservas(String nome)
    {
        String query = "SELECT * FROM reservas where nome='"+nome+"'";
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
     * verifica se um espaco estara livre a dada hora e data
     * @param espaco (String)
     * @param timestamp (String)
     * @return retorna true se um dado espaco esta livre numa determinada data-hora
	 */
    public boolean executeQueryGetEspLivDia(String esp, String ts)
    {
        //conta quantos espacos terao reservas durante essa data-hora
        String query = "SELECT count(*) as c FROM reservas WHERE fg_k_nome='"+esp+"' AND inicio <'"+ts+"' AND fim >='"+ts+"'";
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
            e.printStackTrace();
            System.err.println("Problems retrieving data from db...");
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
    public Vector<Reserva> executeQueryGetReservasDia(String espaco, int ano, int mes, int dia)
    {
        String query = "SELECT * FROM reservas WHERE fg_k_nome='"+espaco+"' AND inicio>='"+String.valueOf(ano)+"-"+String.valueOf(mes)+"-"+String.valueOf(dia)+" 00:00:00' AND inicio<'"+String.valueOf(ano)+"-"+String.valueOf(mes)+"-"+String.valueOf((dia+1))+" 23:59:59'";
        Vector<Reserva> reservas = new Vector<Reserva>();
        
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
            e.printStackTrace();
            System.err.println("Problems retrieving data from db...");
        }
        
        return reservas;
    }
    
    /**
     * Passar um objecto Reserva para ser inserido na BD
     * @param resersa (Reserva)
     * @return feedback message (String)
     */
    public String executeQueryInsertReserva(Reserva reserva) throws ParseException{
        
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
            String query = "SELECT count(*) as c FROM espacos WHERE nome='"+sala+"'";
 
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
                    query = "SELECT count(*) as c FROM reservas WHERE ("+"inicio>='"+inicio +"' AND inicio<'"+fim+"') OR (fim<='"+fim+"' AND fim>'"+inicio+"')";    
                    rs = stmt.executeQuery(query);
                    rs.next();
                    
                    if(rs.getInt("c") == 0){
                        query = "insert into reservas values('"+nome+"','"+email+"','"+inicio+"','"+fim+"', '"+sala+"', '"+local+"')";
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
    
    /**
     * Passar um objecto espaco para ser inserido na BD
     * @param espaco (Espaco)
     * @return feedback message (String)
     */
    public String executeQueryInsertEspaco(Espaco espaco){
        
        String nome = espaco.getNome();
        String localizacao = espaco.getLocalizacao();
        String area = espaco.getArea();
        String capacidade = espaco.getCapacidade();
        String msg = "Reserva Inserida com sucesso!!";
        
        // *******************
        // update/insert
        try {
            // APENAS se a tabela nao existe:
            String query = "insert into espacos values('"+nome+"','"+localizacao+"','"+area+"','"+capacidade+"')";
            this.stmt.executeUpdate(query);
            System.out.println("Espaco inserido com sucesso!");
            
        }
        catch (Exception e) {
            e.printStackTrace();
            msg = "Problems on insert...";
        }
        
        return msg;
    }

    public static void main(String[] args) {
        
        if (args.length<4) {
            System.err.println("FALTAM OS ARGUMENTOS: host bd user password");
            System.exit(1);
        }
        
        BD database = new BD(args[0], args[1], args[2], args[3]);
        
        Vector<Reserva> reservas =  database.executeQueryGetAllReservas();
        Vector<Espaco> espacos = database.executeQueryGetEspacos();
        
        for(Reserva reserva:reservas) {
            System.out.println(reserva);
        }
        
        for(Espaco espaco:espacos) {
            System.out.println(espaco);
        }
        
        reservas = database.executeQueryGetReservasDia("Anf-1", 2014, 4, 1);
        System.out.println("Reservas do dia 2014/4/1");
        
        for(Reserva reserva:reservas) {
            System.out.println(reserva);
        }
        
        reservas = database.executeQueryGetReservas("Ricardo");
        System.out.println("Reservas do Ricardo");
        for(Reserva reserva:reservas) {
            System.out.println(reserva);
        }
        
        database.closeBD();
        
    }
    
    
}
