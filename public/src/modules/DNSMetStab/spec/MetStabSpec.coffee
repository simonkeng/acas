describe 'MetStab Behavior Testing', ->

	beforeEach ->
		@.fixture = $.clone($('#fixture').get(0))

	afterEach ->
		$('#fixture').remove()
		$('body').append $(this.fixture)

	describe 'MetStab Model', ->
		describe 'when instantiated', ->
			beforeEach ->
				@metStab = new MetStab()
			describe "defaults tests", ->
				it  'should have defaults', ->
					expect(@metStab.get 'protocolName').toEqual ""
					expect(@metStab.get 'scientist').toEqual ""
					expect(@metStab.get 'notebook').toEqual ""
					expect(@metStab.get 'project').toEqual ""
					expect(@metStab.get 'assayDate').toEqual null
		describe "validation tests", ->
			beforeEach ->
				@metStab = new MetStab window.MetStabTestJSON.validMetStab

			it "should be valid as initialized", ->
				expect(@metStab.isValid()).toBeTruthy()

			it 'should require that protocolName not be "unassigned"', ->
				@metStab.set
					protocolName: "Select Protocol"
				expect(@metStab.isValid()).toBeFalsy()
				filtErrors = _.filter(@metStab.validationError, (err) ->
					err.attribute=='protocolName'
				)
				expect(filtErrors.length).toBeGreaterThan 0

			it 'should require that scientist not be ""', ->
				@metStab.set
					scientist: ""
				expect(@metStab.isValid()).toBeFalsy()
				filtErrors = _.filter(@metStab.validationError, (err) ->
					err.attribute=='scientist'
				)
				expect(filtErrors.length).toBeGreaterThan 0

			it 'should require that notebook not be ""', ->
				@metStab.set
					notebook: ""
				expect(@metStab.isValid()).toBeFalsy()
				filtErrors = _.filter(@metStab.validationError, (err) ->
					err.attribute=='notebook'
				)
				expect(filtErrors.length).toBeGreaterThan 0

			it 'should require that project not be "unassigned"', ->
				@metStab.set
					project: "unassigned"
				expect(@metStab.isValid()).toBeFalsy()
				filtErrors = _.filter(@metStab.validationError, (err) ->
					err.attribute=='project'
				)
				expect(filtErrors.length).toBeGreaterThan 0

			it 'should require that assayDate not be ""', ->
				@metStab.set
					assayDate: new Date("").getTime()
				expect(@metStab.isValid()).toBeFalsy()
				filtErrors = _.filter(@metStab.validationError, (err) ->
					err.attribute=='assayDate'
				)
				expect(filtErrors.length).toBeGreaterThan 0

	describe 'MetStab Controller', ->
		describe 'when instantiated', ->
			beforeEach ->
				@fpkc = new MetStabController
					model: new MetStab()
					el: $('#fixture')
				@fpkc.render()
			describe "basic existance tests", ->
				it 'should exist', ->
					expect(@fpkc).toBeDefined()
				it 'should load a template', ->
					expect(@fpkc.$('.bv_protocolName').length).toEqual 1
			describe "it should show a picklist for projects", ->
				beforeEach ->
					waitsFor ->
						@fpkc.$('.bv_project option').length > 0
					,
						1000
					runs ->
				it "should show project options after loading them from server", ->
					expect(@fpkc.$('.bv_project option').length).toBeGreaterThan 0
				it "should default to unassigned", ->
					expect(@fpkc.$('.bv_project').val()).toEqual "unassigned"
			describe "it should show a picklist for protocols", ->
				beforeEach ->
					waitsFor ->
						@fpkc.$('.bv_protocolName option').length > 0
					,
						1000
					runs ->
				it "should show protocol options after loading them from server", ->
					expect(@fpkc.$('.bv_protocolName option').length).toBeGreaterThan 0
				it "should default protocol to unassigned", ->
					expect(@fpkc.$('.bv_protocolName').val()).toEqual "unassigned"
			describe "disable and enable", ->
				it "should disable all inputs on request", ->
					@fpkc.disableAllInputs()
					expect(@fpkc.$('.bv_scientist').attr("disabled")).toEqual "disabled"
					expect(@fpkc.$('.bv_project').attr("disabled")).toEqual "disabled"
					expect(@fpkc.$('.bv_protocolName').attr("disabled")).toEqual "disabled"
				it "should enable all inputs on request", ->
					@fpkc.disableAllInputs()
					expect(@fpkc.$('.bv_scientist').attr("disabled")).toEqual "disabled"
					expect(@fpkc.$('.bv_project').attr("disabled")).toEqual "disabled"
					expect(@fpkc.$('.bv_protocolName').attr("disabled")).toEqual "disabled"
					@fpkc.enableAllInputs()
					expect(@fpkc.$('.bv_scientist').attr("disabled")).toBeUndefined()
					expect(@fpkc.$('.bv_project').attr("disabled")).toBeUndefined()
					expect(@fpkc.$('.bv_protocolName').attr("disabled")).toBeUndefined()

			describe 'update model when fields changed', ->
				it "should update the protocolName", ->
					waitsFor ->
						@fpkc.$('.bv_protocolName option').length > 0
					,
						1000
					runs ->
						@fpkc.$('.bv_protocolName').val "PROT-00000014"
						@fpkc.$('.bv_protocolName').change()
						expect(@fpkc.model.get('protocolName')).toEqual "ADME_Human Liver Microsome Stability"
				it "should update the scientist", ->
					@fpkc.$('.bv_scientist').val " test scientist "
					@fpkc.$('.bv_scientist').change()
					expect(@fpkc.model.get('scientist')).toEqual "test scientist"
				it "should update the notebook", ->
					@fpkc.$('.bv_notebook').val " test notebook "
					@fpkc.$('.bv_notebook').change()
					expect(@fpkc.model.get('notebook')).toEqual "test notebook"
				it "should update the assayDate", ->
					@fpkc.$('.bv_assayDate').val " 2013-6-6 "
					@fpkc.$('.bv_assayDate').change()
					expect(@fpkc.model.get('assayDate')).toEqual new Date(2013, 5, 6).getTime()
				it "should update the project", ->
					waitsFor ->
						@fpkc.$('.bv_project option').length > 0
					,
					1000
					runs ->
						@fpkc.$('.bv_project').val "project2"
						@fpkc.$('.bv_project').change()
						expect(@fpkc.model.get('project')).toEqual "project2"
				it "should trigger 'amDirty' when field changed", ->
					runs ->
						@amDirtySet = false
						@fpkc.on 'amDirty', =>
							@amDirtySet = true
						@fpkc.$('.bv_notebook').val " test notebook "
						@fpkc.$('.bv_notebook').change()
					waitsFor =>
						@amDirtySet
					,
					500
					runs ->
						expect(@amDirtySet).toBeTruthy()

		describe "validation testing", ->
			beforeEach ->
				@fpkc = new MetStabController
					model: new MetStab window.MetStabTestJSON.validMetStab
					el: $('#fixture')
				@fpkc.render()
			describe "error notification", ->
				it 'should show error if protocol is unassigned', ->
					waitsFor ->
						@fpkc.$('.bv_protocolName option').length > 0
					,
						1000
					runs ->
						@fpkc.$(".bv_protocolName").val "unassigned"
						@fpkc.$(".bv_protocolName").change()
						expect(@fpkc.$(".bv_group_protocolName").hasClass("error")).toBeTruthy()
				it 'should show error if scientist is empty', ->
					@fpkc.$(".bv_scientist").val ""
					@fpkc.$(".bv_scientist").change()
					expect(@fpkc.$(".bv_group_scientist").hasClass("error")).toBeTruthy()
				it 'should show error if notebook is empty', ->
					@fpkc.$(".bv_notebook").val ""
					@fpkc.$(".bv_notebook").change()
					expect(@fpkc.$(".bv_group_notebook").hasClass("error")).toBeTruthy()
				it 'should show error if project is unassigned', ->
					waitsFor ->
						@fpkc.$('.bv_project option').length > 0
					,
					1000
					runs ->
						@fpkc.$(".bv_project").val "unassigned"
						@fpkc.$(".bv_project").change()
						expect(@fpkc.$(".bv_group_project").hasClass("error")).toBeTruthy()
				it 'should show error if assayDate is empty', ->
					@fpkc.$(".bv_assayDate").val ""
					@fpkc.$(".bv_assayDate").change()
					expect(@fpkc.$(".bv_group_assayDate").hasClass("error")).toBeTruthy()