
/**
 * Module dependencies.
 */

var express = require('express');
var mongoose = require('mongoose');
var cors = require('cors');
var bodyParser = require('body-parser'); //middleware needed in express 4

var constants = require('./framework/constants');

var routes = require('./routes/index');

var crypto = require('./framework/crypto');

var url = require('url');

var mongoDB = 'mongodb://localhost:27017/faturadb';

if(process.env.NODE_ENV == 'test') {
    console.log("Using test enviroment");
    mongoDB = 'mongodb://localhost:27017/faturadb-test';
}

// Connect to mongodb
var connect = function () {
    var options = {
        server: {
            socketOptions: {
                keepAlive: 1
            }
        }
    };
    mongoose.connect(mongoDB, options);
};
connect();

var app = express();

app.use( bodyParser.json() );       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
})); 

app.use(cors());

app.listen(3004, function () {
    var host = this.address().address;
    var port = this.address().port;

    console.log('listening at http://%s:%s', host, port);

    if(constants.DEBUG){
        console.log("Debugging mode enabled");
    }

    if(constants.ENABLE_HASHING_CHECKS) {
        console.log("Hashing verification enabled");
    }

    if(constants.ENCRYPT_DATA) {
        console.log("Data encryption enabled");
    }

    routes.configure(app);
    console.log("Route table initiated");
});


/**
 * Support for data integrity for POST and GET methods
 * other methods will be added later
 */
app.use(function timeLog(req, res, next) {
    var result = null;
    if(req.method == 'POST') {
        if(req.body.data) {
            result = crypto.decryptAndVerify(req._parsedUrl.pathname, req.body);
            if(!result.result)
            {
                return next(res.json({result: constants.ERROR_INTEGRITY_FAILED}));
            }
            req.request = result.data;
        }
        else {
            req.request = req.body;
        }
    }
    else if(req.method == 'GET') {
        var url_parts = url.parse(req.url, true);
        var query = url_parts.query;
        //construct the AES data
        if(query.data) {
            query = decodeURIComponent(query.data);
            var queryParsed = JSON.parse(query);
            result = crypto.decryptAndVerify( req._parsedUrl.pathname, queryParsed);
            if(!result.result)
            {
                return next(res.json({result: constants.ERROR_INTEGRITY_FAILED}));
            }
            req.request = result.data;
        }
        else {
            req.request = req.query;
        }
    }

    next();
});

module.exports = app;






