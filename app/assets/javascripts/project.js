$(document).ready(function() {
  "use strict";
  L.mapbox.accessToken = mapbox_token;

var map = L.mapbox.map('map', 'examples.map-h67hf2ic')
  .setView([47.6794895, -122.2637558], 14);

var transformed_map_data = _.map(map_data, function(coordinates) {
  return L.latLng(coordinates[0], coordinates[1]);
});

var marker = L.marker([map_data[0][0], map_data[0][1]], {
  icon: L.mapbox.marker.icon({
          'marker-color': '#f86767',
    'marker-symbol': 'bus'
        })
});


function drawRoute(index, routeData) {
  setTimeout(function() {
    //marker.setLatLng(routeData[index]);
    polyline.addLatLng(routeData[index]);

    index++;

    if(index < routeData.length - 1) {
      drawRoute(index, routeData);
    }
  }, 1000);
}

drawRoute(0, transformed_map_data);

//marker.addTo(map);

var marker2 = L.marker([map_data[0][0], map_data[0][1]], {
  icon: L.mapbox.marker.icon({
          'marker-color': '#f54143'
        })
});
marker2.addTo(map);

var polyline2 = L.polyline([], {color: 'blue'}).addTo(map);

function createPulse(data) {
  var id = data.id.$oid;
  setInterval(function() {
    $.ajax({
      url: "/equipment/"+id+".json",
      success: function(equipmentData) {
        var coordinates = equipmentData.current_location.coordinates
      marker2.setLatLng(L.latLng(coordinates[0], coordinates[1]));
    polyline2.addLatLng(L.latLng(coordinates[0], coordinates[1]));
      }
    })
  }, 1000);
};

$.ajax({
  url: "/equipment.json",
  success: function(data) {
    data.map(createPulse)
  }
});


});

