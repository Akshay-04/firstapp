import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:wardlabs/providerclasses/auth.dart';
import 'package:wardlabs/providerclasses/basicboxprev.dart';
import '../screens/subscreensofmainscreen/addnewboxes.dart';

class deviceInformationfornewdevices extends StatefulWidget {
  static String routeName = '/deviceInformation';

  @override
  _deviceInformationfornewdevicesState createState() =>
      _deviceInformationfornewdevicesState();
}

class _deviceInformationfornewdevicesState
    extends State<deviceInformationfornewdevices> {
  BluetoothDevice thisdevice;
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
    @override
    void dispose() {
      thisdevice.disconnect();
      super.dispose();
    }

    Provider.of<authentiation>(context);
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    thisdevice = args['selecteddevice'];
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60), // here the desired height
            child: AppBar(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              centerTitle: true,
              title: Text(thisdevice.name),
            )),
        body: Container(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Card(
                    child: Column(children: <Widget>[
                      RaisedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          print('first');
                          String uid =  Provider.of<authentiation>(context,listen: false).getuid();
                           String authkey = Provider.of<authentiation>(context,listen: false).authkey;
                          print('second');
                          await Provider.of<pairedboxes>(context,listen: false).pairnewbox(thisdevice, uid,authkey);

                          print('reached here');
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Pair'),
                      )
                    ]),
                    elevation: 20,
                  ),
            width: double.infinity));
  }
}
