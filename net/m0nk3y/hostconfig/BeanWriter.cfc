<cfcomponent>

<cfsavecontent variable="cs2header"><?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.coldspringframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:util="http://www.coldspringframework.org/schema/util"
	xsi:schemaLocation="http://www.coldspringframework.org/schema/beans http://coldspringframework.org/schema/coldspring-beans-2.0.xsd"
	default-autowire="byName" default-lazy-init="false"
>
</cfsavecontent>
	
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
		content.append(cs2header & chr(10));
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
		
		<cfscript>
       	var xml = createobject("java", "java.lang.StringBuilder");     
       	var i = "";
		
		xml.append('<bean id="#name#" class="#getDotPath(name)#">' & chr(10));
		for(var p in properties) {
			xml.append(chr(9));
			if(isStruct(properties[p])) {
				xml.append('<constructor-arg name="#p#" ref="#name#_#p#" />');	
			}
			else if(isArray(properties[p])) {
				xml.append('<constructor-arg name="#p#"><list>');
				for(var i in properties[p]) {
					xml.append('<value>#i#</value>');
				}
				xml.append('</list></constructor-arg>');
			}
			else {
				xml.append('<constructor-arg name="#p#" value="#xmlformat(properties[p])#" />');
			}
			xml.append(chr(10));
		}
		xml.append('</bean>');
		xml.append(chr(10));
		xml.append(chr(10));
		var xml = xml.toString();
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
		<cfargument name="name" default="Config" />
		<cfset var props = ListToArray(StructKeyList(properties)) />
		<cfset var p = "" />

<cfsavecontent variable="bean"><cfoutput>component<cfif len(config.BeanExtends)> extends="#config.BeanExtends#"</cfif> accessors="true" {
	<cfloop array="#props#" index="p">
	property name="#p#";</cfloop> 
	
	public function init(<cfloop from="1" to="#arraylen(props)#" index="p">#props[p]#<cfif p LT arraylen(props)>, </cfif></cfloop>) {
		<cfloop array="#props#" index="p">
		set#p#(arguments.#p#);</cfloop> 			
		return this;
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