component accessors="true"  {

	property name="EnvironmentID"; 

	function getAsStruct() {
		return deserializeJSON(serializeJSON(this));
	}
	

}