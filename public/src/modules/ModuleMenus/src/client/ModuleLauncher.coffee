class window.ModuleLauncher extends Backbone.Model

	defaults:
		isHeader: false
		menuName: "Menu Name Replace Me"
		mainControllerClassName: "controllerClassNameReplaceMe"
		isLoaded: false
		isActive: false
		isDirty: false

	requestActivation: ->
		@trigger 'activationRequested', @
		@set isActive: true

	requestDeactivation: ->
		@trigger 'deactivationRequested', @
		@set isActive: false

class window.ModuleLauncherList extends Backbone.Collection
	model: ModuleLauncher


class window.ModuleLauncherMenuController extends Backbone.View
	template: _.template($("#ModuleLauncherMenuView").html())
	tagName: 'li'

	events:
		'click': "handleSelect"

	initialize: ->
		@model.bind "change", @render

	render: =>
		$(@el).empty()
		$(@el).html(@template(@model.toJSON()))
		if @model.get('isActive') then $(@el).addClass "active"
		else $(@el).removeClass "active"

		if @model.get('isLoaded') then @$('.bv_isLoaded').show()
		else @$('.bv_isLoaded').hide()
		if @model.get('isDirty') then @$('.bv_isDirty').show()
		else @$('.bv_isDirty').hide()

		@

	handleSelect: =>
		@model.requestActivation()
		@trigger "selected", @

	clearSelected: (who) =>
		unless who?.model?.get("menuName") == @model.get("menuName")
			@model.requestDeactivation()

class window.ModuleLauncherMenuHeaderController extends Backbone.View
	tagName: 'li'
	className: "nav-header"

	initialize: ->
		@model.bind "change", @render

	render: =>
		$(@el).html(@model.get('menuName'))

		@

class window.ModuleLauncherMenuListController extends Backbone.View

	template: _.template($("#ModuleLauncherMenuListView").html())

	initialize: ->
		#@collection.bind 'reset', @render()

	render: =>
		# This render is not safe to run twice because
		# it instantiates new controllers and views but doesn't delete the old controllers
		$(@el).empty()
		$(@el).html @template()
		@collection.each @addOne

		@

	addOne: (menuItem) =>
		menuItemController = @makeMenuItemController(menuItem)
		@$('.bv_navList').append menuItemController.render().el

	makeMenuItemController: (menuItem) ->
		if menuItem.get('isHeader')
			menuItemCont = new ModuleLauncherMenuHeaderController
				model: menuItem
		else
			menuItemCont = new ModuleLauncherMenuController
				model: menuItem
			menuItemCont.bind 'selected', @selectionUpdated
			@bind 'clearSelected', menuItemCont.clearSelected

		return menuItemCont

	selectionUpdated: (who) =>
		@trigger 'clearSelected', who

class window.ModuleLauncherController extends Backbone.View
	tagName: 'div'
	template: _.template($("#ModuleLauncherView").html())

	initialize: ->
		@model.bind 'activationRequested', @handleActivation
		@model.bind 'deactivationRequested', @handleDeactivation
#		if @model.get('routes')?
#			_.each @model.get('routes'), (route) =>
#				window.appRouter.route route.routePath, route.routeCallBackName, @handleRouteRequested

	render: =>
		$(@el).empty()
		$(@el).html @template()
		$(@el).addClass('bv_'+@model.get('mainControllerClassName'))
		if @model.get('isActive')
			$(@el).show()
		else
			$(@el).hide()

		@

	handleActivation:  =>
		unless @model.get('isLoaded')
			unless window.AppLaunchParams.testMode
				@moduleController = new window[@model.get('mainControllerClassName')]({el: @$('.bv_moduleContent')})
				@moduleController.bind 'amDirty', =>
					@model.set isDirty: true
				@moduleController.bind 'amClean', =>
					@model.set isDirty: false
				@moduleController.render()
				@model.set isLoaded: true

		$(@el).show()

	handleDeactivation:  =>
		$(@el).hide()

	handleRouteRequested: (params) =>
		#console.log "got route with params: ", params

class window.ModuleLauncherListController extends Backbone.View

	template: _.template($("#ModuleLauncherListView").html())

	initialize: ->


	render: =>
		# This render is not safe to run twice because
		# it instantiates new controllers and views but doesn't delete the old controllers
		$(@el).empty()
		$(@el).html @template()
		@collection.each @addOne

	addOne: (moduleLauncher) =>
		unless moduleLauncher.get('isHeader')
			modLaunchCont = new ModuleLauncherController
				model: moduleLauncher
			@$('.bv_moduleWrapper').append modLaunchCont.render().el
