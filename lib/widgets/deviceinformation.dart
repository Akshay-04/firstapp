import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';
class deviceInformation extends StatelessWidget {
  static String routeName = '/deviceInformation';
  Widget build(BuildContext context) {
    bool _paired(BluetoothDevice device) {
      List<BluetoothDevice> temp =
          Provider.of<pairedboxes>(context).listofpairedboxes;
      for (int i = 0; i < temp.length; i++) {
        if (device.id == temp[i].id) {
          return true;
        }
      }
      return false;
    }

    final args =
        ModalRoute.of(context).settings.arguments as BluetoothDevice;
    String name = args.name;
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Container(
            child: Card(
              child: Column(children: <Widget>[
                if (!_paired(args))
                  RaisedButton(
                    onPressed: () {
                      Provider.of<pairedboxes>(context,listen:false).pairnewbox(args);
                      Navigator.pop(context);
                    },
                    child: Text('Pair'),
                  )
                else
                  RaisedButton(
                    onPressed: () {
                      Provider.of<pairedboxes>(context,listen: false).unpairbox(args);
                      Navigator.pop(context);
                    },
                    child: Text('Unpair'),
                  )
              ]),
              elevation: 20,
            ),
            width: double.infinity));
  }
}
