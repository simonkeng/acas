/* To install this Module
1) Add these lines to app.coffee under # serverAPI routes:
experimentRoutes = require './routes/ExperimentServiceRoutes.js'
app.get '/api/experiments/codename/:code', experimentRoutes.experimentByCodename
app.get '/api/experiments/protocolCodename/:code', experimentRoutes.experimentsByProtocolCodename
app.get '/api/experiments/:id', experimentRoutes.experimentById
app.post '/api/experiments', experimentRoutes.postExperiment
app.put '/api/experiments', experimentRoutes.putExperiment
*/


(function() {
  exports.experimentByCodename = function(request, response) {
    var baseurl, config, experimentServiceTestJSON, serverUtilityFunctions;
    console.log(request.params.code);
    console.log(request.query.testMode);
    if (request.query.testMode || global.specRunnerTestmode) {
      experimentServiceTestJSON = require('../public/javascripts/spec/testFixtures/ExperimentServiceTestJSON.js');
      return response.end(JSON.stringify(experimentServiceTestJSON.stubSavedExperiment[0]));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.persistence.fullpath + "experiments/codename/" + request.params.code;
      serverUtilityFunctions = require('./ServerUtilityFunctions.js');
      return serverUtilityFunctions.getFromACASServer(baseurl, response);
    }
  };

  exports.experimentsByProtocolCodename = function(request, response) {
    var baseurl, config, experimentServiceTestJSON, serverUtilityFunctions;
    console.log(request.params.code);
    console.log(request.query.testMode);
    if (request.query.testMode || global.specRunnerTestmode) {
      experimentServiceTestJSON = require('../public/javascripts/spec/testFixtures/ExperimentServiceTestJSON.js');
      return response.end(JSON.stringify(experimentServiceTestJSON.stubSavedExperiment));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.persistence.fullpath + "experiments/protocolCodename/" + request.params.code;
      serverUtilityFunctions = require('./ServerUtilityFunctions.js');
      return serverUtilityFunctions.getFromACASServer(baseurl, response);
    }
  };

  exports.experimentById = function(req, resp) {
    var baseurl, config, experimentServiceTestJSON, serverUtilityFunctions;
    console.log(req.params.id);
    if (global.specRunnerTestmode) {
      experimentServiceTestJSON = require('../public/javascripts/spec/testFixtures/ExperimentServiceTestJSON.js');
      return resp.end(JSON.stringify(experimentServiceTestJSON.fullExperimentFromServer));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.persistence.fullpath + "experiments/" + req.params.id;
      serverUtilityFunctions = require('./ServerUtilityFunctions.js');
      return serverUtilityFunctions.getFromACASServer(baseurl, resp);
    }
  };

  exports.postExperiment = function(req, resp) {
    var baseurl, config, experimentServiceTestJSON, request,
      _this = this;
    if (global.specRunnerTestmode) {
      experimentServiceTestJSON = require('../public/javascripts/spec/testFixtures/ExperimentServiceTestJSON.js');
      return resp.end(JSON.stringify(experimentServiceTestJSON.fullExperimentFromServer));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.persistence.fullpath + "experiments";
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

  exports.putExperiment = function(req, resp) {
    var baseurl, config, experimentServiceTestJSON, putId, request,
      _this = this;
    if (global.specRunnerTestmode) {
      experimentServiceTestJSON = require('../public/javascripts/spec/testFixtures/ExperimentServiceTestJSON.js');
      return resp.end(JSON.stringify(experimentServiceTestJSON.fullExperimentFromServer));
    } else {
      config = require('../conf/compiled/conf.js');
      putId = req.body.id;
      baseurl = config.all.client.service.persistence.fullpath + "experiments/" + putId;
      request = require('request');
      return request({
        method: 'PUT',
        url: baseurl,
        body: req.body,
        json: true
      }, function(error, response, json) {
        console.log(response.statusCode);
        if (!error && response.statusCode === 200) {
          console.log(JSON.stringify(json));
          return resp.end(JSON.stringify(json));
        } else {
          console.log('got ajax error trying to save new experiment');
          console.log(error);
          return console.log(response);
        }
      });
    }
  };

}).call(this);
