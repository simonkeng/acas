class window.UtilityFunctions
	getFileServiceURL: ->
		"/uploads"


	testUserHasRole: (user, roleNames) ->
		if not user.roles? then return true

		match = false
		for roleName in roleNames
			for role in user.roles
				if role.roleEntry.roleName == roleName then match = true

		match

	testUserHasRoleTypeKindName: (user, roleInfo) ->
		#roleInfo = list of objects with role type, kind, and name
		if not user.roles? then return true
		match = false
		for role in roleInfo
			for userRole in user.roles
				if userRole.roleEntry.lsType == role.lsType and userRole.roleEntry.lsKind == role.lsKind and userRole.roleEntry.roleName == role.roleName
					match = true

		match

	showProgressModal: (node) ->
		node.modal
			backdrop: "static"
		node.modal "show"

	hideProgressModal: (node) ->
		node.modal "hide"

	getTrimmedInput: (selector) ->
		$.trim(selector.val())

	convertYMDDateToMs: (inStr) ->
		dateParts = inStr.split('-')
		new Date(dateParts[0], dateParts[1]-1, dateParts[2]).getTime()

	convertMSToYMDDate: (ms) ->
		date = new Date ms
		monthNum = date.getMonth()+1
		date.getFullYear()+'-'+("0" + monthNum).slice(-2)+'-'+("0" + date.getDate()).slice(-2)
