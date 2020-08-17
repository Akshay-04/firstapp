import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/addnewboxes.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/pairedboxlist.dart';
import 'package:wardlabs/screens/drawerscreen.dart';
import 'package:provider/provider.dart';
import 'package:wardlabs/screens/subscreensofmainscreen/settingscreen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class mainscreen extends StatefulWidget {
  @override
  static String routeName = '/home';
  int screenindex = 0;
  State<StatefulWidget> createState() {
    return mainscreenState();
  }
}

class mainscreenState extends State<mainscreen> {
  PageController _pageController;
  void _changescreen(int index) {
    setState(() {
      widget.screenindex = index;
    });
  }

  final List<Map<String, Object>> _screens = [
    {
      'Title': 'Added Boxes',
      'screen': boxlist(0),
    },
    {
      'Title': 'Settings',
      'screen': settingscreen(),
    }
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Text(_screens[widget.screenindex]['Title']),
          shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
          centerTitle: true,
          actions: <Widget>[
            if (widget.screenindex == 0)
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 0) {
                    Navigator.of(context).popAndPushNamed(addNewBox.routename);
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
        bottomNavigationBar: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          selectedIndex: widget.screenindex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            widget.screenindex = index;
            _changescreen(index);
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
                inactiveColor: Theme.of(context).primaryColor,
              title: Text('Home'),
              activeColor: Theme.of(context).accentColor,
            ),
            BottomNavyBarItem(
              inactiveColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.settings),
                title: Text('Settings'),
                activeColor:Theme.of(context).accentColor),

          ],
        ));
  }
}
