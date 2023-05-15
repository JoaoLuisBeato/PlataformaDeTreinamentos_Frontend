import 'package:flutter/material.dart';
import 'myhomepage.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "app",
      theme: ThemeData(primaryColor: Colors.white),
      home: MyHomePage(),
    );
  }
}

