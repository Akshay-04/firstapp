import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wardlabs/providerclasses/auth.dart';
import 'package:provider/provider.dart';

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
    // listofpairedboxes = [];
    var res;
    try {
      res =
          await http.get('https://wardlabs.firebaseio.com/paireddevices.json');
    } catch (error) {
      print(error.toString());
    }
    var temp = json.decode(res.body) as Map<String, dynamic>;
    print(temp);
    temp.forEach((key, value) {
      print(value);
      listofpairedboxes.add(MyBox(key, value['deviceid']));
    });

    return [...listofpairedboxes];
  }

  getdeviceidofbox(String id) {
    for (int i = 0; i < paireddeviceid.length; i++) {
      if (id == paireddeviceid[i].id) {
        return paireddeviceid[i].deviceid;
      }
    }
  }

  Future<void> pairnewbox(BluetoothDevice device, BuildContext context) async {
    // print('here1');
    String uid = await Provider.of<authentiation>(context).getuid();
    // print('here2');
    // try {
    //   Future<DocumentReference> idgenerated = Firestore.instance
    //       .collection('users')
    //       .document(uid)
    //       .collection('paireddevices')
    //       .add({'devicename': device.name, 'deviceid': device.id});
    // } catch (error) {
    //   print(error);
    // }

    await http
        .post('https://wardlabs.firebaseio.com/$uid/paireddevices.json',
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

  Future<void> unpairbox(BluetoothDevice deletebox,String uid) async {
    int index = -1;
    String temp = '';
    for (int i = 0; i < listofpairedboxes.length; i++) {
      print(deletebox.id.toString());
      print(listofpairedboxes[i].id);
      if (deletebox.id.toString() == listofpairedboxes[i].deviceid) {
        index = i;
        temp = listofpairedboxes[i].id;
      }
    }
    if (index >= 0) {
      try {
       await http.delete('https://wardlabs.firebaseio.com/$uid/paireddevices/$temp.json');
      } catch (error) {
        print(error.toString());
      }
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
