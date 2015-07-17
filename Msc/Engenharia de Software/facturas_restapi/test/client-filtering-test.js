var request = require("supertest");
var express = require('express');
var should = require('should');
var constants = require('./../framework/constants');

var app = require('../server.js');

process.env.NODE_ENV = 'test';

var Client = require('../models/client');

describe('Clients filtering', function() {

	var test_client_object_id = "";
	var test_search_name = "neo";
	var test_search_mail = "neo.boss@thematrix.com";

	before(function() {
		var client = new Client();
		client.name = "neo";
		client.password = "insidethematrix";
		client.email = "neo.boss@thematrix.com";
		client.devices = [];
		client.save();
		test_client_object_id = client._id;
	});

	after(function(done) {
		Client.find({}).remove().exec(done());
	});

	//
	//	SUCESS TESTS - valid user searches
	//
	it('Client Filtering - valid search with NAME and EMAIL', function() {
		request(app)
			.post('/api/clients/filter')
			.send({
				name: test_search_name,
				email: test_search_mail
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.forEach(function(item) {
					item.should.have.property('_id');
					item.should.have.property('name',test_search_name);
					item.should.have.property('email',[test_search_mail]);
				});
			});
	});

	it('Client Filtering - valid search with NAME ONLY', function() {
		request(app)
			.post('/api/clients/filter')
			.send({
				name: test_search_name
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.forEach(function(item) {
					item.should.have.property('_id');
					item.should.have.property('name',test_search_name);
				});
			});
	});

	it('Client Filtering - valid search with EMAIL ONLY', function() {
		request(app)
			.post('/api/clients/filter')
			.send({
				email: test_search_mail
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.forEach(function(item) {
					item.should.have.property('_id');
					item.should.have.property('email',[test_search_mail]);
				});
			});
	});

	//
	//	WRONG TESTS - checking for error messages
	//
	it('Client Filtering - incorrect NAME', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				name: "morpheus"
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.have.property('result', constants.ERROR_USER_NOT_FOUND);
				done();
			});
	});

	it('Client Filtering - malformed EMAIL', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				email: 'aaaa'
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.have.property('result', constants.ERROR_INVALID_EMAIL);
				done();
			});
	});

	it('Client Filtering - unknown EMAIL', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				email: 'a@a.aa'
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.have.property('result', constants.ERROR_USER_NOT_FOUND);
				done();
			});
	});

	it('Client Filtering - EMPTY fields', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				email: '',
				name: ''
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.have.property('result', constants.ERROR_INSUFFICIENT_DATA);
				done();
			});
	});

	it('Client Filtering - correct NAME and incorrect EMAIL', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				email: 'aaa',
				name: 'neo'
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.have.property('result', constants.ERROR_INVALID_EMAIL);
				done();
			});
	});

	it('Client Filtering - incorrect NAME and correct EMAIL', function(done) {
		request(app)
			.post('/api/clients/filter')
			.send({
				email: 'neo.boss@thematrix.com',
				name: 'morpheus'
			})
			.expect('Content-type', /json/)
			.end(function(err, res) {
				res.body.should.have.property('result', constants.ERROR_USER_NOT_FOUND);
				done();
			});
	});
});