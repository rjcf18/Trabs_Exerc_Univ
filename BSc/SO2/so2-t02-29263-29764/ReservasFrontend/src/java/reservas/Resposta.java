
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

package reservas;

import java.util.Vector;
import org.jgroups.util.Rsp;

/**
 * Esta classe é utilizada para efectuar a contagem das respostas iguais 
 * para verificar a existencia de falhas bizantinas
 * @author marcussantos
 */
public class Resposta {
    Rsp resposta;
    int count;
    
    public Resposta(Rsp resposta){
        this.resposta = resposta;
        count = 0;
    }
    
    public boolean equals(Rsp resp2, Object pedido)
    {
        if (pedido instanceof PedidoDispEsp || pedido instanceof PedidoListagemEspacos) {
            if (!isEqualEspaco((Vector<Espaco>)resposta.getValue(), (Vector<Espaco>)resp2.getValue())) {
                return false;
            }
        }else if (pedido instanceof PedidoListResDia || pedido instanceof PedidoListResPessoa) {
            
        }else if (pedido instanceof PedidoEfectuarRes) {
            
        }
             
        
        return true;
    }
    
    public boolean isEqualEspaco(Vector<Espaco> resp1, Vector<Espaco> resp2) {
        
        if (resp1.size() == 0) {
            return false;
        }
        
        for (int i = 0; i < resp1.size(); i++) {
            if (!resp1.get(i).equals(resp2.get(i))) {
                return false;
            }
        }
        
        return true;
    }
    
}
