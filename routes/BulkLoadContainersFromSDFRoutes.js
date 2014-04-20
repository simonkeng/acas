/* To install this Module
1) add to app.coffee
  # BulkLoadContainersFromSDF routes
	bulkLoadContainersFromSDFRoutes = require './public/src/modules/BulkLoadContainersFromSDF/src/server/routes/BulkLoadContainersFromSDFRoutes.js'
	bulkLoadContainersFromSDFRoutes.setupRoutes(app)

2) Add this line to public/src/modules/ModuleMenus/src/client/ModuleMenusConfiguration.coffee
{isHeader: false, menuName: "Load Containers From SDF", mainControllerClassName: "BulkLoadContainersFromSDFController"}
*/


(function() {
  exports.setupRoutes = function(app) {
    return app.post('/api/bulkLoadContainersFromSDF', exports.bulkLoadContainersFromSDF);
  };

  exports.bulkLoadContainersFromSDF = function(request, response) {
    var serverUtilityFunctions;
    request.connection.setTimeout(6000000);
    serverUtilityFunctions = require('./ServerUtilityFunctions.js');
    response.writeHead(200, {
      'Content-Type': 'application/json'
    });
    if (global.specRunnerTestmode) {
      return serverUtilityFunctions.runRFunction(request, "public/src/modules/BulkLoadContainersFromSDF/src/server/BulkLoadContainersFromSDFStub.R", "bulkLoadContainersFromSDF", function(rReturn) {
        return response.end(rReturn);
      });
    } else {
      return serverUtilityFunctions.runRFunction(request, "public/src/modules/BulkLoadContainersFromSDF/src/server/BulkLoadContainersFromSDF.R", "bulkLoadContainersFromSDF", function(rReturn) {
        return response.end(rReturn);
      });
    }
  };

}).call(this);
