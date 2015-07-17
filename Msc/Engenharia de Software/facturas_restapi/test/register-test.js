var request = require('supertest');
var express = require('express');
var should = require('should');
var constants = require('./../framework/constants');
var Client = require('./../models/client');
var crypto = require('./../framework/crypto');

process.env.NODE_ENV = 'test';

var app = require('../server.js');

//tests
describe('POST /api/register', function(){
    before(function(done) {
        constants.ENCRYPT_DATA = false;
        constants.ENABLE_HASHING_CHECKS = false;
        Client.find({}).remove().exec(done());
    });

    afterEach(function(done) {
        Client.find({}).remove().exec(done());
    });

    it('Register - Create user without errors - No Encryption or Hashing', function(done){
        request(app)
            .post('/api/register')
            .send({username : 'test', password: 'deadbeef-dead'})
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

    it('Register - Duplicated user', function(done){
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
                .post('/api/register')
                .send({username : 'test', password: 'deadbeef-dead'})
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
    });

    //defect tests
    it('Register - Empty Body', function(done){
        request(app)
            .post('/api/register')
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

    it('Register - null body', function(done){
        request(app)
            .post('/api/register')
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

    it('Register - missing username', function(done){
        request(app)
            .post('/api/register')
            .send({password: 'deadbeef-dead'})
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

    it('Register - missing password', function(done){
        request(app)
            .post('/api/register')
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

    it('Register - Create user - encrypted', function(done){
        constants.ENCRYPT_DATA = true;
        constants.ENABLE_HASHING_CHECKS = true;

        request(app)
            .post('/api/register')
            .send({username : 'test', password: 'test'})
            .expect('Content-Type', /json/)
            .expect(200)
            .end(function (err, res) {
                res.body.should.have.property('id');
                res.body.should.have.property('timestamp');
                res.body.should.have.property('hash');
                res.body.should.have.property('data');
                res.body.id.should.equal('test');

                var decryptedData = crypto.decryptAndVerify('/api/register', res.body);
                should(decryptedData.result).equal(true);
                should(decryptedData.data.result).equal(constants.RESULT_OK);
                constants.ENCRYPT_DATA = false;
                constants.ENABLE_HASHING_CHECKS = false;
                done();
            });
    });
});
