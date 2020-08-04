import 'package:flutter/material.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/addnewboxes.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/pairedboxlist.dart';
import 'package:wardlabs/screens/drawerscreen.dart';
import 'package:provider/provider.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/settingscreen.dart';

class mainscreen extends StatefulWidget {
  @override
  static String routeName='/home';
  State<StatefulWidget> createState() {
    return mainscreenState();
  }
}

class mainscreenState extends State<mainscreen> {

  int _screenindex=0;
  void _changescreen(int index)
  {
    setState(() {
      _screenindex=index;
    });
  }

  final List<Map<String,Object>> _screens= [
    {
      'Title': 'Added Boxes',
      'screen': boxList(),
    },
    {
      'Title': 'Add New Box',
      'screen':addNewBox()
    },
        {
      'Title': 'Settings',
      'screen':settingscreen(),
    }
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_screenindex]['Title']),
      ),
      drawer: drawerScreen(),
      body: _screens[_screenindex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screenindex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (value){  _changescreen(value);}
        ,items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth_connected),
            title: Text(_screens[0]['Title'])),
        BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth_audio), title: Text(_screens[1]['Title'])),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text(_screens[2]['Title']))
      ]),
    );
  }
}
