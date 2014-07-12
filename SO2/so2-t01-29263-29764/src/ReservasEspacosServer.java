package src;

import java.rmi.server.*;

/**
 * Class that implements the RMI interface rmi.helloworld.Hello.
 * skeleton importante para servidor, stub importante para servidor e cliente
 * @author marcussantos, ricardofusco
 */
public class ReservasEspacosServer {
    
    public static void main(String args[]) {
        // assume-se que o Servico de Nomes e' local
        // pode ser um processo autonomo ou
        // parte desta aplicacao servidor
        // aqui usamos o externo
        
        int regPort= 1099; // default
        
        if (args.length !=5) { // obrigar 'a presenca de 5 argumentos
            System.out.println("Usage: java so2.rmi.PalavrasServer host db user pw");
            System.exit(1);
        }
        
        
        try {
            // ATENCAO: este porto e' relativo ao binder e nao ao servidor RMI
            regPort=Integer.parseInt(args[0]);
            
            
            // criar um Objecto Remoto
            ReservasEspacos obj = new ReservasEspacosImpl(args[1], args[2], args[3], args[4]);
            
            
            // exportar o objecto para que ele possa receber pedidos
            // NOTA: nao seria necessario se "PalavrasImpl extends UnicastRemoteObject"
            ReservasEspacos stub = (ReservasEspacos) UnicastRemoteObject.exportObject(obj);
            System.out.println("Created RMI object");
            
            
            
            
            // registar este objecto no servico de nomes, para que os clientes
            // possam obter facilmente a sua referencia remota
            
            // usar o Registry local do porto regPort
            // q e' uma aplicacao externa
            java.rmi.registry.Registry registry = java.rmi.registry.LocateRegistry.getRegistry(regPort);
            // mas podiamos tb criar um novo,
            // integrado nesta aplicacao
            
            // ... e bind
            registry.rebind("reservas", stub);  // NOME DO SERVICO
            
            /*
             OUTRO MODO:
             java.rmi.Naming.rebind("rmi://"+regHost+":" +
             regPort + "/palavras", stub);
             
             */
            
            
            System.out.println("Bound RMI object in registry");
            System.out.println("servidor pronto");
            
            
        } 
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
