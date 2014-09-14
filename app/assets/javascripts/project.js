$(document).ready(function() {
  "use strict";
  L.mapbox.accessToken = mapbox_token;
  var map = L.mapbox.map('map', 'examples.map-h67hf2ic')
    .setView([47.6794895, -122.2637558], 14);

  var transformed_map_data = _.map(map_data, function(coordinates) {
    return L.latLng(coordinates[0], coordinates[1]);
  });

  function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }

  var Equipment = function(args) {
    var self = this;
    this.uuid = args.uuid;
    this.color = getRandomColor();
    
    var marker = L.marker([map_data[0][0], map_data[0][1]], {
      icon: L.mapbox.marker.icon({
        'marker-color': this.color,
        'marker-symbol': 'bus'
      })
    }).addTo(map);

    this.previous_coordinates = _.map(args.previous_coordinates, function(lat_lng) {
      return L.latLng(lat_lng[0], lat_lng[1]);
    });

    var polyline = L.polyline(this.previous_coordinates, { color: this.color }).addTo(map);
    this.marker = marker;
    this.polyline = polyline;

    this.createPulse = function() {
      setInterval(function() {
        $.ajax({
          url: "/equipment/"+self.uuid+".json",
          success: function(equipmentData) {
            var coordinates = equipmentData.current_location.coordinates;
            self.marker.setLatLng(L.latLng(coordinates[0], coordinates[1]));
            self.polyline.addLatLng(L.latLng(coordinates[0], coordinates[1]));
          }
        })
      }, 1000)
    };

    this.createPulse();
  };

  $.ajax({
    url: "/equipment.json",
    success: function(data) {
      for (var i = 0; i < data.length; i++) {
        new Equipment({
          uuid: data[i].id.$oid,
          previous_coordinates: data[i].previous_coordinates
        })
      }
    }
  });

  
  $( ".checkbox" ).click(function() {
    var $this = $(this);
    var uuid = $this.children().attr("data-uuid");
    alert( $this.children().attr("data-uuid") + "Handler for .click() called." );
  });
});
