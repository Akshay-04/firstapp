import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

class pairedboxes with ChangeNotifier {
  List<BluetoothDevice> listofpairedboxes = [];

  get getListOfpairedBoxes {
    return [...listofpairedboxes];
  }

  pairnewbox(BluetoothDevice device) {
    listofpairedboxes.add(device);
    notifyListeners();
  }

  void unpairbox(BluetoothDevice deletebox) {
    int index = -1;
    for (int i = 0; i < listofpairedboxes.length; i++) {
      if (deletebox.id == listofpairedboxes[i].id) {
        index = i;
      }
    }
    if (index >= 0) {
      listofpairedboxes.removeAt(index);
      notifyListeners();
    }
  }

  bool checkduplicateboxes(BluetoothDevice b) {
    for (int i = 0; i < listofpairedboxes.length; i++) {
      if (b.id == listofpairedboxes[i].id) {
        return true;
      }
    }
    return false;
  }
}
