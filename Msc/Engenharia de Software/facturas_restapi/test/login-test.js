var request = require('supertest');
var express = require('express');
var should = require('should');
var constants = require('./../framework/constants');
var Client = require('./../models/client');
var crypto = require('./../framework/crypto');

process.env.NODE_ENV = 'test';

var app = require('../server.js');


//tests
describe('POST /api/login', function(){
    before(function(done) {
        constants.ENCRYPT_DATA = false;
        constants.ENABLE_HASHING_CHECKS = false;
        Client.find({}).remove().exec(done());
    });

    afterEach(function(done){
        Client.find({}).remove().exec(done());
    });

    it('login failed - no username - no encrypt or hashing ', function(done){
        request(app)
            .post('/api/login')
            .send({username : 'test', password: 'test'})
            .expect('Content-Type', /json/)
            .expect(200)
            .end(function (err, res) {
                res.body.should.have.property('id');
                res.body.should.have.property('timestamp');
                res.body.should.have.property('hash');
                res.body.should.have.property('data');

                res.body.id.should.equal('test');
                res.body.data.result.should.equal(constants.ERROR_INVALID_USERNAME_OR_PASSWORD);
                done();
            });
    });

    it('login successful', function(done) {
        console.log('Creating dummy username before login test');
        var client = new Client();
        client.name = "test";
        client.password = "test";
        client.bills = [];
        client.email = "placeholder@placeholder.placeholder";
        client.devices = [];

        client.save(function(err) {
            should(err).equal(null);
            console.log("username created");

            request(app)
                .post('/api/login')
                .send({username : 'test', password: 'test'})
                .expect('Content-Type', /json/)
                .expect(200)
                .end(function (err, res) {
                    res.body.should.have.property('id');
                    res.body.should.have.property('timestamp');
                    res.body.should.have.property('hash');
                    res.body.should.have.property('data');

                    res.body.id.should.equal('test');
                    res.body.data.result.should.equal(constants.RESULT_OK);
                    done();
                });
        });
    });

    //defect tests
    it('login failed - empty body', function(done) {
        request(app)
            .post('/api/login')
            .send({})
            .expect('Content-Type', /json/)
            .expect(200)
            .end(function (err, res) {
                res.body.should.not.have.property('id');
                res.body.should.have.property('timestamp');
                res.body.should.have.property('hash');
                res.body.should.have.property('data');
                res.body.data.result.should.equal(constants.ERROR_INVALID_USERNAME_OR_PASSWORD);
                done();
            });
    });

    it('login failed - null body', function(done) {
        request(app)
            .post('/api/login')
            .send(null)
            .expect('Content-Type', /json/)
            .expect(200)
            .end(function (err, res) {
                res.body.should.not.have.property('id');
                res.body.should.have.property('timestamp');
                res.body.should.have.property('hash');
                res.body.should.have.property('data');
                res.body.data.result.should.equal(constants.ERROR_INVALID_USERNAME_OR_PASSWORD);
                done();
            });
    });

    it('login failed - no password field', function(done) {
        request(app)
            .post('/api/login')
            .send({username : 'test'})
            .expect('Content-Type', /json/)
            .expect(200)
            .end(function (err, res) {
                res.body.should.have.property('id');
                res.body.should.have.property('timestamp');
                res.body.should.have.property('hash');
                res.body.should.have.property('data');
                res.body.id.should.equal('test');
                res.body.data.result.should.equal(constants.ERROR_INVALID_USERNAME_OR_PASSWORD);
                done();
            });
    });

    it('login failed - no username field', function(done) {
        request(app)
            .post('/api/login')
            .send({password : 'test'})
            .expect('Content-Type', /json/)
            .expect(200)
            .end(function (err, res) {
                res.body.should.not.have.property('id');
                res.body.should.have.property('timestamp');
                res.body.should.have.property('hash');
                res.body.should.have.property('data');
                res.body.data.result.should.equal(constants.ERROR_INVALID_USERNAME_OR_PASSWORD);
                done();
            });
    });

    //login with encryption
    it('login successful - encrypted', function(done) {
        console.log("enabling encryption and hash checking");
        constants.ENCRYPT_DATA = true;
        constants.ENABLE_HASHING_CHECKS = true;

        console.log('Creating dummy username before login test');
        var client = new Client();
        client.name = "test";
        client.password = "test";
        client.bills = [];
        client.email = "placeholder@placeholder.placeholder";
        client.devices = [];

        client.save(function(err) {
            should(err).equal(null);
            console.log("username created");

            request(app)
                .post('/api/login')
                .send( crypto.encryptData('test', '/api/login',  {username : 'test', password: 'test'}))
                .expect('Content-Type', /json/)
                .expect(200)
                .end(function (err, res) {
                    res.body.should.have.property('id');
                    res.body.should.have.property('timestamp');
                    res.body.should.have.property('hash');
                    res.body.should.have.property('data');

                    res.body.id.should.equal('test');

                    var decryptedData = crypto.decryptAndVerify('/api/login', res.body);
                    should(decryptedData.result).equal(true);
                    should(decryptedData.data.result).equal(constants.RESULT_OK);
                    constants.ENCRYPT_DATA = false;
                    constants.ENABLE_HASHING_CHECKS = false;
                    done();
                });
        });
    });
});
