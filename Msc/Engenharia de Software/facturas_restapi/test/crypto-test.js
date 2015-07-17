var request = require('supertest');
var express = require('express');
var should = require('should');
var constants = require('./../framework/constants');
var crypto = require('./../framework/crypto');

process.env.NODE_ENV = 'test';

var app = require('../server.js');

//tests
describe('Authentication', function(){

    var dummyEncryptedData = { id: 'test',
        timestamp: 1432944458090,
        hash: 'a4d553637ee733a3f80b6c2fde8f84955c1e90f28853d76ff773720b3c606cf0',
        data:
        { ct: 'ghXV/Bq0ps3z7TmxFA2TmQVdt7wExfQoR3W2bqQ7aFg=',
            iv: 'd3c9b5e806688cd0ae177e506046178d',
            s: '9a94d50ea0b0b138' }
    };

    before(function(done) {
        constants.ENCRYPT_DATA = true;
        constants.ENABLE_HASHING_CHECKS = true;
        done();
    });

    it('Authentication - hash checking ', function(done){
        var password = "password-test";
        var expected_hash = "e604ad393025becd397ff04cd449b9ea20e56c7b38f66d6501f1690e00d76e19";
        var hash = crypto.toSHA256(password);
        should(hash).equal(expected_hash);
        done();
    });

    it('Authentication - hash checking fail ', function(done){
        var password = "password-test";
        var expected_hash = "e604ad393025becd397ff04cd449b9ea20e56c7b38f66d6501f1690e00d76e20";
        var hash = crypto.toSHA256(password);
        should(hash).not.equal(expected_hash);
        done();
    });

    it('Authentication - Encrypt -> Decrypt message ', function(done){
        var message = "this is a crypt test :=)";
        var encrypted = crypto.encryptAES(message);
        var decrypted = crypto.decryptAES(encrypted);

        should(decrypted).equal(message);
        done();
    });

    it('Authentication - Data encrypt -> decrypt -> verify ', function(done){
        var method = "/api/register";
        var username = "test";
        var data = { password: "deadbeef"};


        var encryptedData = crypto.encryptData(username, method, data);
        //verify format
        should(encryptedData).have.property('id');
        should(encryptedData).have.property('timestamp');
        should(encryptedData).have.property('hash');
        should(encryptedData).have.property('data');

        should(encryptedData.id).equal(username);

        //attempt to decrypt and verify
        var decryptedData = crypto.decryptAndVerify(method, encryptedData);
        should(decryptedData).have.property('result');
        should(decryptedData).have.property('data');
        should(decryptedData).have.property('data').have.property('password');
        should(decryptedData).property('data').property('password').equal(data.password);
        done();
    });

    //authentication defect tests
    it("Authentication - decrypt empty structure", function(done) {
        var method = "/api/register";
        var data = { };
        var result = crypto.decryptAndVerify(method, data);
        should(result).property('result').equal(false);
        done();
    });

    it("Authentication - decrypt undefined structure", function(done) {
        var method = "/api/register";
        var data = undefined;
        var result = crypto.decryptAndVerify(method, data);
        should(result).property('result').equal(false);
        done();
    });

    //TIMESTAMP TESTS
    it("Authentication - decrypt no timestamp", function(done) {
        var method = "/api/register";
        var data = { id: 'test',
            hash: 'a4d553637ee733a3f80b6c2fde8f84955c1e90f28853d76ff773720b3c606cf0',
            data:
            { ct: 'ghXV/Bq0ps3z7TmxFA2TmQVdt7wExfQoR3W2bqQ7aFg=',
                iv: 'd3c9b5e806688cd0ae177e506046178d',
                s: '9a94d50ea0b0b138' }
        };
        var result = crypto.decryptAndVerify(method, data);
        should(result).property('result').equal(false);
        done();
    });

    it("Authentication - decrypt timestamp null", function(done) {
        var method = "/api/register";
        var data = { id: 'test',
            hash: 'a4d553637ee733a3f80b6c2fde8f84955c1e90f28853d76ff773720b3c606cf0',
            timestamp: null,
            data:
            { ct: 'ghXV/Bq0ps3z7TmxFA2TmQVdt7wExfQoR3W2bqQ7aFg=',
                iv: 'd3c9b5e806688cd0ae177e506046178d',
                s: '9a94d50ea0b0b138' }
        };
        var result = crypto.decryptAndVerify(method, data);
        should(result).property('result').equal(false);
        done();
    });

    it("Authentication - decrypt timestamp negative", function(done) {
        var method = "/api/register";
        var data = { id: 'test',
            hash: 'a4d553637ee733a3f80b6c2fde8f84955c1e90f28853d76ff773720b3c606cf0',
            timestamp: -99999,
            data:
            { ct: 'ghXV/Bq0ps3z7TmxFA2TmQVdt7wExfQoR3W2bqQ7aFg=',
                iv: 'd3c9b5e806688cd0ae177e506046178d',
                s: '9a94d50ea0b0b138' }
        };
        var result = crypto.decryptAndVerify(method, data);
        should(result).property('result').equal(false);
        done();
    });

    //HASH TESTS
    it("Authentication - decrypt no hash", function(done) {
        var method = "/api/register";
        var data = { id: 'test',
            timestamp: 1432944458090,
            data:
            { ct: 'ghXV/Bq0ps3z7TmxFA2TmQVdt7wExfQoR3W2bqQ7aFg=',
                iv: 'd3c9b5e806688cd0ae177e506046178d',
                s: '9a94d50ea0b0b138' }
        };
        var result = crypto.decryptAndVerify(method, data);
        should(result).property('result').equal(false);
        done();
    });

    it("Authentication - decrypt hash null", function(done) {
        var method = "/api/register";
        var data = { id: 'test',
            hash: null,
            timestamp: 1432944458090,
            data:
            { ct: 'ghXV/Bq0ps3z7TmxFA2TmQVdt7wExfQoR3W2bqQ7aFg=',
                iv: 'd3c9b5e806688cd0ae177e506046178d',
                s: '9a94d50ea0b0b138' }
        };
        var result = crypto.decryptAndVerify(method, data);
        should(result).property('result').equal(false);
        done();
    });

    //DATA TESTS
    it("Authentication - decrypt data null", function(done) {
        var method = "/api/register";
        var data = { id: 'test',
            hash: 'a4d553637ee733a3f80b6c2fde8f84955c1e90f28853d76ff773720b3c606cf0',
            timestamp: 1432944458090,
            data: null
        };
        var result = crypto.decryptAndVerify(method, data);
        should(result).property('result').equal(false);
        done();
    });

    it("Authentication - decrypt data structure corruption", function(done) {
        var method = "/api/register";
        var data = { id: 'test',
            hash: 'a4d553637ee733a3f80b6c2fde8f84955c1e90f28853d76ff773720b3c606cf0',
            timestamp: 1432944458090,
            data: "widjwodjpwjf"
        };
        var result = crypto.decryptAndVerify(method, data);
        should(result).property('result').equal(false);
        done();
    });

    it("Authentication - decrypt data invalid AES", function(done) {
        var method = "/api/register";
        var data = { id: 'test',
            hash: 'a4d553637ee733a3f80b6c2fde8f84955c1e90f28853d76ff773720b3c606cf0',
            timestamp: 1432944458090,
            data: { ct: 'ghXV/Bq0ps3z7TmxFA2TmQVdt7wExfQoR3W2bqQ7aFg=',
                s: '9a94d50ea0b0b138' }
        };
        var result = crypto.decryptAndVerify(method, data);
        should(result).property('result').equal(false);
        done();
    });
});

