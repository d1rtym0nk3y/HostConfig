<cfcomponent>

	<cffunction name="init">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="read">
		<cfargument name="configFile">
		<cfset var cfg = "" />
		<cfsavecontent variable="cfg">
			<cfinclude template="#arguments.configFile#" />
		</cfsavecontent>
		
		<cftry>
			<cfset cfg = deserializeJSON(cfg) />
			
			<cfcatch type="Any" >
				<cfthrow message="Error parsing json config file">
			</cfcatch>
		</cftry>
		
		<cfreturn cfg />
	</cffunction>

</cfcomponent>