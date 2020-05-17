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
import 'package:hack_covid19/widgets/CasesData.dart';
import 'package:hack_covid19/widgets/indiaCases_rootnet.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  GoogleMapState createState() => GoogleMapState();
}

class GoogleMapState extends State<GoogleMapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  //Future<IndiaTotalCases> futureIndiaTotalCases;
  Future<IndiaCasesRootNet> futureIndiaTotalCases;

  @override
  void initState() {
    super.initState();
    futureIndiaTotalCases = fetchIndiaTotalCasesRootNet();    //fetchIndiaTotalCases();
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
          //_buildRowContainer(),
          buildBottomRowContainer(context),
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
              target: LatLng(20.5937, 78.9629),
              //target:LatLng(latlng[0],latlng[1]),
              zoom: 6,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              //_setMapStyle(controller);
            },
            zoomControlsEnabled: true,
            markers: {gramercyMarker, bernardinMarker, blueMarker},
          )),
    );
  }

  @override
  Widget buildBottomRowContainer(BuildContext context) {
    return FutureBuilder<IndiaCasesRootNet>(
      future: futureIndiaTotalCases,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildRowContainer(
             snapshot.data.data.unOffSummary[0].active,
             snapshot.data.data.unOffSummary[0].recovered,
             snapshot.data.data.unOffSummary[0].total,
            snapshot.data.data.unOffSummary[0].deaths);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildRowContainer(
      int activeCases, int recoveredCases, int totalCases, int deathCases) {
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
              number: activeCases,
              title: "Infected",
            ),
            Counter(
              color: kDeathColor,
              number: deathCases,
              title: "Deaths",
            ),
            Counter(
              color: kRecovercolor,
              number: recoveredCases,
              title: "Recovered",
            ),
            Counter(
              color: Colors.blueAccent,
              number: totalCases,
              title: "Total",
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
        height: 100.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            // buildBarItem(CupertinoIcons.news,_newsFunction),

            buildBarItem(MyFlutterApp.newspaper, _newsFunction, 'News'),
            buildBarItem(
                MyFlutterApp.online_education, _learningFunction, 'e-Learning'),
            //buildBarItem(CupertinoIcons.book_solid,_learningFunction),
            //buildBarItem(MdiIcons.heart,_fitnessFunction),
            buildBarItem(Icons.store, _storeFunction, 'Store Locator'),
            buildBarItem(
                MyFlutterApp.diet_1_, _fitnessFunction, 'Healthy Meals'),
          ],
        ),
      ),
    );
  }

  void _newsFunction() {
    Navigator.of(context).pushNamed('/News');
  }

  void _learningFunction() {
    Navigator.of(context).pushNamed('/Learning');
  }

  void _fitnessFunction() {
    Navigator.of(context).pushNamed('/Health');
  }

  void _storeFunction() {
    Navigator.of(context).pushNamed('/Store_Locator');
  }

  Widget buildBarItem(
      IconData iconArgument, Function functionName, String name) {
    return Container(
        width: 80.0,
        margin: EdgeInsets.all(4.0),
        color: Colors.white,
        child: Column(children: [
          IconButton(icon: Icon(iconArgument), onPressed: functionName),
          Text(
            name,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black45,
            ),
          ),
        ])
        //child: Icon(icon),

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
    infoWindow: InfoWindow(
        title: 'Total:100, deaths:20, recovered:80', snippet: 'Covid cases'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );
}
