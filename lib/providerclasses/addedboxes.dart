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
    listofpairedboxes = List<MyBox>();
  }
  Future<List<MyBox>> getListOfpairedBoxes(String uid,String authkey) async {
    // listofpairedboxes = [];
    var res;
    try {
      res = await http
          .get('https://wardlabs.firebaseio.com/$uid/paireddevices.json?auth=$authkey');
    } catch (error) {
      print(error.toString());
    }

    var temp = json.decode(res.body) as Map<String, dynamic>;
    print(temp);
    if (temp != null) {
      temp.forEach((key, value) {
        print(value);
        listofpairedboxes.add(MyBox(key, value['deviceid'].toString()));
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

  Future<void> pairnewbox(BluetoothDevice device, String uid,String authkey) async {
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
        'https://wardlabs.firebaseio.com/$uid/paireddevices.json?auth=$authkey',
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

  Future<void> unpairbox(BluetoothDevice deletebox, String uid,String authkey) async {
    int index = -1;
    String temp = '';
    var templist = await getListOfpairedBoxes(uid,authkey);
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
       var res= await http.delete(
            'https://wardlabs.firebaseio.com/$uid/paireddevices/$temp.json?auth=$authkey}');
            
      } catch (error) {
        print(error.toString());
      }
      var removed = listofpairedboxes.removeAt(index);
      print('removed:$removed');
    
    }
    notifyListeners();
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
