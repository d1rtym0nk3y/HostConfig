<?xml version="1.0" encoding="UTF-8"?>
<beans>

	<bean id="HostConfig" class="example.config.cfc.HostConfig">
	
		
		<constructor-arg name="environmentId"><value>local</value></constructor-arg>
		
	
		
		<constructor-arg name="Debug"><value>true</value></constructor-arg>
		
	
		
		<constructor-arg name="Datasource"><ref bean="HostConfig_Datasource" /></constructor-arg>
		
	
	</bean>

	<bean id="HostConfig_Datasource" class="example.config.cfc.HostConfig_Datasource">
	
		
		<constructor-arg name="username"><value>test</value></constructor-arg>
		
	
		
		<constructor-arg name="name"><value>hostconfig_demo</value></constructor-arg>
		
	
		
		<constructor-arg name="password"><value>test</value></constructor-arg>
		
	
	</bean>
</beans>