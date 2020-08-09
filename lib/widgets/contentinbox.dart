import 'package:flutter/material.dart';
import 'package:wardlabs/widgets/deviceinformationfornewdevices.dart';
import 'package:wardlabs/widgets/deviceinformationforpaireddevices.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../screens/subscreensofmainscreen/addnewboxes.dart';

class contentInBox extends StatefulWidget {
  BluetoothDevice device;
  int index;
  List<BluetoothService> _services = [];
  contentInBox(this.device, this.index);
  @override
  createState() {
    return contentInBoxState();
  }
}

class contentInBoxState extends State<contentInBox> {
  void TransitionToDeviceDetail(ctx) {
    if (widget.index == 0) {
      Navigator.of(ctx).pushNamed(deviceInformationforpaireddevices.routeName,
          arguments: {
            'selecteddevice': widget.device,
            'services': widget._services
          });
    }
    if (widget.index == 1) {
      Navigator.of(ctx)
          .pushNamed(deviceInformationfornewdevices.routeName, arguments: {
        'selecteddevice': widget.device,
      });
    }
  }

  Future<void> get func async {
    await flutterBlue.stopScan();
    try {
      await widget.device.connect();
    } catch (e) {
      if (e.code != 'already_connected') {
        throw e;
      }
    } finally {
      widget._services = await widget.device.discoverServices();
    }
  }

  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          await func;
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
