class window.ModuleMenusController extends Backbone.View

	template: _.template($("#ModuleMenusView").html())

	events: ->
		'click .bv_headerName': "handleHome"
		'click .bv_toggleModuleMenuControl': "handleToggleMenus"
		'click .bv_loginUserFirstName': 'handleLoginUserFirstNameClick'
		'click .bv_changeNameBtn': 'handleChangeNameBtnClick'
#		'click .bv_showModuleMenuControl': "handleShowMenus"

	window.onbeforeunload = () ->
		if window.conf.leaveACASMessage == "WARNING: There are unsaved changes."
			return window.conf.leaveACASMessage
		else
			return

	initialize: ->

		$(@el).html @template()

		@moduleLauncherList = new ModuleLauncherList(@options.menuListJSON)
		@moduleLauncherMenuListController = new ModuleLauncherMenuListController
			el: @$('.bv_modLaunchMenuWrapper')
			collection: @moduleLauncherList
		@moduleLauncherListController = new ModuleLauncherListController
			el: @$('.bv_mainModuleWrapper')
			collection: @moduleLauncherList

		if window.conf.require.login
			@$('.bv_loginUserFirstName').html window.AppLaunchParams.loginUser.firstName
			@$('.bv_loginUserLastName').html window.AppLaunchParams.loginUser.lastName
		else
			@$('.bv_userInfo').hide()

		unless window.conf.roologin.showpasswordchange
			@$('.bv_changePassword').hide()

		@moduleLauncherMenuListController.render()
		@moduleLauncherListController.render()

		if window.conf.moduleMenus.summaryStats
			@$('.bv_summaryStats').load('/dataFiles/summaryStatistics/summaryStatistics.html')
		else
			@$('.bv_summaryStats').hide()

		if window.AppLaunchParams.moduleLaunchParams?
			@moduleLauncherMenuListController.launchModule window.AppLaunchParams.moduleLaunchParams.moduleName
		else
			@$('.bv_homePageWrapper').show()

		if window.conf.moduleMenus.logoText?
			logoInfo = window.conf.moduleMenus.logoText
			if window.conf.moduleMenus.logoImageFilePath?
				logoInfo = '<img src='+window.conf.moduleMenus.logoImageFilePath+' style="margin-right: 10px;">'+logoInfo
			@$('.bv_headerName').html logoInfo
		if window.conf.moduleMenus.homePageMessage?
			@$('.bv_homePageMessage').html(window.conf.moduleMenus.homePageMessage)
		if window.conf.moduleMenus.copyrightMessage?
			@$('.bv_copyrightMessage').html(window.conf.moduleMenus.copyrightMessage)
		if window.conf.moduleMenus.modules?.external?
			for module in $.parseJSON window.conf.moduleMenus.modules.external
				modLink = '<li><a href="'+module.href+'"target="_blank">'+module.displayName+'</a></li>'
				@$('.bv_externalACASModules').append modLink

		@socket = io('/user:loggedin')
		@socket.on('connect', @handleConnected)
		@socket.on('connect_error', @handleConnectError)
		@socket.on('loggedOn', @handleLoggedOn)
		@socket.on('loggedOff', @handleLoggedOn)
		@socket.on('usernameUpdated', @handleNameChanged)

		@disconnectedAfterLogin = false

	render: =>
		if window.AppLaunchParams.deployMode?
			unless window.AppLaunchParams.deployMode.toUpperCase() =="PROD"
				@$('.bv_deployMode h1').html(window.AppLaunchParams.deployMode.toUpperCase())

		@

	handleHome: =>
		$('.bv_mainModuleWrapper').hide()
		$('.bv_homePageWrapper').show()

	handleHideMenus: =>
		console.log "got handleHideMenus"
		@$('.bv_moduleMenuWellWrapper').hide()
		@$('.bv_showModuleMenuControl').show()

	handleShowMenus: =>
		@$('.bv_showModuleMenuControl').hide()
		@$('.bv_moduleMenuWellWrapper').show()

	handleToggleMenus: =>
		if @$('.bv_moduleMenuWellWrapper').is ':hidden'
			@$('.bv_moduleMenuWellWrapper').show()
			@$('.bv_mainModuleWellWrapper').removeClass 'span11'
			@$('.bv_mainModuleWellWrapper').addClass 'span9'
		else
			@$('.bv_moduleMenuWellWrapper').hide()
			@$('.bv_mainModuleWellWrapper').removeClass 'span9'
			@$('.bv_mainModuleWellWrapper').addClass 'span11'

	handleConnected: =>
		console.log "handleConnected"

	handleConnectError: =>
		@disconnectedAfterLogin = true
		console.log "handleConnectError"

	handleLoggedOn: (numberOfLogins) ->
		console.log "you're loggedin in this many places: ", numberOfLogins

	handleLoggedOff: (numberOfLogins) ->
		console.log "you're loggedin in this many places: ", numberOfLogins

	handleLoginUserFirstNameClick: =>
		@$(".bv_changeUserName").modal "show"

	handleChangeNameBtnClick: (e) =>
		e.preventDefault()
		firstName = @$(".bv_firstName").val()
		@socket.emit('changeUserName', firstName)
		@$(".bv_firstName").val('')
		@$(".bv_changeUserName").modal "hide"

	handleNameChanged: (updatedFirstName) =>
		@$(".bv_loginUserFirstName").html updatedFirstName
		AppLaunchParams.loginUserName = updatedFirstName
