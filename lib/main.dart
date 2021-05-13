import 'package:andi_taxi/ui/sign_up.dart';
import 'package:andi_taxi/ui/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Map<int, Color> colorCodes = {
    50: Color.fromRGBO(198, 144, 46, .1),
    100: Color.fromRGBO(198, 144, 46, .2),
    200: Color.fromRGBO(198, 144, 46, .3),
    300: Color.fromRGBO(198, 144, 46, .4),
    400: Color.fromRGBO(198, 144, 46, .5),
    500: Color.fromRGBO(198, 144, 46, .6),
    600: Color.fromRGBO(198, 144, 46, .7),
    700: Color.fromRGBO(198, 144, 46, .8),
    800: Color.fromRGBO(198, 144, 46, .9),
    900: Color.fromRGBO(198, 144, 46, 1),
  };

  
  @override
  Widget build(BuildContext context) {
    MaterialColor color = new MaterialColor(0xFFC6902E, colorCodes);

    return MaterialApp(
      title: 'An Di Taxi',
      debugShowCheckedModeBanner: false,
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
        primaryColor: Color(0xFFC6902E),
        accentColor: Color(0xFF97ADB6),
        primarySwatch: color
      ),
      home: Welcome()
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
