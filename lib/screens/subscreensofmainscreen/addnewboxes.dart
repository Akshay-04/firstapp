import 'package:wardlabs/screens/mainscreen.dart';
import 'package:wardlabs/widgets/contentinbox.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/basicbox.dart';
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
              appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context)
                          .popAndPushNamed(mainscreen.routeName)),
                  title: Text('Add new boxes')),
              body: FindDevicesScreen(),
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
  }

  @override
  void dispose() {
    super.dispose();
    FlutterBlue.instance.stopScan();
    print('stopped scan');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanResult>>(
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
            } else if (snapshot.data.isEmpty) {
              return Center(
                child: Text('Empty'),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              var Scanresult = snapshot.data ?? [];
              return GridView.builder(
                itemCount: Scanresult.length ?? 0,
                itemBuilder: (context, index) {
                  BluetoothDevice q = Scanresult[index].device;
                  return contentInBox(q, 1);
                },
                padding: EdgeInsets.all(25),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 4 / 3,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30),
              );
            } else if (snapshot.data.isEmpty) {
              Center(
                child: Text('No device found'),
              );
            }
          }
        });
    floatingActionButton:
    StreamBuilder<bool>(
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
                  .startScan(timeout: Duration(seconds: 4)));
        }
      },
    );
  }
}
