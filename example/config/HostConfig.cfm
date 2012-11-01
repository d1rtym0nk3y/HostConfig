<cfscript>
config = {
	
	// define url patterns for each of your environments
	patterns: {
		local: ["^hostconfig.dev"],
		production: ["^mysite.com", "^www.mysite.com"]
	},
	
	// configure hostconfig to write beans
	config: {
		writebeans: true,
		basebeanname: "Config",
		beanpath: "/example/config/cfc/",
		beanextends: "HostConfig.AbstractBean",
		coldspringbeanfile: "/example/config/beans/Beans.xml.cfm"
	},

	common: {
		debug: true,
		datasource: {
			name: "hostconfig",
			username: "test",
			password: "test"
		}
	},
	
	environments: {
		local: {
			datasource: {
				name: "hostconfig_local"
			}
		},
		
		production: {
			debug: false
		}
	}
	
};
</cfscript>
