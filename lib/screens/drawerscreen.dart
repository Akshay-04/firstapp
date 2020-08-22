import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardlabs/providerclasses/auth.dart';
import 'package:wardlabs/screens/mainscreen.dart';
import '../providerclasses/addedboxes.dart';
import '../screens/subscreensofmainscreen/addnewboxes.dart';

class drawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
  borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),child:Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.of(context).pushReplacementNamed(mainscreen.routeName)
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Add New Box'),
            onTap: () => {
               Navigator.of(context).pushReplacementNamed(addNewBox.routename)
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Provider.of<authentiation>(context,listen: false).logout()
            },
          ),
        ],
      ),
    ));
  }
}