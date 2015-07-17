package src;

import java.util.Vector;
import java.sql.Timestamp;

/**
 * Interface com os metodos remotos do servico
 * @author marcussantos, ricardofusco
 */
public interface ReservasEspacos extends java.rmi.Remote {

    public String adicionarReserva(Reserva res) throws java.rmi.RemoteException, java.text.ParseException;
    public String adicionarEspaco(Espaco esp) throws java.rmi.RemoteException;
    public Vector<Reserva> obterTodasReservas() throws java.rmi.RemoteException;
    public Vector<Reserva> obterReservas(String nome) throws java.rmi.RemoteException;
    public boolean espacoLivDia(String esp, String ts) throws java.rmi.RemoteException;
    public Vector<Reserva> obterResDia(String espaco, int ano, int mes, int dia) throws java.rmi.RemoteException;
    public int obterNumeroRes()throws java.rmi.RemoteException;
    public Vector<Espaco> obterEspacosDisp() throws java.rmi.RemoteException;
    public void fecharDB()throws java.rmi.RemoteException;

}
