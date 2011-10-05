component extends="HostConfig.AbstractBean" accessors="true" {
	
	property name="environmentId";
	property name="Debug";
	property name="Datasource"; 
	
	public function init(environmentId, Debug, Datasource) {
		
		setenvironmentId(environmentId);
		setDebug(Debug);
		setDatasource(Datasource); 			

	} 
	
}			
