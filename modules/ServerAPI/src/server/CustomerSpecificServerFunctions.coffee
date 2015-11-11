###
  Master ACAS -specific implementations of required server functions

  All functions are required with unchanged signatures
###
ACAS_HOME="../../.."
serverUtilityFunctions = require "#{ACAS_HOME}/routes/ServerUtilityFunctions.js"
fs = require 'fs'


exports.logUsage = (action, data, username) ->
	# no ACAS logging service yet
	console.log "would have logged: "+action+" with data: "+data+" and user: "+username
	# logger = require "../../../routes/Logger"
	global.logger.writeToLog("info", "logUsage", action, data, username, null)


exports.getConfServiceVars = (sysEnv, callback) ->
	conf = {}
	callback(conf)

exports.authCheck = (user, pass, retFun) ->
	config = require "#{ACAS_HOME}/conf/compiled/conf.js"
	request = require 'request'
	request(
		headers:
			accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'
		method: 'POST'
		url: config.all.server.roologin.loginLink
		form:
			j_username: user
			j_password: pass
		json: false
	, (error, response, json) =>
		if !error && response.statusCode == 200
			retFun JSON.stringify json
		else if !error && response.statusCode == 302
			retFun JSON.stringify response.headers.location
		else
			console.log 'got connection error trying authenticate a user'
			console.log error
			console.log json
			console.log response
			retFun "connection_error "+error
	)

exports.resetAuth = (email, retFun) ->
	config = require "#{ACAS_HOME}/conf/compiled/conf.js"
	request = require 'request'
	request(
		headers:
			accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'
		method: 'POST'
		url: config.all.server.roologin.resetLink
		form:
			emailAddress: email
		json: false
	, (error, response, json) =>
		if !error && response.statusCode == 200
			retFun JSON.stringify json
		else
			console.log 'got ajax error trying authenticate a user'
			console.log error
			console.log json
			console.log response
			retFun "connection_error "+error
	)

exports.changeAuth = (user, passOld, passNew, passNewAgain, retFun) ->
	config = require "#{ACAS_HOME}/conf/compiled/conf.js"
	request = require 'request'
	request(
		headers:
			accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'
		method: 'POST'
		url: config.all.server.roologin.changeLink
		form:
			username: user
			oldPassword: passOld
			newPassword: passNew
			newPasswordAgain: passNewAgain
		json: false
	, (error, response, json) =>
		if !error && response.statusCode == 200
			retFun JSON.stringify json
		else
			console.log 'got ajax error trying authenticate a user'
			console.log error
			console.log json
			console.log response
			retFun "connection_error "+error
	)
exports.getUser = (username, callback) ->
	config = require "#{ACAS_HOME}/conf/compiled/conf.js"
	if config.all.server.roologin.getUserLink and !global.specRunnerTestmode
		request = require 'request'
		request(
			headers:
				accept: 'application/json'
			method: 'POST'
			url: config.all.server.roologin.getUserLink
			json:
				name:username
		, (error, response, json) =>
			if !error && response.statusCode == 200 && json.id
				callback null,
					id: json.id
					username: json.userName
					email: json.emailAddress
					firstName: json.firstName
					lastName: json.lastName
					roles: json.authorRoles
			else
				callback "user not found", null
		)
	else
		if username != "starksofwesteros"
			callback null,
				id: 0,
				username: username,
				email: username+"@nowhere.com",
				firstName: username,
				lastName: username
		else
			callback "user not found", null


exports.isUserAdmin = (user) ->
	_ = require 'underscore'
	adminRoles = _.filter user.roles, (role) ->
		role.roleEntry.roleName == 'admin'
	isAdmin = if adminRoles.length >0 then true else false

exports.findByUsername = (username, fn) ->
	return exports.getUser username, fn

exports.loginStrategy = (username, password, done) ->
	exports.authCheck username, password, (results) ->
		if results.indexOf("login_error")>=0
			try
				exports.logUsage "User failed login: ", "", username
			catch error
				console.log "Exception trying to log:"+error
			return done(null, false,
				message: "Invalid credentials"
			)
		else if results.indexOf("connection_error")>=0
			try
				exports.logUsage "Connection to authentication service failed: ", "", username
			catch error
				console.log "Exception trying to log:"+error
			return done(null, false,
				message: "Cannot connect to authentication service. Please contact an administrator"
			)
		else
			try
				exports.logUsage "User logged in succesfully: ", "", username
			catch error
				console.log "Exception trying to log:"+error
			exports.getUser username,done

exports.getProjects = (resp) ->
	projects = 	exports.projects = [
		code: "project1"
		name: "Project 1"
		ignored: false
	,
		code: "project2"
		name: "Project 2"
		ignored: false
	]

	resp.end JSON.stringify projects

exports.makeServiceRequestHeaders = (user) ->
	username = if user? then user.username else "testmode"

	headers =
		"From": username

exports.getCustomerMolecularTargetCodes = (resp) ->
	molecTargetTestJSON = require "#{ACAS_HOME}/public/javascripts/spec/PrimaryScreen/testFixtures/PrimaryScreenProtocolServiceTestJSON.js"
	resp.end JSON.stringify molecTargetTestJSON.customerMolecularTargetCodeTable

exports.validateCloneAndGetTarget = (req, resp) ->
	psProtocolServiceTestJSON = require "#{ACAS_HOME}/public/javascripts/spec/PrimaryScreen/testFixtures/PrimaryScreenProtocolServiceTestJSON.js"
	resp.json psProtocolServiceTestJSON.successfulCloneValidation

exports.getAuthors = (resp) ->
	config = require "#{ACAS_HOME}/conf/compiled/conf.js"
	serverUtilityFunctions = require "#{ACAS_HOME}/routes/ServerUtilityFunctions.js"
	baseurl = config.all.client.service.persistence.fullpath+"authors/codeTable"
	serverUtilityFunctions.getFromACASServer(baseurl, resp)

exports.relocateEntityFile = (fileValue, entityCodePrefix, entityCode, callback) ->
	config = require "#{ACAS_HOME}/conf/compiled/conf.js"
	uploadsPath = serverUtilityFunctions.makeAbsolutePath config.all.server.datafiles.relative_path
	oldPath = uploadsPath + fileValue.fileValue

	relEntitiesFolder = serverUtilityFunctions.getRelativeFolderPathForPrefix(entityCodePrefix)
	if relEntitiesFolder==null
		callback false
		return
	relEntityFolder = relEntitiesFolder + entityCode + "/"
	absEntitiesFolder = uploadsPath + relEntitiesFolder
	absEntityFolder = uploadsPath + relEntityFolder
	newPath = absEntityFolder + fileValue.fileValue

	entitiesFolder = uploadsPath + "entities/"
	serverUtilityFunctions.ensureExists entitiesFolder, 0o0744, (err) ->
		if err?
			console.log "Can't find or create entities folder: " + entitiesFolder
			callback false
		else
			serverUtilityFunctions.ensureExists absEntitiesFolder, 0o0744, (err) ->
				if err?
					console.log "Can't find or create : " + absEntitiesFolder
					callback false
				else
					serverUtilityFunctions.ensureExists absEntityFolder, 0o0744, (err) ->
						if err?
							console.log "Can't find or create : " + absEntityFolder
							callback false
						else
							fs.rename oldPath, newPath, (err) ->
								if err?
									console.log err
									callback false
								else
									fileValue.comments = fileValue.fileValue
									fileValue.fileValue = relEntityFolder + fileValue.fileValue
									callback true

exports.getDownloadUrl = (fileValue) ->
	config = require "#{ACAS_HOME}/conf/compiled/conf.js"
	return config.all.client.datafiles.downloadurl.prefix+fileValue

exports.getTestedEntityProperties = (propertyList, entityList, callback) ->
	# This is a stub implementation that returns empty results

	if propertyList.indexOf('ERROR') > -1
		callback null
		return

	ents = entityList.split '\n'
	out = "id,"
	for prop in propertyList
		out += prop+","
	out = out.slice(0,-1) + '\n'
	for i in [0..ents.length-2]
		out += ents[i]+","
		j=0
		for prop2 in propertyList
			if ents[i].indexOf('ERROR') < 0 then out += i + j++
			else out += ""
			out += ','
		out = out.slice(0,-1) + '\n'

	callback out



exports.getExternalReferenceCodes = (displayName, requests, callback) ->
	if displayName == "Corporate Batch ID"
		console.log "looking up compound batches"
		exports.getPreferredBatchIds requests, (response) ->
			callback response
	else if displayName == "Corporate Parent ID"
		console.log "looking up compound parents"
		exports.getPreferredParentIds requests, (response) ->
			callback response
	else
		callback.statusCode = 500
		callback.end "problem with external preferred Code request: code type and kind are unknown to system"

exports.getExternalBestLabel = (displayName, requests, callback) ->
	if displayName == "Corporate Batch ID"
		console.log "looking up compound batches"
		exports.getBatchBestLabels requests, (response) ->
			callback response
	else if displayName == "Corporate Parent ID"
		console.log "looking up compound parents"
		exports.getParentBestLabels requests, (response) ->
			console.log(JSON.stringify(response))
			callback response
	else
		callback.statusCode = 500
		callback.end "problem with external best label request: displayName is unknown to system"


exports.getPreferredBatchIds = (requests, callback) ->
	if global.specRunnerTestmode
		results = []
		for req in requests
			res = requestName: req.requestName
			if req.requestName.indexOf("999999999") > -1
				res.preferredName = ""
			else if req.requestName.indexOf("673874") > -1
				res.preferredName = "DNS000001234::7"
			else
				res.preferredName = checkBatch_TestMode(req.requestName)
			results.push res
		response = results

		callback response
	else #not spec mode
		config = require "#{ACAS_HOME}/conf/compiled/conf.js"
		request = require 'request'
		request
			method: 'POST'
			url: config.all.server.service.external.preferred.batchid.url
			json: true
			body: requests
		, (error, response, json) =>
			if !error && response.statusCode == 200
				callback json
			else
				console.log error
				console.log response
				console.log json
				callback null

exports.getPreferredParentIds = (requests, callback) ->
	if global.specRunnerTestmode
		results = []
		for req in requests
			res = requestName: req.requestName
			if req.requestName.indexOf("999999999") > -1
				res.preferredName = ""
			else if req.requestName.indexOf("673874") > -1
				res.preferredName = "DNS000001234"
			else if req.requestName.indexOf("compoundName") > -1
				res.preferredName = "CMPD000001234"
			else
				res.preferredName = req.requestName
			results.push res
		response = results

		callback response
	else
		config = require "#{ACAS_HOME}/conf/compiled/conf.js"
		request = require 'request'
		request
			method: 'POST'
			url: config.all.server.service.external.preferred.batchid.url+"/parent"
			json: true
			body: requests
		, (error, response, json) =>
			if !error && response.statusCode == 200
				callback json
			else
				console.log error
				console.log response
				console.log json
				callback null


exports.getBatchBestLabels = (requests, callback) ->
	if global.specRunnerTestmode
		results = []
		for req in requests
			res = requestName: req.requestName
			if req.requestName.indexOf("1111") > -1
				res.preferredName = "1111"
			else if req.requestName.indexOf("1234") > -1
				res.preferredName = "1234::7"
			else
				res.preferredName = req.requestName
			results.push res
		response = results

		callback response
	else #not spec mode
		config = require "#{ACAS_HOME}/conf/compiled/conf.js"
		request = require 'request'
		request
			method: 'POST'
			url: config.all.server.service.external.preferred.batchid.url
			json: true
			body: requests
		, (error, response, json) =>
			if !error && response.statusCode == 200
				callback json
			else
				console.log error
				console.log response
				console.log json
				callback null

exports.getParentBestLabels = (requests, callback) ->
	if global.specRunnerTestmode
		results = []
		for req in requests
			res = requestName: req.requestName
			if req.requestName.indexOf("1111") > -1
				res.preferredName = "1111"
			else if req.requestName.indexOf("1234") > -1
				res.preferredName = "1234"
			else if req.requestName.indexOf("CMPD000001234") > -1
				res.preferredName = "1234"
			else
				res.preferredName = req.requestName
			results.push res
		response = results

		callback response
	else
		config = require "#{ACAS_HOME}/conf/compiled/conf.js"
		request = require 'request'
		request
			method: 'POST'
			url: config.all.server.service.external.preferred.batchid.url+"/parent"
			json: true
			body: requests
		, (error, response, json) =>
			if !error && response.statusCode == 200
				callback json
			else
				console.log error
				console.log response
				console.log json
				callback null

checkBatch_TestMode = (requestName) ->
	idComps = requestName.split("_")
	pref = idComps[0];
	respId = "";
	switch pref
		when "norm" then respId = batchName.requestName
		when "none" then respId = ""
		when  "alias" then respId = "norm_"+idComps[1]+"A"
		else respId = requestName
	return respId