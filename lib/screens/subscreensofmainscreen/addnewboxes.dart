import 'package:wardlabs/providerclasses/auth.dart';
import 'package:wardlabs/screens/drawerscreen.dart';
import 'package:wardlabs/screens/mainscreen.dart';
import 'package:wardlabs/widgets/contentinbox.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/basicboxprev.dart';
import 'package:flutter/material.dart';
import '../../providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';

final FlutterBlue flutterBlue = FlutterBlue.instance;

class addNewBox extends StatelessWidget {
  static String routename = '/addnewdevice';
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.on,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return Scaffold(
              drawer: drawerScreen(),
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(60), // here the desired height
                  child: AppBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                      ),
                      elevation: 10,
                      centerTitle: true,
                      title: Text('Add new boxes'))),
              body: FindDevicesScreen(),
              floatingActionButton: StreamBuilder<bool>(
                stream: FlutterBlue.instance.isScanning,
                initialData: false,
                builder: (c, snapshot) {
                  if (snapshot.data) {
                    return FloatingActionButton(
                      child: Icon(Icons.stop),
                      onPressed: () => FlutterBlue.instance.stopScan(),
                      backgroundColor: Colors.red,
                    );
                  } else {
                    return FloatingActionButton(
                        child: Icon(Icons.search),
                        onPressed: () => FlutterBlue.instance
                            .startScan(timeout: Duration(seconds: 2)));
                  }
                },
              ),
            );
          }
          return BluetoothOffScreen(state: state);
        });
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subhead
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatefulWidget {
  List<MyBox> listofalreadypairedboxid = [];
  @override
  _FindDevicesScreenState createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreen> {
  @override
  void initState() {
    super.initState();
    FlutterBlue.instance
        .startScan(timeout: Duration(seconds: 2))
        .then((value) => FlutterBlue.instance.stopScan());
    FlutterBlue.instance.connectedDevices.then((value) {
      value.forEach((element) {
        element.disconnect();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    FlutterBlue.instance.stopScan();
  
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<pairedboxes>(
      builder: (context, value, child) {
        return Wrap(
      children: [
        // FutureBuilder<List<BluetoothDevice>>(
        //   future: FlutterBlue.instance.connectedDevices,
        //   initialData: [],
        //   builder: (BuildContext context,
        //       AsyncSnapshot<List<BluetoothDevice>> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else {
        //       if (snapshot.hasError) {
        //         return Center(
        //           child: Text("Something went wrong"),
        //         );
        //       } else {
        //         return Column(
        //             children: snapshot.data.map((element) {
        //           return contentInBox(element, 1);
        //         }).toList());
        //       }
        //     }
        //   },
        // ),
        StreamBuilder<List<ScanResult>>(
            stream: FlutterBlue.instance.scanResults,
            initialData: [],
            builder: (c, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Something went wrong!'),
                );
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text('Scanning'),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Text('Done!'),
                  );
                } else if (snapshot.connectionState == ConnectionState.active) {
                  var Scanresult = snapshot.data ?? [];

                  Scanresult.retainWhere((element) {
                    if (element.device.name.isNotEmpty) {
                      return true;
                    } else {
                      return false;
                    }
                  });
                 return FutureBuilder<List<MyBox>>(
                    future: Provider.of<pairedboxes>(context)
                        .getListOfpairedBoxes(
                            Provider.of<authentiation>(context).getuid(),
                            Provider.of<authentiation>(context).authkey),
                    initialData: [],
                    builder: (BuildContext context,
                        AsyncSnapshot<List<MyBox>> snapshotofpaired) {
                      if (snapshotofpaired.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshotofpaired.hasError) {
                          return Center(
                            child: Text('Something went wrong'),
                          );
                        } else {
                          if (snapshotofpaired.data.isNotEmpty) {
                            snapshot.data.retainWhere((element) {
                              for (int i = 0;
                                  i < snapshotofpaired.data.length;
                                  i++) {
                                if (element.device.id.toString() ==
                                    snapshotofpaired.data[i].deviceid) {
                                  return false;
                                }
                              }
                              return true;
                            });
                          }
                          return Column(
                              children: Scanresult.map((e) {
                            return contentInBox(e.device, 1);
                          }).toList());
                        }
                      }
                    },
                  );
                }
              }
            }),
      ],
    );
      },
    );
  }
}

// GridView.builder(
//                 itemCount: Scanresult.length ?? 0,
//                 itemBuilder: (context, index) {
//                   BluetoothDevice q = Scanresult[index].device;
//                   return contentInBox(q, 1);
//                 },
//                 padding: EdgeInsets.all(25),
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 330,
//                     childAspectRatio: 5/ 8,
//                     crossAxisSpacing: 30,
//                     mainAxisSpacing: 30),
//               );
