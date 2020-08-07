import 'package:wardlabs/widgets/contentinbox.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/basicbox.dart';
import 'package:flutter/material.dart';
import '../../providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';

final FlutterBlue flutterBlue = FlutterBlue.instance;

class addNewBox extends StatefulWidget {
  final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();

  @override
  _addNewBoxState createState() => _addNewBoxState();
}

class _addNewBoxState extends State<addNewBox> {
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

  GridView _buildListViewOfDevices() {
    widget.devicesList.removeWhere((element) =>
        Provider.of<pairedboxes>(context).checkduplicateboxes(element));
        
    return GridView.builder(
      itemCount: widget.devicesList.length,
      itemBuilder: (context, index) {
        BluetoothDevice q = widget.devicesList[index];
        return contentInBox(q);
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
    return _buildListViewOfDevices();
  }
}
