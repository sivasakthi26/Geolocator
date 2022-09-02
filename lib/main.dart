// import 'package:flutter/material.dart';
// import 'package:gpslocation/homescreen.dart';
//
// void main() {
//   runApp (MaterialApp(
//      home: HomeScreen()));
// }
//
import 'package:flutter/material.dart';
// import 'package:syncmaps/homecontent.dart';

import 'homescreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeContent(),
    );
  }
}