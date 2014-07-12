/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rm;

/**
 * 
 * @author marcussantos
 */
public class BdAuthentication {
    
    private String host;
    private String bd;
    private String user;
    private String pwd;
    
    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getBd() {
        return bd;
    }

    public void setBd(String bd) {
        this.bd = bd;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }
    
    public BdAuthentication(String host, String bd, String user, String pwd)
    {
        setHost(host);
        setBd(bd);
        setUser(user);
        setPwd(pwd);
    }
    
}
