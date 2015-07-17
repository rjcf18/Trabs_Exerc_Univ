/**
 * Created by marcussantos on 21/04/15.
 */

//load the packages
var mongoose = require('mongoose');
var BillSchema = require('../models/bill');
var DeviceSchema = require('../models/device'); // verificar depois os devices
var Device = mongoose.model('Device', DeviceSchema);

var ClientSchema = mongoose.Schema({
    name:String,
    email:[String],
    //devices:[DeviceSchema],
    password:String
});

/*ClientSchema.methods.addDevice = function addDevice(type)
{
	var device = new Device();
	device.type = type;
	this.devices.push(device);
	this.save();
	return "Device successfully added!";
};*/

module.exports = mongoose.model('Client', ClientSchema);
