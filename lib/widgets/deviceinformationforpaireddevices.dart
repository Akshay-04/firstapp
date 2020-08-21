import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:wardlabs/providerclasses/basicboxprev.dart';
import '../screens/subscreensofmainscreen/addnewboxes.dart';
import 'package:wardlabs/providerclasses/auth.dart';

class deviceInformationforpaireddevices extends StatefulWidget {
  static String routeName = '/deviceInformationforpaireddevices';

  @override
  _deviceInformationforpaireddevicesState createState() =>
      _deviceInformationforpaireddevicesState();
}

class _deviceInformationforpaireddevicesState
    extends State<deviceInformationforpaireddevices> {
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
    List<BluetoothService> _services = args['services'];
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60), // here the desired height
            child: AppBar(
              title: Text(thisdevice.name),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              centerTitle: true,
            )),
        body: Container(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Card(
                    child: Column(children: <Widget>[
                      RaisedButton(
                          child: Text('Unpair'),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            String uid=Provider.of<authentiation>(context,listen: false).getuid();
                             String authkey = Provider.of<authentiation>(context,listen: false).authkey;
                            await Provider.of<pairedboxes>(context,
                                    listen: false)
                                .unpairbox(thisdevice,uid,authkey);
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                          }),
                      RaisedButton(
                        child: Text('On'),
                        onPressed: () {
                          print(_services);
                          try {
                            _services[2]
                                .characteristics[0]
                                .write(utf8.encode('ON'));
                          } catch (error) {
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text('error'),
                                  content: Text(error.toString()),
                                ));
                          }
                        },
                      ),
                      RaisedButton(
                          child: Text('Off'),
                          onPressed: () {
                            try {
                              _services[2]
                                  .characteristics[0]
                                  .write(utf8.encode('OFF'));
                            } catch (error) {
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    title: Text('error'),
                                    content: Text(error.toString()),
                                  ));
                            }
                          })
                    ]),
                    elevation: 20,
                  ),
            width: double.infinity));
  }
}
