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
  boxlist(this.index, Key key) : super(key: key);
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

  Wrap _buildListViewOfDevices(List<BluetoothDevice> t) {
    return Wrap(
        children: t.map((e) {
      return contentInBox(e, widget.index);
    }).toList());
  }

  Widget build(BuildContext context) {
    List<BluetoothDevice> temp;
  

    return FutureBuilder<List<MyBox>>(
      future: Provider.of<pairedboxes>(context).getListOfpairedBoxes(
          Provider.of<authentiation>(context).getuid(),
          Provider.of<authentiation>(context).authkey),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<MyBox>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          
          snapshot.data.forEach((element) {
            
          });
          temp = [...widget.devicesList];
        
          if (snapshot.data.isNotEmpty) {
            temp.retainWhere((element) {
              for (int i = 0; i < snapshot.data.length; i++) {
                if (element.id.toString() == snapshot.data[i].deviceid) {
                  return true;
                }
              }
              return false;
            });
          } else {
            temp = [];
          }
          return _buildListViewOfDevices(temp);
        }
      },
    );
  }
}
