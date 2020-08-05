import 'package:wardlabs/widgets/contentinbox.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/basicbox.dart';
import 'package:flutter/material.dart';
import '../../providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';

class addNewBox extends StatefulWidget {
  @override
  _addNewBoxState createState() => _addNewBoxState();
}

class _addNewBoxState extends State<addNewBox> {
  Color boxcolor = Colors.blue;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  @override
  void initState() {
    super.initState();
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if(r.device.name.isNotEmpty){
          if (!Provider.of<box>(context).checkrepeat(r.device)) {
            print('${r.device.name} found! rssi: ${r.rssi}');
            Provider.of<box>(context, listen: false).addBox(r.device);
        }
        }
      }
    });
// Stop scanning
    flutterBlue.stopScan();
  }

  Widget build(BuildContext context) {
    List<BluetoothDevice> listofalreadypairedboxes =
        Provider.of<pairedboxes>(context).getListOfpairedBoxes;

    List<BluetoothDevice> listofnewboxes =
        Provider.of<box>(context).getlistofnewboxes(listofalreadypairedboxes);
    listofnewboxes.removeWhere((element) {
      for (int i = 0; i < listofalreadypairedboxes.length; i++) {
        if (element.id == listofalreadypairedboxes[i].id) {
          return true;
        }
      }
      return false;
    });
    return Container(
        child: GridView(
      padding: EdgeInsets.all(25),
      children: <Widget>[
        if (listofnewboxes.isNotEmpty)
          ...listofnewboxes.map((element) {
            if (!element.name.isEmpty) return contentInBox(element);
          }).toList()
        else
          Text('No new device available')
      ],
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30),
    ));
  }
}
