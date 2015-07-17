var CryptoJS = require("crypto-js");
var constants = require('./constants');

module.exports = {

    /**
     * Crypto key to be used with AES
     */
    cryptKey : "IIEpQIBAAKCAQEA3U+R4ygDChkgYJAQfCbNhsOspKH/rjW317qPR5zwFrYwTAjt3B" +
    "e3Do6H3XHitEiqhA+HSugTPeyg2w7MWa68nLRCcnB4fgeS25F58KVKeZniYg9g",

    /**
     * Uses SHA256 to hash the specified message
     * Use this for passwords or other sensitive data
     * @param message
     * @returns {*|exports}
     */
    toSHA256 : function(message) {
        var hash = CryptoJS.SHA256(message);
        return hash.toString(CryptoJS.enc.Hex);
    },

    /**
     * AES JSON Formatter
     */
    AESToJSON : {
        stringify: function (cipherParams) {
            // create json object with ciphertext
            var jsonObj = {
                ct: cipherParams.ciphertext.toString(CryptoJS.enc.Base64)
            };

            // optionally add iv and salt
            if (cipherParams.iv) {
                jsonObj.iv = cipherParams.iv.toString();
            }
            if (cipherParams.salt) {
                jsonObj.s = cipherParams.salt.toString();
            }

            // stringify json object
            return JSON.stringify(jsonObj);
        },

        parse: function (jsonStr) {
            // parse json string
            var jsonObj = JSON.parse(jsonStr);

            // extract ciphertext from json object, and create cipher params object
            var cipherParams = CryptoJS.lib.CipherParams.create({
                ciphertext: CryptoJS.enc.Base64.parse(jsonObj.ct)
            });

            // optionally extract iv and salt
            if (jsonObj.iv) {
                cipherParams.iv = CryptoJS.enc.Hex.parse(jsonObj.iv)
            }
            if (jsonObj.s) {
                cipherParams.salt = CryptoJS.enc.Hex.parse(jsonObj.s)
            }

            return cipherParams;
        },

        toAESObject : function(jsonObj) {
            // extract ciphertext from json object, and create cipher params object
            var cipherParams = CryptoJS.lib.CipherParams.create({
                ciphertext: CryptoJS.enc.Base64.parse(jsonObj.ct)
            });

            // optionally extract iv and salt
            if (jsonObj.iv) {
                cipherParams.iv = CryptoJS.enc.Hex.parse(jsonObj.iv)
            }
            if (jsonObj.s) {
                cipherParams.salt = CryptoJS.enc.Hex.parse(jsonObj.s)
            }

            return cipherParams;
        }
    },

    /**
     * Encrypts a message using AES.
     * @param message
     * @returns {*}
     */
    encryptAES : function(message) {
        var encryptedMessage = CryptoJS.AES.encrypt(message, this.cryptKey);
        var step1 = this.AESToJSON.stringify((encryptedMessage));
        return JSON.parse(step1);
    },

    /**
     * Decrypts an AES message.
     * @param message
     * @returns {string}
     */
    decryptAES : function(message) {
        var encryptedMessage = this.AESToJSON.toAESObject(message);
        var decryptedMessage = CryptoJS.AES.decrypt(encryptedMessage, this.cryptKey);
        return decryptedMessage.toString(CryptoJS.enc.Utf8);
    },

    /**
     * Encrypts the data that is ready to be sent to the client
     * Every send/json call must call this function always.
     * @param id
     * @param method
     * @param passwordHas
     * @param data
     * @returns {{id: *, timestamp: number, hash: (*|exports), data: *}}
     */
    encryptData : function(id, method, data) {
        var timestamp = new Date().getTime();
        return {
            id: id,
            timestamp: timestamp,
            hash: this.toSHA256(id + timestamp + method + JSON.stringify(data)),
            data: constants.ENCRYPT_DATA ? this.encryptAES(JSON.stringify(data)) : data
        }
    },

    /**
     * Decrypts the given data and verifies the integrity
     * @param id
     * @param method
     * @param timestamp
     * @param hash
     * @param data
     * @returns {*}
     */
    decryptData : function(data) {
        return constants.ENCRYPT_DATA ?  JSON.parse(this.decryptAES(data)) : data;
    },

    /**
     * Verifies the data integrity
     * @param method
     * @param data
     * @returns {boolean}
     */
    decryptAndVerify : function(method, data) {
        if(constants.ENABLE_HASHING_CHECKS) {
            //check for non optional parameters
            if(!data || !data.id || !data.timestamp || !data.hash || !data.data || !data.data.ct || !data.data.iv || !data.data.s)
            {
                return { result: false };
            }

            //attempt to decrypt the data and verify it
            var decryptedData = this.decryptData(data.data);
            var calculatedHash = this.toSHA256(data.id + data.timestamp + method + JSON.stringify(decryptedData));
            return { result : calculatedHash === data.hash, data : decryptedData };
        }

        return { result: true, data:  constants.ENCRYPT_DATA ? this.decryptData(data.data) : (data.data ? data.data : data)};
    }
};
