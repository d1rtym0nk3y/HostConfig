component {

	public any function init(configFile) {
		include configFile;
		if(isNull(variables.config)) {
			throw(message="configfile didn't create CONFIG variable");
		}
		param name="variables.config.config.writebeans" default="false";
		if(variables.config.config.writebeans) {
			writeFiles();
		}
		return this;
	}
	
	public any function getConfig() {
		var id = getEnvironmentIDFromUrl();
		var common = getCommonConfig();
		var target = getEnvironmentConfig(id);
		return structMerge(common, target);
	} 

	private any function writeFiles() {
		var beanwriter = new BeanWriter(variables.config.config);
		beanwriter.createBeans(getConfig());
		beanwriter.createColdspringBeans(getConfig());
	}
	
	private struct function getCommonConfig() {
		if(structKeyExists(variables.config, "common")) {
			return variables.config.common;	
		}
		return {};
	}
	
	private struct function getEnvironmentConfig(id) {
		if(len(id) && structKeyExists(variables.config, "environments") && structKeyExists(variables.config.environments, id)) {
			variables.config.environments[id]["environmentid"] = id;
			return variables.config.environments[id];
		}
		return {
			"environmentid" = "unknown"
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
		if(structKeyExists(variables.config, "defaultEnvironment")) {
			return variables.config.defaultEnvironment;
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