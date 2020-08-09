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
  List<BluetoothDevice> listofalreadypairedboxes=[];
  List<MyBox> listofalreadypairedboxid;
  Future<void> getlist() async {
    await flutterBlue.startScan( timeout: Duration(seconds: 2));

     flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        setState(() {
          listofalreadypairedboxes.add(r.device);
        });
        
      }
    }).onDone(()async {await flutterBlue.stopScan(); });

     
  }

  @override
  void initState() {
 
   getlist().then((value) {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView(
      padding: EdgeInsets.all(25),
      children: <Widget>[
        if (listofalreadypairedboxes.isNotEmpty)
          ...listofalreadypairedboxes.map((element) {
            return contentInBox(element, widget.index);
          }).toList()
        else
          Text('Empty'),
      ],
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30),
    ));
  }
}
