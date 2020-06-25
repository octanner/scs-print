component singleton {

	property name='settings' inject='coldbox:setting:print-helper';

	public function init() {
		return this;
	}

	public function print(
		required string printer,
		required string fullPath,
		numeric copies = 1,
		string layout  = 'portrait',
		numeric scale  = 100
	) {
		var fileExt = fileInformation( arguments.fullPath ).fileExtension;

		if ( listFindNoCase( 'pdf,txt', fileExt ) ) {
			try {
				return sendPrintRequest(
					printer       = arguments.printer,
					base64String  = fullPathToBase64( arguments.fullPath ),
					fileExtension = fileExt,
					copies        = arguments.copies,
					layout        = arguments.layout,
					scale         = arguments.scale
				);
			} catch ( any e ) {
				throw(
					message = 'Error Processing the Print Request.',
					detail  = e.detail
				);
			}
		} else {
			throw(
				message = 'Error Processing the Print Request.',
				detail  = 'You attempted to print a file with extension "' & fileExt & '". That extension is currently not allowed.'
			);
		}
	}

	public any function fileInformation( required string fullPath ) {
		var fileInfo          = getFileInfo( arguments.fullPath );
		var addtionalFileInfo = {
			'fileName' : listFirst(
				listLast( arguments.fullPath, '/*' ),
				'.'
			),
			'fileExtension' : listLast( arguments.fullPath, '/*.' )
		};
		structAppend( fileInfo, addtionalFileInfo, false );

		return fileInfo;
	}

	public function fullPathToBase64( required string fullPath ) {
		return toBase64( fileReadBinary( arguments.fullPath ) );
	}

	public any function sendPrintRequest(
		required string printer,
		required string base64String,
		required string fileExtension,
		numeric copies = 1,
		string layout  = 'portrait',
		numeric scale  = 100
	) {
		cfhttp(
			method  = 'post',
			charset = 'utf-8',
			url     = settings.apiUrl & '/print',
			result  = 'local.result'
		) {
			cfhttpparam(
				name  = 'printer',
				type  = 'formfield',
				value = arguments.printer
			);
			cfhttpparam(
				name  = 'base64String',
				type  = 'formfield',
				value = arguments.base64String
			);
			cfhttpparam(
				name  = 'fileExtension',
				type  = 'formfield',
				value = arguments.fileExtension
			);
			cfhttpparam(
				name  = 'copies',
				type  = 'formfield',
				value = arguments.copies
			);
			cfhttpparam(
				name  = 'layout',
				type  = 'formfield',
				value = arguments.layout
			);
			cfhttpparam(
				name  = 'scale',
				type  = 'formfield',
				value = arguments.scale
			);
		}

		return result;
	}

}
