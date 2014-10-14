(function() {
  (function(exports) {
    exports.savedReagent = {
      cas: 123456,
      barcode: "RR123345",
      vendor: "vendor1",
      hazardCategory: "flammable"
    };
    return exports.hazardCategories = [
      {
        code: "flammable",
        name: "Flammable",
        ignored: false
      }, {
        code: "acid",
        name: "Acid",
        ignored: false
      }, {
        code: "badSmell",
        name: "Smells Bad",
        ignored: true
      }, {
        code: "base",
        name: "Base",
        ignored: false
      }
    ];
  })((typeof process === "undefined" || !process.versions ? window.reagentRegTestJSON = window.reagentRegTestJSON || {} : exports));

}).call(this);
