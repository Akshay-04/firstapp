import 'package:wardlabs/widgets/contentinbox.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/basicbox.dart';
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
    Provider.of<pairedboxes>(context, listen: false)
        .getListOfpairedBoxes()
        .then((value) {
      setState(() {
        paireddevices = value;
      });
    });
  }

  GridView _buildListViewOfDevices() {
    return GridView.builder(
      itemCount: widget.devicesList.length,
      itemBuilder: (context, index) {
        BluetoothDevice q = widget.devicesList[index];
        return InkWell(
            onTap: () {
              setState(() {
                waiting = true;
              });
            },
            child: contentInBox(q, widget.index));
      },
      padding: EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30),
    );
  }

  Widget build(BuildContext context) {
    widget.devicesList.removeWhere((element) {
      Provider.of<pairedboxes>(context);
      for (int i = 0; i < paireddevices.length; i++) {
        if (element.id.toString() == paireddevices[i].deviceid) {
          return false;
        }
        return true;
      }
    });
    if (waiting)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return _buildListViewOfDevices();
  }
}
