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

package map;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author ricardo, marcus
 */
public class Map {
    static BD bd;
    String fileName;
    
    public Map(String fileName){
        this.fileName = fileName;
    }
    
    public byte[] generateByteArray() throws FileNotFoundException, UnsupportedEncodingException{
        String digestStr = "";
        byte[] digestBytes = new byte[2048];
        Vector<String> reservas = bd.executeQueryGetAllReservas();
        //BufferedWriter wr;
        PrintWriter wr = new PrintWriter(fileName, "UTF-8");
        
        try{
            //File f = new File(fileName);
                        
            for(String reserva: reservas){
                digestStr += reserva;
                wr.println(reserva);
            }
            
            wr.close();
            
            digestBytes = digestStr.getBytes();
            
            
        }catch(Exception ex){
            ex.printStackTrace();
        }
        
        return digestBytes;
    }
    
    public String generateDigest(byte[] digestBytes) throws NoSuchAlgorithmException{
        MessageDigest d = MessageDigest.getInstance("SHA1");
        d.update(digestBytes);
        
        byte[] digArr = d.digest();
        
        BigInteger bigInt = new BigInteger(1, digArr);
        
        String hex = bigInt.toString(16);
        
        return hex;
    }
    
    public boolean compareDigest(String dig1, String dig2){
        return dig1.equals(dig2);
    }
    
    public void storeDigest(String digest){
        try {
            PrintWriter wr = new PrintWriter("hash.txt", "UTF-8");
            
            wr.println(digest);
            
            wr.close();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Map.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(Map.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        System.out.println("Digest (hex) guardado no ficheiro hash.txt!");
    }
    
    public String processFile(String filename) throws FileNotFoundException, IOException{
        File f = new File(filename);
        FileReader fr = new FileReader(f.getAbsoluteFile().getAbsolutePath());
       	BufferedReader reader = new BufferedReader(fr);
        StringBuilder sb = new StringBuilder();
        String line;
        
        while((line = reader.readLine())!= null){
            sb.append(line);
        }
        
        reader.close();
        fr.close();
        
        return sb.toString();
    }
    
    public static void main(String[] args) throws FileNotFoundException, UnsupportedEncodingException, NoSuchAlgorithmException, IOException {
        // 
        bd = new BD(args[0], args[1], args[2], args[3], args[4]);
        boolean verified = false;
        int opc = Integer.parseInt(args[5]);
        
        if(opc == 1){
            Map m = new Map("mapa_2014.csv");
            byte[] digestBytes = m.generateByteArray();
            String digest = m.generateDigest(digestBytes);
            m.storeDigest(digest);
        }
        else{
            Map m = new Map("mapa_2014.csv");
            String csv = m.processFile("mapa_2014.csv");
            
            csv = m.generateDigest(csv.getBytes());
            
            String hash = m.processFile("hash.txt");
            verified = m.compareDigest(csv, hash);
            
            if(verified)
                System.out.println("Integridade do ficheiro validada!!");
            else
                System.out.println("Ficheiro nao validado.\nIntegridade do ficheiro nao validada!!");
        }
        
    }
    
}
