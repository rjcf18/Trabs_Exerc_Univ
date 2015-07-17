/**
 * Created by ricardo on 09-07-2015.
 */

var request = require("supertest");
var express = require('express');
var should = require('should');
var app = require('../server.js');

// data model
var Client = require('../models/client');
var constants = require('./../framework/constants');



describe('clients', function (){

    var dummyClientId = "";

    beforeEach(function(done){

        constants.ENCRYPT_DATA = false;
        constants.ENABLE_HASHING_CHECKS = false;

        var client = new Client();

        client.name = "DummyClient";
        client.email = ["dummy1@email.com", "dummy2@email.com"];
        client.password = "password123";

        client.save(function(err){
            if (!err) {
                console.log("Dummy Client saved!!");
            }
            else {
                console.log("Dummy client not saved successfully.");
            }

            dummyClientId = client._id;
            done();

        });
    });

    afterEach(function(done){

        Client.remove({_id:dummyClientId}, function (err) {
            if (!err) {
                console.log("Dummy data deleted!");
            }
            else {
                console.log("Dummy data not deleted successfully!");
            }
            done();
        });
    });


    /**
     * Test if a new client is inserted with success
     */

    describe('POST /api/clients/post', function(){

        var name = "Test1";
        var email = ["test@email.com"];
        var password = "password1";

        it('Test for inserting a new client', function(done){

            request(app).post('/api/clients/post').send({
                name:name,
                email:email,
                password:password

            }).expect('Content-Type', /json/).end(function (err, res) {
                res.body.should.have.property('result', constants.RESULT_OK);

                done();
            });
        });
    });


    /**
     * Test if the client contains all the fields
     */

    describe('GET /api/clients/get', function(){

        var str = '/api/clients/get?_id='+dummyClientId;

        it('Test to the client JSON', function(done){
            request(app).get(str).expect('Content-Type', /json/).end(function(err, res){
                res.body.forEach(function (item) {
                    item.should.have.property('name');
                    item.should.have.property('email');
                    item.should.have.property('password');
                });
                done();
            });
        });
    });


    /**
     * Defect test - insert a client with an invalid email
     */

    describe('POST /api/clients/post', function(){

        var name = "Test2";
        var email = ["55555"];
        var password = "password";

        it('Test for invalid email (DEFECT TEST)', function(done){

            request(app).post('/api/clients/post').send({

                name:name,
                email:email,
                password:password

            }).expect('Content-Type', /json/).end(function (err, res) {
                console.log(res);
                res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                done();

            });
        });
    });

    /**
     * Defect test - insert a client with an invalid name
     */

    describe('POST /api/clients/post', function(){
        var name = "....-";
        var email = ["test@email.com"];
        var password = "password11";

        it('Test for invalid name (DEFECT TEST)', function(done){
            request(app).post('/api/clients/post').send({
                name:name,
                email:email,
                password:password
            }).expect('Content-Type', /json/).end(function (err, res) {
                res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                done();
            });
        });
    });


    /**
     * Defect test - insert without the minimum data required
     */

    describe('POST /api/clients/post', function(){
        var name = "";
        var email = ["test@email.com"];
        var password = "12345";

        it('Test for minimum data (DEFECT TEST)', function(done){

            request(app).post('/api/clients/post').send({
                name:name,
                email:email,
                password:password
            }).expect('Content-Type', /json/).end(function (err, res) {
                res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                done();
            });
        });
    });
});

