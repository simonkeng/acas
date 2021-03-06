describe 'User authentication Service testing', ->
	beforeEach ->
		@waitForServiceReturn = ->
			typeof @serviceReturn != 'undefined'


	describe 'when auth service called', ->
		beforeEach ->
			runs ->
				$.ajax
					type: 'POST'
					url: "api/userAuthentication"
					data:
						user: "bob" # credentials for test user
						password: "secret"
					success: (json) =>
						@serviceReturn = json
					error: (err) =>
						console.log 'got ajax error'
						@serviceReturn = null
					dataType: 'json'

		it 'should return succesfull credentials (expect to fail without valid creds in this spec file)', ->
			waitsFor( @waitForServiceReturn, 'service did not return', 2000)
			runs ->
				expect(@serviceReturn.status).toContain "Success"

	describe 'when user lookup called with valid username', ->
		beforeEach ->
			runs ->
				$.ajax
					type: 'GET'
					url: "api/users/bob"
					success: (json) =>
						@serviceReturn = json
					error: (err) =>
						console.log 'got ajax error'
						@serviceReturn = null
					dataType: 'json'

		it 'should return user', ->
			waitsFor( @waitForServiceReturn, 'service did not return', 2000)
			runs ->
				expect(@serviceReturn.username).toEqual "bob"
		it 'should return firstName', ->
			waitsFor( @waitForServiceReturn, 'service did not return', 2000)
			runs ->
				if window.conf.require.login
					expect(@serviceReturn.firstName).toEqual "bob"
				else
					expect(@serviceReturn.firstName).toEqual ""
		it 'should return lastName', ->
			waitsFor( @waitForServiceReturn, 'service did not return', 2000)
			runs ->
				if window.conf.require.login
					expect(@serviceReturn.lastName).toEqual "bob"
				else
					expect(@serviceReturn.lastName).toEqual "bob"
		it 'should return email', ->
			waitsFor( @waitForServiceReturn, 'service did not return', 2000)
			runs ->
				expect(@serviceReturn.email).toContain "bob"
		it 'should not return password', ->
			waitsFor( @waitForServiceReturn, 'service did not return', 2000)
			runs ->
				expect(@serviceReturn.password).toBeUndefined()

	describe 'when user lookup called with invalid username', ->
		beforeEach ->
			runs ->
				$.ajax
					type: 'GET'
					url: "api/users/starksofwesteros"
					success: (json) =>
						@serviceReturn = "got 200"
					error: (err) =>
						console.log 'got ajax error'
						@serviceReturn = null
					statusCode:
						204: =>
							@serviceReturn = "got 204"
					dataType: 'json'

		it 'should return 204', ->
			waitsFor( @waitForServiceReturn, 'service did not return', 2000)
			runs ->
				if window.conf.require.login
					expect(@serviceReturn).toEqual "got 204"
				else
					expect(@serviceReturn).toEqual "got 200"
