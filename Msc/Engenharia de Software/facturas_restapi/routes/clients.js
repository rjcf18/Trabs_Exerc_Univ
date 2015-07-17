/**
 * Created by ricardo on 07-05-2015.
 */

var express = require('express');
var mongoose = require('mongoose');
var validator = require('validator');
var constants = require('../framework/constants');

var router = express.Router();

var Client = require('../models/client'); // basic data model


module.exports = function(app) {

    app.get('/api/clients', function(req, res) {

        Client.find({
            name: req.request.name
        }, function(err, clients) {
            if (!err) {
                res.send(clients);
            }
            else {
                res.send(err);
            }
        });
    });

    app.get('/api/clients/get', function(req, res) {

        Client.find({
            client_object_id: req.request.id
        }, function(err, clients) {
            if (!err) {
                console.log("GET clients PayMyBills REST Service API");
                res.send(clients);
            } //return console.error(err);
            else {
                res.send(err);
            }
        });
    });

    app.post('/api/clients/filter', function(req, res) {

        var nameIsNull = validator.isNull(req.body.name);
        var emailIsNull = validator.isNull(req.body.email);

        var checkMail = validator.isEmail(req.body.email);

        if (!nameIsNull & !emailIsNull & checkMail) {
            Client.find({
                    name: req.body.name,
                    email: req.body.email
                },
                function(err, clients) {
                    if (!err & clients.length > 0) {
                        //console.log('Filters (name, email)');
                        res.send(clients);
                    } else {
                        res.send({
                            result: constants.ERROR_USER_NOT_FOUND
                        });
                    }
                });

        } else if (!nameIsNull & emailIsNull) {
            Client.find({
                name: req.body.name
            }, function(err, clients) {
                if (!err & clients.length > 0) {
                    //console.log('Filters (name)');
                    res.send(clients);
                } else {
                    res.send({
                        result: constants.ERROR_USER_NOT_FOUND
                    });
                }
            });

        } else if (nameIsNull & !emailIsNull & checkMail) {
            Client.find({
                email: req.body.email
            }, function(err, clients) {
                if (!err & clients.length > 0) {
                    //console.log('Filters (email)');
                    res.send(clients);
                } else {
                    res.send({
                        result: constants.ERROR_USER_NOT_FOUND
                    });
                }
            });
        } else if (!checkMail /*& nameIsNull*/ & !emailIsNull) {
            res.send({
                result: constants.ERROR_INVALID_EMAIL
            });
        } else {
            res.send({
                result: constants.ERROR_INSUFFICIENT_DATA
            });
        }
    });

    app.post('/api/clients/edit', function(req, res) {

        if (validator.isHexadecimal(req.body._id)) {

            var checkName = validator.isAlphanumeric(req.body.new_name);
            var checkPassword = validator.isAlphanumeric(req.body.new_password);
            var checkEmail = validator.isEmail(req.body.new_email);
            var checkDevice = validator.isAlphanumeric(req.body.new_device);

            // Check if the new data is valid
            if (checkName & checkPassword & checkEmail & checkDevice) {

                Bill.update({
                        _id: req.body._id
                    }, {
                        $set: {
                            name: req.body.new_name,
                            password: req.body.new_password
                        }
                    },
                    function(err) {
                        if (!err) {
                            res.send("Edited successfully!");
                        } else {
                            res.send("Opss, something went wrong! :( \n\n" + err);
                        }
                    });

            } else {

                res.send("Opss: Invalid data!!");

            }

        } else {
            res.send("Opss: There is no valid data to find the client you want to edit!");
        }
        console.log("Edit Client Method!!");
    });

    app.post('/api/clients/delete', function(req, res) {

        req.body.forEach(function(item) {
            Client.remove({
                _id: item._id
            }, function(err) {
                if (!err) {
                    console.log("Client removed: ");
                    console.log(item);
                } else {
                    res.send(err);
                }
            });
        });

        res.send("Clients removed");

    });

    app.post('/api/clients/post', function(req, res) {

        var client = new Client();

        client.name = req.body.name;
        client.email = req.body.email;
        //client.devices = req.body.devices;
        client.password = req.body.password;

        // Check if there is enough data to create a client
        if (client.name != null & client.email != null & /*client.devices != null &*/ client.password != null) {
            console.log('Enough data!!');

            var checkName = validator.isAlphanumeric(client.name);
            var checkEmail = validator.isEmail(client.email);
            var checkPassword = validator.isAlphanumeric(client.password);

            console.log('Name: %s', checkName);
            console.log('Email: %s', checkEmail);
            console.log('Password: %s', checkPassword);

            // Check if the minimum necessary data is valid
            if (checkName & checkEmail & checkPassword) {
                client.save(function(err) {
                    if (!err) {
                        res.send({
                            result: constants.RESULT_OK
                        });

                        console.log("Client saved!!");
                    } else {
                        res.send({
                            result: constants.ERROR_INTERNAL_SERVER_ERROR
                        });
                    }

                });
            } else {
                res.send({
                    result: constants.ERROR_INVALID_REQUEST
                });
            }
        }
        else{
            console.log('Not enough data!!');

            res.send({
                result: constants.ERROR_INSUFFICIENT_DATA
            });
        }

    });

};