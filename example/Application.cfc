component {

	this.name = hash(getCurrentTemplatePath());

	/* GET ENVIRONMENT SPECIFIC PROPERTIES*/
	if(!structKeyExists(server, "config_#this.name#") OR !isNull(url.init)) {
		server["config_#this.name#"] = new HostConfig.ConfigService("/example/config/HostConfig.json.cfm"); 
	}
	this.config = server["config_#this.name#"].getConfigStruct();

	function onApplicationStart() {
		
	}
	
	function onRequestStart() {
		writeDump(this.config);
	}


}