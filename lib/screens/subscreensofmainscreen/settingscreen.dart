import 'package:flutter/material.dart';
import 'package:wardlabs/screens/drawerscreen.dart';

//done
class settingscreen extends StatelessWidget {
  static String routeName = '/setting';

  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SwitchListTile(
          value: true,
          onChanged: null,
          title: Text('Setting 1'),
        ),
        SwitchListTile(
          value: true,
          onChanged: null,
          title: Text('Setting 2'),
        ),
        SwitchListTile(
          value: true,
          onChanged: null,
          title: Text('Setting 3'),
        ),
      ],
    );
  }
}
