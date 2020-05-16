import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/googlemap.dart';
import './screens/health.dart';
import './screens/learning.dart';
import './screens/newspage.dart';
import './screens/store_locator.dart';
import './screens/fitness.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unite4Corona',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.red,
      ),
      routes: <String,WidgetBuilder>{
         '/Home': (BuildContext context) => new GoogleMapWidget(),
         '/News': (BuildContext context) => new News(),
         '/Store_Locator': (BuildContext context) => new StoreLocator(),
         '/Health': (BuildContext context) => new Health(),
         '/Learning': (BuildContext context) => new Learning(),
      },
      home: new GoogleMapWidget(), //home page displayed
      
    );
  }
}


