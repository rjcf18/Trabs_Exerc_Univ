//load the packages
var mongoose = require('mongoose');

//create the schema
var BillSchema = new mongoose.Schema({
	//id: Number, needs to be sequential or something
    client_object_id: String,
    image: String,
	limit_date: Date,
    type: String,
    amount: Number,
	ref: Number,
    entity:Number
});

//export the model
module.exports = mongoose.model('Bill', BillSchema);


