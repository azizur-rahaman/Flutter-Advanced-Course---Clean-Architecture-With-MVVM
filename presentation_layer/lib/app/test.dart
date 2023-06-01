import 'package:flutter/material.dart';
import 'myapp.dart';

class TEst extends StatelessWidget {
  const TEst({super.key});

  void updateAppState() {
    MyApp.instance.appState = 2;
  }

  void getAppState() {
    debugPrint(MyApp.instance.appState.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
