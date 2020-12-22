import 'package:flutter/material.dart';
import 'package:image_viewer/image_viewer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ImageViewer example app'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              ImageViewer.showImageSlider(
                images: ['http://192.168.43.56:8090/'],
                startingPosition: 1,
              );
            },
            child: Text('Show slider'),
          ),
        ),
      ),
    );
  }
}
