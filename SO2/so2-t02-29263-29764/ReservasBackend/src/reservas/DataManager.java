package reservas;

import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.jgroups.JChannel;
import org.jgroups.Message;
import org.jgroups.blocks.MessageDispatcher;
import org.jgroups.blocks.RequestHandler;
import org.jgroups.util.RspList;
import rm.BD;
import rm.ReservasEspacosImpl;

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

public class DataManager implements RequestHandler {

    public static DataManager instance;
    private JChannel canal;
    private RspList rspList;
    private MessageDispatcher dispatcher;
    private String nomeG = "MarcusFusco_Cluster2";
    
    private ReservasEspacosImpl reservas;
    
    private BD bd = new BD("localhost", "l29764", "l29764", "l29764", "1");

    public DataManager(String host, String bd, String user, String pwd, String replica) {

        reservas = new ReservasEspacosImpl(host, bd, user, pwd, replica);
        this.openChannel();
        
        this.instance = this;
    }

    /**
     * Devolve uma instancia do DataManager
     * @return 
     */
    public static DataManager getInstance() {
        return instance;
    }

    
    /**
     * Cria o canal para efectuar a comunicação com o back-end 
     */
    public void openChannel() {
        try {
            canal = new JChannel();

            //para não receber as mensagens enviadas
            canal.setDiscardOwnMessages(true);

            dispatcher = new MessageDispatcher(canal, null, null, this);
            canal.connect(nomeG);
        } catch (Exception e) {
            System.err.println("ERRO AO ABRIR O CANAL");
            Logger.getLogger(DataManager.class.getName()).log(Level.SEVERE, null, e);

        }
        System.out.println("Canal aberto");
    }

    /**
     * Recebe a mensagem do FrontEnd e retorna o resultado
     * @param mensagem
     * @return
     * @throws Exception 
     */
    public Object handle(Message mensagem) throws Exception {
        System.out.println(mensagem.getObject());

        System.out.println("Recebeu o pedido");

        if (mensagem.getObject() instanceof PedidoListagemEspacos) {
            
            System.out.println("pedido: Listagem de espacos");
            return reservas.obterEspacosDisp();
       
        } else if (mensagem.getObject() instanceof PedidoDispEsp) {
            
            System.out.println("pedido: Disponibilidade de espacos");
            PedidoDispEsp request = (PedidoDispEsp) mensagem.getObject();
            return reservas.espacoLivDia(request.getNome(), request.getTs());
        
        } else if (mensagem.getObject() instanceof PedidoListResDia) {
            
            System.out.println("pedido: Listagem dos espacos reservados num determinado dia");
            PedidoListResDia request = (PedidoListResDia) mensagem.getObject();
            return reservas.obterResDia(request.getNome(), 
                                        request.getAno(), 
                                        request.getMes(), 
                                        request.getDia());
            
        } else if (mensagem.getObject() instanceof PedidoEfectuarRes) {
            
            System.out.println("pedido: Efectuar uma reserva");
            PedidoEfectuarRes request = (PedidoEfectuarRes) mensagem.getObject();
            return reservas.adicionarReserva(request.getReserva());
            
        } else if (mensagem.getObject() instanceof PedidoListResPessoa) {
            
            System.out.println("pedido: Listagem dos espacos reservados por uma pessoa");
            PedidoListResPessoa request = (PedidoListResPessoa) mensagem.getObject();
            return reservas.obterReservas(request.getNome());
            
        }
        return null;
    }
}
