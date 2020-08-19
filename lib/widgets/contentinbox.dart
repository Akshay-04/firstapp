import 'package:flutter/material.dart';
import 'package:wardlabs/widgets/deviceinformationfornewdevices.dart';
import 'package:wardlabs/widgets/deviceinformationforpaireddevices.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../screens/subscreensofmainscreen/addnewboxes.dart';
import 'dart:math';
import '../screens/designofcard/carddesign.dart';

class contentInBox extends StatefulWidget {
  BluetoothDevice device;
  int index;
  bool waiting = false;
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
    Random random = new Random();
    bool loading = false;
    Map<String, Object> select =
        listofcontainers[random.nextInt(listofcontainers.length)];
    if (loading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else  
    return InkWell(
        onTap: () async {
          await func;
          TransitionToDeviceDetail(context);
        },
        child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.5,
            child: card(
              primary: select['primary'],
              chipColor: select['chipColor'],
              widths: MediaQuery.of(context).size.width * .5,
              backWidget: select['backWidget'],
              chipText1: widget.device.name,
              chipText2: "online",
            )));
  }
}
