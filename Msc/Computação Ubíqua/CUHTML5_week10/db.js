var restaurantDB = (function() {
  var rDB = {};
  var datastore = null;

  /**
   * Open a connection to the datastore.
   */
  rDB.open = function() {
    // Database version.
    var version = 1;

    // Open a connection to the datastore.
    var request = indexedDB.open('restaurants', version);

    // Handle datastore upgrades.
    request.onupgradeneeded = function(e) {
      var db = e.target.result;

      e.target.transaction.onerror = rDB.onerror;

      // Delete the old datastore.
      if (db.objectStoreNames.contains('restaurant')) {
        db.deleteObjectStore('restaurant');
      }

      // Create a new datastore.
      var store = db.createObjectStore('restaurant', {
        keyPath: 'timestamp'
      });

      store.createIndex("id", "timestamp", {unique: true});
      store.createIndex("nameidx", "Name", {unique: true});
      store.createIndex("typeidx", "FoodType", {unique: false});
      store.createIndex("priceidx", "AveragePrice", {unique: false});

    };

    // Handle successful datastore access.
    request.onsuccess = function(e) {
      // Get a reference to the DB.
      datastore = e.target.result;

      //execute the callback
      //callback();
    };

    // Handle errors when opening the datastore.
    request.onerror = rDB.onerror;
  };

  /**
   * Fetch restaurants by type
   */

  rDB.fetchRestaurantsByType = function (type,  callback) {
    var db = datastore;
    var transaction = db.transaction(['restaurant'], 'readwrite');
    var objStore = transaction.objectStore('restaurant');


    var keyRange = IDBKeyRange.only(type);
    //var cursorRequest = objStore.openCursor(keyRange);
    var nameindex = objStore.index("typeidx");
    var cursorRequest = nameindex.openCursor(keyRange);


    //var cursorRequest = objStore.openCursor(keyRange);

    var restaurants = [];


    transaction.oncomplete = function(e) {
      // Execute the callback function.
      callback(restaurants);
    };

    cursorRequest.onsuccess = function(e) {
      var result = e.target.result;

      if (!!result == false) {
        return;
      }

      restaurants.push(result.value);

      result.continue();
    };

    cursorRequest.onerror = rDB.onerror;
  };

  /**
   * Fetch restaurants by price range
   */

  rDB.fetchRestaurantsByPriceRange = function (priceMax, priceMin, callback) {
    var db = datastore;
    var transaction = db.transaction(['restaurant'], 'readwrite');
    var objStore = transaction.objectStore('restaurant');


    var index = objStore.index("priceidx");

    var cursorRequest = index.openCursor(IDBKeyRange.bound( priceMin, priceMax));


    var restaurants = [];


    transaction.oncomplete = function(e) {
      // Execute the callback function.
      callback(restaurants);
    };

    cursorRequest.onsuccess = function(e) {
      var result = e.target.result;

      if (!!result == false) {
        return;
      }

      restaurants.push(result.value);

      result.continue();
    };

    cursorRequest.onerror = rDB.onerror;
  };

  /**
   * Fetch restaurants by name
   */

  rDB.fetchRestaurantsByName = function (name,  callback) {
    var db = datastore;
    var transaction = db.transaction('restaurant');
    var objStore = transaction.objectStore('restaurant');


    var keyRange = IDBKeyRange.only(name);

    var nameindex = objStore.index("nameidx");

    var cursorRequest = nameindex.openCursor(keyRange);


    var restaurants = [];


    transaction.oncomplete = function(e) {
      // Execute the callback function.
      callback(restaurants);
    };



    cursorRequest.onsuccess = function(e) {
      var result = e.target.result;

      if (!!result == false) {
        return;
      }

      restaurants.push(result.value);

      result.continue();
    };

    cursorRequest.onerror = rDB.onerror;
  };

  /**
   * Fetch all of the restaurant items in the datastore.
   */
  rDB.fetchRestaurants = function(callback) {
    var db = datastore;
    var transaction = db.transaction(['restaurant'], 'readwrite');
    var objStore = transaction.objectStore('restaurant');

    //var keyRange = IDBKeyRange.lowerBound(0);
    var cursorRequest = objStore.openCursor();

    var restaurants = [];

    transaction.oncomplete = function(e) {
      // Execute the callback function.
      callback(restaurants);
    };

    cursorRequest.onsuccess = function(e) {
      var result = e.target.result;
      
      if (!!result == false) {
        return;
      }
      
      restaurants.push(result.value);

      result.continue();
    };

    cursorRequest.onerror = rDB.onerror;
  };


  /**
   * Create a new restaurant item.
   */
  rDB.createRestaurant = function(rName, rType,rPrice) {
    // Get a reference to the db.
    var db = datastore;

    // Initiate a new transaction.
    var transaction = db.transaction(['restaurant'], 'readwrite');

    // Get the datastore.
    var objStore = transaction.objectStore('restaurant');

    // Create a timestamp for the restaurant item.
    var timestamp = new Date().getTime();

    // Create an object for the restaurant item.
    var restaurant = {
      'Name': rName,
      'FoodType': rType,
      'AveragePrice': rPrice,
      'timestamp': timestamp
    };

    // Create the datastore request.
    var request = objStore.put(restaurant);

    // Handle a successful datastore put.
    request.onsuccess = function(e) {
      // Execute the callback function.

    };

    // Handle errors.
    request.onerror = rDB.onerror;
  };


  /**
   * Delete a restaurant item.
   */
  rDB.deleteRestaurant = function(id, callback) {
    var db = datastore;
    var transaction = db.transaction(['restaurant'], 'readwrite');
    var objStore = transaction.objectStore('restaurant');
    
    var request = objStore.delete(id);
    
    request.onsuccess = function(e) {
      callback();
    }
    
    request.onerror = function(e) {
      console.log(e);
    }
  };


  // Export the rDB object.
  return rDB;
}());
