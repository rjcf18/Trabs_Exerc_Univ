/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rm;

import java.util.Vector;
import reservas.Espaco;
import reservas.Reserva;

/**
 *
 * @author marcussantos
 */
public class Dictionary {

    private Vector<Espaco> respostaEspaco;
    private Vector<Reserva> respostaReserva;
    private int count;

    public Dictionary() {
        respostaEspaco = new Vector<>();
        respostaReserva = new Vector<>();
        count = 0;
    }

    public Vector<Espaco> getRespostaEspaco() {
        return respostaEspaco;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
    
    public void setRespostaEspaco(Vector<Espaco> respostaEspaco) {
        this.respostaEspaco = respostaEspaco;
    }

    public Vector<Reserva> getRespostaReserva() {
        return respostaReserva;
    }

    public void setRespostaReserva(Vector<Reserva> respostaReserva) {
        this.respostaReserva = respostaReserva;
    }
    
    public void increment()
    {
        this.count++;
    }

    public boolean isEqualEspaco(Vector<Espaco> resp) {
        
        if (this.respostaEspaco.size() == 0) {
            return false;
        }
        
        boolean equal = true;

        for (int i = 0; i < this.respostaEspaco.size(); i++) {
            if (!resp.get(i).equals(this.respostaEspaco.get(i))) {
                return false;
            }
        }
        this.count++;
        return equal;
    }

    public boolean isEqualReserva(Vector<Reserva> resp) {
        
        if (this.respostaReserva.size() == 0) {
            return false;
        }
        
        for (int i = 0; i < this.respostaReserva.size(); i++) {
            if (!resp.get(i).equals(this.respostaReserva.get(i))) {
                return false;
            }
        }
        
        return true;
    }
}
