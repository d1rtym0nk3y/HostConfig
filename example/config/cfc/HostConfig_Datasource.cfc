component extends="HostConfig.AbstractBean" accessors="true" {
	
	property name="username";
	property name="name";
	property name="password"; 
	
	public function init(username, name, password) {
		
		setusername(username);
		setname(name);
		setpassword(password); 			

	} 
	
}			
