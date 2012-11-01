component extends="HostConfig.AbstractBean" accessors="true" {
	
	property name="username";
	property name="name";
	property name="password"; 
	
	public function init(username, name, password) {
		
		setusername(arguments.username);
		setname(arguments.name);
		setpassword(arguments.password); 			
		return this;
	} 
	
}			
