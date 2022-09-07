import 'package:flutter/material.dart';
import 'package:orvba/home_screen.dart';
import 'package:orvba/login_page.dart';
import './splash_screen.dart';


void main() => runApp(new MaterialApp(
  theme:
  ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
  debugShowCheckedModeBanner: false,
  home: HomeScreen(),
));