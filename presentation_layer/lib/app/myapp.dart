import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // const MyApp({super.key}); //default constructor

  MyApp._internal(); // private constructor

  static final MyApp instance =
      MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance;

  int appState = 0;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
