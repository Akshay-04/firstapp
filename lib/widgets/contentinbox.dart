import 'package:flutter/material.dart';
import 'package:wardlabs/widgets/deviceinformation.dart';
import 'package:flutter_blue/flutter_blue.dart';

class contentInBox extends StatefulWidget {
  BluetoothDevice device;
  contentInBox(this.device);
  @override
  createState() {
    return contentInBoxState();
  }
}

class contentInBoxState extends State<contentInBox> {
  void TransitionToDeviceDetail(ctx) {
    Navigator.of(ctx).pushNamed(deviceInformation.routeName, arguments: {
      'selecteddevice':widget.device
    });
  }

  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          TransitionToDeviceDetail(context);
        },
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue.withOpacity(0.7), Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(children: <Widget>[
              Icon(Icons.add_box),
              Text(widget.device.name),
            ])));
  }
}
