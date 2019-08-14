component singleton
{
    property name="settings" inject="coldbox:setting:scs-print";

    public function init(){
        return this;
    }

    public function print(
        required string printer,
        required string fullPath,
        numeric copies = 1,
        string layout = "portrait",
        numeric scale = 100
    ){
        var fileExt = fileNameInfo(arguments.fullPath).fileExtension;

        if ( isAllowedFileExtensions(fileExt) ){
            try {
                sendPrintRequest(
                    printer = arguments.printer,
                    base64String = fullPathToBase64( arguments.fullPath ),
                    fileExtension = fileExt,
                    copies = arguments.copies,
                    layout = arguments.layout,
                    scale = arguments.scale
                );
            }
            catch (any e) {
                var customMessage = ": Error Sending the Print Request: """ & e.Detail & ".";
                e.detail = customMessage;
                rethrow;          
            }
        }
        else{
            throw( message="Error: Processing the Print Request.",
                detail="You attempted to print a file with extension """ & fileExt & """. That extension is currently not allowed."
             );
        }
    }

    public any function fileNameInfo(required fileFullPath){
        var tempFileInfo = getFileInfo(arguments.fileFullPath);
        var additionalFields = {
            "fileName": ListFirst( ListLast(arguments.fileFullPath,"/*"),"."),
            "fileExtension":ListLast(arguments.fileFullPath,"/*.")
        };
        StructAppend(tempFileInfo, additionalFields, false);
        
        return tempFileInfo;
    }

    public boolean function isAllowedFileExtensions( required fileExtention ){
        var booleanResponse = false;
        switch( LCase(arguments.fileExtention) ) {
            case "txt":
                booleanResponse = false;
                break;
            case "pdf":
                booleanResponse = true;
                break;
            case "xls":
                booleanResponse = false;
                break;                
            default: 
                booleanResponse = false;
                break;
        }

        return booleanResponse;
    }

    public function fullPathToBase64( required fullPath ){
        return toBase64(fileReadBinary(arguments.fullPath));
    }

    public any function sendPrintRequest(
            required string printer,
            required string base64String,
            required string fileExtension,
            numeric copies = 1,
            string layout = "portrait",
            numeric scale = 100
    ){
       
        cfhttp(
            method = "post",
            charset = "utf-8",
            url = settings.apiUrl,
            result = "result"
        ) {
            cfhttpparam( name = "printer", type = "formfield", value = arguments.printer);
            cfhttpparam( name = "base64String", type = "formfield", value = arguments.base64String);
            cfhttpparam( name = "fileExtension", type = "formfield", value = arguments.fileExtension);
            cfhttpparam( name = "copies", type = "formfield", value = arguments.copies);
            cfhttpparam( name = "layout", type = "formfield", value = arguments.layout);
            cfhttpparam( name = "scale", type = "formfield", value = arguments.scale);
        }

        return result;
    }

}