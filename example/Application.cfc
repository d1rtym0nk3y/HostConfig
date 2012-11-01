import net.m0nk3y.hostconfig.*;

component {

	this.name = hash(getCurrentTemplatePath());

	this.config = new HostConfig("/example/config/HostConfig.cfm").getConfig();

	function onApplicationStart() {
		/* here you can create a coldspring bean factory and load the beans created by host config
		 in the example they'll be in /example/config/beans/Beans.xml.cfm
		 to use values from your HostConfig beans in other coldspring files use 
		
		<constructor-arg name="email">
			<bean factory-bean="HostConfig" factory-method="getContactEmail" />
		</constructor-arg>
		*/
	}
	
	function onRequestStart() {
		writeDump(this.config);
	}


}