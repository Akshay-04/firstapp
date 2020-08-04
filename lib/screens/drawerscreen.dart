import 'package:flutter/material.dart';
import 'package:wardlabs/screens/mainscreen.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/settingscreen.dart';
//done
class drawerScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
      ListTile(title: Text('Home')),
      FlatButton(
        child: Text('Home'),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(mainscreen.routeName);
        },
      ),
      FlatButton(onPressed: null, child: Text('User Profile')),

    ]));
  }
}
