package beans;
public class User implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    public String status(int mybal,int tbal,int c) {
    	int rb=mybal+tbal/c;
    	if(rb>0) {
    		return "You need to pay : "+rb;
    	}
    	else {
    		return "You will be paid : "+rb*-1;
    	}
    }
}
