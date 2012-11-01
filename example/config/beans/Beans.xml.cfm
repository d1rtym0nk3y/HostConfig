<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.coldspringframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:util="http://www.coldspringframework.org/schema/util"
	xsi:schemaLocation="http://www.coldspringframework.org/schema/beans http://coldspringframework.org/schema/coldspring-beans-2.0.xsd"
	default-autowire="byName" default-lazy-init="false"
>

<bean id="Config" class="example.config.cfc.Config">
	<constructor-arg name="environmentid" value="local" />
	<constructor-arg name="debug" value="true" />
	<constructor-arg name="datasource" ref="Config_datasource" />
</bean>

<bean id="Config_datasource" class="example.config.cfc.Config_datasource">
	<constructor-arg name="username" value="test" />
	<constructor-arg name="name" value="hostconfig_local" />
	<constructor-arg name="password" value="test" />
</bean>

</beans>