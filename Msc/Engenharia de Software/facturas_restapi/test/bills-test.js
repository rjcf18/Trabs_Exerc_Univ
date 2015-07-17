/**
 * Created by marcussantos on 30/05/15.
 */

var request = require("supertest");
var express = require('express');
var should = require('should');
var app = require('../server.js');

var Bill = require('../models/bill'); // basic data model
var constants = require('./../framework/constants');



describe('bills', function (){

    var dummyBillId = "";

    beforeEach(function(done){

        constants.ENCRYPT_DATA = false;
        constants.ENABLE_HASHING_CHECKS = false;

        var bill = new Bill();

        bill.client_object_id = "55562f380ff80dc722157849";
        bill.image = "test.jpg";
        bill.limit_date = "6/31/2015";
        bill.type = "Gas";
        bill.amount = "100";
        bill.ref = "1";
        bill.entity = "1";

        bill.save(function(err){
            if (!err) {
                console.log("Dummy Bill saved!!");
            }
            else {
                console.log("Error saving dummy bill");
            }
            dummyBillId = bill._id;
            done();
        });


    });

    afterEach(function(done){

        Bill.remove({client_object_id:"55562f380ff80dc722157849"}, function (err) {
            if (!err) {
                console.log("Dummy data deleted!");
            }
            else {
                console.log("Error deleting dummy data!");
            }
            done();
        });
    });

    /**
     * Test if the returned bill contains all the fields
     */
    describe('GET /api/bills/get', function(){

        it('Bill JSON Test', function(){
            request(app)
                .get('/api/bills/get?client_object_id=55562f380ff80dc722157849')
                .expect('Content-Type', /json/)
                .end(function(err, res){
                    res.body.forEach(function (item) {
                        item.should.have.property('client_object_id');
                        item.should.have.property('image');
                        item.should.have.property('limit_date');
                        item.should.have.property('type');
                        item.should.have.property('amount');
                        item.should.have.property('ref');
                        item.should.have.property('entity');
                    });
                });

        });
    });

    /**
     * Test if the bill is edited sucessfuly
     */
    describe('POST /api/bills/edit', function (){

        var new_entity = "2";
        var new_ref = "2";
        var new_amount = "200";
        var new_limit_date = "7/1/2015";
        var new_image = "test2.jpg";

        it('Edit successfully test', function(done){

            request(app)
                .post('/api/bills/edit')
                .send({client_object_id:"55562f380ff80dc722157849",
                    _id:dummyBillId, new_entity:new_entity,
                    new_ref:new_ref, new_amount:new_amount,
                    new_limit_date:new_limit_date,
                    new_image:new_image
                })
                .expect('Content-Type', /json/)
                .end(function (err, res) {
                    res.body.should.have.property("result", constants.RESULT_OK);
                    done();
                });
        });

    });

    /**
     * Test if the new bill is inserted sucessfuly
     */
    describe('POST /api/bills/post', function(){

        var entity = "3";
        var ref = "3";
        var amount = "300";
        var limit_date = "7/1/2015";
        var image = "";
        var type = "Gas";

        it('Insert new Bill test', function(done){

            request(app)
                .post('/api/bills/post')
                .send({
                    client_object_id:"55562f380ff80dc722157849",
                    type:type, entity:entity,
                    ref:ref, amount:amount,
                    limit_date:limit_date,
                    image:image
                })
                .expect('Content-Type', /json/)
                .end(function (err, res) {
                    res.body.should.have.property("result", constants.RESULT_OK);
                    done();
                });
        });
    });

    /**
     * Defect test - insert a new Bill with an invalid amount
     */
    describe('POST /api/bills/post', function(){

        var entity = "3";
        var ref = "3";
        var amount = "xpto";
        var limit_date = "7/1/2015";
        var image = "";
        var type = "Gas";
        //console.log("Defect test - insert a new Bill with an invalid amount");

        it('invalid amount test (DEFECT TEST)', function(done){
            request(app)
                .post('/api/bills/post')
                .send({
                    client_object_id:"55562f380ff80dc722157849",
                    type:type,
                    entity:entity,
                    ref:ref, amount:amount,
                    limit_date:limit_date,
                    image:image
                })
                .expect('Content-Type', /json/)
                .end(function (err, res) {
                    res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                    done();
                });
        });
    });

    /**
     * Defect test - insert a new Bill with an invalid reference
     */
    describe('POST /api/bills/post', function(){
        var entity = "3";
        var ref = "abcd";
        var amount = "200";
        var limit_date = "7/1/2015";
        var image = "";
        var type = "Gas";
        console.log("Defect test - insert a new Bill with an invalid amount");
        it('invalid reference test', function(done){

            request(app)
                .post('/api/bills/post')
                .send({
                    client_object_id:"55562f380ff80dc722157849",
                    type:type,
                    entity:entity,
                    ref:ref, amount:amount,
                    limit_date:limit_date,
                    image:image
                })
                .expect('Content-Type', /json/)
                .end(function (err, res) {
                    res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                    done();
                });
        });
    });

    /**
     * Defect test - insert a new Bill with an invalid entity
     */
    describe('POST /api/bills/post', function(){
        var entity = "xpto";
        var ref = "3";
        var amount = "200";
        var limit_date = "7/1/2015";
        var image = "";
        var type = "Gas";
        console.log("Defect test - insert a new Bill with an invalid amount");
        it('invalid entity test', function(done){

            request(app)
                .post('/api/bills/post')
                .send({
                    client_object_id:"55562f380ff80dc722157849",
                    type:type,
                    entity:entity,
                    ref:ref, amount:amount,
                    limit_date:limit_date,
                    image:image
                })
                .expect('Content-Type', /json/)
                .end(function (err, res) {
                    res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                    done();
                });
        });
    });

    /**
     * Defect test - insert a new Bill with an invalid date
     */
    describe('POST /api/bills/post', function(){
        var entity = "3";
        var ref = "3";
        var amount = "200";
        var limit_date = "xpto";
        var image = "";
        var type = "Gas";
        console.log("Defect test - insert a new Bill with an invalid amount");
        it('invalid date test', function(done){

            request(app)
                .post('/api/bills/post')
                .send({
                    client_object_id:"55562f380ff80dc722157849",
                    type:type,
                    entity:entity,
                    ref:ref, amount:amount,
                    limit_date:limit_date,
                    image:image
                })
                .expect('Content-Type', /json/)
                .end(function (err, res) {
                    res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                    done();
                });
        });
    });

    /**
     * Defect test - insert without the minimum data
     */
    describe('POST /api/bills/post', function(){
        var entity = "3";
        var ref = "3";
        var amount = "200";
        var limit_date = "";
        var image = "";
        var type = "Gas";
        console.log("Defect test - insert new bill without the minimum data");
        it('invalid date test', function(done){

            request(app)
                .post('/api/bills/post')
                .send({
                    client_object_id:"55562f380ff80dc722157849",
                    type:type,
                    entity:entity,
                    ref:ref, amount:amount,
                    limit_date:limit_date,
                    image:image
                })
                .expect('Content-Type', /json/)
                .end(function (err, res) {
                    res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                    done();
                });
        });
    });

});

