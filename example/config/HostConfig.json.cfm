<cfoutput>
{
	"patterns": {
		"local": ["^hc.dev"],
		"production": ["^mysite.com", "^www.mysite.com"]
	},
	
	"config": {
		"BeanPath": "/example/config/cfc/",
		"BeanExtends": "HostConfig.AbstractBean",
		"ColdspringBeanFile": "/example/config/beans/Beans.xml.cfm"
	},

	"common": {
		"Debug": true,
		"Datasource": {
			"name": "hostconfig_demo",
			"username": "test",
			"password": "test"
		}
	},
	
	"environments": {
		"local": {
		},
		
		"production": {
			"debug": false
		}

	}
		
}
</cfoutput>
