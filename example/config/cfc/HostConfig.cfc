component extends="HostConfig.AbstractBean" accessors="true" {
	
	property name="EnvironmentId";
	property name="Debug";
	property name="Datasource"; 
	
	public function init(EnvironmentId, Debug, Datasource) {
		setEnvironmentId(EnvironmentId);
		setDebug(Debug);
		setDatasource(Datasource); 			
	} 
}			
