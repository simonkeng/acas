exports.requiredScripts = [
	'/src/lib/jquery.min.js',
	'/src/lib/json2.js',
	'/src/lib/underscore.js',
	'/src/lib/backbone-min.js',
	'/src/lib/bootstrap/bootstrap-tooltip.js',
	'/src/lib/bootstrap-tagsinput/bootstrap-tagsinput.min.js',
	'/src/lib/jqueryFileUpload/js/vendor/jquery.ui.widget.js',
	'/src/lib/jqueryFileUpload/js/jquery.iframe-transport.js',
	'/src/lib/bootstrap/bootstrap.min.js',
	'/src/lib/jqueryFileUpload/tmpl.min.js',
	'/src/lib/jqueryFileUpload/js/jquery.iframe-transport.js',
	'/src/lib/jqueryFileUpload/js/jquery.fileupload.js',
	'/src/lib/jqueryFileUpload/js/jquery.fileupload-fp.js',
	'/src/lib/jqueryFileUpload/js/jquery.fileupload-ui.js',
	'/src/lib/jqueryFileUpload/js/locale.js',
	'/src/lib/jquery-ui-1.10.2.custom/js/jquery-ui-1.10.2.custom.min.js'
];

exports.applicationScripts = [
	'/src/conf/conf.js',
	'/javascripts/src/LSFileInput.js',
	'/javascripts/src/LSFileChooser.js',
	'/javascripts/src/LSErrorNotification.js',
	'/javascripts/src/AbstractFormController.js',
	'/javascripts/src/AbstractParserFormController.js',
	'/javascripts/src/BasicFileValidateAndSave.js',
	'/javascripts/src/PickList.js',
	'/javascripts/src/Label.js',
	'/javascripts/src/AnalysisGroup.js',
	'/javascripts/src/Experiment.js',
	'/javascripts/src/Protocol.js'//APPLICATIONSCRIPTS_TO_BE_REPLACED_BY_PREPAREMODULEINCLUDES
];

exports.jasmineScripts = [
	'src/lib/testLibraries/jasmine-jstd-adapter/jasmine/lib/jasmine-core/jasmine.js',
	'src/lib/testLibraries/jasmine-jstd-adapter/jasmine/lib/jasmine-core/jasmine-html.js',
	'src/lib/testLibraries/jasmine-jquery/lib/jasmine-jquery.js',
	'src/lib/testLibraries/sinon.js'
];

exports.specScripts = [
	'src/modules/DocForBatches/spec/testFixtures/testJSON.js',
	'javascripts/spec/ExperimentSpec.js',
	'javascripts/spec/BatchListValidatorSpec.js',
	'javascripts/spec/DocUploadSpec.js',
	'javascripts/spec/DocForBatchesSpec.js'//SPECSCRIPTS_TO_BE_REPLACED_BY_PREPAREMODULEINCLUDES
]