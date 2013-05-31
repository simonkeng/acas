requiredScripts = [
	'/src/lib/jquery.min.js'
	'/src/lib/json2.js'
	'/src/lib/underscore.js'
	'/src/lib/backbone-min.js'
	#'/src/lib/backbone-localstorage.js'
	'/src/lib/bootstrap/bootstrap-tooltip.js'
	'/src/lib/jqueryFileUpload/js/vendor/jquery.ui.widget.js'
	'/src/lib/jqueryFileUpload/js/jquery.iframe-transport.js'
	'/src/lib/bootstrap/bootstrap.min.js'
	'/src/lib/jqueryFileUpload/tmpl.min.js'
	'/src/lib/jqueryFileUpload/js/jquery.iframe-transport.js'
	'/src/lib/jqueryFileUpload/js/jquery.fileupload.js'
	'/src/lib/jqueryFileUpload/js/jquery.fileupload-fp.js'
	'/src/lib/jqueryFileUpload/js/jquery.fileupload-ui.js'
	'/src/lib/jqueryFileUpload/js/locale.js'
	'/src/lib/jquery-ui-1.10.2.custom/js/jquery-ui-1.10.2.custom.min.js'
]

applicationScripts = [
	'/src/conf/configurationNode.js'
	'/src/conf/configuration.js'
	# For Components module
	'/javascripts/src/LSFileInput.js'
	'/javascripts/src/LSFileChooser.js'
	'/javascripts/src/LSErrorNotification.js'
	'/javascripts/src/AbstractFormController.js'
	'/javascripts/src/BasicFileValidateAndSave.js'
	# For serverAPI module
	'/javascripts/src/Label.js'
	'/javascripts/src/AnalysisGroup.js'
	'/javascripts/src/Experiment.js'
	'/javascripts/src/Protocol.js'
	#Primary Screen module
	'/javascripts/src/PrimaryScreenExperiment.js'
	'/javascripts/src/DoseResponseAnalysis.js'
	#Curve Analysis module
	'javascripts/src/CurveCurator.js'
	'javascripts/src/CurveCuratorAppController.js'
	# For ModuleMenus module
	'/javascripts/src/ModuleMenus.js'
	'/javascripts/src/ModuleLauncher.js'
	'/javascripts/src/ModuleMenusConfiguration.js'
	# For DocForBatchesModule
	'/javascripts/src/BatchListValidator.js'
	'/javascripts/src/DocUpload.js'
	'/javascripts/src/DocForBatches.js'
	'/javascripts/src/DocForBatchesConfiguration.js'
	#'javascripts/src/AppController.js'
	# For Generic Data Parser module
	'/javascripts/src/GenericDataParser.js'
	# For BulkLoadContainersFromSDF module
	'/javascripts/src/BulkLoadContainersFromSDF.js'
	# For BulkLoadSampleTransfers module
	'/javascripts/src/BulkLoadSampleTransfers.js'
	#Primary Screen module
	'/javascripts/src/PrimaryScreenExperiment.js'
]

exports.index = (req, res) ->
	#"use strict"
	global.specRunnerTestmode = false
	scriptsToLoad = requiredScripts.concat(applicationScripts)
	return res.render 'index',
		title: "ACAS Home"
		scripts: scriptsToLoad
		appParams:
#			loginUserName: 'jmcneil' #TODO replace hard-coded username with login and cookies
			loginUserName: req.user.username
			testMode: false


exports.specRunner = (req, res) ->
	"use strict"
	global.specRunnerTestmode = true

	jasmineScripts = [
		'src/lib/testLibraries/jasmine-jstd-adapter/jasmine/lib/jasmine-core/jasmine.js'
		'src/lib/testLibraries/jasmine-jstd-adapter/jasmine/lib/jasmine-core/jasmine-html.js'
		'src/lib/testLibraries/jasmine-jquery/lib/jasmine-jquery.js'
		'src/lib/testLibraries/sinon.js'
	]

	specScripts = [
		#For login module
		'javascripts/spec/dnsAuthenticationServiceSpec.js'
		# For serverAPI module
		'javascripts/spec/PreferredBatchIdServiceSpec.js'
		'javascripts/spec/ProtocolServiceSpec.js'
		'javascripts/spec/ExperimentServiceSpec.js'
		'javascripts/spec/LabelSpec.js'
		'javascripts/spec/ExperimentSpec.js'
		'javascripts/spec/ProtocolSpec.js'
		'javascripts/spec/AnalysisGroupSpec.js'
		'javascripts/spec/testFixtures/ExperimentServiceTestJSON.js'
		'javascripts/spec/testFixtures/ProtocolServiceTestJSON.js'
		#Primary Screen module
		'javascripts/spec/RunPrimaryScreenAnalysisServiceSpec.js'
		'javascripts/spec/PrimaryScreenExperimentSpec.js'
		'javascripts/spec/DoseResponseAnalysisSpec.js'
		#Curve Analysis module
		'javascripts/spec/CurveCuratorServiceSpec.js'
		'javascripts/spec/CurveCuratorSpec.js'
		'javascripts/spec/testFixtures/curveCuratorTestFixtures.js'
		# For ModuleMenus module
		'javascripts/spec/ModuleMenusSpec.js'
		'javascripts/spec/ModuleLauncherSpec.js'
		# For Components module
		'javascripts/spec/LSFileInputSpec.js'
		'javascripts/spec/LSFileChooserSpec.js'
		'javascripts/spec/LSErrorNotificationSpec.js'
		'javascripts/spec/ProjectsServiceSpec.js'
		'src/modules/DocForBatches/spec/testFixtures/testJSON.js'
		# For DocForBatchesModule
		'javascripts/spec/BatchListValidatorSpec.js'
		'javascripts/spec/DocUploadSpec.js'
		'javascripts/spec/DocForBatchesSpec.js'
		'javascripts/spec/DocForBatchesServiceSpec.js'
		# For Generic Data Parser module
		'javascripts/spec/GenericDataParserSpec.js'
		'javascripts/spec/GenericDataParserServiceSpec.js'
		# For BulkLoadContainersFromSDF module
		'javascripts/spec/BulkLoadContainersFromSDFSpec.js'
		'javascripts/spec/BulkLoadContainersFromSDFServerSpec.js'
		# For BulkloadSampleTransfersSpec module
		'javascripts/spec/BulkloadSampleTransfersSpec.js'
		'javascripts/spec/BulkloadSampleTransfersServerSpec.js'
		#For ServerUtility testing module
		'javascripts/spec/ServerUtilityFunctionsSpec.js'
	]

	scriptsToLoad = requiredScripts.concat(jasmineScripts, specScripts)
	scriptsToLoad = scriptsToLoad.concat(applicationScripts)

	res.render('SpecRunner', {
		title: 'SeuratAddOns SpecRunner',
		scripts: scriptsToLoad
		appParams:
			loginUserName: 'jmcneil'
			testMode: true
	})

exports.liveServiceSpecRunner = (req, res) ->
	"use strict"
	global.specRunnerTestmode = false
	jasmineScripts = [
		'src/lib/testLibraries/jasmine-jstd-adapter/jasmine/lib/jasmine-core/jasmine.js'
		'src/lib/testLibraries/jasmine-jstd-adapter/jasmine/lib/jasmine-core/jasmine-html.js'
		'src/lib/testLibraries/jasmine-jquery/lib/jasmine-jquery.js'
		'src/lib/testLibraries/sinon.js'
	]

	specScripts = [
		# For Components module
		'javascripts/spec/ProjectsServiceSpec.js'
		# For serverAPI module
		'javascripts/spec/PreferredBatchIdServiceSpec.js'
		#For login module
		'javascripts/spec/dnsAuthenticationServiceSpec.js'
	]

	scriptsToLoad = requiredScripts.concat(jasmineScripts, specScripts)
	scriptsToLoad = scriptsToLoad.concat(applicationScripts)

	res.render('LiveServiceSpecRunner', {
	title: 'SeuratAddOns LiveServiceSpecRunner',
	scripts: scriptsToLoad
	appParams:
		loginUserName: 'jmcneil'
		testMode: false
		liveServiceTest: true
	})

