

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class Home extends StatefulWidget{
  final Key _mapKey = UniqueKey();
  @override
  State<StatefulWidget> createState() => _HomeState();
      
}
 
    
class _HomeState extends State<Home> {

  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setMarkerIcon();
  }
  
  void _setMarkerIcon() async {
     _markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(),'asserts/cIcon.png');
  } 

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
    setState((){
      _markers.add(Marker(
        markerId: MarkerId("0"),
        position: LatLng(12.9716,77.5946),
        infoWindow: InfoWindow(
          title: "Covid cases",
          snippet: "Total: 23, Death=2, recovered =20",          
        ),
      icon: BitmapDescriptor.defaultMarker,
      ),
      );
    }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(           
      appBar: AppBar(
         title:Text('Home'),
      ),   
      body: Stack(
        children: <Widget>[
          Container (
            height: 350,
            width: double.infinity,
          child :GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(12.9716,77.5946 ),
              zoom: 12,           
            
           ),
            
          ),
      ),
          Align (
            alignment: FractionalOffset.bottomCenter,
            //heightFactor: 100,
            //widthFactor: double.infinity,
            child:ClipRRect(
            borderRadius: BorderRadius.circular(12),
            
            child: Container (
              height: 150,
              width: 300,
              //color: Colors.black,
              decoration: BoxDecoration(color: Colors.white),
              
              child:Card(
                  //shape: RoundedRectangleBorder(	
                  //borderRadius: BorderRadius.circular(15.0),
	
                  //),
                  
                  child: Column(
                    children: <Widget>[
                      
                      ListTile(
                        leading: Icon(Icons.healing,size:10),
                        trailing: Text('Total Cases -23'),
                       

                      ),
                      ListTile(
                        leading: Icon(Icons.healing,size:10),
                        title: Text(' Death Cases'),
                        subtitle: Text('#5'),
                      ),
                    ],
                  ),
            ),
            ),
            

          ),
          ),

        ],
      ),
    );
  }
  
}
