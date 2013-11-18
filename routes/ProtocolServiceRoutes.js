/* To install this Module
1) Add these lines to app.coffee under # serverAPI routes:
protocolRoutes = require './routes/ProtocolServiceRoutes.js'
app.get '/api/protocols/codename/:code', protocolRoutes.protocolByCodename
app.get '/api/protocols/:id', protocolRoutes.protocolById
app.post '/api/protocols', protocolRoutes.postProtocol
app.put '/api/protocols', protocolRoutes.putProtocol
app.get '/api/protocollabels', protocolRoutes.protocolLabels
app.get '/api/protocolCodeList', protocolRoutes.protocolCodeList
app.get '/api/protocolCodeList/:filter', protocolRoutes.protocolCodeList
*/


(function() {
  exports.protocolByCodename = function(req, resp) {
    var baseurl, config, protocolServiceTestJSON, serverUtilityFunctions;
    console.log(req.params.code);
    if (global.specRunnerTestmode) {
      protocolServiceTestJSON = require('../public/javascripts/spec/testFixtures/ProtocolServiceTestJSON.js');
      return resp.end(JSON.stringify(protocolServiceTestJSON.stubSavedProtocol));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.persistence.fullpath + "protocols/codename/" + req.params.code;
      serverUtilityFunctions = require('./ServerUtilityFunctions.js');
      return serverUtilityFunctions.getFromACASServer(baseurl, resp);
    }
  };

  exports.protocolById = function(req, resp) {
    var baseurl, config, protocolServiceTestJSON, serverUtilityFunctions;
    console.log(req.params.id);
    if (global.specRunnerTestmode) {
      protocolServiceTestJSON = require('../public/javascripts/spec/testFixtures/ProtocolServiceTestJSON.js');
      return resp.end(JSON.stringify(protocolServiceTestJSON.fullSavedProtocol));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.persistence.fullpath + "protocols/" + req.params.id;
      serverUtilityFunctions = require('./ServerUtilityFunctions.js');
      return serverUtilityFunctions.getFromACASServer(baseurl, resp);
    }
  };

  exports.postProtocol = function(req, resp) {
    var baseurl, config, experimentServiceTestJSON, request,
      _this = this;
    if (global.specRunnerTestmode) {
      experimentServiceTestJSON = require('../public/javascripts/spec/testFixtures/ProtocolServiceTestJSON.js');
      return resp.end(JSON.stringify(experimentServiceTestJSON.fullSavedProtocol));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.persistence.fullpath + "protocols";
      request = require('request');
      return request({
        method: 'POST',
        url: baseurl,
        body: req.body,
        json: true
      }, function(error, response, json) {
        if (!error && response.statusCode === 201) {
          console.log(JSON.stringify(json));
          return resp.end(JSON.stringify(json));
        } else {
          console.log('got ajax error trying to save new experiment');
          console.log(error);
          console.log(json);
          return console.log(response);
        }
      });
    }
  };

  exports.putProtocol = function(req, resp) {
    var baseurl, config, experimentServiceTestJSON, request,
      _this = this;
    if (global.specRunnerTestmode) {
      experimentServiceTestJSON = require('../public/javascripts/spec/testFixtures/ProtocolServiceTestJSON.js');
      return resp.end(JSON.stringify(experimentServiceTestJSON.fullSavedProtocol));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.persistence.fullpath + "protocols";
      request = require('request');
      return request({
        method: 'PUT',
        url: baseurl,
        body: req.body,
        json: true
      }, function(error, response, json) {
        if (!error && response.statusCode === 201) {
          console.log(JSON.stringify(json));
          return resp.end(JSON.stringify(json));
        } else {
          console.log('got ajax error trying to save new experiment');
          console.log(error);
          console.log(json);
          return console.log(response);
        }
      });
    }
  };

  exports.protocolLabels = function(req, resp) {
    var baseurl, config, protocolServiceTestJSON, serverUtilityFunctions;
    if (global.specRunnerTestmode) {
      protocolServiceTestJSON = require('../public/javascripts/spec/testFixtures/ProtocolServiceTestJSON.js');
      return resp.end(JSON.stringify(protocolServiceTestJSON.protocolLabels));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.persistence.fullpath + "protocollabels";
      serverUtilityFunctions = require('./ServerUtilityFunctions.js');
      return serverUtilityFunctions.getFromACASServer(baseurl, resp);
    }
  };

  exports.protocolCodeList = function(req, resp) {
    var baseurl, config, filterString, labels, protocolServiceTestJSON, request, shouldFilter,
      _this = this;
    console.log(req.params);
    if (req.params.str != null) {
      shouldFilter = true;
      filterString = req.params.str;
    } else {
      shouldFilter = false;
    }
    if (global.specRunnerTestmode) {
      protocolServiceTestJSON = require('../public/javascripts/spec/testFixtures/ProtocolServiceTestJSON.js');
      labels = protocolServiceTestJSON.protocolLabels;
      return resp.json(translateToCodes(labels));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.persistence.fullpath + "protocollabels/codetable";
      if (shouldFilter) {
        baseurl += "/?protocolName=" + filterString;
      }
      request = require('request');
      return request({
        method: 'GET',
        url: baseurl,
        json: true
      }, function(error, response, json) {
        if (!error && response.statusCode === 200) {
          return resp.json(json);
        } else {
          console.log('got ajax error trying to get protocol labels');
          console.log(error);
          console.log(json);
          return console.log(response);
        }
      });
    }
  };

}).call(this);
