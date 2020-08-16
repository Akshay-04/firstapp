import 'package:flutter/material.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/addnewboxes.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/pairedboxlist.dart';
import 'package:wardlabs/screens/drawerscreen.dart';
import 'package:provider/provider.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/settingscreen.dart';

class mainscreen extends StatefulWidget {
  @override
  static String routeName = '/home';
  int screenindex = 0;
  State<StatefulWidget> createState() {
    return mainscreenState();
  }
}

class mainscreenState extends State<mainscreen> {
  void _changescreen(int index) {
    setState(() {
      widget.screenindex = index;
    });
  }

  final List<Map<String, Object>> _screens = [
    {
      'Title': 'Added Boxes',
      'screen': boxList(0),
    },
    {
      'Title': 'Settings',
      'screen': settingscreen(),
    }
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[widget.screenindex]['Title']),
        actions: <Widget>[
          if (widget.screenindex == 0)
            PopupMenuButton(
              onSelected: (value) {
                if (value == 0) {
                  Navigator.of(context).pushNamed(addNewBox.routename);
                }
              },
              itemBuilder: (context) {
                List<String> items = ['Add new box'];
                List<PopupMenuItem> t = items
                    .map((e) => PopupMenuItem(child: Text(e), value: 0))
                    .toList();
                return t;
              },
            )
        ],
      ),
      drawer: drawerScreen(),
      body: _screens[widget.screenindex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.screenindex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.shifting,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (value) {
            _changescreen(value);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.bluetooth_connected),
                title: Text(_screens[0]['Title'])),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text(_screens[1]['Title']))
          ]),
    );
  }
}
