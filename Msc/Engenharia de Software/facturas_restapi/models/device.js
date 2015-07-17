var mongoose = require('mongoose');

var DeviceSchema = mongoose.Schema({
    client_object_id: String,
    type:String,
    details:String
});

//module.exports = mongoose.model('Device', DeviceSchema);
module.exports = DeviceSchema;


