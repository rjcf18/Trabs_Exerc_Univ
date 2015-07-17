var express = require('express');
var mongoose = require('mongoose');
var validator = require('validator');
var bodyParser = require('body-parser');
var constants = require('../framework/constants');

var router = express.Router();

var Bill = require('../models/bill'); // basic data model
var Client = require('../models/client');

module.exports = function(app) {

    app.get('/api/bills/', function(req, res) {
        Client.find({
            name: req.request.name
        }, function(err, clients) {
            if (!err) {
                Bill.find({
                    client_object_id: clients[0]._id
                }, function(err, bills) {
                    if (!err) {
                        res.send(bills);
                    } else {
                        res.send(err);
                    }
                });
            } else {
                res.send(err);
            }
        });
    });

    app.get('/api/bills/get', function(req, res) {
        Bill.find({
            client_object_id: req.request.id
        }, function(err, bills) {
            if (!err) {
                console.log("GET PayMyBills REST Service API");
                res.send(bills);
            } //return console.error(err);
            else {
                res.send(err);
            }
        });
    });

    app.post('/api/bills/edit', function(req, res) {

        if (validator.isHexadecimal(req.request._id) &&
            validator.isHexadecimal(req.request.client_object_id)) {

            var checkRef = validator.isNumeric(req.request.new_ref);
            var checkEntity = validator.isNumeric(req.request.new_entity);
            var checkAmount = validator.isNumeric(req.request.new_amount);
            var checkDate = validator.isDate(req.request.new_limit_date);
            var checkImage = req.request.new_image != null;

            // Check if the new data is valid
            if (checkAmount && checkRef && checkEntity && checkDate) {

                Bill.update({
                        _id: req.request._id,
                        client_object_id: req.request.client_object_id
                    }, {
                        $set: {
                            amount: req.request.new_amount,
                            ref: req.request.new_ref,
                            entity: req.request.new_entity,
                            limit_date: req.request.new_limit_date,
                            image: req.request.new_image
                        }
                    },
                    function(err) {
                        if (!err) {
                            res.send({
                                result: constants.RESULT_OK
                            });
                        } else {
                            console.log(err);
                            res.send({
                                result: constants.ERROR_INTERNAL_SERVER_ERROR
                            });
                        }
                    });

            } else if (checkImage) {
                Bill.update({
                        _id: req.request._id,
                        client_object_id: req.request.client_object_id
                    }, {
                        $set: {
                            image: req.request.new_image
                        }
                    },
                    function(err) {
                        if (!err) {
                            res.send({
                                result: constants.RESULT_OK
                            });
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

        } else {
            res.send({
                result: constants.ERROR_INSUFFICIENT_DATA
            });
        }
        console.log("Edit bill Method!!");
    });

    // Filter bills by type, date range or price
    app.post('/api/bills/filter', function(req, res) {

        //  check if the TYPE is NOT EMPTY
        //
        var hasType = false;

        if (!validator.isNull(req.request.type) &&
            validator.isAlphanumeric(req.request.type)) {
            hasType = true;
        }


        //  check if the DATE range is NOT EMPTY
        //
        var hasDate = false;
        if (!validator.isNull(req.request.date_1) &&
            !validator.isNull(req.request.date_2)) {
            hasDate = true;
        }


        //  check if the PRICE range is NOT EMPTY
        //
        var hasPRange = false;
        if (!validator.isNull(req.request.lower_amount) &&
            !validator.isNull(req.request.higher_amount)) {
            hasPRange = true;
        }

        if (hasType /* && !hasPRange && !hasDate*/ ) {
            Bill.find({
                client_object_id: req.request.client_object_id,
                type: req.request.type
            }, function(err, bills) {
                if (!err) {
                    //console.log('Filters (type):');
                    if (bills.length == 0) {
                        res.send({
                            result: constants.ERROR_NO_RESULTS_FOUND
                        });
                    } else {
                        res.send(bills);
                    }
                } else {
                    res.send({
                        result: constants.ERROR_INTERNAL_SERVER_ERROR
                    });
                }
            });
        } else if (hasPRange /*&& !hasType && !hasDate*/ ) {
            var val_low = req.request.lower_amount;
            var val_high = req.request.higher_amount;

            if (validator.isNumeric(val_low) &&
                validator.isNumeric(val_high) &&
                validator.toInt(val_low) >= 0 &&
                validator.toInt(val_high) >= 0 &&
                val_low <= val_high) {
                Bill.find({
                    client_object_id: req.request.client_object_id,
                    amount: {
                        $gte: req.request.lower_amount,
                        $lte: req.request.higher_amount
                    }
                }, function(err, bills) {
                    if (!err) {
                        if (bills.length == 0) {
                            res.send({
                                result: constants.ERROR_NO_RESULTS_FOUND
                            });
                        } else {
                            res.send(bills);
                        }
                    } else {
                        res.send({
                            result: constants.ERROR_INTERNAL_SERVER_ERROR
                        });
                    }
                });
            } else {
                res.send({
                    result: constants.ERROR_INVALID_PRICE_RANGE
                });
            }
        } else if (hasDate /*&& !hasPRange && !hasType*/ ) {
            if (validator.isDate(req.request.date_1) &&
                validator.isDate(req.request.date_2)) {
                Bill.find({
                    client_object_id: req.request.client_object_id,
                    limit_date: {
                        $gte: req.request.date_1,
                        $lte: req.request.date_2
                    }
                }, function(err, bills) {
                    if (!err) {
                        if (!err) {
                            if (bills.length == 0) {
                                res.send({
                                    result: constants.ERROR_NO_RESULTS_FOUND
                                });
                            } else {
                                res.send(bills);
                            }
                        } else {
                            //console.log('ERROR Filters (date 1, date 2):');
                            res.send({
                                result: constants.ERROR_INTERNAL_SERVER_ERROR
                            });
                        }
                    }
                });
            } else {
                console.log("Invalid Date!");
                res.send({
                    result: constants.ERROR_INVALID_REQUEST
                });
            }
        } else /* (!hasType && !hasPRange && !hasDate)*/ {
            console.log("Not Enough Data");
            res.send({
                result: constants.ERROR_INSUFFICIENT_DATA
            });
        }
    });

    app.post('/api/bills/delete', function(req, res) {

        req.request.forEach(function(item) {

            if (validator.isHexadecimal(item._id) &&
                validator.isHexadecimal(item.client_object_id)) {
                Bill.remove({
                    _id: item._id,
                    client_object_id: item.client_object_id
                }, function(err) {
                    if (!err) {
                        console.log("Bill removed: ");
                        console.log(item);
                        res.send({
                            result: constants.RESULT_OK
                        });
                    } else {
                        res.send(err);
                    }
                });
            } else {
                res.send({
                    result: constants.ERROR_INVALID_REQUEST
                });
                res.send("Bills removed");
            }
        });
    });

    app.post('/api/bills/post', function(req, res) {

        var bill = new Bill();

        bill.client_object_id = req.request.client_object_id;
        bill.image = req.request.image;
        bill.limit_date = req.request.limit_date; // THE DATE FORMAT IS YEAR-MONTH-DAY
        bill.type = req.request.type;
        bill.amount = req.request.amount;
        bill.ref = req.request.ref;
        bill.entity = req.request.entity;

        var checkClientObjectId = validator.isHexadecimal(bill.client_object_id);
        var checkRef = validator.isNumeric(bill.ref);
        var checkEntity = validator.isNumeric(bill.entity);
        var checkAmount = validator.isNumeric(bill.amount);
        //var checkImage = bill.image.length != 0;
        var checkImage = false;
        var checkDate = validator.isDate(bill.limit_date);

        console.log('Ref: %s', checkRef);
        console.log('Entity: %s', checkEntity);
        console.log('Amount: %s', checkAmount);
        console.log('Image: %s', checkImage);
        console.log('Date: %s', checkDate);

        // Check if the minimum necessary data is valid
        if (checkClientObjectId &&
            (checkImage || (checkAmount && checkRef && checkEntity && checkDate))) {

            bill.save(function(err) {
                if (!err) {
                    res.send({
                        result: constants.RESULT_OK
                    });
                    console.log("Bill saved!!");
                } else {
                    res.send({
                        result: constants.ERROR_INTERNAL_SERVER_ERROR
                    });
                    console.log(err);
                }

            });

        } else {
            res.send({
                result: constants.ERROR_INVALID_REQUEST
            });
        }

    });
};