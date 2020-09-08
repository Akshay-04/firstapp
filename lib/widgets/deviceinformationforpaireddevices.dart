import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:wardlabs/providerclasses/basicboxprev.dart';
import '../screens/subscreensofmainscreen/addnewboxes.dart';
import 'package:wardlabs/providerclasses/auth.dart';
import '../screens/designofcard/designofcardfordevicedetailscreen.dart';

class deviceInformationforpaireddevices extends StatefulWidget {
  BluetoothDevice thisdevice;
  Map<String, Object> select;
  deviceInformationforpaireddevices(this.thisdevice, this.select);

  @override
  _deviceInformationforpaireddevicesState createState() =>
      _deviceInformationforpaireddevicesState();
}

class _deviceInformationforpaireddevicesState
    extends State<deviceInformationforpaireddevices> {
  List<BluetoothService> _services;

  bool isLoading = false;
  Future<List<BluetoothService>> get func async {
    try {
      await widget.thisdevice.connect();
    } catch (e) {
      if (e.code != 'already_connected') {
        throw e;
      }
    }
    _services = await widget.thisdevice.discoverServices();
    return _services;
  }

  @override
  void initState() {
    super.initState();
    func;
  }

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 4,
      child: StreamBuilder<BluetoothDeviceState>(
        stream: widget.thisdevice.state,
        initialData: BluetoothDeviceState.connecting,
        builder: (BuildContext context,
            AsyncSnapshot<BluetoothDeviceState> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occured'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == BluetoothDeviceState.disconnected) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == BluetoothDeviceState.connecting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return FutureBuilder<List<BluetoothService>>(
                future: func,
                initialData: [],
                builder: (BuildContext context,
                    AsyncSnapshot snapshotofpaireddevices) {
                  if (snapshotofpaireddevices.hasError) {
                    return Text('An error occured');
                  }
                  if (snapshotofpaireddevices.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : cardfordetaildevices(
                                widths: MediaQuery.of(context).size.width,
                                primary: widget.select['primary'],
                                chipColor: widget.select['chipColor'],
                                backWidget: widget.select['backWidget'],
                                chipText1: widget.thisdevice.name,
                                chipText2: "online",
                                functions: [
                                  {
                                    'name': 'Delete Box',
                                    'functiontoexecute': () {
                                      deletebox(context, widget.thisdevice);
                                    }
                                  },
                                  {
                                    'name': 'Open Box',
                                    'functiontoexecute': () {
                                      openbox(context, _services);
                                    }
                                  },
                                  {
                                    'name': 'Close Box',
                                    'functiontoexecute': () {
                                      closebox(context, _services);
                                    }
                                  }
                                ],
                              ),
                        width: double.infinity);
                  }
                },
              );
            }
          }
        },
      ),
    );
  }
}

void deletebox(BuildContext context, BluetoothDevice device) async {
  String uid = Provider.of<authentiation>(context, listen: false).getuid();
  String authkey = Provider.of<authentiation>(context, listen: false).authkey;
  showDialog(
      context: context,
      child: AlertDialog(
        title: Center(child: CircularProgressIndicator()),
        content: Text(
          'Deleting Box',
          textAlign: TextAlign.center,
        ),
      ));
  await Provider.of<pairedboxes>(context, listen: false)
      .unpairbox(device, uid, authkey)
      .then((value) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  });
}

void openbox(BuildContext context, List<BluetoothService> services) async {
  showDialog(
      context: context,
      child: AlertDialog(
        title: Center(child: CircularProgressIndicator()),
        content: Text('Opening Box', textAlign: TextAlign.center),
      ));
  await services[2].characteristics[0].write(utf8.encode('ON'));
  Navigator.of(context).pop();
}

void closebox(BuildContext context, List<BluetoothService> services) async{
  showDialog(
      context: context,
      child: AlertDialog(
        title: Center(child: CircularProgressIndicator()),
        content: Text('Closing Box', textAlign: TextAlign.center),
      ));
  await services[2].characteristics[0].write(utf8.encode('OFF'));
  Navigator.pop(context);
}
