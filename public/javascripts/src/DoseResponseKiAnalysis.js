(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.DoseResponseKiAnalysisParameters = (function(superClass) {
    extend(DoseResponseKiAnalysisParameters, superClass);

    function DoseResponseKiAnalysisParameters() {
      this.fixCompositeClasses = bind(this.fixCompositeClasses, this);
      return DoseResponseKiAnalysisParameters.__super__.constructor.apply(this, arguments);
    }

    DoseResponseKiAnalysisParameters.prototype.defaults = {
      smartMode: true,
      inactiveThresholdMode: true,
      inactiveThreshold: 20,
      inverseAgonistMode: false,
      max: new Backbone.Model({
        limitType: 'none'
      }),
      min: new Backbone.Model({
        limitType: 'none'
      }),
      kd: new Backbone.Model,
      ligandConc: new Backbone.Model
    };

    DoseResponseKiAnalysisParameters.prototype.initialize = function() {
      return this.fixCompositeClasses();
    };

    DoseResponseKiAnalysisParameters.prototype.fixCompositeClasses = function() {
      if (!(this.get('max') instanceof Backbone.Model)) {
        this.set({
          max: new Backbone.Model(this.get('max'))
        });
      }
      if (!(this.get('min') instanceof Backbone.Model)) {
        this.set({
          min: new Backbone.Model(this.get('min'))
        });
      }
      if (!(this.get('kd') instanceof Backbone.Model)) {
        this.set({
          kd: new Backbone.Model(this.get('kd'))
        });
      }
      if (!(this.get('ligandConc') instanceof Backbone.Model)) {
        return this.set({
          ligandConc: new Backbone.Model(this.get('ligandConc'))
        });
      }
    };

    DoseResponseKiAnalysisParameters.prototype.validate = function(attrs) {
      var errors, limitType;
      errors = [];
      limitType = attrs.min.get('limitType');
      if ((limitType === "pin" || limitType === "limit") && (_.isNaN(attrs.min.get('value')) || attrs.min.get('value') === null)) {
        errors.push({
          attribute: 'min_value',
          message: "Min threshold value must be set when limit type is pin or limit"
        });
      }
      limitType = attrs.max.get('limitType');
      if ((limitType === "pin" || limitType === "limit") && (_.isNaN(attrs.max.get('value')) || attrs.max.get('value') === null)) {
        errors.push({
          attribute: 'max_value',
          message: "Max threshold value must be set when limit type is pin or limit"
        });
      }
      if (_.isNaN(attrs.kd.get('value')) || attrs.kd.get('value') === null || attrs.kd.get('value') === void 0) {
        errors.push({
          attribute: 'kd_value',
          message: "Kd threshold value must be set"
        });
      }
      if (_.isNaN(attrs.ligandConc.get('value')) || attrs.ligandConc.get('value') === null || attrs.ligandConc.get('value') === void 0) {
        errors.push({
          attribute: 'ligandConc_value',
          message: "Ligand Conc. threshold value must be set"
        });
      }
      if (_.isNaN(attrs.inactiveThreshold)) {
        errors.push({
          attribute: 'inactiveThreshold',
          message: "Inactive threshold value must be set to a number"
        });
      }
      if (errors.length > 0) {
        return errors;
      } else {
        return null;
      }
    };

    return DoseResponseKiAnalysisParameters;

  })(Backbone.Model);

  window.DoseResponseKiAnalysisParametersController = (function(superClass) {
    extend(DoseResponseKiAnalysisParametersController, superClass);

    function DoseResponseKiAnalysisParametersController() {
      this.handleMinLimitTypeChanged = bind(this.handleMinLimitTypeChanged, this);
      this.handleMaxLimitTypeChanged = bind(this.handleMaxLimitTypeChanged, this);
      this.handleInverseAgonistModeChanged = bind(this.handleInverseAgonistModeChanged, this);
      this.handleInactiveThresholdMoved = bind(this.handleInactiveThresholdMoved, this);
      this.handleInactiveThresholdChanged = bind(this.handleInactiveThresholdChanged, this);
      this.handleInactiveThresholdModeChanged = bind(this.handleInactiveThresholdModeChanged, this);
      this.handleSmartModeChanged = bind(this.handleSmartModeChanged, this);
      this.updateModel = bind(this.updateModel, this);
      this.render = bind(this.render, this);
      return DoseResponseKiAnalysisParametersController.__super__.constructor.apply(this, arguments);
    }

    DoseResponseKiAnalysisParametersController.prototype.template = _.template($("#DoseResponseKiAnalysisParametersView").html());

    DoseResponseKiAnalysisParametersController.prototype.autofillTemplate = _.template($("#DoseResponseKiAnalysisParametersAutofillView").html());

    DoseResponseKiAnalysisParametersController.prototype.events = {
      "change .bv_smartMode": "handleSmartModeChanged",
      "change .bv_inverseAgonistMode": "handleInverseAgonistModeChanged",
      "change .bv_inactiveThresholdMode": "handleInactiveThresholdModeChanged",
      "click .bv_max_limitType_none": "handleMaxLimitTypeChanged",
      "click .bv_max_limitType_pin": "handleMaxLimitTypeChanged",
      "click .bv_max_limitType_limit": "handleMaxLimitTypeChanged",
      "click .bv_min_limitType_none": "handleMinLimitTypeChanged",
      "click .bv_min_limitType_pin": "handleMinLimitTypeChanged",
      "click .bv_min_limitType_limit": "handleMinLimitTypeChanged",
      "change .bv_max_value": "attributeChanged",
      "change .bv_min_value": "attributeChanged",
      "change .bv_kd_value": "attributeChanged",
      "change .bv_ligandConc_value": "attributeChanged"
    };

    DoseResponseKiAnalysisParametersController.prototype.initialize = function() {
      $(this.el).html(this.template());
      this.errorOwnerName = 'DoseResponseKiAnalysisParametersController';
      return this.setBindings();
    };

    DoseResponseKiAnalysisParametersController.prototype.render = function() {
      this.$('.bv_autofillSection').empty();
      this.$('.bv_autofillSection').html(this.autofillTemplate($.parseJSON(JSON.stringify(this.model))));
      this.$('.bv_inactiveThreshold').slider({
        value: this.model.get('inactiveThreshold'),
        min: 0,
        max: 100
      });
      this.$('.bv_inactiveThreshold').on('slide', this.handleInactiveThresholdMoved);
      this.$('.bv_inactiveThreshold').on('slidestop', this.handleInactiveThresholdChanged);
      this.updateThresholdDisplay(this.model.get('inactiveThreshold'));
      this.setFormTitle();
      this.setThresholdModeEnabledState();
      this.setInverseAgonistModeEnabledState();
      return this;
    };

    DoseResponseKiAnalysisParametersController.prototype.updateThresholdDisplay = function(val) {
      return this.$('.bv_inactiveThresholdDisplay').html(val);
    };

    DoseResponseKiAnalysisParametersController.prototype.setThresholdModeEnabledState = function() {
      if (this.model.get('smartMode')) {
        this.$('.bv_inactiveThresholdMode').removeAttr('disabled');
      } else {
        this.$('.bv_inactiveThresholdMode').attr('disabled', 'disabled');
      }
      return this.setThresholdSliderEnabledState();
    };

    DoseResponseKiAnalysisParametersController.prototype.setThresholdSliderEnabledState = function() {
      if (this.model.get('inactiveThresholdMode') && this.model.get('smartMode')) {
        return this.$('.bv_inactiveThreshold').slider('enable');
      } else {
        return this.$('.bv_inactiveThreshold').slider('disable');
      }
    };

    DoseResponseKiAnalysisParametersController.prototype.setInverseAgonistModeEnabledState = function() {
      if (this.model.get('smartMode')) {
        return this.$('.bv_inverseAgonistMode').removeAttr('disabled');
      } else {
        return this.$('.bv_inverseAgonistMode').attr('disabled', 'disabled');
      }
    };

    DoseResponseKiAnalysisParametersController.prototype.updateModel = function() {
      this.model.get('max').set({
        value: parseFloat(UtilityFunctions.prototype.getTrimmedInput(this.$('.bv_max_value')))
      });
      this.model.get('min').set({
        value: parseFloat(UtilityFunctions.prototype.getTrimmedInput(this.$('.bv_min_value')))
      });
      this.model.get('kd').set({
        value: parseFloat(UtilityFunctions.prototype.getTrimmedInput(this.$('.bv_kd_value')))
      });
      this.model.get('ligandConc').set({
        value: parseFloat(UtilityFunctions.prototype.getTrimmedInput(this.$('.bv_ligandConc_value')))
      });
      this.model.set({
        inactiveThresholdMode: this.$('.bv_inactiveThresholdMode').is(":checked")
      }, {
        silent: true
      });
      this.model.set({
        inverseAgonistMode: this.$('.bv_inverseAgonistMode').is(":checked")
      }, {
        silent: true
      });
      this.model.set({
        smartMode: this.$('.bv_smartMode').is(":checked")
      }, {
        silent: true
      });
      this.setThresholdModeEnabledState();
      this.setInverseAgonistModeEnabledState();
      this.model.trigger('change');
      return this.trigger('updateState');
    };

    DoseResponseKiAnalysisParametersController.prototype.handleSmartModeChanged = function() {
      return this.attributeChanged();
    };

    DoseResponseKiAnalysisParametersController.prototype.handleInactiveThresholdModeChanged = function() {
      return this.attributeChanged();
    };

    DoseResponseKiAnalysisParametersController.prototype.handleInactiveThresholdChanged = function(event, ui) {
      this.model.set({
        'inactiveThreshold': ui.value
      });
      this.updateThresholdDisplay(this.model.get('inactiveThreshold'));
      return this.attributeChanged;
    };

    DoseResponseKiAnalysisParametersController.prototype.handleInactiveThresholdMoved = function(event, ui) {
      return this.updateThresholdDisplay(ui.value);
    };

    DoseResponseKiAnalysisParametersController.prototype.handleInverseAgonistModeChanged = function() {
      return this.attributeChanged();
    };

    DoseResponseKiAnalysisParametersController.prototype.handleMaxLimitTypeChanged = function() {
      var radioValue;
      radioValue = this.$("input[name='bv_max_limitType']:checked").val();
      this.model.get('max').set({
        limitType: radioValue,
        silent: true
      });
      if (radioValue === 'none') {
        this.$('.bv_max_value').attr('disabled', 'disabled');
      } else {
        this.$('.bv_max_value').removeAttr('disabled');
      }
      return this.attributeChanged();
    };

    DoseResponseKiAnalysisParametersController.prototype.handleMinLimitTypeChanged = function() {
      var radioValue;
      radioValue = this.$("input[name='bv_min_limitType']:checked").val();
      this.model.get('min').set({
        limitType: radioValue
      });
      if (radioValue === 'none') {
        this.$('.bv_min_value').attr('disabled', 'disabled');
      } else {
        this.$('.bv_min_value').removeAttr('disabled');
      }
      return this.attributeChanged();
    };

    DoseResponseKiAnalysisParametersController.prototype.setFormTitle = function(title) {
      if (title != null) {
        this.formTitle = title;
        return this.$(".bv_formTitle").html(this.formTitle);
      } else if (this.formTitle != null) {
        return this.$(".bv_formTitle").html(this.formTitle);
      } else {
        return this.formTitle = this.$(".bv_formTitle").html();
      }
    };

    return DoseResponseKiAnalysisParametersController;

  })(AbstractFormController);

  window.DoseResponsePlotCurveKi = (function(superClass) {
    extend(DoseResponsePlotCurveKi, superClass);

    function DoseResponsePlotCurveKi() {
      this.render = bind(this.render, this);
      return DoseResponsePlotCurveKi.__super__.constructor.apply(this, arguments);
    }

    DoseResponsePlotCurveKi.prototype.log10 = function(val) {
      return Math.log(val) / Math.LN10;
    };

    DoseResponsePlotCurveKi.prototype.render = function(brd, curve, plotWindow) {
      var color, fct, intersect, log10;
      log10 = this.log10;
      fct = function(x) {
        return curve.max + (curve.min - curve.max) / (1 + Math.pow(10, x - log10(curve.ki * (1 + curve.ligandConc / curve.kd))));
      };
      brd.create('functiongraph', [fct, plotWindow[0], plotWindow[2]], {
        strokeWidth: 2
      });
      if (curve.curveAttributes.Ki != null) {
        intersect = fct(log10(curve.curveAttributes.Ki));
        if (curve.curveAttributes.Operator != null) {
          color = '#ff0000';
        } else {
          color = '#808080';
        }
        brd.create('line', [[plotWindow[0], intersect], [log10(curve.curveAttributes.Ki), intersect]], {
          fixed: true,
          straightFirst: false,
          straightLast: false,
          strokeWidth: 2,
          dash: 3,
          strokeColor: color
        });
        return brd.create('line', [[log10(curve.curveAttributes.Ki), intersect], [log10(curve.curveAttributes.Ki), 0]], {
          fixed: true,
          straightFirst: false,
          straightLast: false,
          strokeWidth: 2,
          dash: 3,
          strokeColor: color
        });
      }
    };

    return DoseResponsePlotCurveKi;

  })(Backbone.Model);

}).call(this);