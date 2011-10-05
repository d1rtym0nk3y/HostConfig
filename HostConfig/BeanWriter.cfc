<cfcomponent>
<cfscript>
	
	public any function init(config) {
		variables.config = config;
		param name="variables.config.BeanExtends" default="";
		return this;
	}
	
	private function getDotPath(name) {
		var path = arrayToList(listToArray(replace("#config.beanpath#.#name#", "/", ".", "all" ), "."), ".");
		return path;
	}
	
	public function createColdspringBeans(properties) {
		var csfile = expandpath(config.ColdspringBeanFile);
		var tmpdir = getDirectoryFromPath(csfile) & createuuid();
		directoryCreate(tmpdir);
		
		writeColdspringBeanDef(properties=properties, tmpdir=tmpdir);
		
		var beans = directoryList(tmpdir, false, "array", "*.xml.ectmp");
		var content = createobject("java", "java.lang.StringBuilder");
		content.append('<?xml version="1.0" encoding="UTF-8"?>' & chr(10));
		content.append("<beans>" & chr(10));
		for(var b in beans) {
			content.append(fileRead(b));
		}
		content.append("</beans>");
		
		fileWrite(csfile, content.toString());
		directoryDelete(tmpdir, true);		
	}
	

</cfscript>



	<cffunction name="writeColdspringBeanDef" access="private">
		<cfargument name="properties" type="struct" />
		<cfargument name="name" default="Config" />
		<cfargument name="tmpdir" default="#getTempDirectory()#" />
		<cfset var p = "" />
		<cfset var xml = "" />
		
<cfsavecontent variable="xml"><cfoutput>
	<bean id="#name#" class="#getDotPath(name)#">
	<cfloop collection="#properties#" item="p">
		<cfif isStruct(properties[p])>
		<constructor-arg name="#p#"><ref bean="#name#_#p#" /></constructor-arg>
		<cfelse>
		<constructor-arg name="#p#"><value>#properties[p]#</value></constructor-arg>
		</cfif>
	</cfloop>
	</bean>
</cfoutput></cfsavecontent>

		<cfscript>
		var beanfile = "#tmpdir#/#name#.xml.ectmp";
		fileWrite(beanfile, xml);
		
		for(p in properties) {
			if(isStruct(properties[p])) { 
				writeColdspringBeanDef(properties[p], "#name#_#p#", tmpdir);			
			}			
		}
		
		</cfscript>
		
		
	</cffunction>

	
	<cffunction name="createBeans">
		<cfargument name="properties" type="struct" />
		<cfargument name="name" default="HostConfig" />
		<cfset var props = ListToArray(StructKeyList(properties)) />
		<cfset var p = "" />

<cfsavecontent variable="bean"><cfoutput>component<cfif len(config.BeanExtends)> extends="#config.BeanExtends#"</cfif> accessors="true" {
	<cfloop array="#props#" index="p">
	property name="#p#";</cfloop> 
	
	public function init(<cfloop from="1" to="#arraylen(props)#" index="p">#props[p]#<cfif p LT arraylen(props)>, </cfif></cfloop>) {
		<cfloop array="#props#" index="p">
		set#p#(#p#);</cfloop> 			

	} 
	
}			
</cfoutput></cfsavecontent>

		<cfscript>
		var beanfile = expandpath("#config.BeanPath#/#name#.cfc");
		fileWrite(beanfile, bean);
		
		for(p in properties) {
			if(isStruct(properties[p])) {
				createBeans(properties[p], "#name#_#p#");			
			}			
		}
		
		</cfscript>

	</cffunction>
	
</cfcomponent>