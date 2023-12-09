import 'package:flutter/material.dart';
import 'package:green_burgas_explorer/map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GreenBurgas Explorer'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: MapWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
