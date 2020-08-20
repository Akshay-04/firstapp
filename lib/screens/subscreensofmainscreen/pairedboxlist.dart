import 'package:wardlabs/providerclasses/auth.dart';
import 'package:wardlabs/widgets/contentinbox.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/basicboxprev.dart';
import 'package:flutter/material.dart';
import '../../providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';

List<MyBox> paireddevices = [];

class boxlist extends StatefulWidget {
  static String routename = '/pairedboxes';
  List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  int index;
  boxlist(this.index);
  @override
  boxliststate createState() => boxliststate();
}

class boxliststate extends State<boxlist> {
  bool waiting = false;
  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        if (result.device.name.isNotEmpty) {
          _addDeviceTolist(result.device);
        }
      }
    });
    flutterBlue.startScan();
  }
@override
void didChangeDependencies() {
  super.didChangeDependencies();
     String uid = Provider.of<authentiation>(context).getuid();
    Provider.of<pairedboxes>(context).getListOfpairedBoxes(uid).then((value) {
      setState(() {
        paireddevices = value;
      });
    });
}
  Wrap _buildListViewOfDevices(List<BluetoothDevice> temp) {
    Provider.of<pairedboxes>(context);

    return Wrap(
        children: temp.map((e) {
      return contentInBox(e, widget.index);
    }).toList());
  }

  Widget build(BuildContext context) {
    print('paired devices');
    paireddevices.forEach((element) {
      print(element.deviceid);
    });
    List<BluetoothDevice> temp = [...widget.devicesList];
    print(temp.length);
    temp.retainWhere((element) {
      for (int i = 0; i < paireddevices.length; i++) {
        if (element.id.toString() == paireddevices[i].deviceid) {
          return true;
        }
      }
      return false;
    });

    return _buildListViewOfDevices(temp);
  }
}
