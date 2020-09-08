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
  void TransitionToDeviceDetail(ctx,select) {
    if (widget.index == 0) {
      showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => Container(
    height: MediaQuery.of(context).size.height * 0.4,
    decoration: new BoxDecoration(
      color: Colors.white,
      borderRadius: new BorderRadius.only(
        topLeft: const Radius.circular(25.0),
        topRight: const Radius.circular(25.0),
      ),
    ),
    child: Center(
      child: deviceInformationforpaireddevices(widget.device, select),
    ),
  ),
);
    }

    if (widget.index == 1) {
      showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => Container(
    height: MediaQuery.of(context).size.height * 0.4,
    decoration: new BoxDecoration(
      color: Colors.white,
      borderRadius: new BorderRadius.only(
        topLeft: const Radius.circular(25.0),
        topRight: const Radius.circular(25.0),
      ),
    ),
    child: Center(
      child:  deviceInformationfornewdevices(widget.device,select),
    ),
  ),
);

    }
  }

  Widget build(BuildContext context) {
    Random random = new Random();
    Map<String, Object> select =
        listofcontainers[random.nextInt(listofcontainers.length)];
    return InkWell(
        onTap: () async {
          await flutterBlue.stopScan();
          TransitionToDeviceDetail(context,select);
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
