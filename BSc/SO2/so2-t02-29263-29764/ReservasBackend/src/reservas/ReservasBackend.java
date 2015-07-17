/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package reservas;

/**
 *
 * @author marcussantos
 */
public class ReservasBackend {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        DataManager dm = new DataManager(args[0], args[1], args[2], args[3], args[4]);
        dm.openChannel();
    }
    
}
