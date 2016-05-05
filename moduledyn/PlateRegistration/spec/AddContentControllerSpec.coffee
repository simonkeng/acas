AddContentController = require('../src/client/AddContentController.coffee').AddContentController
AddContentModel = require('../src/client/AddContentModel.coffee').AddContentModel
ADD_CONTENT_MODEL_FIELDS = require('../src/client/AddContentModel.coffee').ADD_CONTENT_MODEL_FIELDS

ADD_CONTENT_CONTROLLER_EVENTS = require('../src/client/AddContentController.coffee').ADD_CONTENT_CONTROLLER_EVENTS
identifiersFixture = require('./testFixtures/AddContentModelFixtures.coffee').listOfIdentifiers

$ = require('jquery')
_ = require('lodash')


describe "AddContentController", ->
  beforeEach ->
    fixture = '<div id="fixture"></div>'
    document.body.insertAdjacentHTML('afterbegin', fixture)
    @startUpParams = {}
    @model = new AddContentModel()
    @startUpParams.model = @model
    @addContent = new AddContentController(@startUpParams)

  it "should exist", ->
    expect(@addContent).toBeTruthy()

  describe "template content", ->
    beforeEach ->
      $("#fixture").html @addContent.render().el

    it "should have a template property", ->
      expect(@addContent.template).toBeTruthy()

    it "should have an 'identifiers' textarea input field", ->
      #$("#fixture").html @addContent.render().el
      expect(_.size($("#fixture").find("[name='identifiers']"))).toEqual 1

  describe "utility methods", ->
    beforeEach ->
      @addContent = new AddContentController(@startUpParams)

    describe "calculateNumberOfSelectedCells", ->
      describe "should return the number of selected cells based on the selected region", ->
        it "should return 1 when a single cell is selected", ->
          selectedRegionBoundries =
            rowStart: 0
            rowStop: 0
            colStart: 0
            colStop: 0
          numberOfSelectedCells = @addContent.calculateNumberOfSelectedCells selectedRegionBoundries
          expect(numberOfSelectedCells).toEqual 1

        it "should return 3 when a row with 3 columns is selected", ->
          selectedRegionBoundries =
            rowStart: 0
            rowStop: 0
            colStart: 0
            colStop: 2
          numberOfSelectedCells = @addContent.calculateNumberOfSelectedCells selectedRegionBoundries
          expect(numberOfSelectedCells).toEqual 3

        it "should return 4 when a column with 4 rows is selected", ->
          selectedRegionBoundries =
            rowStart: 0
            rowStop: 3
            colStart: 0
            colStop: 0
          numberOfSelectedCells = @addContent.calculateNumberOfSelectedCells selectedRegionBoundries
          expect(numberOfSelectedCells).toEqual 4

        it "should return 8 when a 2 x 4 region is selected", ->
          selectedRegionBoundries =
            rowStart: 1
            rowStop: 2
            colStart: 1
            colStop: 4
          numberOfSelectedCells = @addContent.calculateNumberOfSelectedCells selectedRegionBoundries
          expect(numberOfSelectedCells).toEqual 8

        it "should return 8 when a 2 x 4 region is selected, starting at the bottom right", ->
          selectedRegionBoundries =
            rowStart: 2
            rowStop: 1
            colStart: 4
            colStop: 1
          numberOfSelectedCells = @addContent.calculateNumberOfSelectedCells selectedRegionBoundries
          expect(numberOfSelectedCells).toEqual 8

    describe "parseIdentifiers", ->
      describe "should return an array containing an element for each identifier entered", ->
        it "should return an array with one element when the input contains no delimiters", ->
          expect(@addContent.parseIdentifiers(identifiersFixture.singleIdentifierInput)).toEqual(identifiersFixture.singleIdentifierOutput)
          expect(_.size(@addContent.parseIdentifiers(identifiersFixture.singleIdentifierInput))).toEqual(1)

        it "should return an array with three elements when the input contains 2 semicolons", ->
          expect(@addContent.parseIdentifiers(identifiersFixture.semicolonSeparatedInput)).toEqual(identifiersFixture.semicolonSeparatedOutput)
          expect(_.size(@addContent.parseIdentifiers(identifiersFixture.semicolonSeparatedInput))).toEqual(3)

        it "should return an array with three elements when the input contains 2 tab characters", ->
          expect(@addContent.parseIdentifiers(identifiersFixture.tabSeparatedInput)).toEqual(identifiersFixture.tabSeparatedOutput)
          expect(_.size(@addContent.parseIdentifiers(identifiersFixture.tabSeparatedInput))).toEqual(3)

  describe "input events", ->
    beforeEach ->
      @model = new AddContentModel()
      @startUpParams.model = @model
      @addContent = new AddContentController(@startUpParams)
      $("#fixture").html @addContent.render().el

    it "should update the identifiers field of the model when text is entered in the Plate Barcode input field", ->
      updatedValue = "updated barcode value"
      $("#fixture").find("[name='identifiers']").val identifiersFixture.semicolonSeparatedInput
      $("#fixture").find("[name='identifiers']").trigger "change"
      expect(@model.get(ADD_CONTENT_MODEL_FIELDS.IDENTIFIERS)).toEqual identifiersFixture.semicolonSeparatedOutput

    it "should update the number of compounds field when identifiers are added", ->
      updatedValue = "updated barcode value"
      $("#fixture").find("[name='identifiers']").val identifiersFixture.semicolonSeparatedInput
      $("#fixture").find("[name='identifiers']").trigger "change"
      expect(parseInt($("#fixture").find(".addContentTotal").html())).toEqual _.size(identifiersFixture.semicolonSeparatedOutput)


  describe "UI event handlers", ->
    beforeEach ->
      @model = new AddContentModel()
      @startUpParams.model = @model
      @addContent = new AddContentController(@startUpParams)
      $("#fixture").html @addContent.render().el

    # the "should eimit an ADD_CONTENT event when the 'Add button is clicked" spec already exercises this, remove in the future
    xit "should call handleAddClick when the 'Add' button is clicked", (done) ->
      spyOn(@addContent, 'handleAddClick')
      @addContent.delegateEvents()
      $("#fixture").find("[name='add']").click()
      _.defer(=>
        expect(@addContent.handleAddClick).toHaveBeenCalled()
        done()
      )


  describe "emitted events", ->
    beforeEach ->
      @model = new AddContentModel()
      @startUpParams.model = @model
      @addContent = new AddContentController(@startUpParams)
      $("#fixture").html @addContent.render().el

    it "should emit an ADD_CONTENT event when the 'Add' button is clicked", (done) ->
      @addContent.on ADD_CONTENT_CONTROLLER_EVENTS.ADD_CONTENT, ->
        expect(true).toBeTruthy()
        done()

      @addContent.handleAddClick()
#
#    describe "model events", ->
#      it "should trigger a PLATE_INFO_CONTROLLER_EVENTS.MODEL_UPDATE_VALID event when the form model is updated to an valid state", (done) ->
#        @plateInfo.on PLATE_INFO_CONTROLLER_EVENTS.MODEL_UPDATE_VALID, ->
#          expect(true).toBeTruthy()
#          done()
#        @plateInfo.updateModel(plateModelFixtures.validPlateInfoModel)
#
#      it "should trigger a PLATE_INFO_CONTROLLER_EVENTS.MODEL_UPDATE_INVALID event when the form model is updated to an invalid state", (done) ->
#        @plateInfo.on PLATE_INFO_CONTROLLER_EVENTS.MODEL_UPDATE_INVALID, ->
#          expect(true).toBeTruthy()
#          done()
#
#        @plateInfo.updateModel({})
#
#    describe "form input fields and model attributes should be bound", ->
#      it "when the model is empty, the input fields should be empty", ->
#        expect($("#fixture").find("[name='plateBarcode']").val()).toEqual ""
#        expect($("#fixture").find("[name='description']").val()).toEqual ""
#        expect($("#fixture").find("[name='plateSize']").val()).toEqual ""
#        expect($("#fixture").find("[name='type']").val()).toEqual ""
#        expect($("#fixture").find("[name='status']").val()).toEqual ""
#        expect($("#fixture").find("[name='createdDate']").val()).toEqual ""
#        expect($("#fixture").find("[name='supplier']").val()).toEqual ""
#
#      it "when the model has values set, the input fields should display those values", ->
#@plateInfo.model.set(plateModelFixtures.validPlateInfoModel)
#        @model = new PlateInfoModel(plateModelFixtures.validPlateInfoModel)
#        @startUpParams.model = @model
#        plateInfo = new PlateInfoController(@startUpParams)
#        $("#fixture").html plateInfo.render().el
#        expect($("#fixture").find("[name='plateBarcode']").val()).toEqual plateModelFixtures.validPlateInfoModel.plateBarcode
#        expect($("#fixture").find("[name='description']").val()).toEqual plateModelFixtures.validPlateInfoModel.description
#        expect(parseInt($("#fixture").find("[name='plateSize']").val())).toEqual plateModelFixtures.validPlateInfoModel.plateSize
#        expect($("#fixture").find("[name='type']").val()).toEqual plateModelFixtures.validPlateInfoModel.type
#        expect($("#fixture").find("[name='status']").val()).toEqual plateModelFixtures.validPlateInfoModel.status
#        expect($("#fixture").find("[name='createdDate']").val()).toEqual plateModelFixtures.validPlateInfoModel.createdDate
#        expect($("#fixture").find("[name='supplier']").val()).toEqual plateModelFixtures.validPlateInfoModel.supplier
#
#
#

