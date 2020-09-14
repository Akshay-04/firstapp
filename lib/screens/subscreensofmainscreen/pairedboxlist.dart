import 'package:wardlabs/providerclasses/auth.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/basicboxprev.dart';
import 'package:flutter/material.dart';
import '../../providerclasses/addedboxes.dart';
import 'package:flutter_blue/flutter_blue.dart';

List<MyBox> paireddevices = [];

class boxlist extends StatefulWidget {
  static String routename = '/pairedboxes';
  int index;
  boxlist(this.index, Key key) : super(key: key);
  @override
  boxliststate createState() => boxliststate();
}

class boxliststate extends State<boxlist> {


  Widget build(BuildContext context) {

  

    return Text('video implementation pending');
  }
}
