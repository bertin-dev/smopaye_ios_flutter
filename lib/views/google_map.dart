import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smopaye_mobile/views/widgets/appBar.dart';

class MyGoogleMap extends StatefulWidget {
  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}


class _MyGoogleMapState extends  State<MyGoogleMap> {
  List<Marker> allMarkers = [];
  GoogleMapController _controller;

  double latitudeData = 0.0;
  double longitudeData = 0.0;


  @override
  void initState() {

    double calculateDistance(lat1, lon1, lat2, lon2){
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 - c((lat2 - lat1) * p)/2 +
          c(lat1 * p) * c(lat2 * p) *
              (1 - c((lon2 - lon1) * p))/2;
      return 12742 * asin(sqrt(a));
    }


    List<dynamic> data = [
      //camair
      {
        "lat": 3.8654263,
        "lng": 11.5205789
      },
      //omnisport
      {
        "lat": 3.8906481,
        "lng": 11.544921
      },
      //campus soa
      {
        "lat": 3.9660964,
        "lng": 11.5935347
      },
      //marché soa
      {
        "lat": 3.9756296,
        "lng": 11.5935448
      },
    ];
    double totalDistance = 0;
    for(var i = 0; i < data.length-1; i++){
      totalDistance += calculateDistance(data[i]["lat"], data[i]["lng"], data[i+1]["lat"], data[i+1]["lng"]);
    }
    print('-----------------------------------------------------${totalDistance}');



    // TODO: implement initState

    //position courante de l'utilisateur
    setState(() {
      getCurrentLocation();
    });

    super.initState();

    //current position
    /*allMarkers.add(Marker(
        markerId: MarkerId('current position'),
        draggable: true,
        onTap: () {
          print('current position');
        },
        position: LatLng(latitudeData, longitudeData),
        infoWindow: InfoWindow(
          title: '${latitudeData}',
          snippet: '${longitudeData}',
        ),
        icon: BitmapDescriptor.defaultMarker
    )
    );*/

    //Camair
    allMarkers.add(Marker(
        markerId: MarkerId('Camair'),
        draggable: true,
        onTap: () {
          print('Camair');
        },
        position: LatLng(3.8654263, 11.5205789),
        infoWindow: InfoWindow(
          title: 'Yaoundé',
          snippet: 'Camair',
        ),
        icon: BitmapDescriptor.defaultMarker
    )
    );


    ////Omnisport
    allMarkers.add(Marker(
        markerId: MarkerId('Omnisport'),
        draggable: true,
        onTap: () {
          print('Omnisport');
        },
        position: LatLng(3.8906481, 11.544921),

        infoWindow: InfoWindow(
          title: 'Yaoundé',
          snippet: 'Mobile Omnisport',
        ),
        icon: BitmapDescriptor.defaultMarker
    )
    );


    //Campus Soa
    allMarkers.add(Marker(
        markerId: MarkerId('Campus Soa'),
        draggable: true,
        onTap: () {
          print('Campus Soa');
        },
        position: LatLng(3.9660964, 11.5935347),

        infoWindow: InfoWindow(
          title: 'SOA',
          snippet: 'Campus de Soa',
        ),
        icon: BitmapDescriptor.defaultMarker

    )
    );

    //Marché Soa
    allMarkers.add(Marker(
        markerId: MarkerId('Marché Soa'),
        draggable: true,
        onTap: () {
          print('Marché Soa');
        },
        position: LatLng(3.9756296, 11.5935448),

            infoWindow: InfoWindow(
              title: 'SOA',
              snippet: 'Marché de Soa',
            ),
            icon: BitmapDescriptor.defaultMarker

        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "A proximité",),
      body: Stack(
          children: [
            Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              trafficEnabled: false,
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition:
              CameraPosition(target: LatLng(3.8654263, 11.5205789), zoom: 12.0),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            ),
          ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: zoomCurrentPosition,
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.green
                  ),
                  child: Icon(Icons.forward, color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: removeZoomCurrentPosition,
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red
                  ),
                  child: Icon(Icons.backspace, color: Colors.white),
                ),
              ),
            )
          ]
      ),
    );
  }




  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  zoomCurrentPosition() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(latitudeData, longitudeData), zoom: 15.0, bearing: 45.0, tilt: 45.0),
    ));
    print(latitudeData);
    print(longitudeData);
  }

  removeZoomCurrentPosition() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(3.8654263, 11.5205789), zoom: 12.0),
    ));
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitudeData = geoposition.latitude;
      longitudeData = geoposition.longitude;
    });
  }

}