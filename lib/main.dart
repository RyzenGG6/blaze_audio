import 'package:blaze_audio/home.dart';
import 'package:blaze_audio/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:ThemeData(
        primaryColor: Colors.blue,

        useMaterial3: true
      ),
      routes: {
        'main':(context)=>  mainscreen(),
        'home':(context)=> home(),
      },



      home: home(),
    );
  }

}
