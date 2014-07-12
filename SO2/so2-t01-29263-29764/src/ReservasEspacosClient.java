package src;


import java.rmi.RMISecurityManager;
import java.util.Vector;
import java.util.Scanner;
import java.sql.Timestamp;
import java.util.InputMismatchException;
import java.util.NoSuchElementException;
import java.lang.IllegalStateException;
import java.rmi.RemoteException;

/**
 * Aplicacao do cliente com o menu principal e invocacao dos metodos remotos
 * @author marcussantos, ricardofusco
 */
public class ReservasEspacosClient {
    
    public String regHost; //hostname do binder
    public String regPort;  // porto do binder
    public Scanner sc;
    
    /**
     * Class constructor
     *
     * @param regHost
     * @param regPort
     */
    public ReservasEspacosClient(String regHost, String regPort){
        this.regHost = regHost;
        this.regPort = regPort;
        this.sc  = new Scanner(System.in);
    }
    
    /**
     * Menu do cliente
     *
     * @param objecto com a implementacao os metodos remotos
     */
    public void menu(ReservasEspacos obj) throws Exception
    {
        boolean run = true;
        int input = 0;
        
        while (run) {
            System.out.println("\t=============================================\n");
            System.out.println("\t\tMENU PRINCIPAL\n");
            System.out.println("\t=============================================\n");
            System.out.println("\t1 - Listar espacos\n\t2 - Verificar se um espaco está livre numa determinada data\n\t3 - Listar as reservas de um espaco num determinado dia");
            System.out.println("\t4 - Efetuar a reserva de um espaço em determinado período\n\t5 - Listar as reservas efetuadas por determinada pessoa");
            System.out.println("\t6 - Sair");
            System.out.println("\t=============================================\n");
            System.out.print(">> ");
            
            try{
                input = sc.nextInt();
                
                switch (input) {
                    case 1:
                        System.out.println("Listar espacos\n");
                        Vector<Espaco> espacos = obj.obterEspacosDisp();
                        
                        for(Espaco espaco:espacos) {
                            System.out.println(espaco);
                        }
                        
                        break;
                    case 2:
                        System.out.println("Verificar se um espaco está livre\n");
                        espacoLivre(obj);
                        break;
                    case 3:
                        System.out.println("Listar as reservas de um espaco num determinado dia\n");
                        listarReservasDia(obj);
                        break;
                    case 4:
                        System.out.println("Efetuar a reserva de um espaço em determinado período\n");
                        menuAdicionarReserva(obj);
                        break;
                    case 5:
                        System.out.println("Listar as reservas efetuadas por determinada pessoa\n");
			            System.out.print("Nome: >> ");
                        String nome = sc.next();
                        Vector<Reserva> reservas = obj.obterReservas(nome);
                        
                        if (!reservas.isEmpty()){
                            for(Reserva reserva: reservas) {
                                System.out.println(reserva.toString());
                            }
                        }
                        else
                            System.out.println("Nao existem reservas feitas por essa pessoa.");
                            
                        
                        break;
                    case 6:
                        run = false;
                        break;
                    default:
                        System.out.println("Opção inválida");
                        break;
                }
            }catch(InputMismatchException e) {
                System.err.println("Foi inserido um caractere invalido");
            }catch(NoSuchElementException e1) {
                System.err.println("Foi inserido um caractere invalido");
            }catch(IllegalStateException  e2) {
                System.err.println("Foi inserido um caractere invalido");
            }
        }
    }

    /**
     * Insere zeros à esquerda numa string caso
     * o seu tamanho seja 1
     * Tem cono objectivo ajudar a criar uma string
     * com o formato Timestamp ou Datetime
     * @param
     */
    public String insereZeros(String n) {
        return n.length() == 1? "0"+n : n;
    }
    
    /**
     * Lista as reservas de um determinado dia
     *
     * @param objecto com a implementacao os metodos remotos
     */
    public void listarReservasDia(ReservasEspacos obj){
        
        System.out.print("Espaco: >> ");
        String esp = sc.next();
        
        System.out.print("Ano: >> ");
        int ano = sc.nextInt();
        
        System.out.print("Mes: >> ");
        int mes = sc.nextInt();
        
        System.out.print("Dia: >> ");
        int dia = sc.nextInt();
        
        Vector<Reserva> reservas = new Vector<Reserva>();
        try {
            reservas = obj.obterResDia(esp, ano, mes, dia);
        }catch(RemoteException e) {
            e.printStackTrace();
        }
    
        if (!reservas.isEmpty()) {
            for(Reserva reserva:reservas) {
                System.out.println(reserva);
            }
        }
        else{
            System.out.println("Nao existem reservas para este espaco na data especificada.");
        }
        
    }
    
    /**
     * Submenu para verificar se um espaco esta livre num determinado dia e hora
     *
     * @param objecto com a implementacao os metodos remotos
     */
    public void espacoLivre(ReservasEspacos obj){
        
        System.out.print("Espaco: >> ");
        String esp = sc.next();
        
        System.out.print("Ano: >> ");
        int ano = sc.nextInt();
        
        System.out.print("Mes: >> ");
        int mes = sc.nextInt();
        
        System.out.print("Dia: >> ");
        int dia = sc.nextInt();
        
        System.out.print("Hora: >> ");
        int hora = sc.nextInt();
        
        System.out.print("Minutos: >> ");
        int min = sc.nextInt();
        
        String ts = String.valueOf(ano)+"-"+insereZeros(String.valueOf(mes))+"-"+insereZeros(String.valueOf(dia))+" "+insereZeros(String.valueOf(hora))+":"+insereZeros(String.valueOf(min))+":00";
        boolean livre = true;
        
        try{
            livre = obj.espacoLivDia(esp, ts);
            if (livre == true)
                System.out.println("O espaco especificado esta livre.\n");
            else
                System.out.println("O espaco especificado nao esta livre.\n");
        }catch(RemoteException e) {
            System.out.println("Ocorreu um erro ao verificar se o espaco esta liver\n");
        }
        
    }
    
    /**
     * Submenu para inserir uma reserva
     *
     * @param objecto com a implementacao os metodos remotos
     */
    public void menuAdicionarReserva(ReservasEspacos obj) throws InputMismatchException, NoSuchElementException, IllegalStateException, java.text.ParseException{
        
        Reserva reserva = null;
        
        String nome = "";
        String email = "";
        String sala = "";
        String local = "";
        
        System.out.print("Nome: >> ");
        nome = sc.next();
        System.out.print("Email: >> ");
        email = sc.next();
        System.out.print("Sala: >> ");
        sala = sc.next();
        System.out.print("Local: >> ");
        local = sc.next();
        
        System.out.println("Insira a data da reserva");
        System.out.print("Ano: >> ");
        int ano = sc.nextInt();
        
        System.out.print("Mes(Numerico): >> ");
        int mes = sc.nextInt();
        
        System.out.print("Dia: >> ");
        int dia = sc.nextInt();
        
        System.out.println("Insira a hora de inicio da reserva");
        System.out.print("Hora: >> ");
        int horaI = sc.nextInt();
        
        System.out.print("Minutos: >> ");
        int minI = sc.nextInt();
        
        System.out.println("Insira a hora de fim da reserva");
        System.out.print("Hora: >> ");
        int horaF = sc.nextInt();
        
        System.out.print("Minutos: >> ");
        int minF = sc.nextInt();
        
        String inicio = String.valueOf(ano)+"-"+insereZeros(String.valueOf(mes))+"-"+insereZeros(String.valueOf(dia))+" "+insereZeros(String.valueOf(horaI))+":"+insereZeros(String.valueOf(minI))+":00";
        String fim = String.valueOf(ano)+"-"+insereZeros(String.valueOf(mes))+"-"+insereZeros(String.valueOf(dia))+" "+insereZeros(String.valueOf(horaF))+":"+insereZeros(String.valueOf(minF))+":00";
        
        reserva = new Reserva(nome, email, sala, local, inicio, fim);
        
        
        if(reserva != null){
            try{
                System.out.println(obj.adicionarReserva(reserva));
            }catch(RemoteException e){
                System.err.println("Ocorreu um erro ao adicionar a reserva");
            }
            
        }else {
            System.err.println("Não foi possivel inserir a reserva");
        }
        
    }
    
    /**
     * Criar o objecto com a implementacao os metodos remotos
     * e corre o menu do cliente
     */
    public void run(){
        try {
            // objeto que fica associado ao proxy para objeto remoto
            ReservasEspacos obj = (ReservasEspacos) java.rmi.Naming.lookup("rmi://" + regHost + ":" +
                                                                           regPort + "/reservas");
            // invocacao de metodos remotos
            menu(obj);
            
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    
    public static void main(String args[]) {
        
        /*public String regHost = "localhost"; //hostname do binder
         public String regPort = "9000";  // porto do binder
         public String frase= "";*/
        
        if (args.length !=2) { // requer 3 argumentos
            System.out.println
            ("Usage: java so2.rmi.PalavrasClient registryHost registryPort");
            System.exit(1);
        }
        
        ReservasEspacosClient reservasEspacosClient =  new ReservasEspacosClient(args[0], args[1]);
        reservasEspacosClient.run();
        
        
    }
}
