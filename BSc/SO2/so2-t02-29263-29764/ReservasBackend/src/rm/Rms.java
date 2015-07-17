/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rm;

import java.util.Vector;

/**
 *
 * @author marcussantos
 */
public class Rms {
    
    private Vector<ReservasEspacosImpl> rms;
    private int nReplicas;
    
    
    public Rms(int nReplicas, Vector<BdAuthentication> auths)
    {
        if (nReplicas == auths.size()) {
            this.nReplicas = nReplicas;
            rms = new Vector<>(this.nReplicas);

            for (int i = 1; i < nReplicas+1; i++) {
                rms.add(new ReservasEspacosImpl(auths.get(i-1).getHost(),
                        auths.get(i-1).getBd(), auths.get(i-1).getUser(),
                        auths.get(i-1).getPwd(), String.valueOf(i)));
            }
        }else{
            throw new ExceptionInInitializerError();
        }
        
    }
    
    public Vector<ReservasEspacosImpl> getRms()
    {
        return this.rms;
    }
    
    
}
