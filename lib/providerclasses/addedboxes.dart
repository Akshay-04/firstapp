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
  List<MyBox> listofpairedboxes = List<MyBox>();
  pairedboxes() {
    List<MyBox> listofpairedboxes = List<MyBox>();
    authentiation().getuid().then((va) {
      http
          .get('https://wardlabs.firebaseio.com/$va/paireddevices.json')
          .then((value) {
        if (json.decode(value.body) != null) {
          listofpairedboxes = json.decode(value.body)['Name'];
        }
      });
    });
  }
  Future<List<MyBox>> getListOfpairedBoxes(String uid) async {
    // listofpairedboxes = [];
    var res;
    try {
      res = await http
          .get('https://wardlabs.firebaseio.com/$uid/paireddevices.json');
    } catch (error) {
      print(error.toString());
    }

    var temp = json.decode(res.body) as Map<String, dynamic>;
    print(temp);
    if (temp != null) {
      temp.forEach((key, value) {
        print(value);
        listofpairedboxes.add(MyBox(key, value['deviceid']));
      });
      notifyListeners();
    }
    return [...listofpairedboxes];
  }

  getdeviceidofbox(String id) {
    for (int i = 0; i < listofpairedboxes.length; i++) {
      if (id == listofpairedboxes[i].id) {
        return listofpairedboxes[i].deviceid;
      }
    }
  }

  Future<void> pairnewbox(BluetoothDevice device, String uid) async {
    print('here1');

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

    http.Response res = await http.post(
        'https://wardlabs.firebaseio.com/$uid/paireddevices.json',
        body: json.encode(
            {'deviceid': device.id.toString(), 'devicename': device.name}));
    print('here2');

    listofpairedboxes
        .add(MyBox(json.decode(res.body)['Name'], device.id.toString()));
    listofpairedboxes
        .add(MyBox(json.decode(res.body)['Name'], device.id.toString()));
    print('paired:');
    print(listofpairedboxes.length);
    notifyListeners();
  }

  Future<void> unpairbox(BluetoothDevice deletebox) async {
    int index = -1;
    String temp = '';
    String uid = await authentiation().getuid();
    var templist = await getListOfpairedBoxes(uid);
    for (int i = 0; i < templist.length; i++) {
      print(deletebox.id.toString());
      print(templist[i].id);
      if (deletebox.id.toString() == templist[i].deviceid) {
        index = i;
        temp = templist[i].id;
      } else {
        print(templist[i].id.toString());
      }
    }
    print(templist.length);
    if (index >= 0) {
      try {
        await http.delete(
            'https://wardlabs.firebaseio.com/$uid/paireddevices/$temp.json');
      } catch (error) {
        print(error.toString());
      }
     var removed=listofpairedboxes.removeAt(index);
     print('removed:$removed');
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
