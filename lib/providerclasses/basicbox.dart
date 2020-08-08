import 'package:flutter/cupertino.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';

class box with ChangeNotifier {
  List<BluetoothDevice> listOfBox = [];

<<<<<<< HEAD
class availablebluetoothdevices {
  Stream<List<BluetoothDevice>> get availabledevices async* {
    flutterBlue.startScan();
    List<BluetoothDevice> temp = [];
   await flutterBlue.startScan(timeout: Duration(seconds: 1));
    flutterBlue.scanResults.listen((event) {
      for (ScanResult result in event) {
        var t = result.device.id;
        temp.add(result.device);
=======
  getlistofnewboxes(List<BluetoothDevice> paired) {
    return [...listOfBox];
  }

  void addBox(BluetoothDevice newBox) {
    listOfBox.add(newBox);
    notifyListeners();
  }

  bool checkrepeat(BluetoothDevice newBox) {
    for (int i = 0; i < listOfBox.length; i++) {
      if (listOfBox[i].id == newBox.id) {
        return true;
>>>>>>> parent of f807b8e... df
      }
    }
    return false;
  }
}
