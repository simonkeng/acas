class window.DoseResponseKnockoutPanelController extends Backbone.View
	template: _.template($("#DoseResponseKnockoutPanelView").html())

	render: =>
		@$el.empty()
		@$el.html @template()
		@setupKnockoutReasonPicklist()
		@$('.bv_doseResponseKnockoutPanel').on "show", =>
			@$('.bv_dataDictPicklist').focus()
		@$('.bv_doseResponseKnockoutPanel').on "keypress", (key)=>
			if key.keyCode == 13
				@$('.bv_doseResponseKnockoutPanelOKBtn').click()
		@$('.bv_doseResponseKnockoutPanel').on "hidden", =>
			@handleDoseResponseKnockoutPanelHidden()
		@

	show: =>
		@$('.bv_doseResponseKnockoutPanel').modal
			backdrop: "static"
		@$('.bv_doseResponseKnockoutPanel').modal "show"

	setupKnockoutReasonPicklist: =>
		@knockoutReasonList = new PickListList()
		@knockoutReasonList.url = "/api/dataDict/user well flags"
		@knockoutReasonListController = new PickListSelectController
			el: @$('.bv_dataDictPicklist')
			collection: @knockoutReasonList

	handleDoseResponseKnockoutPanelHidden: =>
		reason = @knockoutReasonListController.getSelectedCode()
		@trigger 'reasonSelected', reason

class window.DoseResponsePlotController extends AbstractFormController
	template: _.template($("#DoseResponsePlotView").html())
	initialize: ->
		@pointList = []

	render: =>
		@$el.empty()
		@$el.html @template()
		if @model?
			@$('.bv_plotWindow').attr('id', "bvID_plotWindow_" + @model.cid)
			@doseResponseKnockoutPanelController= new DoseResponseKnockoutPanelController
				el: @$('.bv_doseResponseKnockoutPanel')
			@doseResponseKnockoutPanelController.render()
			@initJSXGraph(@model.get('points'), @model.get('curve'), @model.get('plotWindow'), @$('.bv_plotWindow').attr('id'))
			@
		else
			@$el.html "Plot data not loaded"

	showDoseResponseKnockoutPanel: (selectedPoints) =>
		@doseResponseKnockoutPanelController.show()
		@doseResponseKnockoutPanelController.on 'reasonSelected', (reason) =>
			@knockoutPoints(selectedPoints,reason)
		return

	knockoutPoints: (selectedPoints, reason) =>
		selectedPoints.forEach (selectedPoint) =>
			@points[selectedPoint.idx].flag_user = reason
			@points[selectedPoint.idx]['flag_on.load'] = "NA"
			@points[selectedPoint.idx].flag_algorithm = "NA"
			selectedPoint.drawAsKnockedOut()
		@model.set points: @points
		@model.trigger 'change'
		return

	initJSXGraph: (points, curve, plotWindow, divID) =>
		@points = points
		log10 = (val) ->
			Math.log(val) / Math.LN10

		if typeof (brd) is "undefined"
			brd = JXG.JSXGraph.initBoard(divID,
				boundingbox: plotWindow
				axis: false #we do this later (log axis reasons)
				showCopyright: false
				zoom : {
					wheel: false
				},
			)

			promptForKnockout = (selectedPoints) =>
				@showDoseResponseKnockoutPanel selectedPoints

			includePoints = (selectedPoints) =>
				selectedPoints.forEach (selectedPoint) =>
					@points[selectedPoint.idx].flag_user = "NA"
					@points[selectedPoint.idx]['flag_on.load'] = "NA"
					@points[selectedPoint.idx].flag_algorithm = "NA"
					selectedPoint.drawAsIncluded()
				@model.set points: @points
				@model.trigger 'change'
				return

			ii = 0
			while ii < points.length
				x = log10 points[ii].dose
				y = points[ii].response
				flag_user = points[ii].flag_user
				flag_on_load = points[ii]['flag_on.load']
				flag_algorithm = points[ii].flag_algorithm
				if (flag_user != "NA" || flag_on_load != "NA" || flag_algorithm != "NA")
					color = switch
						when flag_user != "NA" then 'red'
						when flag_on_load != "NA" then 'gray'
						when flag_algorithm != "NA" then 'blue'

					p1 = brd.create("point", [x,y],
						name: points[ii].response_sv_id
						fixed: true
						size: 4
						face: "cross"
						strokecolor: color
						withLabel: false
					)
					p1.knockedOut = true

				else
					p1 = brd.create("point", [x,y],
						name: points[ii].response_sv_id
						fixed: true
						size: 4
						face: "circle"
						strokecolor: "blue"
						withLabel: false
					)
					p1.knockedOut = false

				p1.idx = ii
				p1.isDoseResponsePoint = true
				p1.isSelected = false
				p1.drawAsKnockedOut = ->
					@setAttribute
						strokecolor: "red"
						face: "cross"
						knockedOut: true
				p1.drawAsIncluded = ->
					@setAttribute
						strokecolor: "blue"
						face: "circle"
						knockedOut: false
				p1.handlePointClicked = ->
					if (!@knockedOut)
						promptForKnockout([@])
					else
						includePoints([@])
					return

				p1.on "mouseup", p1.handlePointClicked, p1

				p1.flagLabel = switch
					when flag_user != "NA" then flag_user
					when flag_on_load != "NA" then flag_on_load
					when flag_algorithm != "NA" then flag_algorithm
					else ''

				p1.xLabel = JXG.trunc(points[ii].dose, 4)
				@pointList.push p1
				brd.highlightInfobox = (x, y, el) ->
					#brd.infobox.setText('<img src="http://www.freesmileys.org/smileys/big/big-smiley-face.gif" alt="Smiley face" width="42" height="42">');
					brd.infobox.setText "(" + el.xLabel + ", " + y + ", " + el.flagLabel + ")"
					brd.infobox.setProperty {strokeColor: 'black'}
					return
				ii++

			x = brd.create("line", [
				[0,0]
				[1,0]
			],
				strokeColor: "#888888"
			)
			y = brd.create("axis", [
				[plotWindow[0], 0]
				[plotWindow[0], 1]
			])
			x.isDraggable = false

			# create the tick markers for the axis
			t = brd.create("ticks", [x,1],
				# yes, show the labels
				drawLabels: true
			# yes, show the tick marker at zero (or, in this case: 1)
				drawZero: true
				generateLabelValue: (tick) ->
					# get the first defining point of the axis
					p1 = @line.point1
					# this works for the x-axis, for the y-axis you'll have to use usrCoords[2] (usrCoords[0] is the z-coordinate).
					#Xaxis in log scale
					Math.pow 10, tick.usrCoords[1] - p1.coords.usrCoords[1]
			)

		else
			brd.removeObject window.curve  unless typeof (window.curve) is "undefined"

		if curve?
			if curve.type == "LL.4"
				fct = (x) ->
					curve.min + (curve.max - curve.min) / (1 + Math.exp(curve.slope * Math.log(Math.pow(10,x) / curve.ec50)))
				brd.create('functiongraph', [fct, plotWindow[0], plotWindow[2]], {strokeWidth:2});
				if curve.reported_ec50?
					intersect = fct(log10(curve.reported_ec50))
					if curve.reported_operator?
						color = '#ff0000'
					else
						color = '#808080'

					brd.create('line',[[plotWindow[0],intersect],[log10(curve.reported_ec50),intersect]], {fixed: true, straightFirst:false, straightLast:false, strokeWidth:2, dash: 3, strokeColor: color});
					brd.create('line',[[log10(curve.reported_ec50),intersect],[log10(curve.reported_ec50),plotWindow[2]]], {fixed: true, straightFirst:false, straightLast:false, strokeWidth:2, dash: 3, strokeColor: color});

		getMouseCoords = (e) ->
			cPos = brd.getCoordsTopLeftCorner(e)
			absPos = JXG.getPosition(e)
			dx = absPos[0] - cPos[0]
			dy = absPos[1] - cPos[1]
			new JXG.Coords(JXG.COORDS_BY_SCREEN, [
				dx
				dy
			], brd)
		createSelection = (e) ->
			if !brd.elementsByName.selection?
				coords = getMouseCoords(e)
				a = brd.create 'point', [coords.usrCoords[1],coords.usrCoords[2]], {name:'selectionA', withLabel:false, visible:false, fixed:false}
				b = brd.create 'point', [coords.usrCoords[1],coords.usrCoords[2]], {name:'selectionB', visible:false, fixed:true}
				c = brd.create 'point', ["X(selectionA)",coords.usrCoords[2]], {name:'selectionC', visible:false}
				d = brd.create 'point', [coords.usrCoords[1],"Y(selectionA)"], {name:'selectionD', visible:false}
				selection = brd.create 'polygon', [b, c, a, d], {name: 'selection', hasInnerPoints: true}
				selection.update = ->
					if brd.elementsByName.selectionA.coords.usrCoords[2] < brd.elementsByName.selectionB.coords.usrCoords[2]
						@setAttribute
							fillcolor: 'red'
						selection.knockoutMode = true
					else
						@setAttribute
							fillcolor: '#00FF00'
						selection.knockoutMode = false
				selection.on 'update', selection.update, selection
				#p1.on "mouseup", brd.removeObject(brd.elementsByName.selection)
				brd.mouseUp = ->
					selection = brd.elementsByName.selection
					if selection?
						knockoutMode = selection.knockoutMode
						brd.removeObject(selection)
						brd.removeObject(brd.elementsByName.selectionC)
						brd.removeObject(brd.elementsByName.selectionD)
						brd.removeObject(brd.elementsByName.selectionB)
						brd.removeObject(brd.elementsByName.selectionA)
						selected = selection.selected
						if selected?
							if selected.length > 0
								if knockoutMode
									promptForKnockout(selected)
								else
									includePoints(selected)

				brd.on 'mouseup', brd.mouseUp, brd
				brd.followSelection = (e) ->
					if brd.elementsByName.selection
						coords = getMouseCoords(e)
						brd.elementsByName.selectionA.setPosition(JXG.COORDS_BY_USER, coords.usrCoords)
						selection = brd.elementsByName.selection
						selection.update()
						selectionCoords = [selection.vertices[0].coords.usrCoords,
						                   selection.vertices[1].coords.usrCoords,
						                   selection.vertices[2].coords.usrCoords,
						                   selection.vertices[3].coords.usrCoords]
						#Sort by response desc (south is on the top)
						sorted = _.sortBy selection.vertices.slice(0,4), (vertex) -> vertex.coords.usrCoords[2]
						#Sort north and south by response (order will then be 0 = west 1 = east)
						south = _.sortBy sorted.slice(0,2), (vertex) -> vertex.coords.usrCoords[1]
						north = _.sortBy sorted.slice(2,4), (vertex) -> vertex.coords.usrCoords[1]
						northWest = north[0].coords.usrCoords
						northEast = north[1].coords.usrCoords
						southWest = south[0].coords.usrCoords
						southEast = south[1].coords.usrCoords
						selected = []
						doseResponsePoints = _.where(brd.elementsByName, {isDoseResponsePoint: true, isSelected: false})
						doseResponsePoints.forEach (point) ->
							if point.coords.usrCoords[1] > northWest[1] & point.coords.usrCoords[2] < northWest[2] & point.coords.usrCoords[1] < northEast[1] & point.coords.usrCoords[2] < northEast[2] & point.coords.usrCoords[1] > southWest[1] & point.coords.usrCoords[1] > southWest[1] & point.coords.usrCoords[2] > southWest[2] & point.coords.usrCoords[1] < southEast[1] & point.coords.usrCoords[2] > southWest[2]
								selected.push(point)
						selection.selected = selected

				brd.on 'mousemove', brd.followSelection, brd
				return
		brd.on "down", createSelection
		return

class window.CurveDetail extends Backbone.Model
	url: ->
		return "/api/curve/detail/" + @id
	initialize: ->
		@fixCompositeClasses()
	fixCompositeClasses: =>
		if @get('fitSettings') not instanceof DoseResponseAnalysisParameters
			@set fitSettings: new DoseResponseAnalysisParameters(@get('fitSettings'))
	parse: (resp) =>
		if resp.fitSettings not instanceof DoseResponseAnalysisParameters
			resp.fitSettings = new DoseResponseAnalysisParameters(resp.fitSettings)
		return resp

class window.CurveEditorController extends Backbone.View
	template: _.template($("#CurveEditorView").html())
	events:
		'click .bv_reset': 'handleResetClicked'
		'click .bv_update': 'handleUpdateClicked'
		'click .bv_approve': 'handleApproveClicked'
		'click .bv_reject': 'handleRejectClicked'

	render: =>
		@$el.empty()
		@$el.html @template()
		if @model?
			@drapc = new DoseResponseAnalysisParametersController
				model: @model.get('fitSettings')
				el: @$('.bv_analysisParameterForm')
			@drapc.setFormTitle "Fit Criteria"
			@drapc.render()

			@drapc.model.on "change", @handleParametersChanged

			@drpc = new DoseResponsePlotController
				model: new Backbone.Model @model.get('plotData')
				el: @$('.bv_plotWindowWrapper')
			@drpc.render()

			@drpc.model.on "change", @handlePointsChanged

			@$('.bv_reportedValues').html @model.get('reportedValues')
			@$('.bv_fitSummary').html @model.get('fitSummary')
			@$('.bv_parameterStdErrors').html @model.get('parameterStdErrors')
			@$('.bv_curveErrors').html @model.get('curveErrors')
			@$('.bv_category').html @model.get('category')
			if @model.get('flagAlgorithm') == 'NA'
				@$('.bv_pass').show()
				@$('.bv_fail').hide()
			else
				@$('.bv_pass').hide()
				@$('.bv_fail').show()

			if @model.get('flagUser') == 'NA'
				@$('.bv_na').show()
				@$('.bv_thumbsUp').hide()
				@$('.bv_thumbsDown').hide()
			else
				if @model.get('flagUser') == 'approved'
					@$('.bv_na').hide()
					@$('.bv_thumbsUp').show()
					@$('.bv_thumbsDown').hide()
				else
					@$('.bv_na').hide()
					@$('.bv_thumbsUp').hide()
					@$('.bv_thumbsDown').show()
		else
			@$el.html "No curve selected"

	setModel: (model)->
		@model = model
		@render()
		UtilityFunctions::showProgressModal @$('.bv_statusDropDown')
		@model.on 'sync', @handleModelSync

	handleModelSync: =>
		UtilityFunctions::hideProgressModal @$('.bv_statusDropDown')
		@render()

	handlePointsChanged: =>
		UtilityFunctions::showProgressModal @$('.bv_statusDropDown')
		@model.save({action: 'pointsChanged', user: window.AppLaunchParams.loginUserName}, {success :@handleUpdateSuccess, error: @handleUpdateError})

	handleParametersChanged: =>
		if @drapc.model.isValid()
			UtilityFunctions::showProgressModal @$('.bv_statusDropDown')
			@model.save({action: 'parametersChanged', user: window.AppLaunchParams.loginUserName}, {success :@handleUpdateSuccess, error: @handleUpdateError})

	handleResetClicked: =>
		UtilityFunctions::showProgressModal @$('.bv_statusDropDown')
		@model.fetch
			success: @handleUpdateSuccess
			error: @handleUpdateError

	handleUpdateClicked: =>
		UtilityFunctions::showProgressModal @$('.bv_statusDropDown')
		@oldID =  @model.get 'curveid'
		@model.save({action: 'save', user: window.AppLaunchParams.loginUserName}, {success :@handleSaveSuccess, error: @handleSaveError})

	handleApproveClicked: =>
		UtilityFunctions::showProgressModal @$('.bv_statusDropDown')
		@model.save({action: 'flagUser', flagUser: 'approved', user: window.AppLaunchParams.loginUserName}
			success :@handleUpdateSuccess
			error: @handleUpdateError)

	handleRejectClicked: =>
		UtilityFunctions::showProgressModal @$('.bv_statusDropDown')
		@model.save({action: 'flagUser', flagUser: 'rejected', user: window.AppLaunchParams.loginUserName}
			success :@handleUpdateSuccess
			error: @handleUpdateError)

	handleResetError: =>
		UtilityFunctions::hideProgressModal @$('.bv_statusDropDown')
		@trigger 'curveUpdateError'

	handleSaveError: =>
		UtilityFunctions::hideProgressModal @$('.bv_statusDropDown')
		@trigger 'curveUpdateError'

	handleUpdateError: =>
		UtilityFunctions::hideProgressModal @$('.bv_statusDropDown')
		@trigger 'curveUpdateError'

	handleSaveSuccess: =>
		@handleModelSync()
		newID = @model.get 'curveid'
		dirty = @model.get 'dirty'
		category = @model.get 'category'
		@trigger 'curveDetailSaved', @oldID, newID, dirty, category

	handleUpdateSuccess: =>
		@handleModelSync()
		curveid = @model.get 'curveid'
		flagUser = @model.get 'flagUser'
		flagAlgorithm = @model.get 'flagAlgorithm'
		dirty = @model.get 'dirty'
		@trigger 'curveDetailUpdated', curveid, flagUser, flagAlgorithm, dirty

class window.Curve extends Backbone.Model


class window.CurveList extends Backbone.Collection
	model: Curve

	getCategories: ->
		cats = _.unique @.pluck('category')
		catList = new Backbone.Collection()
		_.each cats, (cat) ->
			catList.add
				code: cat
				name: cat
		catList

	getCurveByID: (curveID) =>
		curve = @.findWhere({curveid: curveID})
		return curve

	getIndexByCurveID: (curveID) =>
		curve = @getCurveByID(curveID)
		index = @.indexOf(curve)
		return index

	updateCurveSummary: (oldID, newCurveID, dirty, category) =>
		curve = @getCurveByID(oldID)
		curve.set curveid: newCurveID
		curve.set dirty: dirty
		curve.set category: category

	updateCurveFlagUser: (curveid, flagUser, flagAlgorithm, dirty) =>
		curve = @getCurveByID(curveid)
		curve.set flagUser: flagUser
		curve.set flagAlgorithm: flagAlgorithm
		curve.set dirty: dirty

class window.CurveCurationSet extends Backbone.Model
	defaults:
		sortOptions: new Backbone.Collection()
		curves: new CurveList()
	setExperimentCode: (exptCode) ->
		@url = "/api/curves/stubs/"+exptCode

	parse: (resp) =>
		if resp.curves?
			if resp.curves not instanceof CurveList
				resp.curves = new CurveList(resp.curves)
				resp.curves.on 'change', =>
					@trigger 'change'
		if resp.sortOptions?
			if resp.sortOptions not instanceof Backbone.Collection
				resp.sortOptions = new Backbone.Collection(resp.sortOptions)
				resp.sortOptions.on 'change', =>
					@trigger 'change'
		resp


class window.CurveEditorDirtyPanelController extends Backbone.View
	template: _.template($("#CurveEditorDirtyPanelView").html())

	render: =>
		@$el.empty()
		@$el.html @template()
		@$('.bv_curveEditorDirtyPanel').on "show", =>
			@$('.bv_curveEditorDirtyPanelOKBtn').focus()
		@$('.bv_curveEditorDirtyPanel').on "keypress", (key)=>
			if key.keyCode == 13
				@$('.bv_curveEditorDirtyPanelOKBtn').click()
		@$('.bv_doseResponseKnockoutPanel').on "hidden", =>
			#placeholder
		@

	show: =>
		@$('.bv_curveEditorDirtyPanel').modal
			backdrop: "static"
		@$('.bv_curveEditorDirtyPanel').modal "show"

	hide: =>
		reason = @knockoutReasonListController.getSelectedCode()
		@trigger 'reasonSelected', reason

class window.CurveSummaryController extends Backbone.View
	template: _.template($("#CurveSummaryView").html())
	tagName: 'div'
	className: 'bv_curveSummary'
	events:
		'click': 'setSelected'
	initialize: ->
		@model.on 'change', @render

	render: =>
		@$el.empty()
		if window.AppLaunchParams.testMode
			curveUrl = "/src/modules/curveAnalysis/spec/testFixtures/testThumbs/"
			curveUrl += @model.get('curveid')+".png"
		else
			curveUrl = window.conf.service.rapache.fullpath+"curve/render/dr/?legend=false&showGrid=false&height=120&width=250&showAxes=false&labelAxes=false&curveIds="
			curveUrl += @model.get('curveid')
		@$el.html @template
			curveUrl: curveUrl
		if @model.get('flagAlgorithm') == 'no fit'
			@$('.bv_pass').hide()
			@$('.bv_fail').show()
		else
			@$('.bv_pass').show()
			@$('.bv_fail').hide()
		if @model.get('flagUser') == 'NA'
			@$('.bv_na').show()
			@$('.bv_thumbsUp').hide()
			@$('.bv_thumbsDown').hide()
		else
			if @model.get('flagUser') == 'approved'
				@$('.bv_na').hide()
				@$('.bv_thumbsUp').show()
				@$('.bv_thumbsDown').hide()
			else
				@$('.bv_na').hide()
				@$('.bv_thumbsUp').hide()
				@$('.bv_thumbsDown').show()
		if @model.get('dirty')
			@$('.bv_dirty').show()
		else
			@$('.bv_dirty').hide()

		@$('.bv_compoundCode').html @model.get('curveAttributes').compoundCode
		@model.on 'change', @render
		@

	setSelected: =>
		if !@$el.hasClass('selected')
			@$el.addClass 'selected'
			@trigger 'selected', @

	styleSelected: ->
		if !@$el.hasClass('selected')
			@$el.addClass 'selected'

	clearSelected: (who) =>
		if who?
			if who.model.cid == @.model.cid
				return
		@$el.removeClass 'selected'

class window.CurveSummaryListController extends Backbone.View
	template: _.template($("#CurveSummaryListView").html())

	initialize: ->
		@filterKey = 'all'
		@sortKey = 'none'
		@sortAscending = true

	render: =>
		@$el.empty()
		@$el.html @template()
		@curveEditorDirtyPanel = new CurveEditorDirtyPanelController
			el: @$('.bv_curveEditorDirtyPanel')
		@curveEditorDirtyPanel.render()

		if @filterKey != 'all'
			@toRender = new Backbone.Collection @collection.filter (cs) =>
				cs.get('category') == @filterKey
		else
			@toRender = @collection

		unless @sortKey == 'none'
			@toRender = @toRender.sortBy (curve) =>
				attributes = curve.get('curveAttributes')
				attributes[@sortKey]
			unless @sortAscending
				@toRender = @toRender.reverse()
			@toRender = new Backbone.Collection @toRender
		@toRender.each (cs) =>
			csController = new CurveSummaryController(model: cs)
			@$('.bv_curveSummaries').append(csController.render().el)
			csController.on 'selected', @selectionUpdated
			@on 'clearSelected', csController.clearSelected
			if @selectedcid?
				if csController.model.cid == @selectedcid
					csController.styleSelected()
		@

	anyDirty: =>
		collection = @toRender
		dirty = collection.findWhere(dirty: true)
		return dirty?

	selectionUpdated: (who) =>
		if !@anyDirty()
			@selectedcid = who.model.cid
			@trigger 'clearSelected', who
			@trigger 'selectionUpdated', who
		else
			who.clearSelected()
			@curveEditorDirtyPanel.show()

	filter: (key) ->
		@filterKey = key
		@render()

	sort: (key, ascending) ->
		@sortKey = key
		@sortAscending = ascending
		@render()

class window.CurveCuratorController extends Backbone.View
	template: _.template($("#CurveCuratorView").html())
	events:
		'change .bv_filterBy': 'handleFilterChanged'
		'change .bv_sortBy': 'handleSortChanged'
		'click .bv_sortDirection_ascending': 'handleSortChanged'
		'click .bv_sortDirection_descending': 'handleSortChanged'

	render: (requestedCurveIDToSelect)=>
		@$el.empty()
		@$el.html @template()
		if @model?
			@curveListController = new CurveSummaryListController
				el: @$('.bv_curveList')
				collection: @model.get 'curves'
			@curveListController.render()
			@curveListController.on 'selectionUpdated', @curveSelectionUpdated
			@curveEditorController = new CurveEditorController
				el: @$('.bv_curveEditor')
			@curveEditorController.on 'curveDetailSaved', @handleCurveDetailSaved
			@curveEditorController.on 'curveDetailUpdated', @handleCurveDetailUpdated
			@curveEditorController.on 'curveUpdateError', @handleCurveUpdateError

			if @model.get('sortOptions').length > 0
				@sortBySelect = new PickListSelectController
					collection: @model.get 'sortOptions'
					el: @$('.bv_sortBy')
					selectedCode: (@model.get 'sortOptions')[0]
					autoFetch: false
			else
				@sortBySelect = new PickListSelectController
					collection: @model.get 'sortOptions'
					el: @$('.bv_sortBy')
					insertFirstOption: new PickList
						code: "none"
						name: "No Sort"
					selectedCode: "none"
					autoFetch: false
			@sortBySelect.render()

			@filterBySelect = new PickListSelectController
				collection: @model.get('curves').getCategories()
				el: @$('.bv_filterBy')
				insertFirstOption: new PickList
					code: "all"
					name: "Show All"
				selectedCode: "all"
				autoFetch: false
			@filterBySelect.render()

			if(@curveListController.sortAscending)
				@$('.bv_sortDirection_ascending').attr( "checked", true );
			else
				@$('.bv_sortDirection_descending').attr( "checked", true );

			@handleSortChanged()
			indexOfRequestedCurve = @curveListController.collection.getIndexByCurveID(requestedCurveIDToSelect)
			if indexOfRequestedCurve == -1
				indexOfRequestedCurve = 0
			@$('.bv_curveSummaries .bv_curveSummary').eq(indexOfRequestedCurve).click()

		@

	handleCurveDetailSaved: (oldID, newID, dirty, category) =>
		@curveListController.collection.updateCurveSummary(oldID, newID, dirty, category)

	handleCurveDetailUpdated: (curveid, flagUser, flagAlgorithm, dirty) =>
		@curveListController.collection.updateCurveFlagUser(curveid, flagUser,flagAlgorithm, dirty)

	handleCurveUpdateError: =>
		@$('.bv_badCurveUpdate').modal
			backdrop: "static"
		@$('.bv_badCurveUpdate').modal "show"

	getCurvesFromExperimentCode: (exptCode, curveID) ->
		@model = new CurveCurationSet
		@model.setExperimentCode exptCode
		@model.fetch
			success: =>
				@render(curveID)
			error: =>
				@$('.bv_badExperimentCode').modal
					backdrop: "static"
				@$('.bv_badExperimentCode').modal "show"

	curveSelectionUpdated: (who) =>
		UtilityFunctions::showProgressModal @$('.bv_curveCuratorDropDown')
		curveDetail = new CurveDetail id: who.model.get('curveid')
		curveDetail.fetch
			success: =>
				UtilityFunctions::hideProgressModal @$('.bv_curveCuratorDropDown')
				@curveEditorController.setModel curveDetail
			error: =>
				UtilityFunctions::hideProgressModal @$('.bv_curveCuratorDropDown')
				@$('.bv_badCurveID').modal
					backdrop: "static"
				@$('.bv_badCurveID').modal "show"


	handleGetCurveDetailReturn: (json) =>
		@curveEditorController.setModel new CurveDetail(json)

	handleFilterChanged: =>
		@curveListController.filter @$('.bv_filterBy').val()

	handleSortChanged: =>
		sortBy = @$('.bv_sortBy').val()
		if(sortBy == "none")
			@$("input[name='bv_sortDirection']").prop('disabled', true);
		else
			@$("input[name='bv_sortDirection']").prop('disabled', false);
		sortDirection = if @$("input[name='bv_sortDirection']:checked").val() == "descending" then false else true
		@curveListController.sort sortBy, sortDirection
