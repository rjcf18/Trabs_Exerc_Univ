var crypto = require('./../framework/crypto');
var constants = require('./../framework/constants');
var Client = require('./../models/client');
var validator = require('validator');

module.exports = function (app) {

    function onDatabaseError(username, req, res) {
        res.json( crypto.encryptData(username, req.route.path, { result : constants.ERROR_INTERNAL_SERVER_ERROR} ));
    }

    function onUsernameError(username, req, res) {
        res.json(crypto.encryptData(username, req.route.path, {result: constants.ERROR_INVALID_USERNAME_OR_PASSWORD}));
    }

    function onRequestFailed(username, req, res) {
        res.json(crypto.encryptData(username, req.route.path, {result: constants.ERROR_INVALID_REQUEST}));
    }

    function didValidateLogin(username, req, res) {
        res.json( crypto.encryptData(username, req.route.path, { result : constants.RESULT_OK} ));
    }

    app.post('/api/login', function(req, res) {

        var TAG = "/api/login";

        if(constants.DEBUG) {
            console.log(TAG + "Incoming user login: user: " + req.request.username + " password: " + req.request.password);
        }

        var username = req.request.username;
        var password = req.request.password;

        if(validator.isNull(req.request)) {
            onRequestFailed(username, req, res);
            return;
        }

        if(validator.isNull(req.request.username) || validator.isNull(req.request.password))
        {
            onUsernameError(username, req, res);
            return;
        }

        //check the database for the user
        Client.find({name : username}, function(error, result) {
            if(error) {
                onDatabaseError(username, req, res);
            }
            else if(result.length == 0)
            {
                onUsernameError(username, req, res);
                return;
            }

            if(password === result[0].password) {
                didValidateLogin(username, req, res);
            }
            else
            {
                onUsernameError(username, req, res);
            }
        });
    });
};
