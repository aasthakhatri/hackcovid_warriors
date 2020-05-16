import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hack_covid19/screens/fitness.dart';
import 'package:hack_covid19/screens/learning.dart';
import 'package:hack_covid19/screens/newspage.dart';
import 'package:hack_covid19/screens/store_locator.dart';
import 'package:hack_covid19/widgets/counter.dart';
import 'package:hack_covid19/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../my_flutter_app_icons.dart';


class GoogleMapWidget extends StatefulWidget {
  @override
  GoogleMapState createState() => GoogleMapState();   
  
}

class GoogleMapState extends State<GoogleMapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }
  
  void _setMapStyle(GoogleMapController controller) async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/coronaicon.jpg'),
        title: Text('Covid19 World Map'),
        //trailing:
      ),
      body: Stack(
        children: <Widget>[
          _buildTopRowContainer(),
          _buildGoogleMap(context),
          //SizedBox(width: 50.0,height: 100.0,),
          //_buildContainer(),
          _buildRowContainer(),
        ],
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Align(
      alignment: Alignment.center,
          child: Container(
          height: 300,
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(40.712776, -74.005974),
              zoom: 12,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _setMapStyle(controller);
            },
            zoomControlsEnabled: true,
            markers: {gramercyMarker, bernardinMarker, blueMarker},
          )),
    );
  }

  Widget _buildRowContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100,
        width: double.infinity,
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: kShadowColor,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Counter(
              color: kInfectedColor,
              number: 1046,
              title: "Infected",
            ),
            Counter(
              color: kDeathColor,
              number: 87,
              title: "Deaths",
            ),
            Counter(
              color: kRecovercolor,
              number: 46,
              title: "Recovered",
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTopRowContainer() {
     return Align(
       alignment: Alignment.topCenter,
            child: SizedBox(
    height: 50.0,
    child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
         // buildBarItem(CupertinoIcons.news,_newsFunction),
          buildBarItem(MyFlutterApp.newspaper,_newsFunction),
          buildBarItem(MyFlutterApp.online_education,_learningFunction),
          buildBarItem(CupertinoIcons.book_solid,_learningFunction),
          //buildBarItem(MdiIcons.heart,_fitnessFunction),          
          buildBarItem(Icons.store,_storeFunction),
          buildBarItem(MyFlutterApp.healthy,_fitnessFunction),
          
        ],
    ),
  ),
     );
  }
  void _newsFunction(){
           Navigator.of(context).pushNamed('/News');
  }
  void _learningFunction(){
           Navigator.of(context).pushNamed('/Learning');
  }
  void _fitnessFunction(){
           Navigator.of(context).pushNamed('/Health');
  }
  void _storeFunction(){
           Navigator.of(context).pushNamed('/Store_Locator');
  }
 
  Widget buildBarItem(IconData iconArgument, Function functionName) {
  return Container(
    width: 80.0,
    margin: EdgeInsets.all(4.0),
    color: Colors.white,
    child: IconButton(icon: Icon(iconArgument), onPressed:functionName    
     )
    //child: Icon(icon),
    
  );
}
Widget buildBarIconButton(Icons iconc) {
  return Container(
    width: 100.0,
    margin: EdgeInsets.all(4.0),
    color: Colors.white,
    child:  IconButton(
    icon: Icon(CupertinoIcons.news),
    onPressed: () {
      setState(() {
        //
      });
    },
  ),
  );
}

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.work),
//                  tooltip: "Admin",
                onPressed: () {
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (_) => AdminAuth()),
                  //);
                }),
            SizedBox(width: 10.0),
            IconButton(
                icon: Icon(Icons.fitness_center),
//                  tooltip: "Admin",
                onPressed: () {
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (_) => AdminAuth()),
                  //);
                }),
            IconButton(
                icon: Icon(Icons.store),
//                  tooltip: "Admin",
                onPressed: () {
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (_) => AdminAuth()),
                  //);
                }),
          ],
        ),
      ),
    );
  }

  Marker gramercyMarker = Marker(
    markerId: MarkerId('gramercy'),
    position: LatLng(40.738380, -73.988426),
    infoWindow: InfoWindow(title: 'Total:100, deaths:20, recovered:80'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );

  Marker bernardinMarker = Marker(
    markerId: MarkerId('bernardin'),
    position: LatLng(40.761421, -73.981667),
    infoWindow: InfoWindow(title: 'Total:100, deaths:20, recovered:80'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );
  Marker blueMarker = Marker(
    markerId: MarkerId('bluehill'),
    position: LatLng(40.732128, -73.999619),
    infoWindow: InfoWindow(title: 'Total:100, deaths:20, recovered:80', snippet:'Covid cases' ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );

  _newsfunction() {
  }
}
