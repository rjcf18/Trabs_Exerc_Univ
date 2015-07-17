package src;


// CLASSE DO OBJECTO REMOTO
// TEM A PARTE FUNCIONAL

import java.util.Vector;
import java.sql.Timestamp;

/**
 * Classe que contém o objecto BD que faz a interacao entre a aplicacao servidor
 * e a base de dados
 *
 * @author marcussantos, ricardofusco
 */
public class ReservasEspacosImpl implements ReservasEspacos {

    private BD database;

    /**
     * Class constructor
     *
     * @param host
     * @param database
     * @param user
     * @param pass
     */
    public ReservasEspacosImpl(String host, String db, String user, String pass) {
		database = new BD(host, db, user, pass);
    }

    /*
     * adiciona uma reserva na base de dados
     * @param objecto do tipo Reserva que ira ser inserido na base de dados
     * @return feedback da base de dados
     * @exception java.rmi.RemoteException, java.text.ParseException
     */
    public String adicionarReserva(Reserva res) throws java.rmi.RemoteException, java.text.ParseException {
		//System.err.println("invocacao adicionaReserva() com: "+res.getNome());
		return database.executeQueryInsertReserva(res); //adiciona a reserva na base de dados
	}

    /**
     * adiciona um espaco disponivel na base de dados
     * @param objecto do tipo Espaco que ira ser inserido na base de dados
     * @return feedback da base de dados
     *
     * @exception java.rmi.RemoteException
     */
    public String adicionarEspaco(Espaco esp) throws java.rmi.RemoteException {
        //System.err.println("invocacao adicionaEspaco() com: "+esp.getNome());
        return database.executeQueryInsertEspaco(esp); //adiciona a reserva na base de dados
    }

    /**
     * devolve todas as reservas que foram feitas
     * @return vector de reservas
     *
     * @exception java.rmi.RemoteException
     */
    public Vector<Reserva> obterTodasReservas() throws java.rmi.RemoteException {
        //System.err.println("invocacao obterTodasReservas()");
		return database.executeQueryGetAllReservas();
    }

    /**
     * devolve todas as reservas que foram feitas por uma pessoa
     * @param nome da pessoa
     * @return vector de reservas
     *
     * @exception java.rmi.RemoteException
     */
    public Vector<Reserva> obterReservas(String nome) throws java.rmi.RemoteException {
        //System.err.println("invocacao obterReservas(nome)");
        return database.executeQueryGetReservas(nome);
    }

    /**
     * devolve todos os espacos disponiveis
     * @return vector de espacos
     *
     * @exception java.rmi.RemoteException
     */
    public Vector<Espaco> obterEspacosDisp() throws java.rmi.RemoteException {
        //System.err.println("invocacao obterEspacosDisp()");
        return database.executeQueryGetEspacos();
    }

    /**
     * devolve todas as reservas de um espaco para um dia
     * @param nome do espaco
     * @param ano
     * @param mes
     * @param dia
     * @return vector de reservas
     *
     * @exception java.rmi.RemoteException
     */
    public Vector<Reserva> obterResDia(String espaco, int ano, int mes, int dia) throws java.rmi.RemoteException {
        //System.err.println("invocacao obterResDia()");
        return database.executeQueryGetReservasDia(espaco, ano, mes, dia);
    }

    /**
     * devolve true se o espaço estiver livre numa determinada data e hora
     * @param nome do espaco
     * @param data e hora
     * @return true or false
     *
     * @exception java.rmi.RemoteException
     */
    public boolean espacoLivDia(String esp, String ts) throws java.rmi.RemoteException {
        //System.err.println("invocacao espacoLivDia()");
        return database.executeQueryGetEspLivDia(esp, ts);
    }

    /**
     * devolve o numero de reservas que foram feitas
     * @exception java.rmi.RemoteException
     */
    public int obterNumeroRes()throws java.rmi.RemoteException{
    	//System.err.println("invocacao obterNumeroRes()");
        return database.executeQueryGetNumReservas();
    }

    /**
     * termina a ligacao com a base de dados
     * @exception java.rmi.RemoteException
     */
    public void fecharDB()throws java.rmi.RemoteException{
        //System.err.println("Ligacao com base de dados terminada.");
        database.closeBD();
    }
    


}
