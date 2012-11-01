component extends="HostConfig.AbstractBean" accessors="true" {
	
	property name="environmentid";
	property name="debug";
	property name="datasource"; 
	
	public function init(environmentid, debug, datasource) {
		
		setenvironmentid(arguments.environmentid);
		setdebug(arguments.debug);
		setdatasource(arguments.datasource); 			
		return this;
	} 
	
}			
