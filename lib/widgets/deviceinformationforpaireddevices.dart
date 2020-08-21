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
  BluetoothDevice thisdevice;
  List<BluetoothService> _services;

  bool isLoading = false;
  Future<List<BluetoothService>> get func async {
    try {
      await thisdevice.connect();
    } catch (e) {
      if (e.code != 'already_connected') {
        throw e;
      }
    }
    _services = await thisdevice.discoverServices();
    return _services;
  }

  @override
  void initState() {
    super.initState();
    func;
  }

  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    thisdevice = args['selecteddevice'];

    return Scaffold(
                    appBar: PreferredSize(
                        preferredSize:
                            Size.fromHeight(60), // here the desired height
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
                    body:StreamBuilder<BluetoothDeviceState>(
      stream: thisdevice.state,
      initialData: BluetoothDeviceState.connecting,
      builder:
          (BuildContext context, AsyncSnapshot<BluetoothDeviceState> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('An error occured'),
          );
        } else if (snapshot.data == BluetoothDeviceState.disconnected) {
          return Center(child:Text('Device Disconnected.Please switch on the box'));
        } else {
          if (snapshot.data == BluetoothDeviceState.connecting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return FutureBuilder<List<BluetoothService>>(
              future: func,
              initialData: [],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return  Container(
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : Card(
                                child: Column(children: <Widget>[
                                  RaisedButton(
                                      child: Text('Delete Box'),
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        String uid = Provider.of<authentiation>(
                                                context,
                                                listen: false)
                                            .getuid();
                                        String authkey =
                                            Provider.of<authentiation>(context,
                                                    listen: false)
                                                .authkey;
                                        await Provider.of<pairedboxes>(context,
                                                listen: false)
                                            .unpairbox(
                                                thisdevice, uid, authkey);
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pop(context);
                                      }),
                                  RaisedButton(
                                    child: Text('Open Box'),
                                    onPressed: () {
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
                                      child: Text('Close Box'),
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
                        width: double.infinity);
                ;
              },
            );
          }
        }
      },
    ));
    // FutureBuilder<BluetoothService>(
    //   future: func,
    //   initialData: [],
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     return Scaffold(
    //         appBar: PreferredSize(
    //             preferredSize: Size.fromHeight(60), // here the desired height
    //             child: AppBar(
    //               title: Text(thisdevice.name),
    //               elevation: 10,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.vertical(
    //                   bottom: Radius.circular(30),
    //                 ),
    //               ),
    //               centerTitle: true,
    //             )),
    //         body: Container(
    //             child: isLoading
    //                 ? Center(child: CircularProgressIndicator())
    //                 : Card(
    //                     child: Column(children: <Widget>[
    //                       RaisedButton(
    //                           child: Text('Unpair'),
    //                           onPressed: () async {
    //                             setState(() {
    //                               isLoading = true;
    //                             });
    //                             String uid = Provider.of<authentiation>(context,
    //                                     listen: false)
    //                                 .getuid();
    //                             String authkey = Provider.of<authentiation>(
    //                                     context,
    //                                     listen: false)
    //                                 .authkey;
    //                             await Provider.of<pairedboxes>(context,
    //                                     listen: false)
    //                                 .unpairbox(thisdevice, uid, authkey);
    //                             setState(() {
    //                               isLoading = false;
    //                             });
    //                             Navigator.pop(context);
    //                           }),
    //                       RaisedButton(
    //                         child: Text('On'),
    //                         onPressed: () {
    //                           try {
    //                             _services[2]
    //                                 .characteristics[0]
    //                                 .write(utf8.encode('ON'));
    //                           } catch (error) {
    //                             showDialog(
    //                                 context: context,
    //                                 child: AlertDialog(
    //                                   title: Text('error'),
    //                                   content: Text(error.toString()),
    //                                 ));
    //                           }
    //                         },
    //                       ),
    //                       RaisedButton(
    //                           child: Text('Off'),
    //                           onPressed: () {
    //                             try {
    //                               _services[2]
    //                                   .characteristics[0]
    //                                   .write(utf8.encode('OFF'));
    //                             } catch (error) {
    //                               showDialog(
    //                                   context: context,
    //                                   child: AlertDialog(
    //                                     title: Text('error'),
    //                                     content: Text(error.toString()),
    //                                   ));
    //                             }
    //                           })
    //                     ]),
    //                     elevation: 20,
    //                   ),
    //             width: double.infinity));
    //     ;
    //   },
    // );
  }
}
