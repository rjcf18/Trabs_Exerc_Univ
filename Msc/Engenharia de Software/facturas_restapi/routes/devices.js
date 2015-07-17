var express = require('express');
var mongoose = require('mongoose');
var validator = require('validator');
var bodyParser = require('body-parser');
var constants = require('../framework/constants');

//var router = express.Router();

var Client = require('../models/client');
var DeviceSchema = require('../models/device');
var Device = mongoose.model('Device', DeviceSchema);

module.exports = function (app) 
{
	app.get('/api/devices/filter', function (req, res) 
	{
		var clientIDIsValid = validator.isHexadecimal(req.query.client_object_id);
        var typeIsValid = validator.isAlpha(req.query.type);
		
		if (clientIDIsValid & typeIsValid)
		{
			Device.find({client_object_id:req.query.client_object_id, type:req.query.type}, function(err, devices)
			{
				if(!err)
				{
					res.send(devices);
				}
				else
				{
					console.log(err);
					res.send({
						result: constants.ERROR_INVALID_REQUEST
					});
					//res.send(err);
				}
			});	
		}		
		else if (clientIDIsValid)
		{
			Device.find({client_object_id:req.query.client_object_id}, function(err, devices)
			{
				if(!err)
				{
					res.send(devices);
                    //devices: devices
            	}
				else
				{
					console.log(err);
					res.send({
						result: constants.ERROR_INVALID_REQUEST
					});
					//res.send(err);
				}
			});
		}	
		
		else
		{
			res.send({
		        result: constants.ERROR_INVALID_REQUEST
		    });
		}	
	});

	app.post('/api/devices/add', function(req, res)
	{
		var device = new Device();
			
		var clientIDIsValid = validator.isHexadecimal(req.request.client_object_id);
        var typeIsValid = validator.isAlpha(req.request.type);
        var detailsAreValid = validator.isAscii(req.request.details);
        
        if (clientIDIsValid & typeIsValid & detailsAreValid)
		{
			device.client_object_id = req.request.client_object_id;
	        device.type = req.request.type;
	        device.details = req.request.details;
	        
			device.save(function(err) {
    	        if (!err) 
    	        {
	                //console.log("Device saved!!");
	                res.send({
	                    result: constants.RESULT_OK
	                });	                
	            } 
	            else 
	            {
	                //console.log(err);
	                res.send({
	                    result: constants.ERROR_INVALID_REQUEST
	                });
            	}
            });
		}
		else if (clientIDIsValid & typeIsValid)
		{
			device.client_object_id = req.request.client_object_id;
	        device.type = req.request.type;
	        
			device.save(function(err) {
    	        if (!err) 
    	        {
	                //console.log("Device saved!!");
	                res.send({
	                    result: constants.RESULT_OK
	                });	                
	            } 
	            else 
	            {
	            	//console.log(err);
	                res.send({
	                    result: constants.ERROR_INVALID_REQUEST
	                });
	                
            	}
            });
		}
		else
		{
			res.send({
		        result: constants.ERROR_INVALID_REQUEST
		    });
		}
	});

	
	app.post('/api/devices/delete', function(req, res)
	{
		var idIsValid = validator.isHexadecimal(req.request._id);
		
		if (idIsValid)
		{
			Device.remove({_id:req.request._id}, function(err, item)
			{
                if (!err)
                {
                    //console.log("Device deleted.");
                    res.send({
                        result: constants.RESULT_OK
                	});
                }
                else 
                {
                	res.send({
						result: constants.ERROR_INVALID_REQUEST
					});
                    //res.send(err);
                }
			});	
		}
		else
		{
			res.send({
		        result: constants.ERROR_INVALID_REQUEST
		    });
		}		
	});
	
	app.post('/api/devices/edit', function(req, res)
	{
		var clientIDisValid = validator.isHexadecimal(req.request.client_object_id);
		var idIsValid = validator.isHexadecimal(req.request._id);
        var typeIsValid = validator.isAlpha(req.request.type);
        var detailsAreValid = validator.isAscii(req.request.details);
		
		if(idIsValid & detailsAreValid) //details are changed
		{
			Device.update({_id:req.request._id},
			{
				$set: 
				{
					details: req.request.details
				}
			});	
		}
		
		if (idIsValid & typeIsValid & clientIDisValid) //associated client and type are changed
		{
			Device.update({_id:req.request._id},
			{
				$set: 
				{
					type: req.request.type,
					client_object_id: req.request.client_object_id
				}
			}, 
			function(err, item)
			{
                if (!err)
                {					
                    res.send({
                        result: constants.RESULT_OK
                	});
                }
                else 
                {
                	res.send({
	                    result: constants.ERROR_INVALID_REQUEST
	                });
                    //res.send(err);
                }
			});	
		}
		else if(idIsValid & typeIsValid) //only type is changed
		{
			Device.update({_id:req.request._id},
			{
				$set: 
				{
					type: req.request.type
				}
			}, 
			function(err, item)
			{
                if (!err)
                {					
                    res.send({
                        result: constants.RESULT_OK
                	});
                }
                else 
                {
                	res.send({
	                    result: constants.ERROR_INVALID_REQUEST
	                });
                    //res.send(err);
                }
			});	
		}
		else if(idIsValid & clientIDisValid) //only client is changed
		{
			Device.update({_id:req.request._id},
			{
				$set: 
				{
					client_object_id: req.request.client_object_id
				}
			}, 
			function(err, item)
			{
                if (!err)
                {					
                    res.send({
                        result: constants.RESULT_OK
                	});
                }
                else 
                {
                	res.send({
	                    result: constants.ERROR_INVALID_REQUEST
	                });
                    //res.send(err);
                }
			});	
		}
		else
		{
			res.send({
		        result: constants.ERROR_INVALID_REQUEST
		    });
		}		
	});
};
