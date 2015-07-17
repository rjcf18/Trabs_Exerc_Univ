window.onload = function() {

  // Display the restaurant items.
  restaurantDB.open();
  
  
  // Get references to the form elements.
  var newRestaurantForm = document.getElementById('new-restaurant-form');
  var newRestaurantName = document.getElementById('new-restaurant-name');
  var newRestaurantType = document.getElementById('new-restaurant-type');
  var newRestaurantPrice = document.getElementById('new-restaurant-price');

  var restaurantSearchNameForm = document.getElementById('restaurant-search-form-name');
  var restaurantSearchTypeForm = document.getElementById('restaurant-search-form-type');
  var restaurantSearchPriceForm = document.getElementById('restaurant-search-form-price');
  var restaurantSearchName = document.getElementById('restaurant-search-name');
  var restaurantSearchType = document.getElementById('restaurant-search-type');
  var restaurantSearchMaxPrice = document.getElementById('restaurant-search-maxprice');
  var restaurantSearchMinPrice = document.getElementById('restaurant-search-minprice');

  // Handle new restaurant item form submissions.
  newRestaurantForm.onsubmit = function() {
    // Get the restaurant fields' values.
    var RName = newRestaurantName.value;
    var RType = newRestaurantType.value;
    var RPrice = newRestaurantPrice.value;

    // Check to make sure the text is not blank (or just spaces).
    if (RName.replace(/ /g,'') != '' && RType.replace(/ /g,'') != '') {
      // Create the restaurant item.
      restaurantDB.createRestaurant(RName, RType, RPrice);
    }
    
    // Reset the input field.
    newRestaurantName.value = '';
    newRestaurantType.value = '';
    newRestaurantPrice.value = '';

    // Don't send the form.
    return false;
  };

  // TODO -> acabar a pesquisa
  //handle restaurant search by name
  restaurantSearchNameForm.onsubmit = function() {
    // Get the restaurant search values.
    var RName = restaurantSearchName.value;
    refreshRestaurantsByName(RName);

    // Don't send the form.
    return false;
  };

  //handle restaurant search by type
  restaurantSearchTypeForm.onsubmit = function() {
    // Get the restaurant search values.
    var RType = restaurantSearchType.value;
    refreshRestaurantsByType(RType);

    // Don't send the form.
    return false;
  };

  //handle restaurant search by price range
  restaurantSearchPriceForm.onsubmit = function() {
    // Get the restaurant search values.

    var RMaxp = restaurantSearchMaxPrice.value;
    var RMinp = restaurantSearchMinPrice.value;

    refreshRestaurantsByPrice(RMaxp, RMinp);

    // Don't send the form.
    return false;
  };

};

function refreshRestaurantsByName(rName){
  restaurantDB.fetchRestaurantsByName(rName, function(restaurants) {
    //populates the table body
    var tableBody, row, cell;
    tableBody = document.getElementById('table_body');
    tableBody.innerHTML = '';

    for(var i = 0; i < restaurants.length; i++) {
      // Read the restaurant items backwards (most recent first).
      var restaurant = restaurants[(restaurants.length - 1 - i)];


      var cell = document.createElement("tr");

      var row = document.createElement("td");

      var div = document.createElement("div");
      div.className = "squaredThree";

      var checkbox = document.createElement('input');
      checkbox.type = "checkbox";
      checkbox.value = "None";
      checkbox.id = "squaredThree"+i;
      checkbox.name = "check";
      checkbox.className = "restaurant-checkbox";
      checkbox.setAttribute("data-id", restaurant.timestamp);


      var label = document.createElement("label");
      label.setAttribute("for", "squaredThree"+i);

      div.appendChild(checkbox);
      div.appendChild(label);

      row.appendChild(div);

      cell.appendChild(row);

      for (var atribute in restaurant){
        var row = document.createElement("td");
        row.className = "text-center";
        row.innerHTML = restaurant[atribute];

        cell.appendChild(row);
      }

      tableBody.appendChild(cell);

      // Setup an event listener for the checkbox.
      checkbox.addEventListener('click', function(e) {
        var id = parseInt(e.target.getAttribute('data-id'));

        restaurantDB.deleteRestaurant(id, refreshRestaurants);
      });
    }
  });
}

function refreshRestaurantsByType(rType){
  restaurantDB.fetchRestaurantsByType(rType, function(restaurants) {
    //populates the table body
    var tableBody, row, cell;
    tableBody = document.getElementById('table_body');
    tableBody.innerHTML = '';

    for(var i = 0; i < restaurants.length; i++) {
      // Read the restaurant items backwards (most recent first).
      var restaurant = restaurants[(restaurants.length - 1 - i)];


      var cell = document.createElement("tr");

      var row = document.createElement("td");

      var div = document.createElement("div");
      div.className = "squaredThree";

      var checkbox = document.createElement('input');
      checkbox.type = "checkbox";
      checkbox.value = "None";
      checkbox.id = "squaredThree"+i;
      checkbox.name = "check";
      checkbox.className = "restaurant-checkbox";
      checkbox.setAttribute("data-id", restaurant.timestamp);


      var label = document.createElement("label");
      label.setAttribute("for", "squaredThree"+i);

      div.appendChild(checkbox);
      div.appendChild(label);

      row.appendChild(div);

      cell.appendChild(row);

      for (var atribute in restaurant){
        var row = document.createElement("td");
        row.className = "text-center";
        row.innerHTML = restaurant[atribute];

        cell.appendChild(row);
      }

      tableBody.appendChild(cell);

      // Setup an event listener for the checkbox.
      checkbox.addEventListener('click', function(e) {
        var id = parseInt(e.target.getAttribute('data-id'));

        restaurantDB.deleteRestaurant(id, refreshRestaurants);
      });
    }
  });
}

function refreshRestaurantsByPrice(priceMax, priceMin){
  restaurantDB.fetchRestaurantsByPriceRange(priceMax, priceMin, function(restaurants) {
    //populates the table body
    var tableBody, row, cell;
    tableBody = document.getElementById('table_body');
    tableBody.innerHTML = '';

    for(var i = 0; i < restaurants.length; i++) {
      // Read the restaurant items backwards (most recent first).
      var restaurant = restaurants[(restaurants.length - 1 - i)];


      var cell = document.createElement("tr");

      var row = document.createElement("td");

      var div = document.createElement("div");
      div.className = "squaredThree";

      var checkbox = document.createElement('input');
      checkbox.type = "checkbox";
      checkbox.value = "None";
      checkbox.id = "squaredThree"+i;
      checkbox.name = "check";
      checkbox.className = "restaurant-checkbox";
      checkbox.setAttribute("data-id", restaurant.timestamp);


      var label = document.createElement("label");
      label.setAttribute("for", "squaredThree"+i);

      div.appendChild(checkbox);
      div.appendChild(label);

      row.appendChild(div);

      cell.appendChild(row);

      for (var atribute in restaurant){
        var row = document.createElement("td");
        row.className = "text-center";
        row.innerHTML = restaurant[atribute];

        cell.appendChild(row);
      }

      tableBody.appendChild(cell);

      // Setup an event listener for the checkbox.
      checkbox.addEventListener('click', function(e) {
        var id = parseInt(e.target.getAttribute('data-id'));

        restaurantDB.deleteRestaurant(id, refreshRestaurants);
      });
    }
  });
}


// Update the list of restaurant items.
function refreshRestaurants() {
  restaurantDB.fetchRestaurants(function(restaurants) {
    //populates the table body
    var tableBody, row, cell;
    tableBody = document.getElementById('table_body');
    tableBody.innerHTML = '';

    for(var i = 0; i < restaurants.length; i++) {
      // Read the restaurant items backwards (most recent first).
      var restaurant = restaurants[(restaurants.length - 1 - i)];


      var cell = document.createElement("tr");

      var row = document.createElement("td");

      var div = document.createElement("div");
      div.className = "squaredThree";

      var checkbox = document.createElement('input');
      checkbox.type = "checkbox";
      checkbox.value = "None";
      checkbox.id = "squaredThree"+i;
      checkbox.name = "check";
      checkbox.className = "restaurant-checkbox";
      checkbox.setAttribute("data-id", restaurant.timestamp);


      var label = document.createElement("label");
      label.setAttribute("for", "squaredThree"+i);

      div.appendChild(checkbox);
      div.appendChild(label);

      row.appendChild(div);

      cell.appendChild(row);

      for (var atribute in restaurant){
          var row = document.createElement("td");
          row.className = "text-center";
          row.innerHTML = restaurant[atribute];

          cell.appendChild(row);
      }

      tableBody.appendChild(cell);

        // Setup an event listener for the checkbox.
        checkbox.addEventListener('click', function(e) {
            var id = parseInt(e.target.getAttribute('data-id'));

            restaurantDB.deleteRestaurant(id, refreshRestaurants);
        });
    }

  });
}



