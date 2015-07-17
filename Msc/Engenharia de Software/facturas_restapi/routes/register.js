/**
 * Created by hiperzone on 27-04-2015.
 */

var crypto = require('./../framework/crypto');
var constants = require('./../framework/constants');
var Client = require('./../models/client');
var validator = require('validator');

/**
 * Module that handles user registrations
 * @param app
 */
module.exports = function(app) {
    var TAG = "/api/register ";

    function onDatabaseError(username, req, res) {
        res.json(crypto.encryptData(username, req.route.path, {
            result: constants.ERROR_INTERNAL_SERVER_ERROR
        }));
    }

    function didAddUsernameToTheDatabase(username, req, res) {
        res.json(crypto.encryptData(username, req.route.path, {
            result: constants.RESULT_OK
        }));
    }

    function onUsernameError(username, req, res) {
        res.json(crypto.encryptData(username, req.route.path, {
            result: constants.ERROR_INVALID_USERNAME_OR_PASSWORD
        }));
    }

    function onRequestFailed(username, req, res) {
        res.json(crypto.encryptData(username, req.route.path, {
            result: constants.ERROR_INVALID_REQUEST
        }));
    }

    /**
     * Adds the user to the database.
     * @param user
     * @param password
     */
    var addUserToDB = function(user, password, req, res) {
        var client = new Client();
        client.name = user;
        client.password = password;
        client.bills = [];
        if (!validator.isNull(req.body.email)) {
            client.email = req.body.email;
        }else{
            client.email = "placeholder@placeholder.placeholder";
        }
        client.devices = [];
        client.save(function(err) {
            if (err) {
                onDatabaseError(user, req, res);
                return;
            }

            didAddUsernameToTheDatabase(user, req, res);
        });
    };

    app.post('/api/register', function(req, res) {
        if (constants.DEBUG) {
            console.log(TAG + "Incoming user registration user: " + req.request.username + " password: " + req.request.password);
        }

        var username = req.request.username;
        var password = req.request.password;


        if (validator.isNull(req.request)) {
            onRequestFailed(username, req, res);
            return;
        }

        if (validator.isNull(req.request.username) || validator.isNull(req.request.password)) {
            onUsernameError(username, req, res);
            return;
        }

        //check the database for the user
        Client.find({
            name: username
        }, function(error, result) {
            if (error) {
                onDatabaseError(username, req, res);
                return;
            }

            if (result.length == 0) {
                addUserToDB(username, password, req, res);
                return;
            }

            onUsernameError(username, req, res);
        });
    });
};