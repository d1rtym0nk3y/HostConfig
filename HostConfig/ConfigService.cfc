component {

	public any function init(configFile) {
		variables.config = new ConfigReader().read(configFile);
		variables.beanwriter = new BeanWriter(variables.config.config); 
		writeFiles();
		writelog("ec ran: (#cgi.PATH_INFO#) #cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#");
		return this;
	}
	
	public any function getConfigStruct() {
		var id = getEnvironmentIDFromUrl();
		var common = getCommonConfig();
		var target = getEnvironmentConfig(id);
		return structMerge(common, target);
	} 

	private any function writeFiles() {
		variables.beanwriter.createBeans(getConfigStruct());
		variables.beanwriter.createColdspringBeans(getConfigStruct());
	}
	
	private struct function getCommonConfig() {
		if(structKeyExists(variables.config, "common")) {
			return variables.config.common;	
		}
		return {};
	}
	
	private struct function getEnvironmentConfig(id) {
		if(len(id) && structKeyExists(variables.config, "environments") && structKeyExists(variables.config.environments, id)) {
			variables.config.environments[id]["environmentId"] = id;
			return variables.config.environments[id];
		}
		return {
			"environmentId" = "unknown"
		};
	}

	private string function getEnvironmentIDFromUrl() {
		var host = cgi.server_name;
		var patterns = variables.config.patterns;
		for(var id in patterns) {
			for(var p in patterns[id]) {
				if(refindnocase(p, host)) {
					return id;
				}
			}
		}
		return "";
	}

	/* merge str2 into str1, overwriting things as we go */
	private struct function structMerge(str1, str2) {
		var s1 = structCopy(str1);
		var s2 = structCopy(str2);
		
		for(var key in s2) {
			if(isStruct(s2[key])) {
				if( !structKeyExists(s1, key) ) s1[key] = {}; 	
				s1[key] = structMerge(s1[key], s2[key]);
			}
			else {
				s1[key] = s2[key];
			}
		}
		return s1;
	}

}