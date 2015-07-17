package reservas;

import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

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

import javax.ejb.*;
import org.jgroups.JChannel;
import org.jgroups.Message;
import org.jgroups.blocks.MessageDispatcher;
import org.jgroups.blocks.RequestHandler;
import org.jgroups.blocks.RequestOptions;
import org.jgroups.blocks.ResponseMode;
import org.jgroups.util.Rsp;
import org.jgroups.util.RspList;
import org.jgroups.util.Util;

@Singleton
public class DataManager implements RequestHandler {
    
    public static DataManager instance ;
    private JChannel canal;
    private RspList rspList;
    private MessageDispatcher dispatcher;
    private String nomeG = "MarcusFusco_Cluster2";
    
    
    public DataManager() {
        instance = this;  
        this.openChannel();
    }
    
    /**
     * Devolve uma instancia do DataManager
     * @return 
     */
    public static DataManager getInstance() {
        if (instance == null) {
            instance = new DataManager();
        }
        return instance;
    }
    
    
    /**
     * Cria o canal para efectuar a comunicação com o back-end 
     */
    public void openChannel(){
        try{
            System.out.println("Canal aberto");
            canal = new JChannel();
            //para não receber as mensagens enviadas
            canal.setDiscardOwnMessages(true);
            
            dispatcher = new MessageDispatcher(canal,null,null,this);
            canal.connect(nomeG);
        }catch (Exception e){
            System.err.println("ERRO AO ABRIR O CANAL");
            Logger.getLogger(DataManager.class.getName()).log(Level.SEVERE, null, e);

        }
    }
    
    /**
     * recebe a mensagem e retorna o resultado (server)
     * @param mensagem
     * @return
     * @throws Exception 
     */
    public Object handle(Message mensagem) throws Exception{
        return mensagem.getObject();
    }     
    
    /**
     * Enviar um objecto Pedido para o backend
     * @param object_to_send
     * @return 
     */
    public Object sendMessage(Object object_to_send)
    {
        Vector<Rsp> respostas = new Vector<>();
        
        try {
            Message msg = new Message(null, null, Util.objectToByteBuffer(object_to_send));
            System.out.println("ANTES DO Envio");
            rspList = dispatcher.castMessage(null, msg, new RequestOptions(ResponseMode.GET_ALL, 30000));
            System.out.println("DEPOIS DO Envio");
            
            Rsp resposta;
            for (Object rsp : rspList) {
                resposta = (Rsp) rsp;
                if (resposta.getValue() != null) {
                    
                    respostas.add(resposta);
                    return resposta.getValue(); // Comentar esta linha para testar a tolerancia a falhas bizantinas
                }
            }
            
            return selectResposta(respostas, object_to_send); // Tolerancia a falhas
            
        } catch (Exception ex) {
            System.err.println("ERRO AO ENVIAR A RESPOSTA");
            Logger.getLogger(DataManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    } 
    
    /**
     * Seleciona a resposta mais adequada
     * Tolerancia a falhas bizantinas
     * @param respostas
     * @param pedido
     * @return 
     */
    public Object selectResposta(Vector<Rsp> respostas, Object pedido)
    {           
        Vector<Resposta> resp = new Vector<>();
        boolean found = false;
        
        for (Rsp rsp : respostas) {
            for (int i = 0; i < resp.size(); i++) {
                if (resp.get(i).equals(rsp, pedido)) {
                    resp.get(i).count++;
                    found = true;
                }
            }
            if (!found) {
                Resposta nova = new Resposta(rsp);
                nova.count++;
                resp.add(nova);
                found = false;
            }
        }
        
        Resposta max = resp.get(0);
        for (Resposta r : resp) {
            if (r.count > max.count) {
                max = r;
            }
        }
        
        System.out.println("Numero de respostas iguais :"+String.valueOf(max.count));
        
        return max.resposta.getValue();
    }
    
}
