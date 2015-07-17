var request = require("supertest");
var express = require('express');
var should = require('should');
var constants = require('./../framework/constants');

var app = require('../server.js');

process.env.NODE_ENV = 'test';

var Client = require('../models/client');
var Bill = require('../models/bill');

describe('Bills Filtering', function() {

	var test_client_object_id = "";
	var test_bill_1_id = "";
	var test_bill_2_id = "";


	before(function(done) {
		var client = new Client();

		client.name = "neo";
		client.password = "insidethematrix";
		client.email = "neo.boss@thematrix.com";
		client.devices = [];
		client.save();

		test_client_object_id = client._id;

		var bill1 = new Bill();

		test_bill_1_id = bill1._id;
		bill1.client_object_id = test_client_object_id;
		bill1.image = "bill1.jpg";
		bill1.limit_date = "7/31/2015";
		bill1.type = "Gas";
		bill1.amount = "55";
		bill1.ref = "999999999";
		bill1.entity = "12345";
		bill1.save();

		var bill2 = new Bill();

		test_bill_2_id = bill2._id;
		bill2.client_object_id = test_client_object_id;
		bill2.image = "bill2.jpg";
		bill2.limit_date = "3/12/2015";
		bill2.type = "Electricity";
		bill2.amount = "299";
		bill2.ref = "111111111";
		bill2.entity = "32659";
		bill2.save();
		done();
	});

	after(function(done) {
		Bill.find({}).remove().exec(done());
		Client.find({}).remove().exec(done());
	});

	//	SUCESS TESTS - valid bill filtering
	//
	it('valid PRICE RANGE', function(done) {
		request(app)
			.post('/api/bills/filter')
			.send({
				client_object_id: test_client_object_id,
				lower_amount: "1",
				higher_amount: "1000"
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.not.have.property('result');
				res.body.forEach(function(item) {
					item.should.have.property('client_object_id');
					item.should.have.property('amount');
				});
				done();
			});
	});

	it('valid LIMIT DATE', function(done) {
		request(app)
			.post('/api/bills/filter')
			.send({
				client_object_id: test_client_object_id,
				date_1: "2015-1-1",
				date_2: "2016-1-1"
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.not.have.property('result');
				res.body.forEach(function(item) {
					item.should.have.property('client_object_id');
					item.should.have.property('amount');
				});
				done();
			});
	});

	it('valid TYPE', function(done) {
		request(app)
			.post('/api/bills/filter')
			.send({
				client_object_id: test_client_object_id,
				type: "Gas"
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.not.have.property('result');
				res.body.forEach(function(item) {
					item.should.have.property('client_object_id');
					item.should.have.property('type', 'Gas');
					item.should.have.property('_id')
				});
				done();
			});
	});

	//
	//	DEFECT TESTS - checking for error messages
	//
	it('empty result set', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				client_object_id: test_client_object_id,
				date_1: "2000-1-1",
				date_2: "2001-1-1"
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				/*res.body.should.have.property('result');
				res.body.should.be.equal([]);*/
				res.body.should.have.property('result', constants.ERROR_INSUFFICIENT_DATA);
				done();
			});
	});

	it('empty/incomplete fields', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				client_object_id: test_client_object_id,
				lower_amount: "1",
				higher_amount: ""
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.have.property('result', constants.ERROR_INSUFFICIENT_DATA);
				done();
			});
	});

	it('malformed DATE range', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				client_object_id: test_client_object_id,
				date_1: "123-2015",
				date_2: "2016",
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				/*res.body.should.have.property('result', constants.ERROR_INVALID_REQUEST);*/
				res.body.should.have.property('result', constants.ERROR_INSUFFICIENT_DATA);
				done();
			});
	});

	it('malformed PRICE range', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				client_object_id: test_client_object_id,
				lower_amount: "1001",
				higher_amount: "0"
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.have.property('result', constants.ERROR_INSUFFICIENT_DATA);
				/*res.body.should.have.property('result', constants.ERROR_INVALID_PRICE_RANGE);*/
				done();
			});
	});

	it('unknown TYPE', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				client_object_id: test_client_object_id,
				type: "Water"
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				/*res.body.should.have.property('result', constants.ERROR_NO_RESULTS_FOUND);*/
				res.body.should.have.property('result', constants.ERROR_INSUFFICIENT_DATA);
				done();
			});
	});
});
