import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:wardlabs/providerclasses/basicbox.dart';
import '../screens/subscreensofmainscreen/addnewboxes.dart';

class deviceInformationfornewdevices extends StatefulWidget {
  static String routeName = '/deviceInformation';

  @override
  _deviceInformationfornewdevicesState createState() => _deviceInformationfornewdevicesState();
}

class _deviceInformationfornewdevicesState extends State<deviceInformationfornewdevices> {
  bool isLoading = false;
  Widget build(BuildContext context) {
    // bool _paired(BluetoothDevice device) {
    //   List<BluetoothDevice> temp =
    //       Provider.of<pairedboxes>(context).listofpairedboxes;
    //   for (int i = 0; i < temp.length; i++) {
    //     if (device.id == temp[i].id) {
    //       return true;
    //     }
    //   }
    //   return false;
    // }

    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    BluetoothDevice thisdevice = args['selecteddevice'];
    return Scaffold(
        appBar: AppBar(
           elevation: 10,
          shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
          centerTitle: true,
          title: Text(thisdevice.name),
        ),
        body: Container(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Card(
                    child: Column(children: <Widget>[
                      
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            Provider.of<pairedboxes>(context, listen: false)
                                .pairnewbox(thisdevice)
                                .then((_) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Pair'),
                        )
                      
                    ]),
                    elevation: 20,
                  ),
            width: double.infinity));
  }
}
