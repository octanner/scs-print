component {

	// Module Properties
	this.title              = 'Print Helper';
	this.name               = 'print-helper';
	this.author             = 'Eduardo Gomez';
	this.webUrl             = 'https://github.com/octanner/scs-print-helper';
	this.description        = 'A nice module to Help prepare the http request to a printing api server';
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup   = true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint         = 'print-helper';
	// CF Mapping
	this.cfMapping          = 'print-helper';

	function configure() {
		settings = { 'apiUrl' : 'http:fakesite.com' };
	}

}
