(function() {
  (function(exports) {
    return exports.typeKindList = {
      statetypes: [
        {
          typeName: "data",
          typeName: "dose response",
          typeName: "metadgiata"
        }
      ],
      statekinds: [
        {
          typeName: "metadata",
          kindName: "experiment metadata"
        }, {
          typeName: "data",
          kindName: "results"
        }, {
          typeName: "data",
          kindName: "dose response"
        }, {
          typeName: "data",
          kindName: "results"
        }, {
          typeName: "metadata",
          kindName: "subject metadata"
        }, {
          typeName: "data",
          kindName: "user flag"
        }, {
          typeName: "data",
          kindName: "auto flag"
        }, {
          typeName: "data",
          kindName: "preprocess flag"
        }
      ],
      valuetypes: [
        {
          typeName: "numericValue"
        }, {
          typeName: "codeValue"
        }, {
          typeName: "stringValue"
        }, {
          typeName: "clobValue"
        }, {
          typeName: "codeValue"
        }
      ],
      valuekinds: [
        {
          typeName: "codeValue",
          kindName: "model fit status"
        }, {
          typeName: "clobValue",
          kindName: "model fit parameters"
        }, {
          kindName: "curveErrorsClob",
          typeName: "clobValue"
        }, {
          kindName: "fitSettings",
          typeName: "clobValue"
        }, {
          kindName: "fitSummaryClob",
          typeName: "clobValue"
        }, {
          kindName: "model fit result html",
          typeName: "clobValue"
        }, {
          kindName: "parameterStdErrorsClob",
          typeName: "clobValue"
        }, {
          kindName: "reportedValuesClob",
          typeName: "clobValue"
        }, {
          kindName: "algorithm flag observation",
          typeName: "codeValue"
        }, {
          kindName: "algorithm flag reason",
          typeName: "codeValue"
        }, {
          kindName: "algorithm flag status",
          typeName: "codeValue"
        }, {
          kindName: "batch code",
          typeName: "codeValue"
        }, {
          kindName: "experiment status",
          typeName: "codeValue"
        }, {
          kindName: "flag observation",
          typeName: "codeValue"
        }, {
          kindName: "flag reason",
          typeName: "codeValue"
        }, {
          kindName: "flag status",
          typeName: "codeValue"
        }, {
          kindName: "preprocess flag observation",
          typeName: "codeValue"
        }, {
          kindName: "preprocess flag reason",
          typeName: "codeValue"
        }, {
          kindName: "preprocess flag status",
          typeName: "codeValue"
        }, {
          kindName: "protocol status",
          typeName: "codeValue"
        }, {
          kindName: "user flag observation",
          typeName: "codeValue"
        }, {
          kindName: "user flag reason",
          typeName: "codeValue"
        }, {
          kindName: "user flag status",
          typeName: "codeValue"
        }, {
          kindName: "EC50",
          typeName: "numericValue"
        }, {
          kindName: "Fitted EC50",
          typeName: "numericValue"
        }, {
          kindName: "Fitted Ki",
          typeName: "numericValue"
        }, {
          kindName: "Fitted Max",
          typeName: "numericValue"
        }, {
          kindName: "Fitted Min",
          typeName: "numericValue"
        }, {
          kindName: "Fitted Slope",
          typeName: "numericValue"
        }, {
          kindName: "Kd",
          typeName: "numericValue"
        }, {
          kindName: "Ki",
          typeName: "numericValue"
        }, {
          kindName: "Ligand Conc",
          typeName: "numericValue"
        }, {
          kindName: "Max",
          typeName: "numericValue"
        }, {
          kindName: "Min",
          typeName: "numericValue"
        }, {
          kindName: "Response",
          typeName: "numericValue"
        }, {
          kindName: "rSquared",
          typeName: "numericValue"
        }, {
          kindName: "Slope",
          typeName: "numericValue"
        }, {
          kindName: "SSE",
          typeName: "numericValue"
        }, {
          kindName: "SST",
          typeName: "numericValue"
        }, {
          kindName: "transformed efficacy",
          typeName: "numericValue"
        }, {
          kindName: "category",
          typeName: "stringValue"
        }, {
          kindName: "comment",
          typeName: "stringValue"
        }, {
          kindName: "curve id",
          typeName: "stringValue"
        }, {
          kindName: "EC50",
          typeName: "stringValue"
        }, {
          kindName: "Ki",
          typeName: "stringValue"
        }, {
          kindName: "Max",
          typeName: "stringValue"
        }, {
          kindName: "Min",
          typeName: "stringValue"
        }, {
          kindName: "Rendering Hint",
          typeName: "stringValue"
        }, {
          kindName: "Slope",
          typeName: "stringValue"
        }
      ],
      ddicttypes: [
        {
          typeName: "model fit"
        }, {
          typeName: "compound"
        }, {
          typeName: "user well flags"
        }, {
          typeName: "algorithm well flags"
        }, {
          typeName: "compound"
        }
      ],
      ddictkinds: [
        {
          typeName: "model fit",
          kindName: "status"
        }, {
          typeName: "model fit",
          kindName: "type"
        }, {
          typeName: "compound",
          kindName: "batch name"
        }, {
          typeName: "user well flags",
          kindName: "flag status"
        }, {
          typeName: "user well flags",
          kindName: "flag reason"
        }, {
          typeName: "user well flags",
          kindName: "flag observation"
        }, {
          typeName: "algorithm well flags",
          kindName: "flag status"
        }, {
          typeName: "algorithm well flags",
          kindName: "flag reason"
        }, {
          typeName: "algorithm well flags",
          kindName: "flag observation"
        }
      ],
      codetables: [
        {
          codeType: "model fit",
          codeKind: "status",
          codeOrigin: "ACAS DDICT",
          code: "not started",
          name: "Not Started",
          ignored: false
        }, {
          codeType: "model fit",
          codeKind: "status",
          codeOrigin: "ACAS DDICT",
          code: "running",
          name: "Running",
          ignored: false
        }, {
          codeType: "model fit",
          codeKind: "status",
          codeOrigin: "ACAS DDICT",
          code: "complete",
          name: "Complete",
          ignored: false
        }, {
          codeType: "model fit",
          codeKind: "type",
          codeOrigin: "ACAS DDICT",
          code: "4 parameter D-R",
          name: "EC50",
          ignored: false
        }, {
          codeType: "model fit",
          codeKind: "type",
          codeOrigin: "ACAS DDICT",
          code: "Ki Fit",
          name: "Ki",
          ignored: false
        }, {
          codeType: "user flag status",
          codeKind: "flag status",
          codeOrigin: "ACAS DDICT",
          code: "approved",
          name: "Approved",
          ignored: false
        }, {
          codeType: "user flag status",
          codeKind: "flag status",
          codeOrigin: "ACAS DDICT",
          code: "rejected",
          name: "Rejected",
          ignored: false
        }, {
          codeType: "algorithm flag status",
          codeKind: "flag status",
          codeOrigin: "ACAS DDICT",
          code: "no fit",
          name: "No Fit",
          ignored: false
        }, {
          codeType: "user well flags",
          codeKind: "flag observation",
          codeOrigin: "ACAS DDICT",
          code: "high",
          name: "High Signal",
          ignored: false
        }, {
          codeType: "user well flags",
          codeKind: "flag observation",
          codeOrigin: "ACAS DDICT",
          code: "low",
          name: "Low Signal",
          ignored: false
        }, {
          codeType: "user well flags",
          codeKind: "flag observation",
          codeOrigin: "ACAS DDICT",
          code: "gradient",
          name: "Gradient (slope/trend)",
          ignored: false
        }, {
          codeType: "user well flags",
          codeKind: "flag status",
          codeOrigin: "ACAS DDICT",
          code: "knocked out",
          name: "Knocked Out",
          ignored: false
        }
      ]
    };
  })((typeof process === "undefined" || !process.versions ? window.curveAnalysisConfJSON = window.curveAnalysisConfJSON || {} : exports));

}).call(this);
