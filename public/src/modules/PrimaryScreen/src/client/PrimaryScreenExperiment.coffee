class window.PrimaryScreenAnalysisParameters extends Backbone.Model
	defaults:
		transformationRule: "unassigned"
		normalizationRule: "unassigned"
		hitEfficacyThreshold: null
		hitSDThreshold: null
		positiveControl: new Backbone.Model()
		negativeControl: new Backbone.Model()
		vehicleControl: new Backbone.Model()
		agonistControl: new Backbone.Model()
		thresholdType: "sd"

	initialize: ->
		@fixCompositeClasses()


	fixCompositeClasses: =>
		if @get('positiveControl') not instanceof Backbone.Model
			@set positiveControl: new Backbone.Model(@get('positiveControl'))
		@get('positiveControl').on "change", =>
			@trigger 'change'
		if @get('negativeControl') not instanceof Backbone.Model
			@set negativeControl: new Backbone.Model(@get('negativeControl'))
		@get('negativeControl').on "change", =>
			@trigger 'change'
		if @get('vehicleControl') not instanceof Backbone.Model
			@set vehicleControl: new Backbone.Model(@get('vehicleControl'))
		@get('vehicleControl').on "change", =>
			@trigger 'change'
		if @get('agonistControl') not instanceof Backbone.Model
			@set agonistControl: new Backbone.Model(@get('agonistControl'))
		@get('agonistControl').on "change", =>
			@trigger 'change'

	validate: (attrs) ->
		errors = []
		positiveControl = @get('positiveControl').get('batchCode')
		if positiveControl is "" or positiveControl is undefined
			errors.push
				attribute: 'positiveControlBatch'
				message: "Positive control batch much be set"
		positiveControlConc = @get('positiveControl').get('concentration')
		if _.isNaN(positiveControlConc) || positiveControlConc is undefined
			errors.push
				attribute: 'positiveControlConc'
				message: "Positive control conc much be set"
		negativeControl = @get('negativeControl').get('batchCode')
		if negativeControl is "" or negativeControl is undefined
			errors.push
				attribute: 'negativeControlBatch'
				message: "Negative control batch much be set"
		negativeControlConc = @get('negativeControl').get('concentration')
		if _.isNaN(negativeControlConc) || negativeControlConc is undefined
			errors.push
				attribute: 'negativeControlConc'
				message: "Negative control conc much be set"
		agonistControl = @get('agonistControl').get('batchCode')
		if agonistControl is "" or agonistControl is undefined
			errors.push
				attribute: 'agonistControlBatch'
				message: "Agonist control batch much be set"
		agonistControlConc = @get('agonistControl').get('concentration')
		if _.isNaN(agonistControlConc) || agonistControlConc is undefined
			errors.push
				attribute: 'agonistControlConc'
				message: "Agonist control conc much be set"
		vehicleControl = @get('vehicleControl').get('batchCode')
		if vehicleControl is "" or vehicleControl is undefined
			errors.push
				attribute: 'vehicleControlBatch'
				message: "Vehicle control must be set"
		if attrs.transformationRule is "unassigned" or attrs.transformationRule is ""
			errors.push
				attribute: 'transformationRule'
				message: "Transformation rule must be assigned"
		if attrs.normalizationRule is "unassigned" or attrs.normalizationRule is ""
			errors.push
				attribute: 'normalizationRule'
				message: "Normalization rule must be assigned"
		if attrs.thresholdType == "sd" && _.isNaN(attrs.hitSDThreshold)
			errors.push
				attribute: 'hitSDThreshold'
				message: "SD threshold must be assigned"
		if attrs.thresholdType == "efficacy" && _.isNaN(attrs.hitEfficacyThreshold)
			errors.push
				attribute: 'hitEfficacyThreshold'
				message: "Efficacy threshold must be assigned"

		if errors.length > 0
			return errors
		else
			return null

class window.PrimaryScreenExperiment extends Experiment
	getAnalysisParameters: ->
		ap = @.get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "clobValue", "data analysis parameters"
		if ap.get('clobValue')?
			return new PrimaryScreenAnalysisParameters $.parseJSON(ap.get('clobValue'))
		else
			return new PrimaryScreenAnalysisParameters()

	getModelFitParameters: ->
		ap = @.get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "clobValue", "model fit parameters"
		if ap.get('clobValue')?
			return $.parseJSON(ap.get('clobValue'))
		else
			return {}

	getAnalysisStatus: ->
		status = @get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "stringValue", "analysis status"
		if !status.has('stringValue')
			status.set stringValue: "not started"

		status

	getAnalysisResultHTML: ->
		result = @get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "clobValue", "analysis result html"
		if !result.has('clobValue')
			result.set clobValue: ""

		result

	getModelFitStatus: ->
		status = @get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "stringValue", "model fit status"
		if !status.has('stringValue')
			status.set stringValue: "not started"

		status

	getModelFitResultHTML: ->
		result = @get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "clobValue", "model fit result html"
		if !result.has('clobValue')
			result.set clobValue: ""

		result

class window.PrimaryScreenAnalysisParametersController extends AbstractParserFormController
	template: _.template($("#PrimaryScreenAnalysisParametersView").html())
	autofillTemplate: _.template($("#PrimaryScreenAnalysisParametersAutofillView").html())

	events:
		"change .bv_transformationRule": "attributeChanged"
		"change .bv_normalizationRule": "attributeChanged"
		"change .bv_transformationRule": "attributeChanged"
		"change .bv_hitEfficacyThreshold": "attributeChanged"
		"change .bv_hitSDThreshold": "attributeChanged"
		"change .bv_positiveControlBatch": "attributeChanged"
		"change .bv_positiveControlConc": "attributeChanged"
		"change .bv_negativeControlBatch": "attributeChanged"
		"change .bv_negativeControlConc": "attributeChanged"
		"change .bv_vehicleControlBatch": "attributeChanged"
		"change .bv_agonistControlBatch": "attributeChanged"
		"change .bv_agonistControlConc": "attributeChanged"
		"change .bv_thresholdTypeEfficacy": "handleThresholdTypeChanged"
		"change .bv_thresholdTypeSD": "handleThresholdTypeChanged"

	initialize: ->
		@errorOwnerName = 'PrimaryScreenAnalysisParametersController'
		super()

	render: =>
		@$('.bv_autofillSection').empty()
		@$('.bv_autofillSection').html @autofillTemplate(@model.attributes)
		@$('.bv_transformationRule').val(@model.get('transformationRule'))
		@$('.bv_normalizationRule').val(@model.get('normalizationRule'))

		@

	updateModel: =>
		@model.set
			transformationRule: @$('.bv_transformationRule').val()
			normalizationRule: @$('.bv_normalizationRule').val()
			hitEfficacyThreshold: parseFloat(@getTrimmedInput('.bv_hitEfficacyThreshold'))
			hitSDThreshold: parseFloat(@getTrimmedInput('.bv_hitSDThreshold'))
		@model.get('positiveControl').set
			batchCode: @getTrimmedInput('.bv_positiveControlBatch')
			concentration: parseFloat(@getTrimmedInput('.bv_positiveControlConc'))
		@model.get('negativeControl').set
			batchCode: @getTrimmedInput('.bv_negativeControlBatch')
			concentration: parseFloat(@getTrimmedInput('.bv_negativeControlConc'))
		@model.get('vehicleControl').set
			batchCode: @getTrimmedInput('.bv_vehicleControlBatch')
			concentration: null
		@model.get('agonistControl').set
			batchCode: @getTrimmedInput('.bv_agonistControlBatch')
			concentration: parseFloat(@getTrimmedInput('.bv_agonistControlConc'))

	handleThresholdTypeChanged: =>
		thresholdType = @$("input[name='bv_thresholdType']:checked").val()
		@model.set thresholdType: thresholdType
		if thresholdType=="efficacy"
			@$('.bv_hitSDThreshold').attr('disabled','disabled')
			@$('.bv_hitEfficacyThreshold').removeAttr('disabled')
		else
			@$('.bv_hitEfficacyThreshold').attr('disabled','disabled')
			@$('.bv_hitSDThreshold').removeAttr('disabled')
		@attributeChanged()

class window.AbstractUploadAndRunPrimaryAnalsysisController extends BasicFileValidateAndSaveController
#	See UploadAndRunPrimaryAnalsysisController for example required initialization function

	completeInitialization: ->
		@analysisParameterController.on 'valid', @handleMSFormValid
		@analysisParameterController.on 'invalid', @handleMSFormInvalid
		@analysisParameterController.on 'notifyError', @notificationController.addNotification
		@analysisParameterController.on 'clearErrors', @notificationController.clearAllNotificiations
		@analysisParameterController.on 'amDirty', =>
			@trigger 'amDirty'
		@analyzedPreviously = @options.analyzedPreviously
		@analysisParameterController.render()
		if @analyzedPreviously
			@$('.bv_save').html("Re-Analyze")
		@handleMSFormInvalid() #start invalid since file won't be loaded

	handleMSFormValid: =>
		if @parseFileUploaded
			@handleFormValid()

	handleMSFormInvalid: =>
		@handleFormInvalid()

	handleFormValid: ->
		if @analysisParameterController.isValid()
			super()

	parseAndSave: =>
		if @analyzedPreviously
			if !confirm("Re-analyzing the data will delete the previously saved results")
				return
		super()

	handleValidationReturnSuccess: (json) =>
		super(json)
		@analysisParameterController.disableAllInputs()

	handleSaveReturnSuccess: (json) =>
		super(json)
		@$('.bv_loadAnother').html("Re-Analyze")
		@trigger 'analysis-completed'

	showFileSelectPhase: ->
		super()
		if @analysisParameterController?
			@analysisParameterController.enableAllInputs()

	disableAll: ->
		@analysisParameterController.disableAllInputs()
		@$('.bv_htmlSummary').hide()
		@$('.bv_fileUploadWrapper').hide()
		@$('.bv_nextControlContainer').hide()
		@$('.bv_saveControlContainer').hide()
		@$('.bv_completeControlContainer').hide()
		@$('.bv_notifications').hide()

	enableAll: ->
		@analysisParameterController.enableAllInputs()
		@showFileSelectPhase()

	validateParseFile: =>
		@analysisParameterController.updateModel()
		unless !@analysisParameterController.isValid()
			@additionalData =
				inputParameters: JSON.stringify @analysisParameterController.model
				primaryAnalysisExperimentId: @experimentId
				testMode: false
			super()

	setUser: (user) ->
		@userName = user

	setExperimentId: (expId) ->
		@experimentId = expId

class window.UploadAndRunPrimaryAnalsysisController extends AbstractUploadAndRunPrimaryAnalsysisController
	initialize: ->
		@fileProcessorURL = "/api/primaryAnalysis/runPrimaryAnalysis"
		@errorOwnerName = 'UploadAndRunPrimaryAnalsysisController'
		@allowedFileTypes = ['zip']
		@maxFileSize = 200000000
		@loadReportFile = false
		super()
		@$('.bv_moduleTitle').html("Upload Data and Analyze")
		@analysisParameterController = new PrimaryScreenAnalysisParametersController
			model: @options.paramsFromExperiment
			el: @$('.bv_additionalValuesForm')
		@completeInitialization()

class window.PrimaryScreenAnalysisController extends Backbone.View
	template: _.template($("#PrimaryScreenAnalysisView").html())

	initialize: ->
		@model.on "sync", @handleExperimentSaved
		@model.getStatus().on 'change', @handleStatusChanged
		@dataAnalysisController = null
		$(@el).empty()
		$(@el).html @template()
		if @model.isNew()
			@setExperimentNotSaved()
		else
			@setupDataAnalysisController(@options.uploadAndRunControllerName)
			@setExperimentSaved()

	render: =>
		@showExistingResults()

	showExistingResults: ->
		analysisStatus = @model.getAnalysisStatus()
		if analysisStatus != null
			analysisStatus = analysisStatus.get('stringValue')
		else
			analysisStatus = "not started"
		@$('.bv_analysisStatus').html(analysisStatus)
		resultValue = @model.getAnalysisResultHTML()
		if resultValue != null
			res = resultValue.get('clobValue')
			if res == ""
				@$('.bv_resultsContainer').hide()
			else
				@$('.bv_analysisResultsHTML').html(res)
				@$('.bv_resultsContainer').show()

	setExperimentNotSaved: ->
		@$('.bv_fileUploadWrapper').hide()
		@$('.bv_resultsContainer').hide()
		@$('.bv_saveExperimentToAnalyze').show()

	setExperimentSaved: =>
		@$('.bv_saveExperimentToAnalyze').hide()
		@$('.bv_fileUploadWrapper').show()

	handleExperimentSaved: =>
		unless @dataAnalysisController?
			@setupDataAnalysisController(@options.uploadAndRunControllerName)
		@model.getStatus().on 'change', @handleStatusChanged
		@setExperimentSaved()

	handleAnalysisComplete: =>
		# Results are shown analysis controller, so redundant here until experiment is reloaded, which resets analysis controller
		@$('.bv_resultsContainer').hide()
		@trigger 'analysis-completed'

	handleStatusChanged: =>
		if @dataAnalysisController != null
			if @model.isEditable()
				@dataAnalysisController.enableAll()
			else
				@dataAnalysisController.disableAll()

	setupDataAnalysisController: (dacClassName) ->
		newArgs =
			el: @$('.bv_fileUploadWrapper')
			paramsFromExperiment:	@model.getAnalysisParameters()
			analyzedPreviously: @model.getAnalysisStatus().get('stringValue')!="not started"
		@dataAnalysisController = new window[dacClassName](newArgs)
		@dataAnalysisController.setUser(window.AppLaunchParams.loginUserName)
		@dataAnalysisController.setExperimentId(@model.id)
		@dataAnalysisController.on 'analysis-completed', @handleAnalysisComplete
		@dataAnalysisController.on 'amDirty', =>
			@trigger 'amDirty'
		@dataAnalysisController.on 'amClean', =>
			@trigger 'amClean'


# This wraps all the tabs
class window.AbstractPrimaryScreenExperimentController extends Backbone.View
	template: _.template($("#PrimaryScreenExperimentView").html())

	initialize: ->
		if @model?
			@completeInitialization()
		else
			if window.AppLaunchParams.moduleLaunchParams?
				if window.AppLaunchParams.moduleLaunchParams.moduleName == @moduleLaunchName
					$.ajax
						type: 'GET'
						url: "/api/experiments/codename/"+window.AppLaunchParams.moduleLaunchParams.code
						dataType: 'json'
						error: (err) ->
							alert 'Could not get experiment for code in this URL, creating new one'
							@completeInitialization()
						success: (json) =>
							if json.length == 0
								alert 'Could not get experiment for code in this URL, creating new one'
							else
								#TODO Once server is upgraded to not wrap in an array, use the commented out line. It is consistent with specs and tests
								exp = new PrimaryScreenExperiment json
#								exp = new PrimaryScreenExperiment json[0]
								exp.fixCompositeClasses()
								@model = exp
							@completeInitialization()
				else
					@completeInitialization()
			else
				@completeInitialization()

	completeInitialization: =>
		unless @model?
			@model = new PrimaryScreenExperiment()

		$(@el).html @template()
		@model.on 'sync', @handleExperimentSaved
		@experimentBaseController = new ExperimentBaseController
			model: @model
			el: @$('.bv_experimentBase')
			protocolFilter: @protocolFilter
		@experimentBaseController.on 'amDirty', =>
			@trigger 'amDirty'
		@experimentBaseController.on 'amClean', =>
			@trigger 'amClean'
		@analysisController = new PrimaryScreenAnalysisController
			model: @model
			el: @$('.bv_primaryScreenDataAnalysis')
			uploadAndRunControllerName: @uploadAndRunControllerName
		@analysisController.on 'amDirty', =>
			@trigger 'amDirty'
		@analysisController.on 'amClean', =>
			@trigger 'amClean'
		#@setupModelFitController(@modelFitControllerName)
#		@analysisController.on 'analysis-completed', =>
#			@modelFitController.primaryAnalysisCompleted()
		@model.on "protocol_attributes_copied", @handleProtocolAttributesCopied
		@experimentBaseController.render()
		@analysisController.render()
		#@modelFitController.render()

	setupModelFitController: (modelFitControllerName) ->
		newArgs =
			model: @model
			el: @$('.bv_doseResponseAnalysis')
		@modelFitController = new window[modelFitControllerName](newArgs)
		@modelFitController.on 'amDirty', =>
			@trigger 'amDirty'
		@modelFitController.on 'amClean', =>
			@trigger 'amClean'

	handleExperimentSaved: =>
		@analysisController.render()

	handleProtocolAttributesCopied: =>
		@analysisController.render()

class window.PrimaryScreenExperimentController extends AbstractPrimaryScreenExperimentController
	uploadAndRunControllerName: "UploadAndRunPrimaryAnalsysisController"
	modelFitControllerName: "DoseResponseAnalysisController"
	protocolFilter: "?protocolName=FLIPR"
	moduleLaunchName: "flipr_screening_assay"
