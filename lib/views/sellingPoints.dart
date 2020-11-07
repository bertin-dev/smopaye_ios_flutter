import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smopaye_mobile/views/sellingPointsDetails.dart';


class SellingPoints extends StatefulWidget {
  @override
  _SellingPointsState createState() => _SellingPointsState();
}


class _SellingPointsState extends  State<SellingPoints> {

  List<Marker> allMarkers = [];
  GoogleMapController _controller;

  double latitudeCurrent = 0.0;
  double longitudeCurrent = 0.0;

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  String myConvert(double latitudeCurrent, double longitudeCurrent, double lat, double lng){
    double resultat = calculateDistance(latitudeCurrent, longitudeCurrent, lat, lng);
    if(resultat < 1){
      return "${resultat.toStringAsFixed(2)} m";
    } else{
      return "${resultat.toStringAsFixed(2)} Km";
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    //position courante de l'utilisateur
    setState(() {
      getCurrentLocation();
    });
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
    ));


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
    ));


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

    ));

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

    ));

  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.orange,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(child: Text("CENTRE", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),),
          ),
        ),

        ListTile(
          dense: true,
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute( builder: (context) => new SellingPointsDetails(
            town: "YAOUNDE",
            address: "Retrouvez nos commerciaux à CAMAIR ou rendez vous dans nos locaux",
            time: "Lundi-Vendredi: de 08h00 à 17h",
          ))),
          title: Text("YAOUNDE", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("CAMAIR", style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
              Text(myConvert(latitudeCurrent, longitudeCurrent, 3.8654263, 11.5205789), style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
        ),

        Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),

        ListTile(
          dense: true,
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute( builder: (context) => new SellingPointsDetails(
            town: "YAOUNDE",
            address: "Retrouvez nos commerciaux à OMNISPORT ou rendez vous dans nos locaux",
            time: "Lundi-Vendredi: de 08h00 à 17h",
          ))),
          title: Text("YAOUNDE", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("OMNISPORT", style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
              Text(myConvert(latitudeCurrent, longitudeCurrent, 3.8906481, 11.544921), style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
        ),

        Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),

        ListTile(
          dense: true,
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute( builder: (context) => new SellingPointsDetails(
            town: "YAOUNDE",
            address: "Retrouvez nos commerciaux à SOA ou rendez vous dans nos locaux",
            time: "Lundi-Vendredi: de 08h00 à 17h",
          ))),
          title: Text("SOA", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Entré Campus", style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
              Text(myConvert(latitudeCurrent, longitudeCurrent, 3.9660964, 11.5935347), style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
        ),

        Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),


        ListTile(
          dense: true,
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute( builder: (context) => new SellingPointsDetails(
            town: "YAOUNDE",
            address: "Retrouvez nos commerciaux à SOA ou rendez vous dans nos locaux",
            time: "Lundi-Vendredi: de 08h00 à 17h",
          ))),
          title: Text("SOA", style: TextStyle(color: Color(0xff039BE5), fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Marché Soa", style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
              Text(myConvert(latitudeCurrent, longitudeCurrent, 3.9756296, 11.5935448), style: TextStyle(color: Color(0xff039BE5), fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff039BE5),),
        ),

        Divider(color: Color(0xff039BE5), thickness: 2, height: 0,),

        Stack(
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
                  CameraPosition(target: LatLng(3.8654263, 11.5205789), zoom: 11.0),
                  markers: Set.from(allMarkers),
                  onMapCreated: mapCreated,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
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
                alignment: Alignment.topCenter,
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

      ],
    );
  }


  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  zoomCurrentPosition() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(latitudeCurrent, longitudeCurrent), zoom: 15.0, bearing: 45.0, tilt: 45.0),
    ));
    print(latitudeCurrent);
    print(longitudeCurrent);
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
      latitudeCurrent = geoposition.latitude;
      longitudeCurrent = geoposition.longitude;
    });
  }
}