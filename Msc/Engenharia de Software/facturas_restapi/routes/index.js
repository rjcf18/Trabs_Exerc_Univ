module.exports = {
    /**
     * Routing table
     * Use this variable to setup the REST API URL PATH and the function callback
     * that should be in a separate file.
     */
    routingTable: [
    {path: './login'},
    {path: './clients'},
    {path: './bills'},
    {path: './register'},
    {path: './devices'}],

    /**
     * Configure the service API routing
     * @param app
     */
    configure: function (app) {

        var routingTable = module.exports.routingTable;
        for (var route in routingTable) {
            var obj = routingTable[route];
            require(obj.path)(app);
        }
    }
};
