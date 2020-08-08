import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';

const String firebaseurl = 'https://wardlabs.firebaseio.com/paireddevices.json';

class MyBox {
  String id;
  DeviceIdentifier deviceid;
  MyBox(this.id, this.deviceid);
   
}

class pairedboxes with ChangeNotifier {
  List<BluetoothDevice> listofpairedboxes = [];
  List<MyBox> paireddeviceid = [];
  get getListOfpairedBoxes {
    return [...listofpairedboxes];
  }
  getdeviceidofbox(String id)
  {
    for(int i=0;i<paireddeviceid.length;i++)
    {
    if(id==paireddeviceid[i].id)
    {
      return paireddeviceid[i].deviceid;
    }
    }
  }

  Future<void> pairnewbox(BluetoothDevice device) {
    print('here1');
    return http.post(firebaseurl, body: json.encode({'device': device.toString()}))
        .then((value) {
      paireddeviceid.add(MyBox(json.decode(value.body)['Name'], device.id));
      print('here2');
      listofpairedboxes.add(device);
      notifyListeners();
    });
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
<<<<<<< HEAD

  bool checkduplicateboxes(BluetoothDevice b) {
    for (int i = 0; i < listofpairedboxes.length; i++) {
      if (b.id == listofpairedboxes[i].id) {
        return true;
      }
    }
    return false;
  }
=======
>>>>>>> parent of f807b8e... df
}
