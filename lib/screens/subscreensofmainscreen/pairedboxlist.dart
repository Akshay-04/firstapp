import 'package:wardlabs/providerclasses/basicbox.dart';
import 'package:wardlabs/widgets/contentinbox.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';

class boxList extends StatefulWidget {
  int index;
  boxList(this.index);

  @override
  _boxListState createState() => _boxListState();
}

class _boxListState extends State<boxList> {
  List<ScanResult> listofalreadypairedboxes = [];

  List<MyBox> listofalreadypairedboxid = [];

  Future<List<BluetoothDevice>> getlist() async {
    flutterBlue.scan(timeout: Duration(seconds: 2));
    List<BluetoothDevice> temp = [];
    await for (List<ScanResult> results in flutterBlue.scanResults) {
      for (ScanResult r in results) {
        temp.add(r.device);
        print(r.device.name);
      }
      await flutterBlue.stopScan();
      return temp;
    }
    return temp;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<pairedboxes>(context, listen: false)
        .getListOfpairedBoxes()
        .then((value) {
          setState(() {
             listofalreadypairedboxid = value;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: flutterBlue.scanResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Empty');
          } else if (snapshot.error != null) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.active) {
            listofalreadypairedboxes = snapshot.data;
            listofalreadypairedboxes.retainWhere((element) {
              for (int i = 0; i < listofalreadypairedboxid.length; i++) {
                if (element.device.id.toString() ==
                    listofalreadypairedboxid[i].deviceid) {
                  return true;
                }
              }
              return false;
            });
            return Container(
                child: GridView(
              padding: EdgeInsets.all(25),
              children: <Widget>[
                if (listofalreadypairedboxes.isNotEmpty)
                  ...listofalreadypairedboxes.map((element) {
                    return contentInBox(element.device, widget.index);
                  }).toList()
              ],
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30),
            ));
          }
        });
  }
}
