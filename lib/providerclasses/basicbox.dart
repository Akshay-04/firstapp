import 'package:flutter/cupertino.dart';
import 'package:wardlabs/providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';


class box with ChangeNotifier {
  List<BluetoothDevice> listOfBox = [
  ];

  getlistofnewboxes(List<BluetoothDevice> paired) {
    return [...listOfBox];
  }

  void addBox(BluetoothDevice newBox) {
    listOfBox.add(newBox);
    notifyListeners();
  }

 
}
