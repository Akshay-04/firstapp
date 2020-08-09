import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';

const String firebaseurl = 'https://wardlabs.firebaseio.com/paireddevices.json';

class MyBox {
  String id;
  String deviceid;
  MyBox(this.id, this.deviceid);
}

class pairedboxes with ChangeNotifier {
  List<MyBox> listofpairedboxes = [];
  List<MyBox> paireddeviceid = [];
  Future<List<MyBox>> getListOfpairedBoxes() async {
    listofpairedboxes = [];
    var res=await http.get(firebaseurl);
      var temp = json.decode(res.body) as Map<String, dynamic>;
      temp.forEach((key, value) {
        listofpairedboxes.add(MyBox(key, value));
      });
  
    print('in init');
    print(listofpairedboxes.length);
    return [...listofpairedboxes];
  }

  getdeviceidofbox(String id) {
    for (int i = 0; i < paireddeviceid.length; i++) {
      if (id == paireddeviceid[i].id) {
        return paireddeviceid[i].deviceid;
      }
    }
  }

  Future<void> pairnewbox(BluetoothDevice device) async {
    print('here1');
    await http
        .post(firebaseurl,
            body: json.encode(
                {'deviceid': device.id.toString(), 'devicename': device.name}))
        .then((value) {
      paireddeviceid
          .add(MyBox(json.decode(value.body)['Name'], device.id.toString()));
      listofpairedboxes
          .add(MyBox(json.decode(value.body)['Name'], device.id.toString()));
      print('paired:');
      print(listofpairedboxes[listofpairedboxes.length - 1].deviceid);
      notifyListeners();
    });
  }

  void unpairbox(BluetoothDevice deletebox) {
    int index = -1;
    for (int i = 0; i < listofpairedboxes.length; i++) {
      if (deletebox.id.toString() == listofpairedboxes[i].id) {
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
      if (b.id.toString() == listofpairedboxes[i].deviceid.toString()) {
        return true;
      }
    }
    return false;
  }
}
