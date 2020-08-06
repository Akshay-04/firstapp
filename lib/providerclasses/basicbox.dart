import 'package:flutter/cupertino.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';

FlutterBlue flutterBlue = FlutterBlue.instance;
List<int> a = [1, 2, 3, 45, 5];

class availablebluetoothdevices {
  Stream<List<BluetoothDevice>> get availabledevices async* {
    flutterBlue.startScan();
    List<BluetoothDevice> temp = [];
   await flutterBlue.startScan(timeout: Duration(seconds: 1));
    flutterBlue.scanResults.listen((event) {
      for (ScanResult result in event) {
        var t = result.device.id;
        print('result: $t');
        temp.add(result.device);
      }
    });
    flutterBlue.stopScan();
    yield temp;
  }
}
