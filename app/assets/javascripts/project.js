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
    });

    this.previous_coordinates = _.map(args.previous_coordinates, function(lat_lng) {
      return L.latLng(lat_lng[0], lat_lng[1]);
    });

    var polyline = L.polyline(this.previous_coordinates, { color: this.color });
    this.marker = marker;
    this.polyline = polyline;

    var layer = L.featureGroup([marker, polyline]).addTo(map)

    this.createPulse = function() {
      setInterval(function() {
        $.ajax({
          url: "/equipment/"+self.uuid+".json",
          success: function(equipmentData) {
            if (equipmentData.current_location != null) {
              var coordinates = equipmentData.current_location.coordinates;
              self.marker.setLatLng(L.latLng(coordinates[0], coordinates[1]));
              self.polyline.addLatLng(L.latLng(coordinates[0], coordinates[1]));
            }
          }
        })
      }, 1000)
    };

    this.hide = function() {
      layer.removeLayer(marker);
      layer.removeLayer(polyline);
    }

    this.show = function() {
      layer.addLayer(marker);
      layer.addLayer(polyline);
    }

    this.zoom = function() {
      map.setView(marker.getLatLng(), 14);
    }

    this.createPulse();
  };

  window.EquipmentRegistry = {};

  window.EquipmentRegistry.registry = {};

  window.EquipmentRegistry.add = function(equipment) {
    this.registry[equipment.uuid] = equipment;
  }

  $.ajax({
    url: "/equipment.json",
    success: function(data) {
      for (var i = 0; i < data.length; i++) {
        var equip = new Equipment({
          uuid: data[i].id.$oid,
          previous_coordinates: data[i].previous_coordinates
        })
        EquipmentRegistry.add(equip)
      }
    }
  });

  // Checkbox
  $( "input[data-uuid]" ).change(function() {
    var $this = $(this);
    var uuid = $this.data("uuid");

    if ($this.is(':checked')) {
      EquipmentRegistry.registry[uuid].show();
    } else {
      EquipmentRegistry.registry[uuid].hide();
    }
  });

  // Link
  $( ".equip-name a" ).click(function() {
    var $this = $(this);
    var uuid = $this.data("uuid");
    var checkbox = $( "input[data-uuid="+uuid+"]" )

    if (checkbox.is(':checked')) {
      EquipmentRegistry.registry[uuid].zoom();
    }
  });
  
});
