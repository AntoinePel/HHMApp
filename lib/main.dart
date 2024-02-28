import 'package:flutter/material.dart';
import 'views/mapPage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.yellow,
    ),
    home: MapPage(),
  ));
}