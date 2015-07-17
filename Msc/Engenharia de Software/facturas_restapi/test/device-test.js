var request = require("supertest");
var express = require('express');
var should = require('should');
var constants = require('./../framework/constants');
var assert = require("assert")
var mongoose = require('mongoose');

var app = require('../server.js');

//console.log("boooop devices start\n");

process.env.NODE_ENV = 'test';

var Client = require('../models/client');
//var Bill = require('../models/bill');
//var Device = require('../models/device');
var DeviceSchema = require('../models/device');
var Device = mongoose.model('Device', DeviceSchema);



describe('Device', function()
{
	var testClientID = "55562f380ff80dc722157849";
	
	/* --------------------------- setup ----------------------------- */
	
    beforeEach(function(done)
    {
        var device = new Device();

        device.client_object_id = testClientID;
        device.type = "android";
        device.details = "this is merely a dummy device...";
        
        device.save();
        done();
    });
    
    afterEach(function(done){
        Device.remove({client_object_id:testClientID});
        done();
    });
    
    
    
    /* --------------------------- actual tests ----------------------------- */
    
    //FILTER (list + filter)
    //test if get returns all attributes
    describe('GET /api/devices/filter', function(){
        it('tests filtering devices', function(){
            request(app)
                .get('/api/devices/filter?client_object_id=' + testClientID)
                .expect('Content-Type', /json/)
                .end(function(err, res){
                    res.body.forEach(function (item) {
                        item.should.have.property('details');
                        item.should.have.property('type');
                        item.should.have.property('client_object_id');                        
                    });
                });

        });
    });
    
    //ADD
    //test adding new device
    describe('POST /api/devices/add', function(){

		var type = "android";
		var details = "these are the details!";
		//console.log("add device test");
        it('tests adding a device', function(done){
            request(app)
                .post('/api/devices/add')
                .send({
				  client_object_id: testClientID,
				  type: type,
				  details: details
				})
                .expect('Content-Type', /json/)
                .end(function (err, res) {
	                console.log(res.body);
                    res.body.should.have.property("result", constants.RESULT_OK);                
                    done();
                });

        });
    });
    
    //test new device with invalid type
    describe('POST /api/devices/add', function(){

		var type = "12345";
		var details = "these are the details!";

        it('should fail when adding a device with invalid type', function(done){
            request(app)
                .post('/api/devices/add')
                .send({
				  client_object_id: testClientID,
				  type: type,
				  details: details
				})
                .expect('Content-Type', /json/)
                .end(function (err, res) {
                    res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                    done();
                });

        });
    });
    
    //test new device with invalid details
    /*describe('POST /api/devices/add', function(){

		var type = "android";
		var details = "£¥§";

        it('Add Device Defect Details Test', function(done){
            request(app)
                .post('/api/devices/add')
                .send({
				  client_object_id: testClientID,
				  type: type,
				  details: details
				})
                .expect('Content-Type', /json/)
                .end(function (err, res) {
                    res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                    done();
                });

        });
    });*/
    
    //test new device with insufficient data
    describe('POST /api/devices/add', function(){

		var type = "";
		var details = "";

        it('should fail as the device has insufficient data', function(done){
            request(app)
                .post('/api/devices/add')
                .send({
				  client_object_id: testClientID,
				  type: type,
				  details: details
				})
                .expect('Content-Type', /json/)
                .end(function (err, res) {
                    res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
                    done();
                });

        });
    });
    
    //EDIT
    //device edited successfully
    describe('POST /api/devices/edit', function (){

        var type = "android";
		var details = "these are the details!";

		it('edits info about a device', function(done){
			Device.findOne({client_object_id:testClientID}, function(err, device){
				if(!err)
				{				
					request(app)
					    .post('/api/devices/edit')
					    .send({
						  client_object_id: testClientID,
						  _id: device._id,
						  type: type,
						  details: details
						})
					    .expect('Content-Type', /json/)
					    .end(function (err, res) {
					        res.body.should.have.property("result", constants.RESULT_OK);
					        done();
					    });				
				}
				else{console.log(err);}
			});
		});
    });
    
    //device edit attempt with invalid id
    describe('POST /api/devices/edit', function (){

        var type = "android";
		var details = "these are the details!";

		it('should fail as the id is invalid', function(done){
			Device.findOne({client_object_id:testClientID}, function(err, device){
				if(!err)
				{				
					request(app)
					    .post('/api/devices/edit')
					    .send({
						  client_object_id: testClientID,
						  _id: "123_abc",
						  type: type,
						  details: details
						})
					    .expect('Content-Type', /json/)
					    .end(function (err, res) {
					        res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
					        done();
					    });				
				}
				//else{console.log(err);}
			});
		});
    });
    
       
    //device edit attempt with invalid client_object_id
    describe('POST /api/devices/edit', function (){

        var type = "android";
		var details = "these are the details!";

		it('should succeed even if client_object_id is invalid', function(done){
			Device.findOne({client_object_id:testClientID}, function(err, device){
				if(!err)
				{				
					request(app)
					    .post('/api/devices/edit')
					    .send({
						  client_object_id: "abc def",
						  _id: device._id,
						  type: type,
						  details: details
						})
					    .expect('Content-Type', /json/)
					    .end(function (err, res) {
					        res.body.should.have.property("result", constants.RESULT_OK);
					        done();
					    });				
				}
				//else{console.log(err);}
			});
		});
    });
    
    //device edit attempt with invalid type
    describe('POST /api/devices/edit', function (){

        var type = 123;
		var details = "these are the details!";

		it('should succeed even if type is invalid', function(done){
			Device.findOne({client_object_id:testClientID}, function(err, device){
				if(!err)
				{				
					request(app)
					    .post('/api/devices/edit')
					    .send({
						  client_object_id: testClientID,
						  _id: device._id,
						  type: type,
						  details: details
						})
					    .expect('Content-Type', /json/)
					    .end(function (err, res) {
					        res.body.should.have.property("result", constants.RESULT_OK);
					        done();
					    });				
				}
				//else{console.log(err);}
			});
		});
    });
    
    //DELETE
    //device deleted successfully
    describe('POST /api/devices/delete', function (){

		it('tests deleting a device', function(done){
			Device.findOne({client_object_id:testClientID}, function(err, device){
				if(!err)
				{
				
						request(app)
						    .post('/api/devices/delete')
						    .send({
							  _id: device._id
							})
						    .expect('Content-Type', /json/)
						    .end(function (err, res) {
						        res.body.should.have.property("result", constants.RESULT_OK);
						        done();
						    });

				}
				//else{console.log(err);}
			});
		});		
    });
    
    //device deletion attempt with invalid id
    describe('POST /api/devices/delete', function (){

		it('should fail when attempting to delete a device with invalid ID', function(done){
			Device.findOne({client_object_id:testClientID}, function(err, device){
				if(!err)
				{
					request(app)
					    .post('/api/devices/delete')
					    .send({
						  _id: "abc_123"
						})
					    .expect('Content-Type', /json/)
					    .end(function (err, res) {
					        res.body.should.have.property("result", constants.ERROR_INVALID_REQUEST);
					        done();
					    });

				}
				//else{console.log(err);}
			});
		});		
    });
});
