package rm;


import java.util.Vector;
import reservas.Espaco;
import reservas.Reserva;

/**
 * Interface com os metodos remotos do servico
 * @author marcussantos, ricardofusco
 */
public interface ReservasEspacos extends java.rmi.Remote {

   
    public String adicionarReserva(Reserva res) throws java.rmi.RemoteException, java.text.ParseException;
    public Vector<Reserva> obterTodasReservas() throws java.rmi.RemoteException;
    public Vector<Reserva> obterReservas(String nome) throws java.rmi.RemoteException;
    public boolean espacoLivDia(String esp, String ts) throws java.rmi.RemoteException;
    public Vector<Reserva> obterResDia(String espaco, String ano, String mes, String dia) throws java.rmi.RemoteException;
    public int obterNumeroRes()throws java.rmi.RemoteException;
    public Vector<Espaco> obterEspacosDisp() throws java.rmi.RemoteException;
    public void fecharDB()throws java.rmi.RemoteException;

}
