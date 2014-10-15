(function() {
  beforeEach(function() {
    return this.fixture = $.clone($("#fixture").get(0));
  });

  afterEach(function() {
    $("#fixture").remove();
    return $("body").append($(this.fixture));
  });

  describe("Primary Screen Protocol module testing", function() {
    describe("Primary Screen Protocol Parameters model testing", function() {
      describe("When loaded from new", function() {
        beforeEach(function() {
          return this.pspp = new PrimaryScreenProtocolParameters();
        });
        describe("Defaults", function() {
          it('Should have an default maxY curve display of 100', function() {
            expect(this.pspp.getCurveDisplayMax() instanceof Value).toBeTruthy();
            return expect(this.pspp.getCurveDisplayMax().get('numericValue')).toEqual(100.0);
          });
          return it('Should have an default minY curve display of 0', function() {
            expect(this.pspp.getCurveDisplayMin() instanceof Value).toBeTruthy();
            return expect(this.pspp.getCurveDisplayMin().get('numericValue')).toEqual(0);
          });
        });
        return describe("required states and values", function() {
          it("should have an assay activity value", function() {
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay activity') instanceof Value).toBeTruthy();
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay activity').get('codeValue')).toEqual("unassigned");
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay activity').get('codeOrigin')).toEqual("acas ddict");
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay activity').get('codeType')).toEqual("protocolMetadata");
          });
          it("should have a molecular target value with code origin set to acas ddict", function() {
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('molecular target') instanceof Value).toBeTruthy();
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('molecular target').get('codeValue')).toEqual("unassigned");
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('molecular target').get('codeOrigin')).toEqual("acas ddict");
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('molecular target').get('codeType')).toEqual("protocolMetadata");
          });
          it("should have a target origin value", function() {
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('target origin') instanceof Value).toBeTruthy();
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('target origin').get('codeValue')).toEqual("unassigned");
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('target origin').get('codeOrigin')).toEqual("acas ddict");
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('target origin').get('codeType')).toEqual("protocolMetadata");
          });
          it("should have an assay type value", function() {
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay type') instanceof Value).toBeTruthy();
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay type').get('codeValue')).toEqual("unassigned");
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay type').get('codeOrigin')).toEqual("acas ddict");
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay type').get('codeType')).toEqual("protocolMetadata");
          });
          it("should have an assay technology value", function() {
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay technology') instanceof Value).toBeTruthy();
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay technology').get('codeValue')).toEqual("unassigned");
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay technology').get('codeOrigin')).toEqual("acas ddict");
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay technology').get('codeType')).toEqual("protocolMetadata");
          });
          it("should have a cell line value", function() {
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('cell line') instanceof Value).toBeTruthy();
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('cell line').get('codeValue')).toEqual("unassigned");
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('cell line').get('codeOrigin')).toEqual("acas ddict");
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('cell line').get('codeType')).toEqual("protocolMetadata");
          });
          return it("should have an assay stage value", function() {
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay stage') instanceof Value).toBeTruthy();
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay stage').get('codeValue')).toEqual("unassigned");
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay stage').get('codeOrigin')).toEqual("acas ddict");
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay stage').get('codeType')).toEqual("protocolMetadata");
          });
        });
      });
      describe("When loaded from existing", function() {
        beforeEach(function() {
          return this.pspp = new PrimaryScreenProtocolParameters(window.primaryScreenProtocolTestJSON.primaryScreenProtocolParameters);
        });
        describe("Existence and Defaults", function() {
          return it("should be defined", function() {
            return expect(this.pspp).toBeDefined();
          });
        });
        return describe("after initial load", function() {
          it("should have a maxY curve display ", function() {
            return expect(this.pspp.getCurveDisplayMax().get('numericValue')).toEqual(200.0);
          });
          it("should have a minY curve display ", function() {
            return expect(this.pspp.getCurveDisplayMin().get('numericValue')).toEqual(10.0);
          });
          it('Should have an assay Activity value', function() {
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay activity').get('codeValue')).toEqual("luminescence");
          });
          it('Should have a molecularTarget value with the codeOrigin set to customer ddict', function() {
            expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('molecular target').get('codeValue')).toEqual("target x");
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('molecular target').get('codeOrigin')).toEqual("customer ddict");
          });
          it('Should have an targetOrigin value', function() {
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('target origin').get('codeValue')).toEqual("human");
          });
          it('Should have an assay type value', function() {
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay type').get('codeValue')).toEqual("cellular assay");
          });
          it('Should have a molecularTarget value with code origin set to dns target list', function() {
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay technology').get('codeValue')).toEqual("wizard triple luminescence");
          });
          it('Should have an targetOrigin value', function() {
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('cell line').get('codeValue')).toEqual("cell line y");
          });
          return it('Should have an assay stage value', function() {
            return expect(this.pspp.getPrimaryScreenProtocolParameterCodeValue('assay stage').get('codeValue')).toEqual("assay development");
          });
        });
      });
      return describe("model validation", function() {
        beforeEach(function() {
          return this.pspp = new PrimaryScreenProtocolParameters(window.primaryScreenProtocolTestJSON.primaryScreenProtocolParameters);
        });
        it("should be valid when loaded from saved", function() {
          return expect(this.pspp.isValid()).toBeTruthy();
        });
        it("should be invalid when maxY is NaN", function() {
          var filtErrors;
          this.pspp.getCurveDisplayMax().set({
            numericValue: NaN
          });
          expect(this.pspp.isValid()).toBeFalsy();
          filtErrors = _.filter(this.pspp.validationError, function(err) {
            return err.attribute === 'maxY';
          });
          return expect(filtErrors.length).toBeGreaterThan(0);
        });
        return it("should be invalid when minY is NaN", function() {
          var filtErrors;
          this.pspp.getCurveDisplayMin().set({
            numericValue: NaN
          });
          expect(this.pspp.isValid()).toBeFalsy();
          filtErrors = _.filter(this.pspp.validationError, function(err) {
            return err.attribute === 'minY';
          });
          return expect(filtErrors.length).toBeGreaterThan(0);
        });
      });
    });
    describe("Primary Screen Protocol model testing", function() {
      describe("When loaded from new", function() {
        beforeEach(function() {
          return this.psp = new PrimaryScreenProtocol();
        });
        return describe("Existence and Defaults", function() {
          return it("should be defined", function() {
            return expect(this.psp).toBeDefined();
          });
        });
      });
      return describe("When loaded from existing", function() {
        beforeEach(function() {
          return this.psp = new PrimaryScreenProtocol(window.primaryScreenProtocolTestJSON.fullSavedPrimaryScreenProtocol);
        });
        describe("Existence and Defaults", function() {
          return it("should be defined", function() {
            return expect(this.psp).toBeDefined();
          });
        });
        return describe("special getters", function() {
          return describe("primary screen protocol parameters", function() {
            it('Should be able to get primary screen protocol parameters', function() {
              return expect(this.psp.getPrimaryScreenProtocolParameters() instanceof PrimaryScreenProtocolParameters).toBeTruthy();
            });
            return it('Should parse primary screen protocol parameters', function() {
              expect(this.psp.getPrimaryScreenProtocolParameters().getCurveDisplayMax().get('numericValue')).toEqual(200.0);
              return expect(this.psp.getPrimaryScreenProtocolParameters().getCurveDisplayMin().get('numericValue')).toEqual(10.0);
            });
          });
        });
      });
    });
    describe("PrimaryScreenProtocolParametersController", function() {
      describe("when instantiated with no data", function() {
        beforeEach(function() {
          this.psppc = new PrimaryScreenProtocolParametersController({
            model: new PrimaryScreenProtocolParameters(),
            el: $('#fixture')
          });
          return this.psppc.render();
        });
        describe("Basic existence tests", function() {
          it("should exist", function() {
            return expect(this.psppc).toBeDefined();
          });
          return it('should load autofill template', function() {
            return expect(this.psppc.$('.bv_assayActivity').length).toEqual(1);
          });
        });
        return describe("render existing parameters", function() {
          it("should show the assayActivity as unassigned", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayActivity option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay activity').get('codeValue')).toEqual("unassigned");
              return expect(this.psppc.assayActivityListController.getSelectedCode()).toEqual("unassigned");
            });
          });
          it("should show the molecularTarget as unassigned", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_molecularTarget option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('molecular target').get('codeValue')).toEqual("unassigned");
              return expect(this.psppc.molecularTargetListController.getSelectedCode()).toEqual("unassigned");
            });
          });
          it("should show the targetOrigin as unassigned", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_targetOrigin option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('target origin').get('codeValue')).toEqual("unassigned");
              return expect(this.psppc.targetOriginListController.getSelectedCode()).toEqual("unassigned");
            });
          });
          it("should show the assay type as unassigned", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayType option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay type').get('codeValue')).toEqual("unassigned");
              return expect(this.psppc.assayTypeListController.getSelectedCode()).toEqual("unassigned");
            });
          });
          it("should show the assay technology as unassigned", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayTechnology option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay technology').get('codeValue')).toEqual("unassigned");
              return expect(this.psppc.assayTechnologyListController.getSelectedCode()).toEqual("unassigned");
            });
          });
          it("should show the cell line as unassigned", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_cellLine option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('cell line').get('codeValue')).toEqual("unassigned");
              return expect(this.psppc.cellLineListController.getSelectedCode()).toEqual("unassigned");
            });
          });
          it("should show the assay stage as unassigned", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayStage option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay stage').get('codeValue')).toEqual("unassigned");
              return expect(this.psppc.assayStageListController.getSelectedCode()).toEqual("unassigned");
            });
          });
          it("should have the customer molecular target ddict checkbox ", function() {
            return expect(this.psppc.$('.bv_customerMolecularTargetDDictChkbx').attr("checked")).toBeUndefined();
          });
          it("should show the curve display max", function() {
            expect(this.psppc.model.getCurveDisplayMax().get('numericValue')).toEqual(100.0);
            return expect(this.psppc.$('.bv_maxY').val()).toEqual("100");
          });
          return it("should show the curve display min", function() {
            expect(this.psppc.model.getCurveDisplayMin().get('numericValue')).toEqual(0.0);
            return expect(this.psppc.$('.bv_minY').val()).toEqual("0");
          });
        });
      });
      return describe("when instantiated with data", function() {
        beforeEach(function() {
          this.psppc = new PrimaryScreenProtocolParametersController({
            model: new PrimaryScreenProtocolParameters(window.primaryScreenProtocolTestJSON.primaryScreenProtocolParameters),
            el: $('#fixture')
          });
          return this.psppc.render();
        });
        describe("Basic existence tests", function() {
          it("should exist", function() {
            return expect(this.psppc).toBeDefined();
          });
          return it('should load autofill template', function() {
            return expect(this.psppc.$('.bv_assayActivity').length).toEqual(1);
          });
        });
        describe("render existing parameters", function() {
          it("should have the assayActivity set", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayActivity option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay activity').get('codeValue')).toEqual("luminescence");
              return expect(this.psppc.assayActivityListController.getSelectedCode()).toEqual("luminescence");
            });
          });
          it("should have the molecularTarget set", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_molecularTarget option').length > 0;
            }, 1000);
            return runs(function() {
              waits(1000);
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('molecular target').get('codeValue')).toEqual("target x");
              return expect(this.psppc.molecularTargetListController.getSelectedCode()).toEqual("target x");
            });
          });
          it("should have the targetOrigin set", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_targetOrigin option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('target origin').get('codeValue')).toEqual("human");
              return expect(this.psppc.targetOriginListController.getSelectedCode()).toEqual("human");
            });
          });
          it("should have the assay type set", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayType option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay type').get('codeValue')).toEqual("cellular assay");
              return expect(this.psppc.assayTypeListController.getSelectedCode()).toEqual("cellular assay");
            });
          });
          it("should have the assay technology set", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayTechnology option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay technology').get('codeValue')).toEqual("wizard triple luminescence");
              return expect(this.psppc.assayTechnologyListController.getSelectedCode()).toEqual("wizard triple luminescence");
            });
          });
          it("should have the cell line set", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_cellLine option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('cell line').get('codeValue')).toEqual("cell line y");
              return expect(this.psppc.cellLineListController.getSelectedCode()).toEqual("cell line y");
            });
          });
          it("should have the assay stage set", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayStage option').length > 0;
            }, 1000);
            return runs(function() {
              expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay stage').get('codeValue')).toEqual("assay development");
              return expect(this.psppc.assayStageListController.getSelectedCode()).toEqual("assay development");
            });
          });
          it("should have the customer molecular target ddict checkbox checked ", function() {
            return expect(this.psppc.$('.bv_customerMolecularTargetDDictChkbx').attr("checked")).toEqual("checked");
          });
          it('should show the maxY', function() {
            return expect(this.psppc.model.getCurveDisplayMax().get('numericValue')).toEqual(200.0);
          });
          return it('should show the minY', function() {
            return expect(this.psppc.model.getCurveDisplayMin().get('numericValue')).toEqual(10.0);
          });
        });
        describe("model updates", function() {
          it("should update the assay activity", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayActivity option').length > 0;
            }, 1000);
            return runs(function() {
              this.psppc.$('.bv_assayActivity .bv_parameterSelectList').val('fluorescence');
              this.psppc.$('.bv_assayActivity').change();
              return expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay activity').get('codeValue')).toEqual("fluorescence");
            });
          });
          it("should update the molecular target", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_molecularTarget option').length > 0;
            }, 1000);
            return runs(function() {
              this.psppc.$('.bv_molecularTarget .bv_parameterSelectList').val('target y');
              this.psppc.$('.bv_molecularTarget').change();
              return expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('molecular target').get('codeValue')).toEqual("target y");
            });
          });
          it("should update the target origin", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_targetOrigin option').length > 0;
            }, 1000);
            return runs(function() {
              this.psppc.$('.bv_targetOrigin .bv_parameterSelectList').val('chimpanzee');
              this.psppc.$('.bv_targetOrigin').change();
              return expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('target origin').get('codeValue')).toEqual("chimpanzee");
            });
          });
          it("should update the assay type", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayType option').length > 0;
            }, 1000);
            return runs(function() {
              this.psppc.$('.bv_assayType .bv_parameterSelectList').val('unassigned');
              this.psppc.$('.bv_assayType').change();
              return expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay type').get('codeValue')).toEqual("unassigned");
            });
          });
          it("should update the assay technology", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayTechnology option').length > 0;
            }, 1000);
            return runs(function() {
              this.psppc.$('.bv_assayTechnology .bv_parameterSelectList').val('unassigned');
              this.psppc.$('.bv_assayTechnology').change();
              return expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay technology').get('codeValue')).toEqual("unassigned");
            });
          });
          it("should update the cell line", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_cellLine option').length > 0;
            }, 1000);
            return runs(function() {
              this.psppc.$('.bv_cellLine .bv_parameterSelectList').val('unassigned');
              this.psppc.$('.bv_cellLine').change();
              return expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('cell line').get('codeValue')).toEqual("unassigned");
            });
          });
          it("should update the curve display max", function() {
            this.psppc.$('.bv_maxY').val("130 ");
            this.psppc.$('.bv_maxY').change();
            return expect(this.psppc.model.getCurveDisplayMax().get('numericValue')).toEqual(130);
          });
          it("should update the curve display min", function() {
            this.psppc.$('.bv_minY').val(" 13 ");
            this.psppc.$('.bv_minY').change();
            return expect(this.psppc.model.getCurveDisplayMin().get('numericValue')).toEqual(13);
          });
          return it("should update model when assay stage changed", function() {
            waitsFor(function() {
              return this.psppc.$('.bv_assayStage option').length > 0;
            }, 1000);
            return runs(function() {
              this.psppc.$('.bv_assayStage').val('unassigned');
              this.psppc.$('.bv_assayStage').change();
              return expect(this.psppc.model.getPrimaryScreenProtocolParameterCodeValue('assay stage').get('codeValue')).toEqual("unassigned");
            });
          });
        });
        describe("behavior", function() {
          return it("should hide the Molecular Target's add button when the customer molecular target ddict checkbox is checked", function() {
            this.psppc.$('.bv_customerMolecularTargetDDictChkbx').click();
            return expect(this.psppc.$('.bv_molecularTarget .bv_addOptionBtn')).toBeHidden();
          });
        });
        return describe("controller validation rules", function() {
          it("should show error when maxY is NaN", function() {
            this.psppc.$('.bv_maxY').val("b");
            this.psppc.$('.bv_maxY').change();
            return expect(this.psppc.$('.bv_group_maxY').hasClass('error')).toBeTruthy();
          });
          return it("should show error when minY is NaN", function() {
            this.psppc.$('.bv_minY').val("b");
            this.psppc.$('.bv_minY').change();
            return expect(this.psppc.$('.bv_group_minY').hasClass('error')).toBeTruthy();
          });
        });
      });
    });
    describe("PrimaryScreenProtocolController", function() {
      beforeEach(function() {
        this.pspc = new PrimaryScreenProtocolController({
          model: new PrimaryScreenProtocol(window.primaryScreenProtocolTestJSON.fullSavedPrimaryScreenProtocol),
          el: $('#fixture')
        });
        return this.pspc.render();
      });
      return describe("when instantiated", function() {
        return describe("basic existence tests", function() {
          it("should exist", function() {
            return expect(this.pspc).toBeDefined();
          });
          it("should have protocol base controller", function() {
            return expect(this.pspc.protocolBaseController).toBeDefined();
          });
          return it("should have a primary screen protocol parameters controller", function() {
            return expect(this.pspc.primaryScreenProtocolParametersController).toBeDefined();
          });
        });
      });
    });
    describe("Abstract Primary Screen Protocol Module Controller testing", function() {
      return describe("Basic loading", function() {
        return it("Class should exist", function() {
          return expect(window.AbstractPrimaryScreenProtocolModuleController).toBeDefined();
        });
      });
    });
    return describe("Primary Screen Protocol Module Controller testing", function() {
      beforeEach(function() {
        this.pspmc = new PrimaryScreenProtocolModuleController({
          model: new PrimaryScreenProtocol(),
          el: $('#fixture')
        });
        return this.pspmc.render();
      });
      return describe("when instantiated", function() {
        return describe("basic existence tests", function() {
          it("should exist", function() {
            return expect(this.pspmc).toBeDefined();
          });
          it("should have a primary screen protocol controller", function() {
            return expect(this.pspmc.primaryScreenProtocolController).toBeDefined();
          });
          return it("should have a primary screen analysis parameters controller", function() {
            return expect(this.pspmc.primaryScreenAnalysisParametersController).toBeDefined();
          });
        });
      });
    });
  });

}).call(this);
