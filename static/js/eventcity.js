var EventCity = {
    map: null,
    marker: null,

    getPosition: function() {
        if(navigator.geoLocation == false) {
            EventCity.noGeoSupport();
            return;
        }

        var loader = $(".map-container .loader");
        loader.show();
        $(".map-container .fail").hide();

        var watchPositionId = navigator.geolocation.watchPosition(function(position) {
            console.log("position:", position);
            var point = [position.coords.latitude, position.coords.longitude];
            EventCity.initMap();
            EventCity.map.setView(point, 15);
            EventCity.addMarker(point);

            var reverseUrl = "/location/" + position.coords.latitude + "/" + position.coords.longitude;

            $.get(reverseUrl, function(response) {
                console.log("response:", response);
                console.log(response);
                if (response) {
                    var eventpoint = [response.location.lat, response.location.lng];
                    console.log(eventpoint);
                    EventCity.addMarker(eventpoint);
                } else {
                    EventCity.failMessage("Error! Couldn't add events to the map");
                }
            }).fail(function() {
                EventCity.failMessage("Fail!!");
            });
        }, function() {
            EventCity.failMessage("You have to allow the website to know your location");
        });
    },

    onLocationFound: function(e) {
        var radius = e.accuracy / 2;

        L.marker(e.latlng).addTo(map)
            .bindPopup("You are within " + radius + " meters from this point").openPopup();

        L.circle(e.latlng, radius).addTo(map);
    },

    initMap: function() {
        $("map").show();

        if (!this.map) {
            var map = L.map('map', {zoomControl:true});
            L.tileLayer('http://{s}.tile.cloudmade.com/33f1c74149b04476931958e293559044/997/256/{z}/{x}/{y}.png', {attribution: ''}).addTo(map);
            map.attributionControl.setPrefix('');
            //map.locate({setView: true, maxZoom: 16});
            this.map = map;
        }
        return this.map;
    },

    addMarker: function(point) {
        this.marker = L.marker(point).addTo(this.map);
    },

    noGeoSupport: function() {
        console.log("Your browser doesn't support geo coding.");
    },

    failMessage: function(message) {
        $(".map-container .loader").hide();
        $(".map-container .fail").show();
        $("#map").hide();
        $(".position-info").html("<p>" + message + "</p>");
    }
}
