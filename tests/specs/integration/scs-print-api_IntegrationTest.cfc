component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {
    function run() {
        describe( "scs-print", function() {
            it( "can read a PDF file and retunr a base64String", function() {
                expect( false ).toBeTrue();
            } );
            // it( "can send a request to the scs-print-api and return a 200 status code", function() {
            //     expect( false ).toBeTrue();
            // } );            
        } );
    }
}